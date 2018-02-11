CREATE SCHEMA IF NOT EXISTS MOVIE;
USE MOVIE;

SET foreign_key_checks = 0;
DROP TABLE IF EXISTS person_table;
DROP TABLE IF EXISTS movie_table;
DROP TABLE IF EXISTS reviews;
SET foreign_key_checks = 1;

/* 3 table system */
CREATE TABLE Reviewer
(
  Reviewer_id int PRIMARY KEY NOT NULL UNIQUE,
  FirstName varchar(200) NOT NULL,
  LastName varchar(200) NOT NULL
);

CREATE TABLE Movies
(
  Movie_id int PRIMARY KEY NOT NULL,
  Movie_name varchar(200) NOT NULL
);

CREATE TABLE Reviews
(
	Review_rank int NOT NULL,
    Reviewer_id INT,
    movie_id INT,
	FOREIGN KEY (Reviewer_id) REFERENCES Reviewer (Reviewer_id) 
		ON UPDATE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movies (movie_id) 
		ON UPDATE CASCADE
 );
 
 /* load data */
 INSERT INTO Reviewer (Reviewer_id, FirstName, LastName)
 VALUES (1, 'Jon', 'Morbharachar'),
		(2, 'Melanie', 'Wells'),
		(3, 'Donald', 'Trump'),
        (4, 'Bill', 'Clinton'),
        (5, 'Hillary', 'Clinton');

SELECT * FROM Reviewer;

INSERT INTO Movies (movie_id, movie_name)
VALUES (1, "Casablanca"),
	   (2, "God Father"),
       (3, "Gone with the Wind"),
       (4, "Shreak"),
       (5, "La La Land"),
       (6, "Gladiator");
       
SELECT * FROM MOVIES;

INSERT INTO Reviews (review_rank, Reviewer_id, movie_id)
VALUES (4, 1, 1),
	   (3, 2, 1),
       (5, 3, 1), 
       (4, 4, 1),
       (5, 5, 1),
       (2, 1, 2),
	   (3, 2, 2),
       (2, 3, 2), 
       (3, 4, 2),
       (3, 5, 2),
       (5, 1, 3),
	   (4, 2, 3),
       (5, 3, 3), 
       (4, 4, 3),
       (4, 5, 3),
       (4, 1, 4),
	   (3, 2, 4),
       (3, 3, 4), 
       (4, 4, 4),
       (5, 5, 4),
       (3, 1, 5),
	   (3, 2, 5),
       (4, 3, 5), 
       (4, 4, 5),
       (3, 5, 5),
       (4, 1, 6),
	   (4, 2, 6),
       (5, 3, 6), 
       (4, 4, 6),
       (3, 5, 6);
       
SELECT p.FirstName, p.LastName, m.movie_name, r.review_rank FROM Reviewer p
	LEFT JOIN reviews r
		ON p.Reviewer_id = r.Reviewer_id
	LEFT JOIN Movies m
		ON m.movie_id = r.movie_id
	ORDER BY m.movie_name;
