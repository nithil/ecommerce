class HomeController < ApplicationController

  def index
  	@categories = Category.order('name DESC')
  	@products = Product.all
  end
end
