class AddColumnToOrders < ActiveRecord::Migration
  def change
  	# add_column :table_name, :column_name, :column_type
  	add_column :orders, :address_id, :integer
  end
end
