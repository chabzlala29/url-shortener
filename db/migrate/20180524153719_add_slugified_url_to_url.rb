class AddSlugifiedUrlToUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :slugified_url, :string
  end
end
