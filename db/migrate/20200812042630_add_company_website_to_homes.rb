class AddCompanyWebsiteToHomes < ActiveRecord::Migration[5.0]
  def change
    add_column :homes, :company_website, :string
  end
end
