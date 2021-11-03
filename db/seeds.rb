# Nettoyage de la BDD
User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
Tagger.destroy_all
PrivateMessage.destroy_all
Comment.destroy_all
Like.destroy_all

Faker::Config.locale="fr"

# Création de 10 villes
10.times do
  City.create(
    name:Faker::Address.city, 
    zip_code:"#{'%02d' % rand(00..77)}000"
  )
end
cities_array = City.all

# Création de 10 users
10.times do |i|
  rand_fname = Faker::Name.unique.first_name
  rand_lname = Faker::Name.unique.last_name
  User.create(
    first_name: rand_fname,
    last_name: rand_lname,
    description: Faker::Lorem.sentence(word_count: 4),
    email: "#{rand_fname}.#{rand_lname}@mail.com",
    age: rand(18..77),
    city:cities_array[rand(0..9)]
  )
end
User.create(first_name:"anonymous", last_name:"anonymous",description:"utilisateur test",email:"anonymous@gmail.com",age:"20",city:cities_array.first)
users_array = User.all

# Création de 20 gossips
20.times do |i|
  chuckborisfact = Faker::ChuckNorris.fact.gsub('Chuck Norris', 'Chuck Boris')
  Gossip.create(
    title:"Potin n°#{i}",
    content:chuckborisfact,
    user:users_array[rand(0..9)]
  )
end
gossips_array = Gossip.all

# Création de 10 tags
# 10.times do
#   Tag.create(
#     title: Faker::SlackEmoji.unique.people
#   )
# end
emojis_array = ["😘", "😥", "😮", "😎", "😭", "😂", "🤮", "😳", "😱", "🤯"]
10.times do |i|
  Tag.create(title:emojis_array[i])
end
tags_array = Tag.all

# Création des Taggers, qui associent les messages à leurs tags respectifs 
Gossip.all.each do |each_gossip|
  # random_times = rand(1..2)
  # random_times.times do 
    Tagger.create(
      gossip: each_gossip,
      tag: tags_array[rand(0...tags_array.length)]
    )
  # end
end

# Création de messages privés
10.times do
  PrivateMessage.create(
    content: Faker::Quote.yoda, 
    sender: users_array[rand(0...users_array.length)],
    recipient: users_array[rand(0...users_array.length)]
  )
end

# Création de 10 commentaires sur les Gossip
10.times do 
  Comment.create(
    content: Faker::Quotes::Chiquito.expression,
    commentable: gossips_array[rand(0...gossips_array.length)],
    user: users_array[rand(0...users_array.length)]
  )
end
comments_array = Comment.all

# Création de 10 commentaires sur les commentaires #polymorphismception

# 10.times do 
#   Comment.create(
#     content: Faker::Quotes::Chiquito.expression,
#     commentable: comments_array[rand(0...comments_array.length)],
#     user: users_array[rand(0...users_array.length)]
#   )
# end

# Création de 20 likes, aléatoirement sur des Gossip ou des Comment
20.times do
  if rand(0..1) == 1
    Like.create(
      likeable: gossips_array[rand(0...gossips_array.length)],
      user: users_array[rand(0...users_array.length)]
    )
  else
    Like.create(
      likeable: comments_array[rand(0...comments_array.length)],
      user: users_array[rand(0...users_array.length)]
    )
  end
end