select m.id, g.player 
from euro.mecze m inner join euro.gole g on g.matchid = m.id
where g.teamid like 'POL';

select m.*
from euro.mecze m inner join euro.gole g on g.matchid = m.id
where m.id = 1004 and g.player like 'Jakub Blaszczykowski';

SELECT player, teamname, stadium, mdate FROM mecze JOIN gole ON (id=matchid) join druzyny on (mecze.team1=druzyny.id) or (mecze.team2=druzyny.id)
where teamname like 'Poland';

SELECT player, team1, team2 FROM mecze JOIN gole ON (id=matchid) join druzyny on (mecze.team1=druzyny.id) or (mecze.team2=druzyny.id)
where player like  'Mario%';

select player, teamid, coach, gtime 
from gole join druzyny on (teamid=id)
where gtime < 10;

select teamname, mdate
from druzyny join mecze on (mecze.team1=druzyny.id) or (mecze.team2=druzyny.id)
where coach like 'Franciszek Smuda';

SELECT player, gtime FROM druzyny join gole on (druzyny.id=teamid) join mecze on (matchid=mecze.id) WHERE (team1='GER' AND team2='GRE' and teamname='Greece');

select teamname, count(gole.*) as IloscGoli from druzyny join gole on gole.teamid = druzyny.id 
group by teamname
order by IloscGoli desc;

select stadium, count(gole.*) as IloscGoli from mecze join gole on (id=matchid)
group by stadium
order by IloscGoli desc;
