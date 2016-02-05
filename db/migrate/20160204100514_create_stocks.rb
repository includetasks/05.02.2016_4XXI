class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string  :symbol,              null: false
      t.integer :count,   default: 1, null: false
      
      t.references :portfolio, index: true, foreign_key: true
      t.references :user,      index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
