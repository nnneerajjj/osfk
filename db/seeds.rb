# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
user = User.new(email: "luddement@gmail.com", password: "hejsan123", approved: true)
user.admin = true
user.save

role = Role.new
role.name = "Administrator"
role.save

page = Page.create(title: 'Hem', header: 'Bostadsrättsförening', content: '.', public: true)
page.key = 'home'
page.save!

page = Page.create(title: 'Kontakt', header: 'Kontakta oss', content: '.', public: true)
page.key = 'contact'
page.save!

page = Page.create(title: 'Medlemmar', header: 'Lista på registrerade medlemmar', content: '.', public: false)
page.key = 'members'
page.save!

#(1..20).each {|x| News.create(subject: Faker::Lorem.sentence, content: Faker::Lorem.paragraph(200, false)) }
