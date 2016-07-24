class AddCityIdToIdentifyCallings < ActiveRecord::Migration[5.0]
  def change
    change_table :identify_callings do |t|
      t.integer :city_id
    end
  end
end
