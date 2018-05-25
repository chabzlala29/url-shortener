class AddLastVisitedAtAndDeviceNameAndBrowserToUrlInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :url_infos, :last_visited_at, :datetime
    add_column :url_infos, :device_name, :string
    add_column :url_infos, :browser, :string
  end
end
