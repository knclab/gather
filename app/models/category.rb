class Category < ActiveRecord::Base
  has_many :tags, autosave: true, dependent: :destroy
  has_many :medias, autosave: true, dependent: :destroy
end
