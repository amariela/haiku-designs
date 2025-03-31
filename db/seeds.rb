# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# require "nokogiri"
# require "httparty"
# require "faker"

# Category data
# Category.destroy_all

# Category.create(name: "Home")
# Category.create(name: "Office")
# Category.create(name: "Outdoor")
# Category.create(name: "Dining")

# puts "Created a total of #{Category.count} categories."


# def proper_price(price)
#     price.gsub(/[$,]/, '').to_f
# end

# # HOME category products
# home_category = Category.find_by(name: "Home")

# home_url = "https://luxefurniture.ca/collections/living-room?view=view-36&grid_list=grid-view"
# home_response = HTTParty.get(home_url)

# if home_response.code == 200
#     home_parsed_page = Nokogiri::HTML(home_response.body)
#     home_products = home_parsed_page.css('div.productitem--info')
#     home_count = 0
#     home_products.each do |product|
#         if home_count == 25
#             break
#         end
#         name = product.css('h2.productitem--title > a')
#         price = product.css('div.price--main > span.money')
#         home_category.products.create(
#             name: name.text.strip,
#             description: Faker::Marketing.buzzwords,
#             price: proper_price(price.text.strip),
#             stock_quantity: Faker::Number.number(digits: 3)
#         )
#         home_count += 1
#     end
#     home_products = Product.where(category_id: home_category.id)
#     puts "Created a total of #{home_products.count} home products."
# end

# # OUTDOOR category products
# outdoor_category = Category.find_by(name: "Outdoor")

# outdoor_url = "https://luxefurniture.ca/collections/outdoor-dining-tables?view=view-36&grid_list=grid-view"
# outdoor_response = HTTParty.get(outdoor_url)

# if outdoor_response.code == 200
#     outdoor_parsed_page = Nokogiri::HTML(outdoor_response.body)
#     outdoor_products = outdoor_parsed_page.css('div.productitem--info')
#     outdoor_count = 0
#     outdoor_products.each do |product|
#         if outdoor_count == 25
#             break
#         end
#         outdoor_name = product.css('h2.productitem--title > a')
#         outdoor_price = product.css('div.price--main > span.money')
#         outdoor_category.products.create(
#             name: outdoor_name.text.strip,
#             description: Faker::Marketing.buzzwords,
#             price: proper_price(outdoor_price.text.strip),
#             stock_quantity: Faker::Number.number(digits: 3)
#         )
#         outdoor_count += 1
#     end
#     outdoor_products = Product.where(category_id: outdoor_category.id)
#     puts "Created a total of #{outdoor_products.count} outdoor products."
# end

# # OFFICE category products
# office_category = Category.find_by(name: "Office")

# office_url = "https://luxefurniture.ca/collections/artwork-wall-decor?view=view-36&grid_list=grid-view"
# office_response = HTTParty.get(office_url)

# if office_response.code == 200
#     office_parsed_page = Nokogiri::HTML(office_response.body)
#     office_products = office_parsed_page.css('div.productitem--info')
#     office_count = 0
#     office_products.each do |product|
#         if office_count == 30
#             break
#         end
#         office_name = product.css('h2.productitem--title > a')
#         office_price = product.css('div.price--main > span.money')
#         office_category.products.create(
#             name: office_name.text.strip,
#             description: Faker::Marketing.buzzwords,
#             price: proper_price(office_price.text.strip),
#             stock_quantity: Faker::Number.number(digits: 2)
#         )
#         office_count += 1
#     end
#     office_products = Product.where(category_id: office_category.id)
#     puts "Created a total of #{office_products.count} office products."
# end


# # DINING category products
# dining_category = Category.find_by(name: "Dining")

# dining_url = "https://luxefurniture.ca/collections/diningroom"
# dining_response = HTTParty.get(dining_url)

# if dining_response.code == 200
#     dining_parsed_page = Nokogiri::HTML(dining_response.body)
#     dining_products = dining_parsed_page.css('div.productitem--info')
#     dining_count = 0
#     dining_products.each do |product|
#         if dining_count == 40
#             break
#         end
#         dining_name = product.css('h2.productitem--title > a')
#         dining_price = product.css('div.price--main > span.money')
#         dining_category.products.create(
#             name: dining_name.text.strip,
#             description: Faker::Marketing.buzzwords,
#             price: proper_price(dining_price.text.strip),
#             stock_quantity: Faker::Number.number(digits: 2)
#         )
#         dining_count += 1
#     end
#     dining_products = Product.where(category_id: dining_category.id)
#     puts "Created a total of #{dining_products.count} dining products."
# end

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
