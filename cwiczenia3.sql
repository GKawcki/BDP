select b2.* from building_2018 b join building_2019 b2 on b.polygon_id=b2.polygon_id where not ST_Equals(b.geom, b2.geom);

select count(DISTINCT poi.geom), poi.type from t2019_kar_poi_table poi, (select geometry(ST_Buffer((geography(b2.geom)), 500)) as buffer from building_2018 b 
	join building_2019 b2 on b.polygon_id=b2.polygon_id
	where not ST_Equals(b.geom, b2.geom)) as b3 where ST_Contains(b3.buffer, poi.geom)
	GROUP by poi.type;

CREATE TABLE streets_reprojected as
select * from t2019_kar_streets;

SELECT UpdateGeometrySRID('streets_reprojected','geom',3068);

create table input_points(nazwa varchar(30), geom geometry );
INSERT INTO input_points 
values 
('punkt1', ST_Point(8.36093, 49.03174)),
('punkt2', ST_Point(8.39876, 49.00644));

SELECT UpdateGeometrySRID('input_points','geom',3068);

SELECT UpdateGeometrySRID('t2019_kar_street_node','geom',4326);

SELECT DISTINCT tksn.geom FROM t2019_kar_street_node tksn, (select geometry(ST_Buffer(geography(ST_SetSRID(ST_MakeLine(p1.geom, p2.geom), 4326)), 200)) as buffer from (select * from input_points where nazwa like 'punkt1') as p1,
(select * from input_points where nazwa like 'punkt2') as p2) as b where ST_Contains(b.buffer, tksn.geom);

select ST_Buffer(geography(ST_SetSRID(ST_MakeLine(p1.geom, p2.geom), 4326)), 200) from (select * from input_points where nazwa like 'punkt1') as p1,
(select * from input_points where nazwa like 'punkt2') as p2;

select count(distinct ST_Contains(ST_buffer(tklua.geom::geography, 300)::geometry, poi.geom)) 
	from t2019_kar_land_use_a tklua, t2019_kar_poi_table poi where poi.type like 'Sporting Goods Store';

CREATE TABLE T2019_KAR_BRIDGES as
select DISTINCT ST_Intersection(w.geom, r.geom) from t2019_kar_railways r, t2019_kar_water_lines w where ST_INTERSECTS(r.geom, w.geom);

select * from streets_reprojected;
select * from t2019_kar_streets;
