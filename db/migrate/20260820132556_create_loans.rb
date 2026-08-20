class CreateLoans < ActiveRecord::Migration[8.1]
  def change
    create_table :loans do |t|
      t.references :book, null: false, foreign_key: true
      t.references :library_user, null: false, foreign_key: true
      t.date :loan_date
      t.date :due_date
      t.boolean :returned
      t.date :returned_at

      t.timestamps
    end
  end
end
