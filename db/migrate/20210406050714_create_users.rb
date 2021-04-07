class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :password_digest
      t.integer :wallet
      t.string :address
      t.string :email

      t.timestamps
    end

    add_column :users, :admin, :boolean, :default => false
  end
end
