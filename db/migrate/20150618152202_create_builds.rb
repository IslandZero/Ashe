class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.belongs_to :bundle, index: true, foreign_key: true
      t.string :version,    index: true, null: false
      t.string :build,      index: true, null: false
      t.string :file
      t.string :desc

      t.timestamps null: false
    end
  end
end
