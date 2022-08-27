import request from 'supertest';
import app from '../server.js';

it('Is the server healthy?', done => {
    request(app)
        .get('/health')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200)
        .expect('{"resultado":"The server is healthy"}')
        .end((err) => {
            if (err) return done(err);
            done();
        })
});