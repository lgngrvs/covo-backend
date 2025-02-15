DROP TABLE IF EXISTS event_signups;
DROP TABLE IF EXISTS events;

CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    imgurl VARCHAR(255) NOT NULL,
    date DATETIME NOT NULL
    -- Optionally, add a FULLTEXT index for search:
    -- , FULLTEXT(title, description)
);

CREATE TABLE event_signups (
    event_id INT NOT NULL,
    signupuuid INT NOT NULL,
    FOREIGN KEY (event_id) REFERENCES events(id)
);
