class CreateSearchTerms < ActiveRecord::Migration
  def change
    create_table :search_terms do |t|
      t.string :term, null: false
      t.belongs_to :product, null: false
      t.timestamps null: false
    end
  end
end
