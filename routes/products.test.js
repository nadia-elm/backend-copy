const request = require('supertest');
const app = require('../app');

describe('Products API', () => {
  it('should respond with all products', async () => {
    const response = await request(app).get('/products');
    expect(response.statusCode).toBe(200);
    expect(response.body.length).toBeGreaterThan(0);
  });
  it('should respond with a single product', async () => {
    const response = await request(app).get('/products/1');
    expect(response.statusCode).toBe(200);
    expect(response.body.id).toBe(1);
  });
});
