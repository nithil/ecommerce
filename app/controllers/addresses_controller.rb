class AddressesController < ApplicationController

	def index
		@addresses = Address.all
	end

	def new
		@address = Address.new
	end

	def create
		@address = Address.new(params[:address].permit(:street, :city, :landmark, :pin, :user_id))
		@address.user_id = current_user.id
		if @address.save
			redirect_to addresses_path, notice: "Successfully added address"
		else
			render action: "new"
		end
	end

	def edit
		@address = Address.find(params[:id])
	end

	def update
		@address = Address.find(params[:id])
		if @address.update_attributes(params[:address].permit(:street, :city, :landmark, :pin))
			redirect_to addresses_path, notice: "Successfully updated the address"
		else
			render action: "edit"
		end
	end

	def destroy
		@address = Address.find(params[:id])
		@address.destroy
		redirect_to addresses_path, notice: "Successfully removed the address"
	end
end
