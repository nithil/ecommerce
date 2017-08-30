class Wishlist < ActiveRecord::Base
	belongs_to :cart_line_item
	belongs_to :user
	belongs_to :product
	validates_presence_of :user_id, :product_id
	validates_numericality_of :user_id, :product_id

		# def save_or_update

		# line_item = CartLineItem.find_by(user_id: self.user_id, product_id: self.product_id)

		# if line_item.nil?
		# 	self.save
		# else
		# 	return "exists"
		# end
	# end
end
