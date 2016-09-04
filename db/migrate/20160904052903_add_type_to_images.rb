class AddTypeToImages < ActiveRecord::Migration[5.0]
  def up
    change_table :images do |t|
      t.string :type
    end

    Image.where.not(sensetime_image_id: nil).update_all(type: 'IdentifyImage')
  end

  def down
    change_table :images do |t|
      t.remove :type
    end
  end
end
