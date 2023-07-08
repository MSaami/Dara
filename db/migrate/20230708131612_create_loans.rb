class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.integer :number_of_installment
      t.string :title
      t.float :amount
      t.integer :number_of_paid

      t.timestamps
    end
  end
end
