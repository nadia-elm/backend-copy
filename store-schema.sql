
CREATE TABLE storeUsers (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL, 
  email VARCHAR(255) NOT NULL
);

CREATE TABLE storeProducts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  image_url VARCHAR(255), -- URL to the product image or relative path
  category VARCHAR(255),
  company VARCHAR(255)
);

CREATE TABLE userFavorites (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  product_id INT REFERENCES products(id),
  CONSTRAINT unique_favorites UNIQUE (user_id, product_id));
