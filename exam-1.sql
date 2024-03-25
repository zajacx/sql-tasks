-- Tomasz Zając 448580, grupa 3., zadanie 1.

with nastepny_rejs as (
	select a.numer, a.dokad, a.koniec, a.statek, min(b.poczatek) as pocz_nast
	from rejs a left join rejs b on a.statek = b.statek
	where a.numer <> b.numer and a.koniec < b.poczatek
	group by a.numer, a.dokad, a.koniec, a.statek
)
select p.statek, p.dokad, p.koniec, q.skad, q.poczatek 
from rejs p
left join nastepny_rejs on p.numer = nastepny_rejs.numer
left join rejs q on nastepny_rejs.pocz_nast = q.poczatek and nastepny_rejs.statek = q.statek
where p.dokad <> q.skad;