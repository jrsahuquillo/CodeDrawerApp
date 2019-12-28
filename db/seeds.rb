# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user = User.find_by_id 1
["Carlos", "Pepe", "Juan", "Vicente", "Alfonso"].each do |u|
  user = User.create(email: "#{u}@mail.com", username: "#{u}", password: "password", password_confirmation: 'password')
  n = 1
  5.times do
    drawer = Drawer.create(title: "Drawer #{n}", description: "Description drawer #{n}", user: user)
    m = 1
    5.times do
      Codetool.create(title: "Codetool #{m}", content: "Content codetool #{m}", drawer: drawer, user: user)
      m += 1
    end
    5.times do
      Codetool.create(title: "Codetool #{m}", content: "Content codetool #{m}", drawer: drawer, user: user, public: true)
      m += 1
    end
    n += 1
  end
end
