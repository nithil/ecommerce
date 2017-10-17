class ReviewsController < ApplicationController
	def index
		@reviews = Review.all
	end
	
	def create
		@review = Review.new(params[:review].permit(:rating, :body, :product_id, :user_id))
		@review.user_id = current_user.id

		respond_to do |format|
			if @review.save
				# Notification.review_confirmation(@review).deliver!
				format.html {redirect_to :back, notice: "-----Successfully added a review------"}
				format.js
			else
				format.html {redirect_to :back, notice: "-----review body can't be blank-----"}
				format.js
			end
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
		respond_to do |format|
			format.html {redirect_to product_path(@review.product_id), notice: "-----Successfully deleted the review-----"}
			format.js
		end
	end
end
