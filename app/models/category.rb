class Category < ActiveRecord::Base
  has_many :tags
  has_many :media
end
