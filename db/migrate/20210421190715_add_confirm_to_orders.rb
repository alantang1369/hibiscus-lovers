class AddConfirmToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :confirm, :boolean, :default => false
  end
end
