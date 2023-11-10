CREATE TABLE IF NOT EXISTS musician (
	musician_id SERIAL PRIMARY KEY,
	first_name VARCHAR(40) NOT NULL,
	last_name VARCHAR(40) NOT NULL,
	nick_name VARCHAR(40) NULL
);
	
CREATE TABLE IF NOT EXISTS genre_of_music (
	genre_of_music_id SERIAL PRIMARY KEY,
	genre_name VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS musician_genre_of_music (
	musician_genre_id serial PRIMARY KEY,
	musician_id INTEGER NOT NULL REFERENCES musician(musician_id),
	genre_of_music_id INTEGER NOT NULL REFERENCES genre_of_music(genre_of_music_id)
);

CREATE TABLE IF NOT EXISTS music_album (
	music_album_id serial PRIMARY KEY,
	album_name VARCHAR(60) NOT NULL,
	year_of_release INTEGER CHECK (year_of_release > 0)
);
	
CREATE TABLE IF NOT EXISTS musician_music_album(
	musician_music_album_id SERIAL PRIMARY KEY,
	musician_id INTEGER NOT NULL REFERENCES musician(musician_id),
	music_album_id INTEGER NOT NULL REFERENCES music_album(music_album_id)
);

CREATE TABLE IF NOT EXISTS music_track (
	music_track_id SERIAL PRIMARY KEY,
	track_name VARCHAR(100) NOT NULL,
	music_album_id INTEGER NOT NULL REFERENCES music_album(music_album_id),
	duration INTEGER
);


CREATE TABLE IF NOT EXISTS collection (
	collection_id SERIAL PRIMARY KEY,
	collection_name VARCHAR(100) NOT NULL,
	year_of_release INTEGER CHECK (year_of_release > 0)
);

CREATE TABLE IF NOT EXISTS music_track_collection (
	music_track_collection_id SERIAL PRIMARY KEY,
	music_track_id INTEGER NOT NULL REFERENCES music_track(music_track_id),
	collection_id INTEGER NOT NULL REFERENCES collection(collection_id)
);
