class CreateHomes < ActiveRecord::Migration[5.0]
  def change
    create_table :homes do |t|
      t.string :home_type #Church, Park District, Town Hall, Parking Lot, Back Yard, Vine Yard, Golf Course, Warehouse
      t.integer :bedrooms
      t.integer :bathrooms
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_pool
      t.boolean :is_sauna
      t.boolean :is_hot_tub
      t.integer :price
      t.boolean :active
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end