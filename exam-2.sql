-- Tomasz Zając 448580, grupa 3., zadanie 2.

with 
przywiezione as (
	select port.nazwa as port, coalesce(sum(ilosc), 0) as przyw
	from port
	left join rejs on port.nazwa = rejs.dokad
	left join manifest on rejs.numer = manifest.rejs
	group by port.nazwa
),
wywiezione as (
	select port.nazwa as port, coalesce(sum(ilosc), 0) as wyw
	from port
	left join rejs on port.nazwa = rejs.skad
	left join manifest on rejs.numer = manifest.rejs
	group by port.nazwa
)
select nazwa as nazwa_portu, przyw - wyw as bilans
from port
left join przywiezione on port.nazwa = przywiezione.port
left join wywiezione on port.nazwa = wywiezione.port
order by bilans desc;