# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require "nokogiri"
require "httparty"
require "faker"


# Category data
# Category.destroy_all

# Category.create(name: "Storage")
# Category.create(name: "Home")
# Category.create(name: "Office")
# Category.create(name: "Outdoor")

# puts "Created a total of #{Category.count} categories."


def proper_price(price)
    price.gsub(/[$,]/, '').to_f
end

# Home category products
home_category = Category.find_by(name: "Home")

home_url = "https://luxefurniture.ca/collections/living-room?view=view-36&grid_list=grid-view"
home_response = HTTParty.get(home_url)

if home_response.code == 200
    home_parsed_page = Nokogiri::HTML(home_response.body)
    home_products = home_parsed_page.css('div.productitem--info')
    count = 0
    home_products.each do |product|
        if count == 25
            break
        end
        name = product.css('h2.productitem--title > a')
        price = product.css('div.price--main > span.money')
        home_category.products.create(
            name: name.text.strip,
            description: Faker::Marketing.buzzwords,
            price: proper_price(price.text.strip),
            stock_quantity: Faker::Number.number(digits: 3)
        )
        count += 1
    end
    products = Product.where(category_id: home_category.id)
    puts "Created a total of #{products.count} products."
end

