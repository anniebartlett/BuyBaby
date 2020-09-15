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
toy = Product.create(
{
 #def create_products
 category: 'Toy'
 description: 'In good condition'
 condition: 'Good'
 size: 'Medium '
 colour: 'As per product'
 address: '10 Dowining Street London SW1A 2AA',
 price: '£10'
 seller: 'sandy_sells_stuff'
 }
 )
puts "created #{toy}"

boys clothing = Product.create(
{
 category: 'Boys Clothing'
 description: 'In good condition'
 condition: 'Used'
 size: 'Medium '
 colour: 'As per product'
 address: '56 Shoreditch High St, Hackney, London E1 6JJ',
 price: '£13'
 seller: 'sandy_sells_stuff'
)
}
puts "created #{boys_clothing}"

girls_clothing = Product.create (
{
 category: 'Girls-clothing'
 description: 'Good'
 condition: 'Used'
 size: 'Small'
 colour: 'As per product'
 address: '1 Wootton St,London SE1 8RT',
 price: '£7'
 seller: 'sandy_sells_stuff'
 )
}
puts "created #{girl_clothing}"

nursery = Product.create (
{
 category: 'Nursery'
 description: 'Good condition'
 condition: 'Used'
 size: 'Large'
 colour: 'As per product'
 address: '87-135 Brompton Rd, Knightsbridge, London SW1X 7XL',
 price: '£40'
 seller: 'sandy_sells_stuff'
 )
 }

puts "created #{nursery}"

pushchairs = Product.create (
 {
 category: 'Pushchairs'
 description: ' In Good condition'
 condition: 'Used'
 size: '0-1 Year'
 colour: 'As per product'
 address: '6 Southwark St, London SE1 1TQ',
 price: '£35'
 seller: 'sandy_sells_stuff'
)
}
puts "created #{pushchairs}"

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
            sleep(3)
            next
          end
          products.photos.attach(io: file, filename: 'product.png', content_type: 'image/png')
          products.save

        puts "Created #{products.id} - #{products.name}"
      end
    end
end

clean_database
create_user
scrape_product(boys_clothing)
scrape_product(girls_clothing)
scrape_product(toys)
scrape_product(crib)
scrape_product(prams)

puts "Finished!"

