const _express = require('express');
const _server = _express();
const {Pool} = require('pg')

const pool = new Pool();

const registry_data = async (value1, value2, result) => {
  const text = 'INSERT INTO Results(sumando01,sumando02,resultado) VALUES($1,$2,$3) RETURNING *';
  pool.query(text, [value1, value2, result]);
}

const _port = 4000;

_server.get('/retoibm/sumar/:sumando01/:sumando02', function(request, response) {
  try{
    var _sumando01 = new Number(request.params.sumando01);
    var _sumando02 = new Number(request.params.sumando02);
    var _resultado = _sumando01 + _sumando02;

    if (typeof _resultado !== "undefined" && _resultado!==null && !isNaN(_resultado)){
      registry_data(_sumando01,_sumando02,_resultado)
      return response.status(200).json({resultado : _resultado});
    }else{
      return response.status(400).json({resultado : "Bad Request"});
    }
  }
  catch(e){
    return response.status(500).json({resultado : e});
  }
});


_server.listen(_port, () => {
   console.log(`Server listening at ${_port}`);
});
