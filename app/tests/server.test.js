const request = require('supertest')
const app = require('../server.js')

it('respond with json', done => {
    request(app)
        .get('/retoibm/sumar/4/50')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200,done);
})
