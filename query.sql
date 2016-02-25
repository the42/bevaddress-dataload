-- Connect to the database
-- psql -h localhost -d BEVADDRESS -U bevsu

-- perform a full text search with partial match
select search
from addritems
where search @@ to_tsquery(plainto_tsquery('german', 'Krems eisen')::text || ':*') 
limit 10;

--
--select ortsname, strassenname
--from addritems
-- check if distinct is really required
select distinct plz, gemeindename, ortsname, strassenname, gkz, okz, skz, matches.num
from gemeinde
inner join ortschaft
using (gkz)
inner join strasse
using (gkz)
inner join adresse
using (gkz, okz, skz)
inner join
(select skz, count(skz) as num
from addritems
where search @@ to_tsquery(plainto_tsquery('german', 'am hof')::text || ':*') 
group by skz
-- to limit search time
order by num desc
limit 10) as matches
using(skz)
order by matches.num desc, gemeindename