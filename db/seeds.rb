# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

ingredient_url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
response = URI.open(ingredient_url)
json_response = JSON.parse(response.read)
ingredients = json_response['drinks']

puts 'Creating ingredients...'
ingredients.each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end
puts 'Ingredients created'

cocktails = [
  'mojito',
  'bloody mary',
  'whisky sour',
  'gin tonic',
  'pina colada',
  'caipirinha',
  'amaretto sour',
  'long island ice tea'
]

puts 'Creating cocktails...'
# mojito_image = URI.open('https://images.unsplash.com/photo-1551538827-9c037cb4f32a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2501&q=80')
# mojito = Cocktail.new(name: 'Mojito')
# mojito.photo.attach(io: mojito_image, filename: 'mojito.jpeg', content_type: 'image/jpeg')
# mojito.save
cocktails.each do |cocktail|
  image = URI.open("https://source.unsplash.com/600x1200/?#{cocktail}>")
  new_cocktail = Cocktail.new(name: cocktail.capitalize)
  new_cocktail.photo.attach(io: image, filename: "#{cocktail}.jpeg", content_type: 'image/jpeg')
  new_cocktail.save
end
puts 'Cocktails created'
