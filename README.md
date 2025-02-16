# CoVo Backend

A simple API endpoint for CoVo running node.js with MySQL.

To install: 

1. `git clone` onto your local machine
2. `./clean.zsh` to get a fresh install of mySQL and start the server (assuming you're running macOS with Homebrew) **Warning: this will reinstall mysql and wipe any config files or other (e.g. root user login) saved on your computer!** 
3. `./setup.zsh` to prepare the database
4. Run `node api.js` to start the server.

Current supported endpoints
- Get a single event: `127.0.0.1:3000/api/event?id=n` where `n` is an integer: retrieve information from the database about the event with unique event id `n`
    - returns a single JSON object of the form `{"id": integer, "title": string, "date":"YYYY-MM-DDTHH:MM:SS.000Z", "location": string, "description": string}`
- Get all events: `127.0.0.1:3000/api/allevents`: returns a json object, an array with all events in the database together, in the form given above