class Vendor < ActiveRecord::Base
	validates :name, :email, presence: true, uniqueness: true
	validates :mobile, presence: true, uniqueness: true, numericality: true
end
