u = User.create(id: 1, username: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email)

5.times do
  User.create(username: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email)
end

r = Room.create
r.users<<u

100.times do
  Message.create msg: 'Hello', sender_id: u.id, room: r
end
