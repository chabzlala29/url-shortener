class CreateUrlInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :url_infos do |t|
      t.string :ip
      t.string :city
      t.string :region
      t.string :country
      t.string :loc
      t.string :postal

      t.timestamps
    end
  end
end
