class TopController < ApplicationController
  def index
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
    @tag = Tag.includes(:category).find(params[:tag_id])
    @media = Media.find_by(media_id: params[:media_id])

    if @media.blank?
      begin
        conn = Instagram.client(:access_token => Constants.instagram.access_token)
        res = conn.media_item(params[:media_id])
        @media = set_media(res)
      rescue Exception => e
        @media = nil
      end
    end
  end
end
