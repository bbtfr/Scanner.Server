class CreateCallings < ActiveRecord::Migration[5.0]
  def change
    create_table :callings do |t|
      t.string :request_id
      t.string :remote_ip
      t.string :device_id
      t.string :id_number
      t.string :name
      t.references :image, foreign_key: true
      t.text :sensetime_result

      t.datetime :created_at
    end
  end
end
