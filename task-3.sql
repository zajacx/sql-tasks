-- Bazy danych 2023/24, trzeci mikroprojekt;
-- Autor: Tomasz Zając <tz448580@students.mimuw.edu.pl>

WITH best_values AS (
    SELECT
        a.id,
        b.praca,
        c.punkty / c.autorzy AS value,
        ROW_NUMBER() OVER (PARTITION BY a.id ORDER BY c.punkty / c.autorzy DESC) AS rank
    FROM
        autor a
        LEFT JOIN autorstwo b ON a.id = b.autor
        LEFT JOIN praca c ON b.praca = c.id
    ORDER BY a.id
)
SELECT
    id AS author,
    COALESCE(ROUND(SUM(value), 2), 0.00) AS result
FROM best_values
WHERE rank <= 4
GROUP BY id;
