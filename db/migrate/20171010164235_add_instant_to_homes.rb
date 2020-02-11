class AddInstantToHomes < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :instant, :integer, default: 1
  end
end