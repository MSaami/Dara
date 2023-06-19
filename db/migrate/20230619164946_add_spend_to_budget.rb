class AddSpendToBudget < ActiveRecord::Migration[7.0]
  def change
    add_column :budgets, :spend, :float, default: 0
  end
end
