require "open-uri"

boys_clothing = "https://www.mamasandpapas.com/en-gb/c/clothing/boys-clothing"
girls_clothing = "https://www.mamasandpapas.com/en-gb/c/clothing/girls-clothing"
toys = "https://www.mamasandpapas.com/en-gb/c/toys-gifts/playtime"
crib = "https://www.mamasandpapas.com/en-gb/c/nursery/nursery-furniture/cots-cribs-cotbeds"
prams = "https://www.mamasandpapas.com/en-gb/c/travel/pushchairs/pushchairs-all/pushchairs-prams"

def clean_database
  puts "Cleaning database..."
  Product.destroy_all
  User.destroy_all
  Order.destroy_all
  puts "Database clean..."
end

def create_user
  puts "Creating user..."
  user_1 = User.create(name: 'lisa', email: 'lisa@me.com', password: '123456', nickname: 'lisa_buys_stuff', description: 'Good buyer')
  user_2 = User.create(name: 'sandy', email: 'sandy@me.com', password: '123456', nickname: 'sandy_sells_stuff', description: 'Good seller')
  puts "Created #{user_1.name}"
  puts "Created #{user_2.name}"
end

def scrape_sell_product(product)
  puts "Creating products..."

  category = product.split("/")[6].capitalize

  doc = Nokogiri::HTML(open("#{product}"))

    doc.search('.productCard').each do |element|
      title = element.search('.productCard_title').text.strip
      price = element.search('.productCard_price').text.strip
      img = element.search('img').attribute('data-src')&.value

      address = [
        "82a Jerningham Road, London, SE14 5NW",
        "156 Lewisham High Street, London, SE13 6LG",
        "4 Clarendon Rise, London, SE13 5ES",
        "144 Lee High Road, Lonsdon, SE13 5PR",
        "Lee Terrace, London, SE13 5DL",
        "10A Wisteria Road, London, SE13 5HN",
        "292 Lewisham High Street, London, SE13 6JZ",
        "47 Vicars Hill, London, SE13 7JN",
        "172 Adelaide Avenue, London, SE4 1JN",
        "81 Tressillian Road, London, SE4 1XZ",
        "12 Montague Avenue, London, SE4 1YP",
        "54 Campshill Road, London, SE13 6QT",
        "55 Ermine Road, London, SE13 7JJ",
        "122 Marsala Road, London, SE13 7AF",
        "267 Broadway, London, DA6 8DB",
        "123 Mayday Gardens, London, SE3 8NP",
        "64 Blackfen Road, Lonsdon, DA15 8SW",
        "7 Newmarket Green, London, SE9 5ER",
        "117 Burnt Ash Hill, London, SE12 0AJ",
      ]

      unless img.nil? || title.nil?

        products = Product.create(
          user_id: User.last.id,
          name: title,
          description: "In good condition",
          address: address.sample,
          condition: %w[Used Good New].sample,
          size: %w[Small Medium Large].sample,
          colour: "As per product",
          payment_options: Product::PAYMENT_OPTIONS.sample,
          category: category,
          price_cents: rand(0..20),
          sale_type: %w[Sell Swap].sample,
          deliver_option: Product::DELIVERY_OPTIONS.sample
        )
          file = URI.open(img)
          if file.class == StringIO
            file = URI.open("https://images.unsplash.com/photo-1527866512907-a35a62a0f6c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2775&q=80")
          end
          products.photos.attach(io: file, filename: 'product.png', content_type: 'image/png')
          products.save!

        puts "Created #{products.id} - #{products.name}, #{products.address}"
      end
    end
end

def create_reviews
  20.times do
    reviews = Review.create(
      user_id: User.first.id,
      comment: ["Good experience with seller", "Product was in good condition and seller was great", "Would highly recommend this seller!"].sample,
      rating: rand(3..5),
      reviewer_id: User.first.id,
      reviewed_id: User.last.id,
      )
    reviews.save
  puts "Created review #{reviews.id}"
  end
end

def amend_swap_price
  @products = Product.all
  @products = Product.where(sale_type: "Swap").update_all(price_cents: 0)
  @products = Product.where(price_cents: 0).update_all(sale_type: "Swap")
  puts "Amended swap prices"
end

clean_database
create_user
scrape_sell_product(boys_clothing)
scrape_sell_product(girls_clothing)
scrape_sell_product(toys)
scrape_sell_product(crib)
scrape_sell_product(prams)
create_reviews
amend_swap_price

puts "Finished!"
