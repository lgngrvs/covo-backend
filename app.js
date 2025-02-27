console.log("app.js is deprecated, but left in this repo for reference purposes. API.js should be used.")

/*const express = require('express');
const url = require("node:url");
const mysql = require("mysql2");
const fs = require("fs")*/


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
/*
const pool  = mysql.createPool({
    host: 'localhost',
    user: "root",
    password: "x",
    database: 'eventsAndSignups',
    multipleStatements: true  // Important for executing multiple SQL statements at once
});*/

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

/*pool.query("SHOW DATABASES")

const app = express()
const PORT = 3000

app.set('view engine', 'ejs'); //sets view engine to use ejs
app.set('views', __dirname + '/templates'); // sets the directory to look for templates ("views") in /templates folder


app.get('/', (req, res) => { // renders index template located at templates/index.ejs
    res.render('index');
});

app.get('/profile', (req, res) => { // will "profile" template located at templates/profile.ejs
    let q = url.parse(req.url);
    res.render('profile', {name: q.u}); // passes in q.query (the "q=..." string) for the `name` variable in the profile template
});

app.get("/event", (req, res) => {
    console.log("Request to location" + req.url)
    let q = url.parse(req.url, true);
    let eventid = q.query["id"]; // Parses the id key `id: 1` from the query string `?id=1` into just `1`
    // console.log("eventID: " + eventid)

    pool.query("USE eventsAndSignups", (err) => {if (err) throw err}); // Tells SQL that commands after this one are related to the specific eventsAndSignups database, which contains the schema defined in schema.sql. (SQL servers by default contain a bunch of databases, each of which has tables (e.g. `information_schema` or `sys` or `mysql`))

    pool.query("SELECT * FROM events WHERE id = " + eventid, function(err, result) {
        if (err) throw err;
        if (Object.keys(result).length != 0) { // True if db query returned something other than an empty object
            console.log(result[0]["title"]);

            // Extract the title, description, and date from the SQL response, which contains {row 0, row 1, ... row n}, each of which has the structure {title: "title", description: "descripton", date: "date"} etc; see schema.sql for more info on the row structures. We only care about the 0th object because the SQL query involves exact match to the unique `id` field, so the SQL query should only return exactly 0 or exactly 1 row from the database. 
            var eventName = result[0]["title"];
            var eventDescription = result[0]["description"];
            var eventDate = result[0]["date"];

            // console.log("event name after reassignment: " + eventName);

            // Render the template event.ejs from the templates/ directory
            res.render('event', {name: eventName, description: eventDescription, date: eventDate});

        } else if (Object.keys(result).length == 0) {
            // Will create a nice special 404 for events at some point but this is not a priority
            res.render('event', {name: "This event does not exist", description: "N/A", date: "N/A"});
        }
    })
})

app.all('*', (req, res) => { // generic '*' will handle any page that doesn't have a specified route above, i.e. a 404 error. 
    res.render('404'); // renders the 404 page
})

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
}); */
