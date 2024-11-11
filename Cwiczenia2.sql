create extension postgis;

create table roads (id int, geometry geometry, name varchar(50));
create table buildings (id int, geometry geometry, name varchar(50));
create table poi (id int, geometry geometry, name varchar(50));

insert into roads (id, name, geometry) values
(1, 'RoadX', 'LINESTRING(0 4.5, 12 4.5)'),
(2, 'RoadY', 'LINESTRING(7.5 10.5, 7.5 0)');

insert into poi (id, name, geometry) values
(1, 'K', 'POINT(6 9.5)'),
(2, 'J', 'POINT(6.5 6)'),
(3, 'I', 'POINT(9.5 6)'),
(4, 'G', 'POINT(1 3.5)'),
(5, 'H', 'POINT(5.5 1.5)');

insert into buildings (id, name, geometry) values
(1, 'BuildingA', 'POLYGON((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))'),
(2, 'BuildingB', 'POLYGON((4 7, 6 7, 6 5, 4 5, 4 7))'),
(3, 'BuildingC', 'POLYGON((3 8, 5 8, 5 6, 3 6, 3 8))'),
(4, 'BuildingD', 'POLYGON((9 9, 10 9, 10 8, 9 8, 9 9))'),
(5, 'BuildingF', 'POLYGON((1 2, 2 2, 2 1, 1 1, 1 2))');


-- a)
select sum(ST_Length(geometry)) from roads;

-- b)
select ST_AsText(geometry), ST_Area(geometry), ST_Perimeter(geometry) from buildings where name like 'BuildingA';

-- c)
select name, ST_Area(geometry) from buildings order by name ASC;

-- d)
select name, ST_Perimeter(geometry) from buildings order by ST_Area(geometry) desc  limit 2;

-- e)
select ST_Distance(p.geometry, b.geometry) from buildings b, poi p where b.name like 'BuildingC' and p.name like 'K';

-- f)
select ST_Area(ST_Difference(C.geometry, ST_Buffer(B.geometry, 0.5))) from buildings B, buildings C where B.name LIKE 'BuildingB' and C.name like 'BuildingC';

-- g)
select name, ST_Centroid(geometry) from buildings where ST_Y(ST_Centroid(geometry)) > 4.5;

-- h)
select ST_Area(ST_Difference(geometry, ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))'))) from buildings where name like 'BuildingC';
