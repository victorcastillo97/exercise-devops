import pkg from 'pg';

const {Pool} = pkg;
const pool = new Pool();

const record_data = async (value1, value2, result) => {
    const text = 'INSERT INTO Results(sumando01,sumando02,resultado) VALUES($1,$2,$3) RETURNING *';
    pool.query(text, [value1, value2, result]);
}

export default record_data