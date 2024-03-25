-- Bazy danych 2023/24, czwarty mikroprojekt;
-- Autor: Tomasz Zając <tz448580@students.mimuw.edu.pl>

WITH RECURSIVE sub (autor, liczba, sciezka) AS (
    SELECT id, 0 AS liczba, 'Pilipczuk Mi' AS sciezka
    FROM autor
    WHERE id = 'Pilipczuk Mi'
  UNION ALL
    SELECT b.autor, sub.liczba + 1 AS liczba, CONCAT(sub.sciezka, b.autor) AS sciezka
    FROM autorstwo a
    JOIN sub ON a.autor = sub.autor
    LEFT JOIN autorstwo b ON a.praca = b.praca
    WHERE a.autor <> b.autor
    AND sub.sciezka NOT LIKE CONCAT('%', b.autor, '%')
)
SELECT DISTINCT autor.id, MIN(liczba) AS liczba
FROM autor LEFT JOIN sub ON autor.id = sub.autor
GROUP BY autor.id
ORDER BY liczba;
