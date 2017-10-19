class ProductsController < ApplicationController
=begin 
	index 
		Role - is to list resouces / data
		path - products_path
		uri  - /products
		HTTP Method - GET

	new
		Role - is to instantiate an object, and setup a form 
		path - new_prduct_path
		URI  - /products/new
		HTTP Method - GET
	create 
		Role - is to take the values coming in from the form
				and save it to the database if the validation pass,
				else display error message
		path - products_path
		URI  - /products
		HTTP Method - POST
	show
		Role - is to find the data and display it's details on the show page,
				along with it also display it's associated data
		path - product_path(:id)
		URI  - /products/:id
		HTTP Method - GET
	edit
		Role - is to find the record from the db and display the details
				inside a form
		Path - edit_product_path(:id)
		URI  - /products/:id/edit
		HTTP Method - GET
	update
		Role - is to find the record from the db the user is trying to update,
				and update the values of the record with the parameters coming in
				from the form if the validations pass, else display the error msg
		Path - product_path(:id)
		URI  - products/:id
		HTTP Method - PATCH
	destroy
		ROle - is to find the record from the db and delete it, once deleted 
				redirect the user to a new page.
		Path - product_path(:id)
		URI  - /products/:id
		HTTP Method - DELETE
=end

# filter
before_action :authenticate_user!, except: [:index, :show]
before_action :check_is_admin, except: [:index, :show]
	def index
		# sleep(2)
		 # binding.pry
		if params[:category_id] == ""
		 	# binding.pry
			@products = Product.where(price: params["start_rate"]..params["end_rate"]).offset(params[:offset]).limit(50)
			render json: @products.map{|p| p.attributes.merge({category_name: p.category.name})};
		elsif params[:category_id]
			# binding.pry
			@products = Product.where(price: params["start_rate"]..params["end_rate"]).where(category_id: params[:category_id].split(",")).offset(params[:offset]).limit(50)
			render json: @products.map{|p| p.attributes.merge({category_name: p.category.name})};
		else
			@products = Product.all
		end
		 # binding.pry
		# respond_to do |format|
		# 	format.html 
		# 	format.json {render json: @products}
		# end
	end

	def new
		@product = Product.new
	end

	def create 
		@product = Product.new(params[:product].permit(:name, :category_id, :description, :price, :stock, :code, :COD_eligibility))
		if @product.save
			redirect_to products_path, notice: "Successfully created the product"
		else
			render action: "new"
		end
	end

	def show
		@product = Product.find(params[:id])
		@cart_line_item = CartLineItem.new
		@review = Review.new
		@wishlist = Wishlist.new
		# @categories = Category.find(@product.category_id)
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(params[:product].permit(:name, :category_id, :description, :price, :stock, :code, :COD_eligibility))
			redirect_to products_path, notice: "Successfully updated the product"
		else
			render action: "edit"
		end
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to products_path, notice: "Successfully destroyed the product"
	end

end
