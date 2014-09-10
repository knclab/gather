namespace :import do

  # 全ハッシュデータの最新メディアを取得
  desc 'import all media'
  task :all => :environment do
    start_time = Time.now
    MediaImport.new.make_all_media
    MediaImport.new.delete_old_media(start_time)
  end

end

class MediaImport
  #= public
  #== 初期設定
  def initialize
    initialize_logger
    initialize_valiable
    @con = connection_instagram
  end

  #== 変数の初期化
  def initialize_valiable
    @ids = []
    @results = []
  end

  #== logの設定
  def initialize_logger
    @logger = Logger.new("#{Rails.root}/log/import.log")
    @logger.formatter = Logger::Formatter.new
    @logger.datetime_format = "%Y-%m-%d %H:%M:%S"
  end

  #== 古いデータの削除
  def delete_old_media(start_time)
    @logger.info("Start Delete Old Media")
    Media.where('updated_at < ?', start_time).destroy_all
    @logger.info("Finish Delete Old Media")
  end

  #== Instagramのコネクションを設定
  def connection_instagram
    Instagram.client(:access_token => Constants.instagram.access_token)
  end

  #== DBへデータ登録
  # 100件づつDBに保存
  def import_database(klass, results, update_fields)
    @logger.info("#{klass.name}:: Start DB Import")
    rows = results.in_groups_of(100)
    rows.each_with_index do |row, idx|
      @logger.info("#{klass.name}:: Start -- #{idx+1} / #{rows.size}") if ((idx+1) % 100).zero? || idx+1 >= rows.size
      begin
        klass.import(row.compact, { :on_duplicate_key_update => update_fields })
      rescue Exception => e
        @logger.error(e.inspect)
        @logger.error(e.backtrace.join("\n"))
      end
    end
    @logger.info("#{klass.name}:: Finish DB Import")
  end

  #== 更新カラムの設定
  def media_update_columns
    [:updated_at, :category_id, :tag_id, :media_id, :attribution,
     :tags, :media_type, :location, :comments, :filter, :created_time,
     :link, :likes, :images, :videos, :users_in_photo, :caption, :user_has_liked, :user
    ]
  end

  #== 全メディアを更新
  def make_all_media
    @logger.info("Start Make All Media")
    categories = Category.all
    categories.each do |category|
      category.tags.each do |tag|
        res = get_media(tag)
        next if res.blank?
        set_media(res, tag)
        sleep 0.3
      end
      import_database(Media, @results, media_update_columns)
      initialize_valiable
    end
    @logger.info("Finish Make All Media")
  end

#  #== ハッシュタグの情報を更新
#  def update_tags(tags)
#    return if tags.blank?
#    tags.each do |t|
#      begin
#        res = @con.tag(t.name)
#        t.media_count = res['count'] if res.blank?
#      rescue Exception => e
#      end
#    end
#  end

  #== ハッシュタグの情報最新メディアを取得
  def get_media(tag)
    @logger.info("Get Tag Recent media:: #{tag.name}")
    begin
      @con.tag_recent_media(CGI.escape(tag.name))
    rescue Exception => e
      @logger.error(e.inspect)
      @logger.error(e.backtrace.join("\n"))
      return nil
    end
  end

  #== メディア情報のセット
  def set_media(res, tag)
    @logger.info("Set media:: #{tag.name}")
    res.each do |media|
      next if @ids.include?(media[:id])
      ret = Media.where(category_id: tag.category_id, media_id: media[:id]).first_or_initialize
      ret.category_id = tag.category_id
      ret.tag_id = tag.id
      ret.media_id = media[:id]
      ret.attribution = media[:attribution]
      ret.tags = media[:tags]
      ret.media_type = media[:type]
      ret.location = media[:location]
      ret.comments = media[:comments]
      ret.filter = media[:filter]
      ret.created_time = media[:created_time]
      ret.link = media[:link]
      ret.likes = media[:likes]
      ret.images = media[:images]
      ret.videos = media[:videos]
      ret.users_in_photo = media[:users_in_photo]
      ret.caption = media[:caption]
      ret.user_has_liked = media[:user_has_liked]
      ret.user = media[:user]
      @ids << media[:id]
      @results << ret
    end
  end

end
