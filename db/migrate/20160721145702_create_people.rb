class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :id_number, unique: true
      t.string :name
      t.references :image, foreign_key: true

      t.timestamps
    end
  end
end
