class CreateAbilities < ActiveRecord::Migration[5.0]
  def change
    create_table :abilities do |t|
      t.string :unique_id, unique: true
      t.text :use_counts

      t.timestamps
    end
  end
end
