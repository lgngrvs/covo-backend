const express = require('express');
const url = require("node:url");

const app = express()
const PORT = 3000

app.set('view engine', 'ejs'); //sets view engine to use ejs
app.set('views', __dirname + '/templates'); // sets the directory to look for templates ("views") in

app.get('/', (req, res) => {
    res.render('index');
});

app.get('/profile', (req, res) => {
    let q = url.parse(req.url);
    res.render('profile', {name: q.query});
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
