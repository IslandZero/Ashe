class CreateProvisions < ActiveRecord::Migration
  def change
    create_table :provisions do |t|
      t.belongs_to :build, index: true, foreign_key: true
      t.string :udid,      index: true, null: false

      t.timestamps null: false
    end
  end
end
