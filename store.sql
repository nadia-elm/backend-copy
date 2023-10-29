

DROP DATABASE IF EXISTS storedb;

CREATE DATABASE storedb;

\c storedb;

DROP TABLE IF EXISTS users; 
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL, 
  email VARCHAR(255) NOT NULL
);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  image_url VARCHAR(255), -- URL to the product image or relative path
  category VARCHAR(255),
  company VARCHAR(255)
);

CREATE TABLE favorites (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  product_id INT REFERENCES products(id),
  CONSTRAINT unique_favorites UNIQUE (user_id, product_id));

INSERT INTO products (name, description, price, image_url, category, company)
VALUES
  ('lounge furniture', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 259.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607014/11_taxd4u.jpg', 'office', 'marcos'),
  ('cosy sofa', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 1099.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607012/1_rhd6iy.jpg', 'living room', 'liddy'),
  ('wall arts', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 3099.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607013/3_vj4eaj.jpg', 'kitchen', 'liddy'),
  ('TV bench', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 125.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607017/4_aj9wxj.jpg', 'bedroom', 'marcos'),
  ('dining table', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 429.99, 'https://images.pexels.com/photos/4352247/pexels-photo-4352247.jpeg?auto=compress&cs=tinysrgb&w=1600', 'dining', 'ikea'),
  ('yellow chair', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 239.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607013/6_jkpxok.jpg', 'bedroom', 'ikea'),
  ('leather sofa', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 599.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607013/7_bugbg0.jpg', 'living room', 'caressa'),
  ('high-back bench', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund', 399.99, 'https://res-console.cloudinary.com/dwp1kgrki/thumbnails/v1/image/upload/v1696607017/NF9hajl3eGo=/grid_landscape', 'office', 'ikea'),
  ('zen decoration', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 200.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607014/11_taxd4u.jpg', 'bedroom', 'caressa'),
  ('sofa set', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 999.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607014/10_lpsvj5.jpg', 'office', 'caressa'),
  ('modern living-room', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 319.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607014/9_qz1lut.jpg', 'kids', 'caressa'),
  ('bright lounge', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 30.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607014/12_alf9nu.jpg', 'living room', 'liddy'),
  ('reading chair', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 309.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607013/14_ppmgw7.jpg', 'living room', 'ikea'),
  ('dark green sofa ', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 1099.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607012/15_t5q9bd.jpg', 'living room', 'liddy'),
  ('sofa set', 'Cloud bread VHS hell of banjo bicycle rights jianbing umami mumblecore etsy 8-bit pok pok +1 wolf. Vexillologist yr dreamcatcher waistcoat, authentic chillwave trust fund. Viral typewriter fingerstache pinterest pork belly narwhal. Schlitz venmo everyday carry kitsch pitchfork chillwave iPhone taiyaki trust fund hashtag kinfolk microdosing gochujang live-edge', 1299.99, 'https://res.cloudinary.com/dwp1kgrki/image/upload/v1696607014/10_lpsvj5.jpg', 'living room', 'marcos');

