# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "manishjoon1987@gmail.com", password: "abcd1234")
User.create(email: "jmrlogistics16@gmail.com", password: "kiyaansh", admin: true)
User.update(email: "jmrlogistics16@gmail.com", password: "kiyansh2019", admin: true)