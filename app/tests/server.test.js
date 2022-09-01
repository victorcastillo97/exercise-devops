import request from 'supertest';
import app from '../server.js';



it('Is the server healthy?', done => {
    request(app)
        .get('/')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200)
        .expect('{"status":{"healthy":true}}')
        .end((err) => {
            if (err) return done(err);
            done();
        })
});



it('Correctly answering the incorrect', done => {
    request(app)
        .get('/retoibm/sumar/comida/basura')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(400)
        .expect('{"resultado":"Bad Request"}')
        .end((err) => {
            if (err) return done(err);
            done();
        })
});
