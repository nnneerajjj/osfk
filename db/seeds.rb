# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#


# user = User.new(email: "luddement@gmail.com", password: "hejsan123", approved: true)
# user.admin = true
# user.save

# role = Role.new
# role.name = "administrator"
# role.save

# page = Page.create(title: 'Hem', header: 'Bostadsrättsförening', content: '.', public: true)
# page.key = 'home'
# page.save!

# page = Page.create(title: 'Kontakt', header: 'Kontakta oss', content: '.', public: true)
# page.key = 'contact'
# page.save!

# page = Page.create(title: 'Medlemmar', header: 'Lista på registrerade medlemmar', content: '.', public: false)
# page.key = 'members'
# page.save!


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

image = ImageUpload.new
image.file = open('http://www.sportnik.com/file/show/2031590')
image.save!
image2 = ImageUpload.new
image2.file = open('http://www.sportnik.com/file/show/2031588')
image2.save!
news = News.new
news.subject = "ÖSFK deltog på ungdomens dag 29/8 2014"
news.created_at = "2014-08-28 20:00:00"
news.content = "<p></p>I fredags, 29/8 , kl. 13-17 fanns ÖSFK på plats bakom Bergateatern och visade upp olika fiskemetoder och berättade om ÖSFKs verksamhet.&nbsp;<div><br></div><div>Högstadie- och gymnasieungdomar i kommunen hade ledigt för att besöka området där olika ideella föreningar visade upp vad de kan erbjuda ungdomar. ÖSFK ställde ut en fiskebåt med 8 riggade spön lämpliga att använda för fiske i i kommunens vatten.&nbsp;</div><div><br></div><div>På bilderna syns ungdomar som deltog och fick pris i tipstävlingen. Hi-Sport och Jaktia skänkte priser och Tommy A och Per S höll i arrangemanget från ÖSFKs sida.<br><div></div><p></p></div>"
news.image_upload_ids = [ image.id, image2.id ]
news.save!


image = ImageUpload.new
image.file = open('http://www.sportnik.com/file/show/2031784')
image.save!
image2 = ImageUpload.new
image2.file = open('http://www.sportnik.com/file/show/2031783')
image2.save!
news = News.new
news.subject = "Kanaldagsmetet söndag 31 augusti"
news.created_at = "2014-08-31 20:00:00"
news.content = "Vår traditionella metetävling denna dag hade totalt 25 deltagare. 12 barn i klassen 0-12 år och 13 vuxna. Härligt väder och god stämning där ÖSFK bjöd på grillad korv i samband med prisutdelningen efter tävlingen. Vinnare i barn och vuxenklasserna syns på bild. Jaktia och Hi-Sport skänkte priser. Resultat nedan!<p><table class='cms-table'><tbody><tr><td><strong class='cms-bold'>Resultat barn:</strong></td><td></td></tr><tr><td>1. Zacke Lundqvist</td><td>3,10 kg</td></tr><tr><td>2. Maliss</td><td>0,98 kg</td></tr><tr><td>3. Philip Knaberg </td><td>0,25 kg</td></tr><tr><td><strong class='cms-bold'>Resultat vuxna:</strong></td><td></td></tr><tr><td>1. Krister Nyberg</td><td>6,87 kg</td></tr><tr><td>2. Bertil Larsson</td><td>5,20 kg</td></tr><tr><td>3. Åke Leander</td><td>4,73 kg</td></tr></tbody></table><br></p>"
news.image_upload_ids = [ image.id, image2.id ]
news.save!



image = ImageUpload.new
image.file = open('http://www.sportnik.com/file/show/1918772')
image.save!
news = News.new
news.subject = "Fiskehelg St. Mossön fredag-söndag, 19/9 - 21/9"
news.created_at = "2014-09-10 20:00:00"
news.content = '<strong>Fiskeintresserade medlemmar träffas och umgås under dessa tre dagar på ön med fokus på fiske och beredning av fisk. Bl.annat röker vi fisk vi fångar. Erfarna medlemmar delar med sig av sina kunskaper.</strong><p>Med fokus på fiske, trevlig samvaro och tillagning av fångad fisk träffas vi som kan och vill denna helg på Mossön. Lördagen blir huvuddag. Vi lägger vårt stora strömmingssköte fredag eftermiddag, upptag lördag morgon, och tror på mycket strömming!</p><p>Vi satsar på olika fiskemetoder. De som kan lite mer delar gärna med sig av sina kunskaper till de som vill lära sig mer.</p><p>Vi får våra fiskar varma (och oss själva) med hjälp av bastun, röken, grillen, kaminen i stugan och medhavt (varma kläder viktigt!?</p><p>Lördagens fångster använder vi i första hand för gemensam tillagning. T.ex.(preliminärt beroende på tillgång) rökt strömming och sik, flamstekta gös, abborr och sikfileer. Lördag afton satsar vi på gravad havsörings (alt. norsk lax)file eller annat gott, som tillagas i förväg.</p><p>Klubben införskaffar och bjuder på tillbehör till fiskfrosseriet på lördagen såsom potatis, såser/röror, grönsaker och smör o bröd och gravad havsöring (norsk lax) file eller annat gott. Drycker tar var och en med själv!</p><p>Varmt välkomna alla medlemmar med familj (gärna ser vi barn och ungdomar)</p><p>För ÖSFK,</p><p>Ansvariga Per Schilling-Tommy Almqvist-Thomas Trägårdh</p>'
news.image_upload_ids = [ image.id ]
news.save!


user = User.new(email: "luddement+arlen@gmail.com", firstname: "Arlen", lastname: "Rios", password: "arlen123", approved: true)
user.admin = true
user.save

topic = Topic.new
topic.subject = "Vad saknas?"
topic.content = "Hej!\r\n\r\nVad saknas på nya hemsidan?\r\n\r\nOch vad skulle kunna förbättras?"
topic.user = user
topic.save!



event = Event.new
event.subject = "Fiskehelg"
event.start_date =  "2014-09-26 10:00:00"
event.end_date =  "2014-09-28 00:00:00"
event.location = "Stora mossön"
event.created_by = user
event.can_participate = true
event.content = "<strong>Fiskeintresserade medlemmar träffas och umgås under dessa tre dagar på ön med fokus på fiske och beredning av fisk. Bl.annat röker vi fisk vi fångar. Erfarna medlemmar delar med sig av sina kunskaper.</strong><p>Med fokus på fiske, trevlig samvaro och tillagning av fångad fisk träffas vi som kan och vill denna helg på Mossön. Lördagen blir huvuddag. Vi lägger vårt stora strömmingssköte fredag eftermiddag, upptag lördag morgon, och tror på mycket strömming!</p><p>Vi satsar på olika fiskemetoder. De som kan lite mer delar gärna med sig av sina kunskaper till de som vill lära sig mer.</p><p>Vi får våra fiskar varma (och oss själva) med hjälp av bastun, röken, grillen, kaminen i stugan och medhavt (varma kläder viktigt!?</p><p>Lördagens fångster använder vi i första hand för gemensam tillagning. T.ex.(preliminärt beroende på tillgång) rökt strömming och sik, flamstekta gös, abborr och sikfileer. Lördag afton satsar vi på gravad havsörings (alt. norsk lax)file eller annat gott, som tillagas i förväg.</p><p>Klubben införskaffar och bjuder på tillbehör till fiskfrosseriet på lördagen såsom potatis, såser/röror, grönsaker och smör o bröd och gravad havsöring (norsk lax) file eller annat gott. Drycker tar var och en med själv!</p><p>Varmt välkomna alla medlemmar med familj (gärna ser vi barn och ungdomar)</p><br>"
event.save!






















puts "Seed OK!"
