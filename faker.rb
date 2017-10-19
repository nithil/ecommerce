# require 'faker'

10.times do 
	category = Category.new({"name" => Faker::Commerce.department(1)})
	category.save
end

400.times do
	product = Product.new({"name" => Faker::Commerce.product_name, "price" => Faker::Commerce.price(10..1000), "description" => Faker::Lorem.sentence, "category_id" => Category.all.sample.id})
	product.save
end