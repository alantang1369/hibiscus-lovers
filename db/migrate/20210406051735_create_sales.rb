class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.integer :user_id
      t.integer :cultivar_id
      t.integer :available_seed
      t.integer :seed_price

      t.timestamps
    end
  end
end
