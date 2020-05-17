class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :home, index: true, foreign_key: true
      t.string "image_file_name"
      t.string "image_content_type"
      t.integer "image_file_size"
      t.timestamps null: false
    end
  end
  
  def self.up
    change_table :photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :photos, :image
  end
end