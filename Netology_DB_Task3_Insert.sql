INSERT INTO musician(first_name, last_name, nick_name)
VALUES ('Robert', 'Dylan', 'Bob Dylan'),
('Elvis', 'Presley', 'The King'),
('Charles', 'Berry', 'Chuck Berry'),
('Johnny', 'Hendrix', 'Jimi Hendrix'),
('Robert', 'Marley', 'Bob Marley'),
('Madonna', 'Ciccone', 'Madonna')
;

/*DELETE FROM musician;
SELECT setval(pg_get_serial_sequence('musician', 'musician_id'), coalesce(max(musician_id),0) + 1, false) FROM musician;*/


INSERT INTO genre_of_music(genre_name)
VALUES ('Jazz'),
('Rock and roll'),
('Rock'),
('Reggae'),
('pop rock'),
('rock opera');

/*DELETE FROM genre_of_music;
SELECT setval(pg_get_serial_sequence('genre_of_music', 'genre_of_music_id'), coalesce(max(genre_of_music_id),0) + 1, false) 
FROM genre_of_music;*/


INSERT INTO musician_genre_of_music (musician_id, genre_of_music_id)
VALUES (1, 1), (1, 2), (2, 2), 
(3, 2), (3, 3), (4, 3), (5, 1), (5, 4), (6, 5), (6, 6);

/*DELETE FROM musician_genre_of_music;
SELECT setval(pg_get_serial_sequence('musician_genre_of_music', 'musician_genre_id'), 
coalesce(max(musician_genre_id),0) + 1, false) FROM musician_genre_of_music;
*/

INSERT INTO music_album (album_name, year_of_release)
VALUES ('The Freewheelin Bob Dylan', 1963),
('Blonde on Blonde', 1966),
('From Elvis in Memphis', 1969),
('Maybellene', 1953),
('Rainbow Bridge', 1971),
('Soul Rebels', 1970),
('Rebel Heart', 2015),
('Madam X', 2019);

UPDATE music_album 
SET year_of_release = 2020
WHERE music_album_id = 8;

INSERT INTO musician_music_album (musician_id, music_album_id)
VALUES (1, 1), (1, 2), (2, 2), (2, 3), (3, 4), (4, 5), (5, 6), (6, 7), (6, 8);

/*DELETE FROM musician_music_album;
SELECT setval(pg_get_serial_sequence('musician_music_album', 'musician_music_album_id'), 
coalesce(max(musician_music_album_id),0) + 1, false) FROM musician_music_album;*/



INSERT INTO music_track (track_name, music_album_id, duration)
VALUES ('Down the Highway', 1, 207),
('Oxford Town', 1, 110),
('Vision of Johanna', 2, 453),
('Only the Strong Survive', 3, 164),
('Long Black Limousine', 3, 224),
('Maybellene', 4, 139),
('Dolly Dagger', 5, 283),
('Try Me', 6, 170),
('Living for Love', 7, 218),
('Devil Pray', 7, 245),
('Medellin', 8, 298),
('God Control', 8, 379);

INSERT INTO music_track (track_name, music_album_id, duration)
VALUES ('My Sympathy', 6, 165);

INSERT INTO collection (collection_name, year_of_release)
VALUES ('Olds cool', 2010),
('Music for the car', 2020),
('Hits of the 60s', 2000),
('Back to the 70s', 2005),
('Pepsi-Cola generation', 2020);

INSERT INTO music_track_collection (music_track_id, collection_id)
VALUES (1, 1), (1, 3), (2, 1), (2, 3), (3, 1), (3, 3), (4, 2), (4, 3), (5, 2), (5, 4),
(6, 1), (6, 2), (7, 4), (8, 4), (9, 5), (10, 5), (11, 2), (11, 5), (12, 2), (12, 5);
