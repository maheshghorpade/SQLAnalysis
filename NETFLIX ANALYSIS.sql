CREATE DATABASE NETFLIX_ANALYSIS;

USE NETFLIX_ANALYSIS;

CREATE TABLE mytable(
   id                   VARCHAR(9) NOT NULL PRIMARY KEY
  ,title                VARCHAR(104)
  ,type                 VARCHAR(5) NOT NULL
  ,description          VARCHAR(1731)
  ,release_year         INTEGER  NOT NULL
  ,age_certification    VARCHAR(5)
  ,runtime              INTEGER  NOT NULL
  ,genres               VARCHAR(103) NOT NULL
  ,production_countries VARCHAR(42) NOT NULL
  ,seasons              NUMERIC(4,1)
  ,imdb_id              VARCHAR(10)
  ,imdb_score           NUMERIC(3,1)
  ,imdb_votes           NUMERIC(9,1)
  ,tmdb_popularity      VARCHAR(18)
  ,tmdb_score           NUMERIC(5,3)
);

DELETE FROM MYTABLE WHERE IMDB_SCORE IS NULL;


-- What were the top 10 movies according to IMDB score?

SELECT TITLE,TYPE,IMDB_SCORE 
FROM MYTABLE 
WHERE IMDB_SCORE >= 8.0 AND TYPE = "MOVIE" 
GROUP BY TITLE,TYPE,IMDB_SCORE ORDER BY IMDB_SCORE 
DESC LIMIT 10;


-- What were the top 10 shows according to IMDB score?
SELECT TITLE,TYPE,IMDB_SCORE 
FROM MYTABLE 
WHERE IMDB_SCORE >= 8.0 AND TYPE = "SHOW" 
GROUP BY TITLE,TYPE,IMDB_SCORE ORDER BY IMDB_SCORE 
DESC LIMIT 10;

-- What were the bottom 10 movies according to IMDB score? 
SELECT TITLE,TYPE,IMDB_SCORE 
FROM MYTABLE 
WHERE TYPE = "MOVIE" 
GROUP BY TITLE,TYPE,IMDB_SCORE ORDER BY IMDB_SCORE 
ASC LIMIT 10;

-- What were the bottom 10 shows according to IMDB score? 
SELECT TITLE,TYPE,IMDB_SCORE 
FROM MYTABLE 
WHERE TYPE = "SHOW" 
GROUP BY TITLE,TYPE,IMDB_SCORE ORDER BY IMDB_SCORE 
ASC LIMIT 10;

-- What were the average IMDB and TMDB scores for shows and movies?

SELECT TYPE, 
ROUND(AVG(IMDB_SCORE)) AS AVGIMDB,
ROUND(AVG(TMDB_SCORE)) AS AVGTMDB
FROM MYTABLE
GROUP BY TYPE;

-- Count of movies and shows in each decade

SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade,
	COUNT(*) AS movies_shows_count
FROM MYTABLE
WHERE release_year >= 1950
GROUP BY CONCAT(FLOOR(release_year / 10) * 10, 's')
ORDER BY decade;

-- What were the average IMDB and TMDB scores for each production country?

SELECT DISTINCT(PRODUCTION_COUNTRIES), 
ROUND(AVG(IMDB_SCORE),2) AS AVGIMDB, ROUND(AVG(TMDB_SCORE),2) AS AVGTMDB
FROM MYTABLE
GROUP BY (PRODUCTION_COUNTRIES)
ORDER BY AVG(IMDB_SCORE) DESC;

-- What were the average IMDB and TMDB scores for each age certification for shows and movies?

 SELECT DISTINCT age_certification, 
 ROUND(AVG(IMDB_SCORE),2) AS IMDBSCORE,
 ROUND(AVG(TMDB_SCORE),2) AS TMDBSCORE
 FROM MYTABLE
 GROUP BY AGE_CERTIFICATION
 ORDER BY AVG(IMDB_SCORE) DESC;
 
select * from mytable; 

select distinct type from mytable;
