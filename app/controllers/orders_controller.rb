class OrdersController < ApplicationController

	def index
		# Order.where('user_id = ?', current_user.id)
		@orders = current_user.orders
	end

	def create
		binding.pry
		@order = Order.new(params[:order].permit(:address_id))
		@order.order_date = Date.today
		@order.order_number = "DCT#{Random.rand(1000)}"
		@order.user_id = current_user.id
		@order.save
		#Notification.order_confirmation(@order).deliver!
		redirect_to orders_path, notice: "Your order has been placed"
	end
end
