import request from 'supertest';
import app from '../server.js';

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
