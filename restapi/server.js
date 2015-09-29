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

// Select
app.get('/animal', selectAllEntries);
app.get('/owner', selectAllEntries);
app.get('/animal/:name', selectName);
app.get('/owner/:name', selectName);

// Insert
app.post('/animal', createNewEntry);
app.post('/owner', createNewEntry);

// Update
app.put('/animal/age', updateAge);
app.put('/owner/age', updateAge);

// Delete
app.delete('/animal', deleteEntry);
app.delete('/owner', deleteEntry);

function selectAllEntries(req, res, next) {
  var query = 'SELECT * FROM ??';
  var table = [req.url.slice(1)];
  query = mysql.format(query,table);
  connection.query(query, function(err, rows) {
    if (err) {
      next(err);
      return;
    } else if (rows.length == 0) {
      var err = new Error('Unable to find entries in this table');
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
  } else if (rows.length == 0) {
    var err = new Error('No entries found for name ' + req.params.name);
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

function createNewEntry (req, res, next) {
  if (req.url == '/animal' && Object.keys(req.body).length == 3) {
    var query = 'INSERT INTO ??(??,??,??) VALUES (?,?,?)';
    var table = ['animal','name','species','age',req.body.name,req.body.species,req.body.age];
  } else if (req.url == '/owner' && Object.keys(req.body).length == 2) {
      var query = 'INSERT INTO ??(??,??) VALUES (?,?)';
      var table = ['owner','name','age',req.body.name,req.body.age];
  } else {
    var err = new Error('Incorrect number of arguments');
    next(err);
    return;
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

function updateAge (req, res, next) {
  var query = 'UPDATE ?? SET ?? = ? WHERE ?? = ?';
  var table = [req.url.split('/')[1],'age',req.body.age,'name',req.body.name];
  query = mysql.format(query,table);
  connection.query(query,function(err,rows){
    if(err) {
      next(err);
      return;
    } else if (rows.affectedRows == 0) {
      var err = new Error('No entries for name ' + req.body.name)
      next(err);
      return;
    } else {
      res.send({'result': 'success','message': 'Rows affected: ' + rows.affectedRows});
    }
  });
}

function deleteEntry (req, res, next) {
  var query = 'DELETE FROM ?? WHERE ?? = ?';
  var table = [req.url.slice(1),'name',req.body.name];
  query = mysql.format(query,table);
  connection.query(query,function(err,rows){
    if(err) {
      next(err);
      return;
    } else if (rows.affectedRows == 0) {
      var err = new Error('No entries for name ' + req.body.name)
      next(err);
      return;
    } else {
      res.send({'result': 'success','message': 'Rows affected: ' + rows.affectedRows});
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