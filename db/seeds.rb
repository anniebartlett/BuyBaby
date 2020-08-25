require "open-uri"

prams = "https://www.mamasandpapas.com/en-gb/c/travel/pushchairs/pushchairs-all/pushchairs-prams"
crib = "https://www.mamasandpapas.com/en-gb/c/nursery/nursery-furniture/cots-cribs-cotbeds"
toys = "https://www.mamasandpapas.com/en-gb/c/toys-gifts/playtime"
boys_clothing = "https://www.mamasandpapas.com/en-gb/c/clothing/boys-clothing"
girls_clothing = "https://www.mamasandpapas.com/en-gb/c/clothing/girls-clothing"

def clean_database
  puts "Cleaning database..."
  Product.destroy_all
  User.destroy_all
  Order.destroy_all
  puts "Database clean..."
end

def create_user
  puts "Creating user..."
  user = User.create(name: 'lisa', email: 'lisa@me.com', password: '123456', nickname: 'lisa_sells_stuff', description: 'Good seller')
  puts "Created #{user.name}"
end

def scrape_product(product)
  puts "Creating products..."

  category = product.split("/")[5].capitalize

  doc = Nokogiri::HTML(open("#{product}"))

    doc.search('.productCard').each do |element|
      title = element.search('.productCard_title').text.strip
      price = element.search('.productCard_price').text.strip
      img = element.search('img').attribute('data-src')&.value

      unless img.nil? || title.nil?

        products = Product.new(
          user_id: User.first.id,
          name: title,
          description: "In great condition, your kids will love this!",
          location: "London",
          condition: %w[Used Good New].sample,
          size: %w[Small Medium Large].sample,
          colour: "As per product",
          payment_options: Product::PAYMENT_OPTIONS.sample,
          category: category,
          # stripe_plan_name: "Test",
          # price_cent: price,
          deliver_option: Product::DELIVERY_OPTIONS.sample
        )
          file = URI.open(img)
          products.photos.attach(io: file, filename: 'product.png', content_type: 'image/png')
          products.save!

        puts "Created #{products.id} - #{products.name}"
      end
    end
end

clean_database
create_user
scrape_product(prams)
scrape_product(crib)
scrape_product(toys)
scrape_product(boys_clothing)
scrape_product(girls_clothing)

puts "Finished!"

