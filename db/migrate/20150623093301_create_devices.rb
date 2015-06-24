class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :owner
      t.string :product
      t.string :serial
      t.string :udid,  null: false, index: true, unique: true
      t.string :token, null: false, index: true, unique: true
      t.string :version

      t.timestamps null: false
    end
  end
end
