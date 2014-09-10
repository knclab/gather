class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.timestamps

      t.integer :category_id
      t.integer :tag_id
      t.string  :media_id
      t.text    :attribution
      t.text    :tags
      t.string  :type
      t.text    :location
      t.text    :comments
      t.string  :filter
      t.string  :created_time
      t.string  :link
      t.text    :likes
      t.text    :images
      t.text    :videos
      t.text    :users_in_photo
      t.text    :caption
      t.text    :user_has_liked
      t.text    :user
    end
  end
end
