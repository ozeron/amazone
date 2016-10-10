class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.date :date, null: false
      t.json :data, default: {}
      t.belongs_to :search_term
      t.timestamps null: false
    end
  end
end
