class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.timestamps

      t.references :category, index: true, null: false
      t.references :tag, index: true, null: false
      t.string  :media_id
      t.text    :attribution
      t.text    :tags
      t.string  :media_type
      t.text    :location
      t.text    :comments
      t.string  :filter
      t.integer :created_time
      t.string  :link
      t.text    :likes
      t.text    :images
      t.text    :videos
      t.text    :users_in_photo
      t.text    :caption
      t.text    :user_has_liked
      t.text    :user

      t.index :media_id
      t.index :created_time
      t.index :created_at
    end
  end
end
