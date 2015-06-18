class CreateBundles < ActiveRecord::Migration
  def change
    create_table :bundles do |t|
      t.string :name,       null: false
      t.string :identifier, null: false, index: true, unique: true
      t.string :desc

      t.timestamps null: false
    end
  end
end
