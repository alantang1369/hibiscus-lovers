class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :sale_id
      t.integer :seed_amount
      t.integer :total

      t.timestamps
    end
  end
end
