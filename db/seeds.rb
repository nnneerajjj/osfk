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
role.name = "administrator"
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


image = ImageUpload.new
image.file = open('http://s3-eu-west-1.amazonaws.com/osfksite/image_uploads/files/000/000/006/original/mosson.jpg?1411233732')
image.save!
content = 'Stora Mossön, vår klubbö, ligger mellan Skeppsdals brygga och Linanäs på Ljusterö. Här finns allt vad vi fiskeklubbmedlemmar behöver. Ön är relativt lättillgänglig, har bra fiskevatten dessutom bryggor och ett självservicehus. Huset har vedspis, värmekamin, gasolkök och möjlighet för tillfällig övernattning. Det finns också en brunn med bra dricksvatten, fiskrök och vedeldad bastu.'
slide = Slide.create(header: 'Stora mossön', header2: '- N 59°28,90   E 18°28,90', content: content, link: '')
slide.image_upload = image
slide.save!

image2 = ImageUpload.new
image2.file = open('http://s3-eu-west-1.amazonaws.com/osfksite/image_uploads/files/000/000/005/original/drangsjon.JPG?1411233698')
image2.save!
content2 = 'Fiskeutsättning utav regnbåge. Medelvikten ligger på ca. 1,5 kg, men ett antal väger upp mot 3 kg. Isen är upp mot 50 cm men skiktad och stöpe förekommer.'
slide2 = Slide.create(header: 'Drängsjön', header2: '- Dommaruden', content: content2, link: '')
slide2.image_upload = image2
slide2.save!



image3 = ImageUpload.new
image3.file = open('http://s3-eu-west-1.amazonaws.com/osfksite/image_uploads/files/000/000/012/original/fiske.JPG?1411238162')
image3.save!
content3 = 'Ungdomarna på bilden, 15-18 år gamla, kommer från Syrien, Irak, Eritrea, Somalia och Afganistan fick se lite av Roslagen från båt, prova på att dra strömming och att jigga efter abborre. Stor entusiasm och hjälpvillighet noterades bland ungdomarna som också fick prova på att ro ÖSFKs små fiskebåtar och att bada bastu.'
slide3 = Slide.create(header: 'Ungdomsverksamhet', header2: '- För att prova på', content: content3, link: '')
slide3.image_upload = image3
slide3.save!

image4 = ImageUpload.new
image4.file = open('http://s3-eu-west-1.amazonaws.com/osfksite/image_uploads/files/000/000/014/original/lion.JPG?1411238796')
image4.save!
content4 = 'ÖSFKs representanter, ordförande Per Schilling och vice ordförande Jan Höglund mottog priset på 10 000 kr. Särskilt framhölls vårt engagemang i fiskevård och kontroll av kommunens fiskevatten'
slide4 = Slide.create(header: 'Lions Club', header2: '- Stipendieutdelning', content: content4, link: '')
slide4.image_upload = image4
slide4.save!





#(1..20).each {|x| News.create(subject: Faker::Lorem.sentence, content: Faker::Lorem.paragraph(200, false)) }
