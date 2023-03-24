class CreateWalletTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :wallet_transactions do |t|
      t.references :category, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true

      t.text :description
      t.float :amount, null: false

      t.timestamps
    end
  end
end
