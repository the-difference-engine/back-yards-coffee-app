Category.create!(
  name:"Coffees",
)

Category.create!(
  name:"Espressos",
)

Category.create!(
  name:"Iced",
)

Product.create!(
  name:"47th Street Drip Coffee 12oz",
  category_id:1,
  description:"Our signature blend",
  price:2
)

Product.create!(
  name:"Cafe de Olla 12oz",
  category_id:1,
  description:"47th Street Blend infused with Mexican raw sugar molasses and spiced with cinnamon, star anise, and clove.",
  price: 3
)

Product.create!(
  name:"Cafe con Leche 12oz",
  category_id:1,
  description:"Coffee and steamed milk",
  price: 3
)

Product.create!(
  name:"Pour Over",
  category_id:1,
  description:"Add a description about this item",
  price: 4
)

Product.create!(
  name:"Chemex for two",
  category_id:1,
  description:"Add a description about this item",
  price: 5
)

Product.create!(
  name:"Xocolatte",
  category_id:2,
  description:"Espresso, chocolate, cinnamon, chile ancho, steamed milk",
  price: 3.75
)

Product.create!(
  name:"Ojo Rojo",
  category_id:2,
  description:"Cafe de Olla and espresso",
  price: 3.50
)

Product.create!(
  name:"Cortadito",
  category_id:2,
  description:"Add a description about this item",
  price: 2.50
)

Product.create!(
  name:"Cubanito",
  category_id:2,
  description:"Add a description about this item",
  price: 2.50
)

Product.create!(
  name:"Cappuccino",
  category_id:2,
  description:"Add a description about this item",
  price: 3
)

Product.create!(
  name:"Latte",
  category_id:2,
  description:"Add a description about this item",
  price: 3.5
)

Product.create!(
  name:"Mocha",
  category_id:2,
  description:"Add a description about this item",
  price: 3.5
)

Product.create!(
  name:"Shot of Espresso",
  category_id:2,
  description:"Add a description about this item",
  price: 2
)

Product.create!(
  name:"Decaf Americano",
  category_id:2,
  description:"Add a description about this item",
  price: 2.5
)

Product.create!(
  name:"El Toro Cold Brew",
  category_id:3,
  description:"Cold brew served over ice",
  price: 3.5
)

Product.create!(
  name:"Toro Loco",
  category_id:3,
  description:"47th Street Cold Brew, CO2 bubbles, simple syrup and lime",
  price: 4
)

Product.create!(
  name:"Horchatta Latte",
  category_id:3,
  description:"47th Street Cold brew mixed with housemade rice syrup, spiced with cinnamon",
  price: 3.5
)

Product.create!(
  name:"Dulce de Leche",
  category_id:3,
  description:"47th Street Cold Brew and Lecherita Creamer Syrup",
  price: 3.5
)

Product.create!(
  name:"Iced Cafe de Olla",
  category_id:3,
  description:"47th Street Cold Brew infused with piloncillo, cinnamon, star anise, clavo",
  price: 3.5
)

Editable.create(
  about_me_sec_1:"Our Origin",
  about_me_pic_1: "https://scontent-dfw5-1.xx.fbcdn.net/v/t1.0-9/32116570_2067246413533586_756754185080274944_o.jpg?_nc_cat=0&oh=1d00547879ba78fb7743eb675f0ce6bb&oe=5B581D45",
  about_me_sec_2: "Our Coffee",
  about_me_pic_2:"https://scontent-dfw5-1.xx.fbcdn.net/v/t1.0-9/31369590_2061136080811286_9123507634836602880_o.jpg?_nc_cat=0&oh=10f7e2f22251062db9bdd7f1f9bc598a&oe=5B962AFC",
  about_me_sec_3:"Our Mission",
  about_me_pic_3:"https://scontent-dfw5-1.xx.fbcdn.net/v/t1.0-9/30705856_2055346538056907_1033765904791371776_o.jpg?_nc_cat=0&oh=46aaf60a5e9551e591c8e3be95de9952&oe=5B8D3AB1",
  about_me_sec_4: "Our People",
  about_me_pic_4:"https://s3-media1.fl.yelpcdn.com/buphoto/-EWkaX0xODm-wJTzu4dl6A/o.jpg"
)
