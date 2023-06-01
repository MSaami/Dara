class CreateBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets do |t|
      t.references :wallet, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.integer :month, null: false
      t.integer :year, null: false
      t.float :amount, null: false

      t.timestamps
    end
  end
end
