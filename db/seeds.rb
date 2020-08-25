puts "Cleaning database..."
User.destroy_all
Product.destroy_all


puts "Creating products..."

user = User.create(name: 'lisa', email: 'lisa@me.com', password: '1234561', nickname: 'liz', description: 'young mom')

20.times do
  product = Product.create(
    user_id: user.id,
    name: Faker::Name.first_name,
    description: %w[beautiful colourful pretty].sample,
    location: %w[london manchester dover].sample,
    condition: %w[good excellent ok].sample,
    size: rand(3..15),
  )
  product.save
  puts "Created #{product.name}"
end

puts "Finished!"

