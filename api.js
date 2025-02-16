const express = require('express');
const url = require("node:url");
const mysql = require("mysql2");
const fs = require("fs")


// == mysql Setup ==

/*const { exec } = require('child_process');


exec("chmod +x setup.sh")
exec('./setup.zsh', (error, stdout, stderr) => { //run shell script
  if (error) {
    console.error(`Error executing shell script: ${error}`);
    return;
  }
  console.log(`Shell script output:\n${stdout}`);
  if (stderr) {
    console.error(`Shell script error output:\n${stderr}`);
  }
});

console.log("Database initialization successful!");

const credentials = fs.readFileSync('./credentials', 'utf8').split("\n");
const dbUsername = credentials[0].trim();
const dbPassword = credentials[1].trim();
*/

const pool  = mysql.createPool({
    host: 'localhost',
    user: "root",
    password: "x",
    database: 'eventsAndSignups',
    multipleStatements: true  // Important for executing multiple SQL statements at once
});

// const schema = fs.readFileSync('./schema.sql', 'utf8');
/*
pool.query(schema, (err, results) => {
    if (err) {
      console.error('Error creating database schema:', err);
      return;
    }
    console.log('Database schema created.');
});*/
  
// pool.query("INSERT INTO events (title, description, imgurl, date) VALUES ('event title', 'event description', 'url://', '2025-02-14 23:55:00')")

pool.query("SHOW DATABASES")

const app = express()
const PORT = 3000

app.set('view engine', 'ejs'); //sets view engine to use ejs
app.set('views', __dirname + '/templates'); // sets the directory to look for templates ("views") in /templates folder

app.get("/api/event", (req, res) => {
    console.log("Request to location" + req.url)
    let q = url.parse(req.url, true);
    let eventid = q.query["id"]; // Parses the id key `id: 1` from the query string `?id=1` into just `1`
    // console.log("eventID: " + eventid)

    pool.query("USE eventsAndSignups", (err) => {if (err) throw err}); // Tells SQL that commands after this one are related to the specific eventsAndSignups database, which contains the schema defined in schema.sql. (SQL servers by default contain a bunch of databases, each of which has tables (e.g. `information_schema` or `sys` or `mysql`))

    pool.query("SELECT * FROM events WHERE id = " + eventid, function(err, result) {
        if (err) throw err;
        if (Object.keys(result).length != 0) { /* True if db query returned something other than an empty object */
            console.log(result[0]["title"]);

            var event = result[0]

            res.json(event);

        } else if (Object.keys(result).length == 0) {
            // Will create a nice special 404 for events at some point but this is not a priority
            var JSONResponse = {"title": "This event does not exist", "description": "N/A", "date": "N/A"}
            res.json(JSONResponse);

        }
    })
})

app.get("/api/allevents", (req, res) => {
  pool.query("SELECT * FROM events", function(err, result) {
    if (err) throw err;
    if (Object.keys(result).length != 0) {
      res.json(result);
    } else {
      throw err;
    }
  })
});

app.all('*', (req, res) => { // generic '*' will handle any page that doesn't have a specified route above, i.e. a 404 error. 
    res.render('404'); // renders the 404 page
})

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
