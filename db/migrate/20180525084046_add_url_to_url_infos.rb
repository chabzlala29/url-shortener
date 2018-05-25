class AddUrlToUrlInfos < ActiveRecord::Migration[5.2]
  def change
    add_reference :url_infos, :url, foreign_key: true
  end
end
