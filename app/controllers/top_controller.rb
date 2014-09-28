class TopController < ApplicationController
  def index
    conn = Instagram.client(:access_token => Constants.instagram.access_token)
    tag_count = conn.tag(CGI.escape(Constants.instagram.tag_name))
    options = {}
    options[:max_id] = params[:max_id].to_i if params[:max_id]
    options[:min_id] = params[:min_id].to_i if params[:min_id]
    res = conn.tag_recent_media(CGI.escape(Constants.instagram.tag_name), options)
#p res.pagination

    @results = res
    #@results = Kaminari.paginate_array(res, total_count: tag_count[:media_count]).page(1).per(20)
    @next_max_id = res.pagination.next_max_id
    @next_min_id = res.pagination.next_min_id
  end

  def search
    conn = Instagram.client(:access_token => Constants.instagram.access_token)
    options = {}
    options[:max_id] = params[:id].to_i if params[:id]
    res = conn.tag_recent_media(CGI.escape(Constants.instagram.tag_name), options)
#p res.pagination
    @results = res
    @next_max_id = res.pagination.next_max_id
#    respond_to do |format|
#      format.html { redirect_to root_url }
#      format.json { render json: {pagination: res.pagination, results: res} }
#    end
  end

  def feed
    conn = Instagram.client(:access_token => Constants.instagram.access_token)
    @results = conn.tag_recent_media(CGI.escape(Constants.instagram.tag_name))
    respond_to do |format|
      format.html { redirect_to root_url }
      format.rss { render layout: false }
    end
  end

  def list
    @category = Category.includes(:medias).find(params[:id])
  end

  def show
    def set_media(res)
#binding.pry
      return nil if res.blank?
      return Media.new( category_id: @tag.category_id, tag_id: @tag.id, media_id: res[:id],
                        attribution: res[:attribution], tags: res[:tags], media_type: res[:type],
                        location: res[:location], comments: res[:comments], filter: res[:filter],
                        created_time: res[:created_time], link: res[:link], likes: res[:likes],
                        images: res[:images], videos: res[:videos], users_in_photo: res[:users_in_photo],
                        caption: res[:caption], user_has_liked: res[:user_has_liked], user: res[:user],
                      )
    end


#binding.pry
    #@tag = Tag.includes(:category).find(params[:tag_id])
    @media = Media.find_by(media_id: params[:media_id])

    if @media.blank?
      begin
        conn = Instagram.client(:access_token => Constants.instagram.access_token)
        res = conn.media_item(params[:media_id])
        @media = res
      rescue Exception => e
        @media = nil
      end
    end
  end
end
