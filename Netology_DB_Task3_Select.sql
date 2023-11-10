/*Task_2*/

/*1.Название и продолжительность самого длительного трека.
 * Теоритически может быть несколько треков с одинаковой продолжительностью*/

SELECT track_name AS Название, duration AS Продолжительность
FROM music_track
WHERE duration = (SELECT MAX(duration) FROM music_track);

/*2.Название треков, продолжительность которых не менее 3,5 минут.*/

SELECT track_name AS Название
FROM music_track
WHERE duration >= 210;

/*3.Названия сборников, вышедших в период с 2018 по 2020 год включительно.*/

SELECT collection_name AS Название
FROM collection
WHERE year_of_release BETWEEN 2018 AND 2020;

/*4.Исполнители, чьё имя состоит из одного слова.
 В моей таблице имена всех исполнителей состоят из одного слова, но псевдонимы могут состоять из нескольких слов,
 поэтому выборку сделаю по полю "Псевдоним"*/
SELECT first_name, last_name, nick_name
FROM musician
WHERE nick_name NOT LIKE '% %';

/*5.Название треков, которые содержат слово «мой» или «my»*/
SELECT track_name 
FROM music_track
WHERE track_name LIKE 'My _%' /*отбирает слово My в начале названия */
	OR track_name LIKE 'Мой _%%' /*отбирает слово Мой в начале названия */
	OR track_name LIKE '_% my _%' /*отбирает слово my внутри названия */
	OR track_name LIKE '_% мой _%' /*отбирает слово мой внутри названия */
	OR track_name LIKE '_% my' /*отбирает слово my в конце названия */
	OR track_name LIKE '_% Мой' /*отбирает слово мой в конце названия */
	OR track_name LIKE 'My' /* отбирает название, состоящее из одного слова My */
	OR track_name LIKE 'Мой'/* отбирает название, состоящее из одного слова Мой */
;

/*Task_3*/

/*1.Количество исполнителей в каждом жанре.*/

SELECT genre_name, COUNT(*) AS Количество 
FROM genre_of_music gom
JOIN musician_genre_of_music mgom ON gom.genre_of_music_id = mgom.genre_of_music_id
GROUP BY genre_name 
ORDER BY Количество DESC;

/*2.Количество треков, вошедших в альбомы 2019–2020 годов.*/

SELECT COUNT(music_track_id) 
FROM music_track mt 
JOIN music_album ma ON mt.music_album_id = ma.music_album_id 
WHERE year_of_release BETWEEN 2019 AND 2020;

/*3.Средняя продолжительность треков по каждому альбому.*/

SELECT album_name, AVG(duration) AS Средняя_продолжительность_треков
FROM music_track mt 
JOIN music_album ma ON mt.music_album_id = ma.music_album_id
GROUP BY album_name

/*4.Все исполнители, которые не выпустили альбомы в 2020 году.*/

SELECT first_name, last_name, nick_name
FROM musician
WHERE nick_name NOT IN (SELECT DISTINCT nick_name
						FROM musician m
						JOIN musician_music_album mma ON m.musician_id = mma.musician_id  
						JOIN music_album ma ON mma.music_album_id = ma.music_album_id 
						WHERE year_of_release = 2020);
					
/*5.Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами). Пусть будет Elvis Presley*/

SELECT DISTINCT collection_name 
FROM collection c 
JOIN music_track_collection mtc ON c.collection_id = mtc.collection_id 
JOIN music_track mt ON mtc.music_track_id = mt.music_track_id 
JOIN music_album ma ON mt.music_album_id = ma.music_album_id 
JOIN musician_music_album mma ON ma.music_album_id = mma.music_album_id 
JOIN musician m ON mma.musician_id = m.musician_id 
WHERE first_name = 'Elvis' AND last_name = 'Presley'

/*Task_4*/

/*1. Названия альбомов, в которых присутствуют исполнители более чем одного жанра.*/

SELECT DISTINCT album_name
FROM music_album ma 
JOIN musician_music_album mma ON ma.music_album_id = mma.music_album_id
WHERE mma.musician_id IN (SELECT mgom.musician_id
						FROM musician_genre_of_music mgom  
						JOIN genre_of_music gom ON mgom.genre_of_music_id = gom.genre_of_music_id 
						GROUP BY mgom.musician_id
						HAVING COUNT(genre_name)>=2);
						
/*2.Наименования треков, которые не входят в сборники.*/

SELECT track_name
FROM music_track mt 
WHERE music_track_id NOT IN (SELECT DISTINCT music_track_id
							FROM music_track_collection mtc);
						
/*3.Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, 
— теоретически таких треков может быть несколько.*/

SELECT DISTINCT first_name, last_name, nick_name
FROM musician m 
JOIN musician_music_album mma ON m.musician_id = mma.musician_id 
JOIN music_album ma ON mma.music_album_id = ma.music_album_id 
JOIN music_track mt ON ma.music_album_id = mt.music_album_id
WHERE duration = (SELECT MIN(duration)
				FROM music_track);
				
/*4.Названия альбомов, содержащих наименьшее количество треков.*/

SELECT album_name 
FROM music_album ma2
JOIN music_track mt2 ON ma2.music_album_id = mt2.music_album_id 
GROUP BY ma2.music_album_id 
HAVING count(*) = (SELECT count(*)
				FROM music_album ma 
				JOIN music_track mt ON ma.music_album_id = mt.music_album_id 
				GROUP BY ma.music_album_id
				ORDER BY 1
				LIMIT 1);