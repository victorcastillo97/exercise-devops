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

it('Respond with json', done => {
    request(app)
        .get('/retoibm/sumar/0/0')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200,done);
});

it('Respond correct', done => {
    request(app)
        .get('/retoibm/sumar/999999999999999/999999999999999')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200)
        .expect('{"resultado":1999999999999998}')
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
