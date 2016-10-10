class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :asin, null: false
      t.json :metadata, default: {}
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
