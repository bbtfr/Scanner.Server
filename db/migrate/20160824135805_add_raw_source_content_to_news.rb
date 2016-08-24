class AddRawSourceContentToNews < ActiveRecord::Migration[5.0]
  def change
    change_table :news do |t|
      t.text :raw_source_content
    end
  end
end
