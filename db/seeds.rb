# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([{name: 'ファッション'}, {name: 'ねこ'}, {name: 'いぬ'}, {name: 'そら'}, {name: 'ビーチ'}, {name: 'インテリア'}])

Tag.create([
  {category_id: 1, name: 'ootd'}, {category_id: 1, name: 'outfit'}, {category_id: 1, name: 'coordinate'},
  {category_id: 1, name: 'ladyupshoes'}, {category_id: 1, name: 'hairarrange'},
  {category_id: 2, name: 'cat'}, {category_id: 2, name: 'kitten'}, {category_id: 2, name: 'ilovemycat'},
  {category_id: 2, name: 'lovekittens'}, {category_id: 2, name: 'catlover'},
  {category_id: 3, name: 'dog'}, {category_id: 3, name: 'puppy'}, {category_id: 3, name: 'ilovemydog'},
  {category_id: 3, name: 'lovedogs'}, {category_id: 3, name: 'doglover'},
  {category_id: 4, name: 'sun'}, {category_id: 4, name: 'sunnyday'}, {category_id: 4, name: 'sunshine'},
  {category_id: 4, name: 'goodday'}, {category_id: 4, name: 'bluesky'},
  {category_id: 5, name: 'beach'}, {category_id: 5, name: 'beachtime'}, {category_id: 5, name: 'beachside'},
  {category_id: 5, name: 'seaside'}, {category_id: 5, name: 'oceanfront'},
  {category_id: 6, name: 'インテリア'}, {category_id: 6, name: 'インテリア雑貨'}, {category_id: 6, name: '北欧インテリア'},
  {category_id: 6, name: 'ナチュラルインテリア'}, {category_id: 6, name: 'アンティークインテリア'},
])
