CREATE VIEW insight_top_genres AS
SELECT 
    g.name AS genre,
    AVG(t.imdb_score) AS avg_imdb,
    AVG(t.tmdb_popularity) AS avg_popularity,
    COUNT(*) AS total_titles
FROM genres g
JOIN title_genres tg ON g.genre_id = tg.genre_id
JOIN titles t ON t.id = tg.title_id
GROUP BY g.name
ORDER BY avg_imdb DESC, avg_popularity DESC;



CREATE VIEW insight_top_countries AS
SELECT 
    c.name AS country,
    AVG(t.imdb_score) AS avg_imdb,
    AVG(t.tmdb_popularity) AS avg_popularity,
    COUNT(*) AS total_titles
FROM countries c
JOIN title_countries tc ON c.country_id = tc.country_id
JOIN titles t ON t.id = tc.title_id
WHERE t.imdb_score IS NOT NULL
GROUP BY c.name
ORDER BY avg_imdb DESC;



CREATE VIEW insight_age_certification AS
SELECT 
    age_certification,
    AVG(imdb_score) AS avg_imdb,
    COUNT(*) AS total_titles
FROM titles
WHERE age_certification IS NOT NULL
GROUP BY age_certification
ORDER BY avg_imdb DESC;



CREATE VIEW insight_genre_gaps AS
SELECT 
    g.name AS genre,
    COUNT(t.id) AS num_titles,
    AVG(t.imdb_score) AS avg_imdb
FROM genres g
JOIN title_genres tg ON g.genre_id = tg.genre_id
JOIN titles t ON t.id = tg.title_id
WHERE t.imdb_score IS NOT NULL
GROUP BY g.name
HAVING COUNT(t.id) < 100
ORDER BY avg_imdb DESC, num_titles ASC;
