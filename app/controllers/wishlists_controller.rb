class WishlistsController < ApplicationController
	def index
		@wishlists = Wishlist.all
		@cart_line_item = CartLineItem.new
	end

	def create
		@wishlist = Wishlist.new(params[:wishlist].permit(:user_id, :product_id))
		@wishlist.user_id = current_user.id

		cart_product = CartLineItem.find_by(user_id: @wishlist.user_id, product_id: @wishlist.product_id)

		if @wishlist.save
			if cart_product != nil
				cart_product.destroy
			end
			redirect_to wishlists_path, notice: "Product added to wishlist"
		else
			redirect_to wishlists_path, notice: "error occured"
		end
	end

	def destroy
		@wishlist = Wishlist.find(params[:id])
		@wishlist.destroy
		redirect_to :back, notice: "Successfully removed product from wishlist"
	end
end
