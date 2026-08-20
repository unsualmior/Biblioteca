class CreateLibraryUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :library_users do |t|
      t.string :full_name
      t.string :cpf
      t.string :phone
      t.string :email
      t.string :loan_password

      t.timestamps
    end
  end
end
