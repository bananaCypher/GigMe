User.create!([
  {email: "callum@email.com", encrypted_password: "$2a$10$MjsL.oWBFRLwfYX14jzkSOCp1heQoXO9N8JRTfIiA.XJ4izdoCM2q", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 11, current_sign_in_at: "2016-01-10 14:49:31", last_sign_in_at: "2016-01-10 12:08:46", current_sign_in_ip: "::1", last_sign_in_ip: "::1", role: "admin", password: "password", password_confirmation: "password"},
  {email: "gigger1@email.com", encrypted_password: "$2a$10$ftq5ZyEBVWhB0aJTnXKZ4eaXOAeKkkyQSfezNPCrAy/AtqBDWs0.u", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2016-01-10 12:06:29", last_sign_in_at: "2016-01-09 17:31:39", current_sign_in_ip: "::1", last_sign_in_ip: "::1", role: nil, password: "password", password_confirmation: "password"},
  {email: "gigger2@email.com", encrypted_password: "$2a$10$dPkJrTLtqP9iXcY7GG9apuEiyEbIdahDUmZQ4tS131pvhn6ZWU6ZW", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 3, current_sign_in_at: "2016-01-09 18:07:33", last_sign_in_at: "2016-01-09 17:32:48", current_sign_in_ip: "::1", last_sign_in_ip: "::1", role: nil, password: "password", password_confirmation: "password"},
  {email: "gigger3@email.com", encrypted_password: "$2a$10$uzAW5JeONBrk8volSsFbYug57gOAsg.mZdSRnFv6gmYlDG.ceK69a", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2016-01-08 20:44:06", last_sign_in_at: "2016-01-08 20:44:06", current_sign_in_ip: "::1", last_sign_in_ip: "::1", role: nil, password: "password", password_confirmation: "password"}
])
Act.create!([
  {name: "AC/DC", description: "AC/DC are an Australian hard rock band, formed in November 1973 by brothers Malcolm and Angus Young, who continued as members until Malcolms illness and departure in 2014. Commonly referred to as a hard rock or blues rock band, they are also considered pioneers of heavy metal and are sometimes classified as such, though they have always dubbed their music as simply \"rock and roll\"", image: "https://upload.wikimedia.org/wikipedia/commons/b/bc/ACDC_in_St._Paul,_November_2008.jpg"},
  {name: "Rage Against the Machine", description: "Rage Against the Machine is an American rap metal band from Los Angeles, California. Formed in 1991, the group consisted of rapper and vocalist Zack de la Rocha, bassist and backing vocalist Tim Commerford, guitarist Tom Morello and drummer Brad Wilk. They draw inspiration from early heavy metal instrumentation, as well as hip hopacts such as Afrika Bambaataa, Public Enemy, the Beastie Boys and Dutch crossover band Urban Dance Squad. Rage Against the Machine is well known for the members leftist and revolutionary political views, which are expressed in many of the bands songs. As of 2010, they have sold over 16 million records worldwide.", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Rage_Against_The_Machine.jpg/1920px-Rage_Against_The_Machine.jpg"},
  {name: "Avenged Sevenfold", description: "Avenged Sevenfold (sometimes abbreviated as A7X) is an American heavy metal band from Huntington Beach, California, formed in 1999. The bands current lineup consists of lead vocalist M. Shadows, rhythm guitarist and backing vocalist Zacky Vengeance, lead guitarist and backing vocalist Synyster Gates, bass guitarist Johnny Christ and drummer Brooks Wackerman.", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Avenged_Sevenfold-Rock_im_Park_2014_by_2eight_3SC7821.jpg/1920px-Avenged_Sevenfold-Rock_im_Park_2014_by_2eight_3SC7821.jpg"}
])
Keyword.create!([
  {tag: "Heavy metal", description: "Heavy metal (or simply metal) is a genre of rock music that developed in the late 1960s and early 1970s, largely in the United Kingdom and the United States. With roots in blues rock and psychedelic rock, the bands that created heavy metal developed a thick, massive sound, characterized by highly amplified distortion, extended guitar solos, emphatic beats, and overall loudness. Heavy metal lyrics and performance styles are often associated withmasculinity, aggression, and machismo."},
  {tag: "Hard rock", description: "Hard rock is a loosely defined subgenre of rock music that began in the mid-1960s, with the garage, psychedelicand blues rock movements. It is typified by a heavy use of aggressive vocals, distorted electric guitars, bass guitar,drums, and often accompanied with pianos and keyboards."},
  {tag: "Metalcore", description: "Metalcore is a broad fusion genre of extreme metal and hardcore punk. The name is a blend of the names of the two genres. Metalcore is distinguished by its emphasis on breakdowns, which are slow, intense passages that are conducive to moshing.  Pioneering metalcore bandssuch as Earth Crisis and Integrity, both of which had formed before 1990are described as leaning more toward hardcore, whereas later bandssuch as Killswitch Engage, All That Remains, As I Lay Dying, Bullet for My Valentine, Parkway Drive and Underoathare described as leaning more towards metal."},
  {tag: "Progressive rock", description: nil},
  {tag: "Psychedelic rock", description: nil},
  {tag: "Art rock", description: nil},
  {tag: "Blues rock", description: nil},
  {tag: "Rock and roll", description: nil},
  {tag: "Rap metal", description: nil},
  {tag: "Alternative metal", description: nil},
  {tag: "Funk metal", description: nil}
])
Act::HABTM_Keywords.create!([
  {act_id: 3, keyword_id: 3},
  {act_id: 3, keyword_id: 2},
  {act_id: 3, keyword_id: 1},
  {act_id: 2, keyword_id: 10},
  {act_id: 2, keyword_id: 9},
  {act_id: 2, keyword_id: 3},
  {act_id: 1, keyword_id: 1},
  {act_id: 1, keyword_id: 8},
  {act_id: 1, keyword_id: 7}
])
Venue.create!([
  {name: "The O2 Arena", location: "London", capacity: 20000},
  {name: "Hyde Park", location: "London", capacity: 65000},
  {name: "The SSE Hydro", location: "Glasgow", capacity: 13000}
])
Gig.create!([
  {price: "45.0", start_time: "2016-01-16 19:00:00", end_time: "2016-01-16 21:00:00", capacity: 20000, act_id: 1, venue_id: 1},
  {price: "35.5", start_time: "2016-01-23 19:00:00", end_time: "2016-01-10 21:30:00", capacity: 10000, act_id: 2, venue_id: 2},
  {price: "50.0", start_time: "2016-01-16 19:30:00", end_time: "2016-01-10 22:00:00", capacity: 6000, act_id: 3, venue_id: 3}
])
