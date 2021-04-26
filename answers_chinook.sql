/* TASK I
Which artists did not make any albums at all? 
Include their names in your answer.
*/
SELECT albums.AlbumId, artists.name, artists.ArtistId 
FROM artists
LEFT OUTER JOIN albums
ON artists.ArtistId = albums.ArtistId
WHERE albums.AlbumId IS NULL;

/* TASK II
Which artists recorded any tracks of the Latin genre?
*/


SELECT DISTINCT artists.Name
FROM artists
OUTER LEFT JOIN albums
ON artists.ArtistId = albums.ArtistId
OUTER LEFT JOIN tracks
ON albums.AlbumId = tracks.AlbumId
WHERE GenreId IN (
SELECT GenreId
FROM genres
WHERE Name = 'Latin');

/* TASK III
Which video track has the longest length?
*/

SELECT Name, MAX(Milliseconds)
FROM tracks
WHERE MediaTypeId IN
(SELECT MediaTypeId 
FROM media_types
WHERE Name LIKE '%video%');

/* TASK IV
Find the names of customers who live in 
the same city as the top employee 
(The one not managed by anyone).
*/

SELECT FirstName, LastName
FROM customers
WHERE City IN (
SELECT City 
FROM employees
WHERE ReportsTo IS NULL);

/* TASK V
Find the managers of employees supporting 
Brazilian customers.
*/

SELECT FirstName, LastName
FROM employees
WHERE EmployeeId IN (
SELECT ReportsTo
FROM employees
WHERE EmployeeId IN (
SELECT SupportRepId
FROM customers
WHERE Country = 'Brazil'));

/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT * FROM playlists;


SELECT DISTINCT playlists.PlaylistId, playlists.Name
FROM playlists
LEFT OUTER JOIN playlist_track 
ON playlists.PlaylistId = playlist_track.PlaylistId
LEFT OUTER JOIN tracks
ON tracks.TrackId = playlist_track.TrackId
WHERE GenreId IN (
SELECT GenreId
FROM genres
WHERE Name != 'Latin');