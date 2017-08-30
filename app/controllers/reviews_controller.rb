class ReviewsController < ApplicationController
	def index
		@reviews = Review.all
	end
	
	def create
		@review = Review.new(params[:review].permit(:rating, :body, :product_id, :user_id))
		@review.user_id = current_user.id
		if @review.save
			Notification.review_confirmation(@review).deliver!
			redirect_to :back, notice: "-----Successfully added a review------"
		else
			redirect_to :back, notice: "-----review body can't be blank-----"
		end
	end

	def edit
		@review = Review.find(params[:id])
	end

	def update
		@review = Review.find(params[:id])
		if @review.update_attributes(params[:review].permit(:rating, :body, :product_id, :user_id))
			redirect_to product_path(@review.product_id), notice: "-----Successfully updated a review-----"
		else
			render action: "edit"
		end
	end

	def destroy
		@review = Review.find(params[:id])
		@review.destroy
		redirect_to product_path(@review.product_id), notice: "-----Successfully deleted the review-----"
	end
end
