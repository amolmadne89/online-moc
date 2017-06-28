class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.has_attached_file :image
      t.timestamps null: false
    end
  end
end
