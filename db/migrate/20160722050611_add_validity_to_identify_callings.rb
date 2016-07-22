class AddValidityToIdentifyCallings < ActiveRecord::Migration[5.0]
  def change
    change_table :identify_callings do |t|
      t.string :validity
    end
  end
end
