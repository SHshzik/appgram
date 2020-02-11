u = User.create(id: 1, username: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email)

100.times do
  another_user = User.create(username: Faker::Name.name, phone: Faker::PhoneNumber.phone_number, email: Faker::Internet.email)
  room = Room.create
  room.users << [u, another_user]
  room.messages.create msg: Faker::Lorem.question, room: room, sender_id: u, status: Faker::Boolean.boolean
  room.messages.create msg: Faker::Lorem.question, room: room, sender_id: another_user, status: Faker::Boolean.boolean
  room.messages.create msg: Faker::Lorem.question, room: room, sender_id: another_user, status: Faker::Boolean.boolean
end
