class Media < ActiveRecord::Base
  belongs_to :category
  belongs_to :tag

  serialize :tags
  serialize :location
  serialize :comments
  serialize :likes
  serialize :images
  serialize :videos
  serialize :users_in_photo
  serialize :caption
  serialize :user_has_liked
  serialize :user
end
