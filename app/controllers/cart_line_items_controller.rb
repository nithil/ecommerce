class CartLineItemsController < ApplicationController

	def create
		@cart_line_item = CartLineItem.new(params[:cart_line_item].permit(:quantity, :product_id))

		@cart_line_item.user_id = current_user.id # 

		@wishlist = Wishlist.find_by(user_id: @cart_line_item.user_id, product_id: @cart_line_item.product_id)
		
		if @cart_line_item.save_or_update 
			if @wishlist != nil
				@wishlist.destroy
			end
			redirect_to cart_line_items_path, notice: "Successfully added product to the cart"
			# redirect_to :back, notice: "Successfully added product to the cart"
			# show the same page with success notice
		end
	end

	def index
		# binding.pry
		# @cart_line_items = current_user.cart_line_items
		@cart_line_items = current_user.cart_line_items
		@wishlist = Wishlist.new
		@order = Order.new
		@address = Address.new
		# binding.pry
	end

	def destroy
		@cart_line_item = CartLineItem.find(params[:id])
		@cart_line_item.destroy
		redirect_to cart_line_items_path, notice: "Successfully deleted the product"
		
	end
	def edit
		@cart_line_item = CartLineItem.find(params[:id])
	end

	def update
		@cart_line_item = CartLineItem.find(params[:id])
		if @cart_line_item.update_attributes(params[:cart_line_item].permit(:quantity))
			redirect_to cart_line_items_path, notice: "Successfully updated the cart"
		end
	end
end
