-- Bazy danych 2023/24, piąty mikroprojekt;
-- Autor: Tomasz Zając <tz448580@students.mimuw.edu.pl>

WITH poczatek AS (
    SELECT g.tgt, COUNT(*) AS ile
    FROM e e, e f, e g
    WHERE e.src = 0 AND e.tgt = f.src AND f.tgt = g.src
    GROUP BY g.tgt
),
koniec AS (
    SELECT e.src, COUNT(*) AS ile
    FROM e e, e f
    WHERE e.tgt = f.src
    GROUP BY e.src
),
pelna_sciezka AS (
    SELECT poczatek.tgt, poczatek.ile * koniec.ile AS liczba
    FROM poczatek, koniec
    WHERE poczatek.tgt = koniec.src
)
SELECT SUM(liczba)
FROM pelna_sciezka;
