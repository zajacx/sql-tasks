-- Tomasz Zając 448580, grupa 3., zadanie 3.

with obciazenie as (
	select statek.nazwa, statek.ladownosc, rejs.numer, coalesce(sum(ilosc), 0) as masa -- dopuszczamy rejsy bez ladunku
	from statek
	left join rejs on statek.nazwa = rejs.statek
	left join manifest on rejs.numer = manifest.rejs
	group by statek.nazwa, statek.ladownosc, rejs.numer
),
liczba_rejsow as (
	select statek.nazwa, count(*) as liczba
	from statek
	left join rejs on statek.nazwa = rejs.statek
	group by statek.nazwa
),
lekkie_rejsy as (
	select *
	from obciazenie
	where masa <= ladownosc / 2
),
pomocnicza as (
	select statek.nazwa as nazwa, count(lekkie_rejsy.nazwa) as lekkie, liczba_rejsow.liczba
	from statek
	left join lekkie_rejsy on lekkie_rejsy.nazwa = statek.nazwa
	left join liczba_rejsow on liczba_rejsow.nazwa = statek.nazwa
	group by statek.nazwa, liczba_rejsow.liczba
)
select nazwa from pomocnicza
where (cast(lekkie as double precision) / liczba) >= 0.5;


