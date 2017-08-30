class Address < ActiveRecord::Base
	belongs_to :user
	has_many :orders
	belongs_to :cart_line_item
	validates_presence_of :user_id, :street, :city, :landmark, :pin
	validates_numericality_of :user_id, :pin
	validates_length_of :pin, is:6
end
