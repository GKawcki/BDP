create extension postgis;
create table obiekty(nazwa varchar(30), geometria geometry );
INSERT INTO obiekty 
values 
('obiekt1', ST_GeomFromText('COMPOUNDCURVE((0 1, 1 1), CIRCULARSTRING(1 1, 2 0, 3 1),CIRCULARSTRING(3 1, 4 2, 5 1), (5 1, 6 1) )', 0)),
('obiekt2', ST_GeomFromText('COMPOUNDCURVE((10 6, 14 6), CIRCULARSTRING(14 6, 16 4, 14 2), CIRCULARSTRING(14 2, 12 0, 10 2), (10 2, 10 6) )', 0)),
('obiekt3', ST_GeomFromText('LINESTRING(7 15, 10 17, 12 13, 7 15)', 0)),
('obiekt4', ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)', 0)),
('obiekt5', ST_GeomFromText('MULTIPOINT(30 30 59, 38 32 234)', 0)),
('obiekt6', ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(1 1, 3 2), POINT(4 2))', 0));

select ST_area(ST_Buffer(ST_ShortestLine(o3.geometria, o4.geometria), 5)) from (select * from obiekty where nazwa like 'obiekt3') as o3,
(select * from obiekty where nazwa like 'obiekt4') as o4;

update obiekty set geometria = ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5, 20 20)', 0) where nazwa like 'obiekt4';
select ST_MakePolygon(o.geometria) from obiekty o where nazwa like 'obiekt4';

INSERT INTO obiekty 
values ('obiekt7', ST_Union(ST_GeomFromText('LINESTRING(7 15, 10 17, 12 13, 7 15)', 0), ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5, 20 20)', 0)));

SELECT SUM(ST_Area(ST_Buffer(geometria , 5))) AS total_area FROM obiekty o where not ST_HasArc(geometria);



