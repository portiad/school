var express     = require('express'),
    mysql       = require('mysql'),
    bodyParser  = require('body-parser');


var connection = mysql.createConnection({
  host     : 'db',
  user     : process.env.MYSQL_USER,
  password : process.env.MYSQL_PASSWORD,
  database : process.env.MYSQL_DATABASE
});

var app = express();
connection.connect();
app.use(bodyParser.json());

app.get('/animal', selectAllEntries);
app.get('/owner', selectAllEntries);

//Select
app.get('/animal/:name', selectName);
app.get('/owner:name', selectName);


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
      entry.ownerName = rows[i]['owner']['name'];
      entry.ownerAge = rows[i]['owner']['age'];
      entry.petName = rows[i]['animal']['name'];
      entry.petSpecies = rows[i]['animal']['species'];
      entry.petAge = rows[i]['animal']['age'];
      list.push(entry);
    }
    console.log(list);
    res.json(list);
  });
});

//Insert
app.post('/animal', addNewEntry);
app.post('/owner', addNewEntry);
app.post('/pets',   function (req, res) {
// } else if (req.url == '/pets') {
  //   var query = 'INSERT INTO ??(??,??) VALUES (?,?)';
  //   var table = ['owner','name','age',req.body.name,req.body.age];
  //   query = mysql.format(query,table););
});

//update

app.put('/animal', function (req, res) {
  var query = 'UPDATE ?? SET ?? = ? WHERE ?? = ?';
  var table = ['animal','name',req.body.age,'name',req.body.name];
  query = mysql.format(query,table);
  connection.query(query,function(err,rows){
    if(err) {
      res.json({'Error':true,'Message':'Error executing MySQL query'});
    } else {
      res.json({'Error':false,'Message':'Owner Added!'});
    }
  });
});

function selectAllEntries(req, res, next) {
  var query = 'SELECT * FROM ??';
  var table = [req.url.slice(1)];
  query = mysql.format(query,table);
  connection.query(query, function(err, rows) {
    if (err) {
      next(err);
      return;
    } 
    var list = []
    for (var i in rows) {
      list.push(rows[i]);
    }
    res.json(list);
  });
}

function selectName(req, res, next) {
  var query = 'SELECT * FROM ?? WHERE name=?'
  var table = [req.url.split('/')[1], [req.params.name]];
  query = mysql.format(query,table);
  connection.query(query, function(err, rows) {
  if (err) {
    next(err);
    return;
  }
  var list = []
  for (var i in rows) {
    list.push(rows[i]);
  }
  console.log(list);
  res.json(list);
  });
}

function addNewEntry (req, res, next) {
  if (Object.keys(req.body).length > 3) {
      var err = new Error('Incorrect number of arguments');
      next(err);
      return;
  }
  
  if (req.url == '/animal') {
    var query = 'INSERT INTO ??(??,??,??) VALUES (?,?,?)';
    var table = ['animal','name','species','age',req.body.name,req.body.species,req.body.age];
  } else if (req.url == '/owner') {
    var query = 'INSERT INTO ??(??,??) VALUES (?,?)';
    var table = ['owner','name','age',req.body.name,req.body.age];
  } 
  query = mysql.format(query,table);
  connection.query(query,function (err,rows){
    if(err) {
      next(err);
      return
    } else {
      res.send({'result': 'success','message':'Added!'});
    }
  });
}

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// error handler
app.use(function(err, req, res, next) {
    res.status(err.status || 500).send({
      result: 'error',
      message: err.message,
      error: err
  });
});

console.log('Express server started on port %s',process.env.HTTP_PORT);
app.listen(process.env.HTTP_PORT);