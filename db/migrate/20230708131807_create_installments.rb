class CreateInstallments < ActiveRecord::Migration[7.0]
  def change
    create_table :installments do |t|
      t.date :due_date
      t.float :amount
      t.references :loan, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
