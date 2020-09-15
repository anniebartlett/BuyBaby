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

puts 'creating products...'

def manual_create
  puts "creating manual products"

  manual_toy = Product.create(
    user_id: User.last.id,
    name: 'Teddy Bear',
    description: 'In good condition',
    address: '10 Downing Street, London, SW1A 2AA',
    condition: 'Good',
    size: 'Medium',
    colour: 'As per product',
    payment_options: Product::PAYMENT_OPTIONS.sample,
    category: 'playtime',
    price_cents: '£10',
    deliver_option: Product::DELIVERY_OPTIONS.sample
   )
  puts "created #{manual_toy.name}"

  manual_boys_top = Product.create(
    user_id: User.last.id,
    name: 'Dinosaur Top',
    description: 'In good condition',
    address: '56 Shoreditch High St, Hackney, London E1 6JJ',
    condition: 'Good',
    size: 'Medium',
    colour: 'As per product',
    payment_options: Product::PAYMENT_OPTIONS.sample,
    category: 'boys_clothing',
    price_cents: '£13',
    deliver_option: Product::DELIVERY_OPTIONS.sample
   )
  puts "created #{manual_boys_top.name}"

  manual_girls_top = Product.create(
    user_id: User.last.id,
    name: 'Dungaree Dress',
    description: 'In good condition',
    address: '1 Wootton St,London SE1 8RT',
    condition: 'Good',
    size: 'Medium',
    colour: 'As per product',
    payment_options: Product::PAYMENT_OPTIONS.sample,
    category: 'girls_clothing',
    price_cents: '£7',
    deliver_option: Product::DELIVERY_OPTIONS.sample
   )
  puts "created #{manual_girls_top.name}"

  manual_nursery = Product.create(
    user_id: User.last.id,
    name: 'Wooden Crib',
    description: 'In good condition',
    address: '87-135 Brompton Rd, Knightsbridge, London SW1X 7XL',
    condition: 'Good',
    size: 'Large',
    colour: 'As per product',
    payment_options: Product::PAYMENT_OPTIONS.sample,
    category: 'nursery_furniture',
    price_cents: '£30',
    deliver_option: Product::DELIVERY_OPTIONS.sample
   )
  puts "created #{manual_nursery.name}"

  manual_pram = Product.create(
    user_id: User.last.id,
    name: 'Mamas & Papas Pram',
    description: 'In good condition',
    address: '6 Southwark St, London SE1 1TQ',
    condition: 'Good',
    size: 'Large',
    colour: 'As per product',
    payment_options: Product::PAYMENT_OPTIONS.sample,
    category: 'pushchairs',
    price_cents: '£80',
    deliver_option: Product::DELIVERY_OPTIONS.sample
   )
  puts "created #{manual_pram.name}"
end

def scrape_product(product)
  puts "Creating products..."

  category = product.split("/")[6].capitalize

  doc = Nokogiri::HTML(open("#{product}"))

    doc.search('.productCard').each do |element|
      title = element.search('.productCard_title').text.strip
      price = element.search('.productCard_price').text.strip
      img = element.search('img').attribute('data-src')&.value

      unless img.nil? || title.nil?

        products = Product.create(
          user_id: User.last.id,
          name: title,
          description: "In good condition",
          address: "London ",
          condition: %w[Used Good New].sample,
          size: %w[Small Medium Large].sample,
          colour: "As per product",
          payment_options: Product::PAYMENT_OPTIONS.sample,
          category: category,
          # stripe_plan_name: "Test",
          price_cents: rand(5..20),
          deliver_option: Product::DELIVERY_OPTIONS.sample
        )
          file = URI.open(img)
          if file.class == StringIO
            file = URI.open("https://images.unsplash.com/photo-1527866512907-a35a62a0f6c5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2775&q=80")
          end
          products.photos.attach(io: file, filename: 'product.png', content_type: 'image/png')
          products.save

        puts "Created #{products.id} - #{products.name}"
      end
    end
end

clean_database
create_user
manual_create
scrape_product(boys_clothing)
scrape_product(girls_clothing)
scrape_product(toys)
scrape_product(crib)
scrape_product(prams)

puts "Finished!"

