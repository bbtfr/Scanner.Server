class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.attachment :file
      t.string :sensetime_image_id

      t.timestamps
    end
  end
end
