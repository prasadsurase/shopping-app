# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.destroy_all
Item.create!([
            { name: 'Smart Hub', price: 49.99, discount: 0 },
            { name: 'Motion Sensor', price: 24.99, discount: 0 },
            { name: 'Wireless Camera', price: 99.99, discount: 0 },
            { name: 'Smoke Sensor', price: 19.99, discount: 0 },
            { name: 'Water Leak Sensor', price: 14.99, discount: 0 }
])

PromoCode.destroy_all
PromoCode.create!([
                 { code: '20%OFF', combined: false, discount_type: 'percentage', active: true, value: 20 },
                 { code: '5%OFF', combined: true, discount_type: 'percentage', active: true, value: 5 },
                 { code: '20POUNDSOFF', combined: true, discount_type: 'value', active: true, value: 20 }

])
