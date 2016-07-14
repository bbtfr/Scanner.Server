class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string     :title
      t.string     :subtitle
      t.string     :author
      t.string     :category

      t.string     :thumbnail_url
      t.attachment :thumbnail_image

      t.string     :source_url
      t.text       :source_content

      t.timestamps
    end
  end
end
