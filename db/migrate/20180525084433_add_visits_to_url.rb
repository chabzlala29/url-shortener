class AddVisitsToUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :visits, :bigint
  end
end
