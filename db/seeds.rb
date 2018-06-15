# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Departure.create(from: "Split",to: "Zagreb",departureDate: "2018-06-20 14:00:00",arrival: "2018-06-20 19:00:00",numberOfTickets:20,price: 20,idCompany: 1)
Departure.create(from: "Zagreb",to: "Split",departureDate: "2018-06-20 14:00:00",arrival: "2018-06-20 19:00:00",numberOfTickets:30,price: 5,idCompany: 1)
Departure.create(from: "Split",to: "Rijeka",departureDate: "2018-06-21 12:00:00",arrival: "2018-06-20 19:30:00",numberOfTickets:50,price: 25,idCompany: 2)
Departure.create(from: "Zagreb",to: "Osijek",departureDate: "2018-06-22 08:00:00",arrival: "2018-06-20 13:00:00",numberOfTickets:22,price: 20,idCompany: 3)
Departure.create(from: "Split",to: "Zagreb",departureDate: "2018-06-20 14:00:00",arrival: "2018-06-20 19:00:00",numberOfTickets:20,price: 20,idCompany: 4)
Departure.create(from: "Zagreb",to: "Slavonski Brod",departureDate: "2018-06-22 14:00:00",arrival: "2018-06-20 19:00:00",numberOfTickets:20,price: 20,idCompany: 3)
Departure.create(from: "Zagreb",to: "VaraŽdin",departureDate: "2018-06-17 11:00:00",arrival: "2018-06-20 14:00:00",numberOfTickets:20,price: 20,idCompany: 2)
Departure.create(from: "Zagreb",to: "Sisak",departureDate: "2018-06-16 14:30:00",arrival: "2018-06-20 15:30:00",numberOfTickets:25,price: 10,idCompany: 2)
Departure.create(from: "Split",to: "Zagreb",departureDate: "2018-06-20 14:45.00",arrival: "2018-06-20 20:00:00",numberOfTickets:20,price: 20,idCompany: 3)
Departure.create(from: "Zagreb",to: "Split",departureDate: "2018-06-21 11:00:00",arrival: "2018-06-20 16:00:00",numberOfTickets:20,price: 20,idCompany: 4)
Departure.create(from: "Split",to: "Zagreb",departureDate: "2018-06-20 14:00:00",arrival: "2018-06-20 19:00:00",numberOfTickets:20,price: 20,idCompany: 2)
Departure.create(from: "Rijeka",to: "Zagreb",departureDate: "2018-06-21 14:00:00",arrival: "2018-06-21 17:00:00",numberOfTickets:20,price: 20,idCompany: 4)
Departure.create(from: "Split",to: "Zagreb",departureDate: "2018-06-21 14:30:00",arrival: "2018-06-21 19:30:00",numberOfTickets:20,price: 20,idCompany: 1)
Company.create(email:"prometMakarska@gmail.com",name:"Promet Makarska",password:"123456",password_confirmation:"123456")
Company.create(email:"ariva@gmail.com",name:"Ariva",password:"123456",password_confirmation:"123456")
Company.create(email:"chazmatrans@gmail.com",name:"Chazmatrans",password:"123456",password_confirmation:"123456")
Company.create(email:"flixBus@gmail.com",name:"FlixBus",password:"123456",password_confirmation:"123456")

