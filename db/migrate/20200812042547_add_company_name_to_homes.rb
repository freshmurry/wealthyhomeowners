class AddCompanyNameToHomes < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :company_name, :string
  end
end
