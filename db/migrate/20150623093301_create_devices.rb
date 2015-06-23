class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :product
      t.string :serial
      t.string :udid
      t.string :version

      t.timestamps null: false
    end
  end
end
