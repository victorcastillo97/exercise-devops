import record_data from './bd.js'
import _express  from 'express';

const _server = _express();


_server.get('/', function(request, response) {
    response.status(200).json({"status" : {"healthy": true}});
});

_server.get('/retoibm/sumar/:sumando01/:sumando02', function(request, response) {
  try{
        var _sumando01 = new Number(request.params.sumando01);
        var _sumando02 = new Number(request.params.sumando02);
        var _resultado = _sumando01 + _sumando02;

    if (typeof _resultado !== "undefined" && _resultado!==null && !isNaN(_resultado)){
        record_data(_sumando01,_sumando02,_resultado)
        return response.status(200).json({resultado : _resultado});
    }else{
        return response.status(400).json({resultado : "Bad Request"});
    }
  }
  catch(e){
    return response.status(500).json({resultado : e});
  }
});

export default _server;