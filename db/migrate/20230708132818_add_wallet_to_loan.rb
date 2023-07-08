class AddWalletToLoan < ActiveRecord::Migration[7.0]
  def change
    add_reference :loans, :wallet, null: false
  end
end
