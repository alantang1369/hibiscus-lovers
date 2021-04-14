class AddStatusToCultivars < ActiveRecord::Migration[6.1]
  def change
    add_column :cultivars, :status, :string, :default => 'out-of-stock'
  end
end
