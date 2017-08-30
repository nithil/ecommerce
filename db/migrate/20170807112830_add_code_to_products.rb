class AddCodeToProducts < ActiveRecord::Migration
  def change
  	# add_column :table_name, :column_name, :column_type
  	add_column :products, :code, :string
  	add_column :products, :stock, :integer
  	add_column :products, :COD_eligibility, :boolean, default: true

  	add_column :categories, :code, :string
  end
end
