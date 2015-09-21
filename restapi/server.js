var express     = require('express'),
    mysql       = require('mysql'),
    bodyParser  = require('body-parser'),
    Boom        = require('boom');


var connection = mysql.createConnection({
  host     : 'db',
  user     : process.env.MYSQL_USER,
  password : process.env.MYSQL_PASSWORD,
  database : process.env.MYSQL_DATABASE
});

var app = express();
connection.connect();
app.use(bodyParser.json());

app.get('/animal', function (req, res) {
  connection.query('SELECT * FROM animal', function(err, rows) {
    if (err) {
      throw err;
    }
    var list = []
    for (var i in rows) {
      list.push(rows[i]);
    }
    console.log(list);
    res.json(list);
  });
});

//Select
app.get('/animal/:name', function (req, res) {
  connection.query('SELECT * FROM animal WHERE name=?',[req.params.name], function(err, rows) {
    if (err) {
      throw err;
    }
    var list = []
    for (var i in rows) {
      list.push(rows[i]);
    }
    console.log(list);
    res.json(list);
  });
});

app.get('/owner:name', function (req, res) {
  connection.query('SELECT * FROM owner WHERE name=?',[req.params.owner], function(err, rows) {
    if (err) {
      throw err;
    }
    var list = []
    for (var i in rows) {
      list.push(rows[i]);
    }
    console.log(list);
    res.json(list);
  });
});

app.get('/owner', function (req, res) {
  connection.query('SELECT * FROM owner', function(err, rows) {
    if (err) {
      throw err;
    }
    var list = []
    for (var i in rows) {
      list.push(rows[i]);
    }
    console.log(list);
    res.json(list);
  });
});

app.get('/pets', function (req, res) {
  var query = 'SELECT * FROM pets join owner on pets.owner_id = owner.id join animal on pets.animal_id = animal.id'
  var options = {sql: query, nestTables: true};
  connection.query(options, function(err, rows) {
    if (err) {
      throw err;
    }
    console.log(rows);
    var list = [];
    for (var i in rows) {
      var entry = {};
      entry.ownerName = rows[i]["owner"]["name"];
      entry.ownerAge = rows[i]["owner"]["age"];
      entry.petName = rows[i]["animal"]["name"];
      entry.petSpecies = rows[i]["animal"]["species"];
      entry.petAge = rows[i]["animal"]["age"];
      list.push(entry);
    }
    console.log(list);
    res.json(list);
  });
});

//Insert
app.post('/animal', addNewEntry);
app.post('/owner', addNewEntry);
app.post('/pets', addNewEntry);

//update

app.put('/animal', function (req, res) {
  var query = "UPDATE ?? SET ?? = ? WHERE ?? = ?";
  var table = ["animal","name",req.body.age,"name",req.body.name];
  query = mysql.format(query,table);
  connection.query(query,function(err,rows){
    if(err) {
      res.json({"Error":true,"Message":"Error executing MySQL query"});
    } else {
      res.json({"Error":false,"Message":"Owner Added!"});
    }
  });
});

function addNewEntry(req, res) {
  if (req.url == '/animal') {
    var query = "INSERT INTO ??(??,??,??) VALUES (?,?,?)";
    var table = ["animal","name","species","age",req.body.name,req.body.species,req.body.age];
  } else if (req.url == '/owner') {
    var query = "INSERT INTO ??(??,??) VALUES (?,?)";
    var table = ["owner","name","age",req.body.name,req.body.age];
  // } else if (req.url == '/pets') {
  //   var query = "INSERT INTO ??(??,??) VALUES (?,?)";
  //   var table = ["owner","name","age",req.body.name,req.body.age];
  //   query = mysql.format(query,table);
  } else {
    res.send(Boom.notFound('missing'));
    return;
  }
  query = mysql.format(query,table);
  connection.query(query,function(err,rows){
    if(err) {
      res.json({"Error":true,"Message":"Error executing MySQL query"});
    } else {
      res.json({"Error":false,"Message":"Added!"});
    }
  });
}

// function validateData(expected, actual, cb) {
//   if (expected == actual)

// }

console.log('Express server started on port %s',process.env.HTTP_PORT);
app.listen(process.env.HTTP_PORT);