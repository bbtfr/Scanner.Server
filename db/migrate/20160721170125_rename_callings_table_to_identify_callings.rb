class RenameCallingsTableToIdentifyCallings < ActiveRecord::Migration[5.0]
  def change
    rename_table :callings, :identify_callings

    change_table :identify_callings do |t|
      t.string :endpoint
    end
  end
end
