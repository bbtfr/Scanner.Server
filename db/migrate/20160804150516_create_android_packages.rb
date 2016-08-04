class CreateAndroidPackages < ActiveRecord::Migration[5.0]
  def change
    create_table :android_packages do |t|
      t.string :version
      t.attachment :file

      t.timestamps
    end
  end
end
