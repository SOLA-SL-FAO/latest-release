--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = system, pg_catalog;

--
-- Data for Name: config_map_layer_type; Type: TABLE DATA; Schema: system; Owner: postgres
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE config_map_layer_type DISABLE TRIGGER ALL;

INSERT INTO config_map_layer_type (code, display_value, status, description) VALUES ('wms', 'WMS server with layers::::Server WMS con layer', 'c', NULL);
INSERT INTO config_map_layer_type (code, display_value, status, description) VALUES ('shape', 'Shapefile::::Shapefile', 'c', NULL);
INSERT INTO config_map_layer_type (code, display_value, status, description) VALUES ('pojo', 'Pojo layer::::Pojo layer', 'c', NULL);
INSERT INTO config_map_layer_type (code, display_value, status, description) VALUES ('pojo_public_display', 'Pojo layer used for public display', 'c', 'It is an extension of pojo layer. It is used only during the public display map generation.');


ALTER TABLE config_map_layer_type ENABLE TRIGGER ALL;

--
-- Data for Name: query; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE query DISABLE TRIGGER ALL;

INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getParcelsPending', 'select co.id, co.name_firstpart || ''/'' || co.name_lastpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom  from cadastre.cadastre_object co  where type_code= ''parcel'' and status_code= ''pending''   and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid})) union select co.id, co.name_firstpart || ''/'' || co.name_lastpart as label,  st_asewkb(co_t.geom_polygon) as the_geom  from cadastre.cadastre_object co inner join cadastre.cadastre_object_target co_t on co.id = co_t.cadastre_object_id and co_t.geom_polygon is not null where ST_Intersects(co_t.geom_polygon, ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))       and co_t.transaction_id in (select id from transaction.transaction where status_code not in (''approved'')) ', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getSurveyControls', 'select id, label, st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.survey_control  where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getRoads', 'select id, label, st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.road where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid})) and st_area(geom)> power(5 * #{pixel_res}, 2)', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getPlaceNames', 'select id, label, st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.place_name where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getApplications', 'select id, nr as label, st_asewkb(st_transform(location, #{srid})) as the_geom from application.application where ST_Intersects(st_transform(location, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_parcel_pending', 'select co.id, co.name_firstpart || ''/'' || co.name_lastpart as parcel_nr,       ( SELECT spatial_value_area.size FROM cadastre.spatial_value_area         WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,   st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom    from cadastre.cadastre_object co  where type_code= ''parcel'' and ((status_code= ''pending''    and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid})))   or (co.id in (select cadastre_object_id           from cadastre.cadastre_object_target co_t inner join transaction.transaction t on co_t.transaction_id=t.id           where ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid})) and t.status_code not in (''approved''))))', NULL);
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_place_name', 'select id, label,  st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.place_name where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_road', 'select id, label,  st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.road where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_application', 'select id, nr,  st_asewkb(st_transform(location, #{srid})) as the_geom from application.application where ST_Intersects(st_transform(location, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_survey_control', 'select id, label,  st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.survey_control where ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getParcelsHistoricWithCurrentBA', 'select co.id, co.name_firstpart || ''/'' || co.name_lastpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom from cadastre.cadastre_object co inner join administrative.ba_unit_contains_spatial_unit ba_co on co.id = ba_co.spatial_unit_id   inner join administrative.ba_unit ba_unit on ba_unit.id= ba_co.ba_unit_id where co.type_code=''parcel'' and co.status_code= ''historic'' and ba_unit.status_code = ''current'' and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 'select co.id, co.name_firstpart || ''/'' || co.name_lastpart as parcel_nr,         (select string_agg(ba.name_firstpart || ''/'' || ba.name_lastpart, '','')           from administrative.ba_unit_contains_spatial_unit bas, administrative.ba_unit ba           where spatial_unit_id= co.id and bas.ba_unit_id= ba.id) as ba_units,         (SELECT spatial_value_area.size      FROM cadastre.spatial_value_area           WHERE spatial_value_area.type_code=''officialArea'' and spatial_value_area.spatial_unit_id = co.id) AS area_official_sqm,         st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom        from cadastre.cadastre_object co inner join administrative.ba_unit_contains_spatial_unit ba_co on co.id = ba_co.spatial_unit_id   inner join administrative.ba_unit ba_unit on ba_unit.id= ba_co.ba_unit_id where co.type_code=''parcel'' and co.status_code= ''historic'' and ba_unit.status_code = ''current''       and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getParcels', 'select co.id, co.name_firstpart || ''/'' || co.name_lastpart as label,  st_asewkb(st_transform(co.geom_polygon, #{srid})) as the_geom from cadastre.cadastre_object co where type_code= ''parcel'' and status_code= ''current'' and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('system_search.cadastre_object_by_baunit_id', 'SELECT id,  name_firstpart || ''/ '' || name_lastpart as label, st_asewkb(st_transform(geom_polygon, #{srid})) as the_geom  FROM cadastre.cadastre_object WHERE transaction_id IN (  SELECT cot.transaction_id FROM (administrative.ba_unit_contains_spatial_unit ba_su     INNER JOIN cadastre.cadastre_object co ON ba_su.spatial_unit_id = co.id)     INNER JOIN cadastre.cadastre_object_target cot ON co.id = cot.cadastre_object_id     WHERE ba_su.ba_unit_id = #{search_string})  AND (SELECT COUNT(1) FROM administrative.ba_unit_contains_spatial_unit WHERE spatial_unit_id = cadastre_object.id) = 0 AND status_code = ''current''', 'Query used by BaUnitBean.loadNewParcels');
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getParcelNodes', 'select distinct st_astext(st_transform(geom, #{srid})) as id, '''' as label, st_asewkb(st_transform(geom, #{srid})) as the_geom from (select (ST_DumpPoints(geom_polygon)).* from cadastre.cadastre_object co  where type_code= ''parcel'' and status_code= ''current''  and ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))) tmp_table ', NULL);
INSERT INTO query (name, sql, description) VALUES ('public_display.parcels_next', 'SELECT co_next.id, co_next.name_firstpart as label,  st_asewkb(st_transform(co_next.geom_polygon, #{srid})) as the_geom  from cadastre.cadastre_object co_next, cadastre.cadastre_object co where co.type_code= ''parcel'' and co.status_code= ''current'' and co_next.type_code= ''parcel'' and co_next.status_code= ''current'' and co.name_lastpart = #{name_lastpart} and co_next.name_lastpart != #{name_lastpart} and st_dwithin(st_transform(co.geom_polygon, #{srid}), st_transform(co_next.geom_polygon, #{srid}), 5) and ST_Intersects(st_transform(co_next.geom_polygon, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', ' Query is used from public display map. It retrieves parcels being near the parcels of the layer public-display-parcels.');
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getHierarchy', 'select id, label, st_asewkb(geom) as the_geom, filter_category  from cadastre.hierarchy where ST_Intersects(geom, ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid})) and st_area(geom)> power(5 * #{pixel_res}, 2)', 'Query is used from Spatial Unit Group Editor to edit hierarchy records');
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getRoadCenterlines', 'select id, label, st_asewkb(st_transform(geom, #{srid})) as the_geom from cadastre.spatial_unit where level_id = ''road-centerline'' and ST_Intersects(st_transform(geom, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getHouseNum', 'select su.id, su.label,  st_asewkb(su.reference_point) as the_geom from cadastre.spatial_unit su, cadastre.level l where su.level_id = l.id and l."name" = ''House Number'' and ST_Intersects(su.reference_point, ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_parcel', 'SELECT co.id, co.name_firstpart || ''/'' || co.name_lastpart AS parcel_nr, 
	   (SELECT string_agg(ba.name_firstpart || ''/'' || ba.name_lastpart, '', '') 
	    FROM administrative.ba_unit_contains_spatial_unit bas, 
		     administrative.ba_unit ba 
		WHERE spatial_unit_id = co.id 
		AND   bas.ba_unit_id = ba.id) AS ba_units,
	   (SELECT cadastre.format_area_metric(sva.size)
	    FROM cadastre.spatial_value_area  sva    
		WHERE sva.type_code = ''officialArea'' 
		AND   sva.spatial_unit_id = co.id) AS area_official_sqm,
       (SELECT string_agg(a.description, '' - '')
	    FROM   cadastre.spatial_unit_address sua,
		       address.address a
		WHERE  sua.spatial_unit_id = co.id
		AND    a.id = sua.address_id) AS locality,				
        st_asewkb(st_transform(geom_polygon, #{srid})) as the_geom 
  FROM cadastre.cadastre_object  co
  WHERE co.type_code = ''parcel''
  AND   status_code = ''current''
  AND   geom_polygon IS NOT NULL
  AND  ST_Intersects(st_transform(geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getStateLands', 'SELECT id, co.name_firstpart || '' '' || co.name_lastpart AS label, 
        co.state_land_status_code AS filter_category,
        st_asewkb(st_transform(geom_polygon, #{srid})) AS the_geom 
 FROM cadastre.cadastre_object  co
 WHERE co.type_code = ''stateLand''
 AND co.status_code = ''current''
 AND co.geom_polygon IS NOT NULL
 AND ST_Intersects(st_transform(geom_polygon, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', 'Retrieves state land polygons');
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_state_land', 'SELECT id, co.name_firstpart || '' '' || co.name_lastpart AS label, 
	   (SELECT string_agg(ba.name_firstpart || ba.name_lastpart, '', '') 
	    FROM administrative.ba_unit_contains_spatial_unit bas, 
		     administrative.ba_unit ba 
		WHERE spatial_unit_id = co.id 
		AND   bas.ba_unit_id = ba.id) AS property,
	   (SELECT cadastre.format_area_metric(sva.size)
	    FROM cadastre.spatial_value_area  sva    
		WHERE sva.type_code = ''officialArea'' 
		AND   sva.spatial_unit_id = co.id) AS area,
       (SELECT string_agg(a.description, '' - '')
	    FROM   cadastre.spatial_unit_address sua,
		       address.address a
		WHERE  sua.spatial_unit_id = co.id
		AND    a.id = sua.address_id) AS locality,		
       (SELECT sl.display_value 
	    FROM   cadastre.state_land_status_type sl
		WHERE  sl.code = co.state_land_status_code) AS sl_status,		
        st_asewkb(st_transform(geom_polygon, #{srid})) as the_geom 
  FROM cadastre.cadastre_object  co
  WHERE co.type_code = ''stateLand''
   AND  co.status_code = ''current''
  AND   geom_polygon IS NOT NULL
  AND  ST_Intersects(st_transform(geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getPendingStateLands', 'SELECT id, co.name_firstpart || '' '' || co.name_lastpart AS label, 
        co.state_land_status_code AS filter_category,
        st_asewkb(st_transform(geom_polygon, #{srid})) AS the_geom 
 FROM cadastre.cadastre_object  co
 WHERE co.type_code = ''stateLand''
 AND co.status_code = ''pending''
 AND co.geom_polygon IS NOT NULL
 AND ST_Intersects(st_transform(geom_polygon, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', 'Retrieves state land polygons');
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_pending_state_land', 'SELECT id, co.name_firstpart || '' '' || co.name_lastpart AS label, 
	   (SELECT string_agg(ba.name_firstpart || ba.name_lastpart, '', '') 
	    FROM administrative.ba_unit_contains_spatial_unit bas, 
		     administrative.ba_unit ba 
		WHERE spatial_unit_id = co.id 
		AND   bas.ba_unit_id = ba.id) AS property,
	   (SELECT cadastre.format_area_metric(sva.size)
	    FROM cadastre.spatial_value_area  sva    
		WHERE sva.type_code = ''officialArea'' 
		AND   sva.spatial_unit_id = co.id) AS area,
       (SELECT string_agg(a.description, '' - '')
	    FROM   cadastre.spatial_unit_address sua,
		       address.address a
		WHERE  sua.spatial_unit_id = co.id
		AND    a.id = sua.address_id) AS locality,		
       (SELECT sl.display_value 
	    FROM   cadastre.state_land_status_type sl
		WHERE  sl.code = co.state_land_status_code) AS sl_status,		
        st_asewkb(st_transform(geom_polygon, #{srid})) as the_geom 
  FROM cadastre.cadastre_object  co
  WHERE co.type_code = ''stateLand''
   AND  co.status_code = ''pending''
  AND   geom_polygon IS NOT NULL
  AND  ST_Intersects(st_transform(geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('SpatialResult.getDisposedStateLands', 'SELECT id, co.name_firstpart || '' '' || co.name_lastpart AS label, 
        st_asewkb(st_transform(geom_polygon, #{srid})) AS the_geom 
 FROM cadastre.cadastre_object  co
 WHERE co.type_code = ''stateLand''
 AND co.state_land_status_code = ''disposed''
 AND co.geom_polygon IS NOT NULL
 AND ST_Intersects(st_transform(geom_polygon, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', 'Retrieves state land polygons');
INSERT INTO query (name, sql, description) VALUES ('dynamic.informationtool.get_disposed_state_land', 'SELECT id, co.name_firstpart || '' '' || co.name_lastpart AS label, 
	   (SELECT string_agg(ba.name_firstpart || ba.name_lastpart, '', '') 
	    FROM administrative.ba_unit_contains_spatial_unit bas, 
		     administrative.ba_unit ba 
		WHERE spatial_unit_id = co.id 
		AND   bas.ba_unit_id = ba.id) AS property,
	   (SELECT cadastre.format_area_metric(sva.size)
	    FROM cadastre.spatial_value_area  sva    
		WHERE sva.type_code = ''officialArea'' 
		AND   sva.spatial_unit_id = co.id) AS area,
       (SELECT string_agg(a.description, '' - '')
	    FROM   cadastre.spatial_unit_address sua,
		       address.address a
		WHERE  sua.spatial_unit_id = co.id
		AND    a.id = sua.address_id) AS locality,		
       (SELECT sl.display_value 
	    FROM   cadastre.state_land_status_type sl
		WHERE  sl.code = co.state_land_status_code) AS sl_status,		
        st_asewkb(st_transform(geom_polygon, #{srid})) as the_geom 
  FROM cadastre.cadastre_object  co
  WHERE co.type_code = ''stateLand''
  AND   co.state_land_status_code = ''disposed''
  AND   geom_polygon IS NOT NULL
  AND  ST_Intersects(st_transform(geom_polygon, #{srid}), ST_SetSRID(ST_GeomFromWKB(#{wkb_geom}), #{srid}))', NULL);
INSERT INTO query (name, sql, description) VALUES ('map_search.locality', 'WITH state_land AS ( SELECT co.id, a.description as label, st_asewkb(co.geom_polygon) as the_geom 
  FROM cadastre.cadastre_object co, cadastre.spatial_unit_address sa,
       address.address a
  WHERE co.id = sa.spatial_unit_id
  AND   a.id = sa.address_id  
  AND compare_strings(#{search_string}, a.description)
  AND co.geom_polygon IS NOT NULL
  AND co.type_code = ''stateLand''
  AND co.status_code IN (''pending'', ''current''))
  
 SELECT co.id, a.description as label, 
        st_asewkb(co.geom_polygon) as the_geom	
  FROM cadastre.cadastre_object co, cadastre.spatial_unit_address sa,
       address.address a
  WHERE co.id = sa.spatial_unit_id
  AND   a.id = sa.address_id  
  AND compare_strings(#{search_string}, a.description)
  AND co.geom_polygon IS NOT NULL
  AND co.type_code != ''stateLand''
  AND co.status_code IN (''pending'', ''current'')
  AND NOT EXISTS (SELECT sl.id FROM state_land sl 
                  WHERE a.description = sl.label)
  UNION
  SELECT id, label, the_geom  FROM state_land ', NULL);
INSERT INTO query (name, sql, description) VALUES ('map_search.cadastre_object_by_number', 'WITH state_land AS ( 
  SELECT co.id, TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) as label, 
         st_asewkb(co.geom_polygon) as the_geom 
  FROM cadastre.cadastre_object co
  WHERE co.geom_polygon IS NOT NULL
  AND co.type_code = ''stateLand''
  AND co.status_code = ''current''
  AND compare_strings(#{search_string}, co.name_firstpart || '' '' || co.name_lastpart)),
  
state_land_pending AS ( 
  SELECT co.id, TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) as label, 
         st_asewkb(co.geom_polygon) as the_geom 
  FROM cadastre.cadastre_object co
  WHERE co.geom_polygon IS NOT NULL
  AND co.type_code = ''stateLand''
  AND co.status_code = ''pending''
  AND compare_strings(#{search_string}, co.name_firstpart || '' '' || co.name_lastpart))
  
 SELECT co.id, TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) as label, 
         st_asewkb(co.geom_polygon) as the_geom 
  FROM cadastre.cadastre_object co
  WHERE co.geom_polygon IS NOT NULL
  AND co.type_code != ''stateLand''
  AND co.status_code = ''current''
  AND compare_strings(#{search_string}, co.name_firstpart || '' '' || co.name_lastpart)
  AND NOT EXISTS (SELECT sl.id FROM state_land sl 
                  WHERE TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) = sl.label)
  AND NOT EXISTS (SELECT slp.id FROM state_land_pending slp
                  WHERE TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) = slp.label)
  UNION 
  SELECT id, label, the_geom FROM state_land_pending slp
  WHERE NOT EXISTS (SELECT sl.id FROM state_land sl 
                    WHERE slp.label = sl.label)
  UNION
  SELECT id, label, the_geom FROM state_land 
  LIMIT 50 ', NULL);
INSERT INTO query (name, sql, description) VALUES ('map_search.cadastre_object_by_baunit', 'WITH state_land AS ( 
  SELECT co.id, TRIM(ba.name_firstpart) || TRIM(ba.name_lastpart)
    || '' ('' || TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) || '')'' as label, 
         st_asewkb(co.geom_polygon) as the_geom 
  FROM cadastre.cadastre_object co,
       administrative.ba_unit_contains_spatial_unit bas,
	   administrative.ba_unit ba
  WHERE co.geom_polygon IS NOT NULL
  AND co.type_code = ''stateLand''
  AND co.status_code = ''current''
  AND bas.spatial_unit_id = co.id
  AND ba.id = bas.ba_unit_id
  AND ba.status_code = ''current''
  AND compare_strings(#{search_string}, ba.name_firstpart || '' '' || ba.name_lastpart)),
  
state_land_pending AS ( 
  SELECT co.id, TRIM(ba.name_firstpart) || TRIM(ba.name_lastpart) 
       || '' ('' || TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) || '')'' as label, 
         st_asewkb(co.geom_polygon) as the_geom
  FROM cadastre.cadastre_object co,
       administrative.ba_unit_contains_spatial_unit bas,
	   administrative.ba_unit ba
  WHERE co.geom_polygon IS NOT NULL
  AND co.type_code = ''stateLand''
  AND co.status_code = ''pending''
  AND bas.spatial_unit_id = co.id
  AND ba.id = bas.ba_unit_id
  AND ba.status_code = ''current''
  AND compare_strings(#{search_string}, ba.name_firstpart || '' '' || ba.name_lastpart))
  
  SELECT id, label, the_geom, 1 AS sort_idx FROM state_land_pending slp
  WHERE NOT EXISTS (SELECT sl.id FROM state_land sl 
                    WHERE slp.label = sl.label)
  UNION
  SELECT id, label, the_geom, 1 AS sort_idx FROM state_land
  UNION
  SELECT co.id, TRIM(ba.name_firstpart) || ''/'' || TRIM(ba.name_lastpart) 
     || '' ('' || TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) || '')'' as label,   
         st_asewkb(co.geom_polygon) as the_geom, 2 AS sort_idx
  FROM cadastre.cadastre_object co,
       administrative.ba_unit_contains_spatial_unit bas,
	   administrative.ba_unit ba
  WHERE co.geom_polygon IS NOT NULL
  AND co.type_code != ''stateLand''
  AND co.status_code = ''current''
  AND bas.spatial_unit_id = co.id
  AND ba.id = bas.ba_unit_id
  AND ba.status_code = ''current''
  AND compare_strings(#{search_string}, ba.name_firstpart || '' '' || ba.name_lastpart)
  LIMIT 50 ', NULL);
INSERT INTO query (name, sql, description) VALUES ('map_search.cadastre_object_by_baunit_owner', 'WITH state_land AS ( 
  SELECT co.id,  COALESCE(p.name, '''') || '' '' || COALESCE(p.last_name, '''') 
       || '' ('' || TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) || '')'' as label, 
         st_asewkb(co.geom_polygon) as the_geom 
  FROM cadastre.cadastre_object co,
       administrative.ba_unit_contains_spatial_unit bas,
	   administrative.rrr rrr, 
	   administrative.party_for_rrr pfr,
	   party.party p   
  WHERE co.geom_polygon IS NOT NULL
  AND co.type_code = ''stateLand''
  AND co.status_code = ''current''
  AND bas.spatial_unit_id = co.id
  AND rrr.ba_unit_id = bas.ba_unit_id
  AND rrr.is_primary = TRUE
  AND rrr.status_code = ''current''
  AND pfr.rrr_id = rrr.id
  AND p.id = pfr.party_id
  AND compare_strings(#{search_string}, COALESCE(p.name, '''') || '' '' || COALESCE(p.last_name, ''''))),
  
state_land_pending AS ( 
  SELECT co.id,  COALESCE(p.name, '''') || '' '' || COALESCE(p.last_name, '''') 
    || '' ('' || TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) || '')'' as label, 
         st_asewkb(co.geom_polygon) as the_geom 
  FROM cadastre.cadastre_object co,
       administrative.ba_unit_contains_spatial_unit bas,
	   administrative.rrr rrr, 
	   administrative.party_for_rrr pfr,
	   party.party p   
  WHERE co.geom_polygon IS NOT NULL
  AND co.type_code = ''stateLand''
  AND co.status_code = ''pending''
  AND bas.spatial_unit_id = co.id
  AND rrr.ba_unit_id = bas.ba_unit_id
  AND rrr.is_primary = TRUE
  AND rrr.status_code = ''current''
  AND pfr.rrr_id = rrr.id
  AND p.id = pfr.party_id
  AND compare_strings(#{search_string}, COALESCE(p.name, '''') || '' '' || COALESCE(p.last_name, '''')))
  
  SELECT id, label, the_geom, 1 AS sort_idx FROM state_land_pending slp
  WHERE NOT EXISTS (SELECT sl.id FROM state_land sl 
                    WHERE slp.label = sl.label)
  UNION
  SELECT id, label, the_geom, 1 AS sort_idx FROM state_land
  UNION
  SELECT co.id,  COALESCE(p.name, '''') || '' '' || COALESCE(p.last_name, '''') 
     || '' ('' || TRIM(co.name_firstpart) || '' '' || TRIM(co.name_lastpart) || '')'' as label,   
         st_asewkb(co.geom_polygon) as the_geom, 2 AS sort_idx 
  FROM cadastre.cadastre_object co,
       administrative.ba_unit_contains_spatial_unit bas,
	   administrative.rrr rrr, 
	   administrative.party_for_rrr pfr,
	   party.party p   
  WHERE co.geom_polygon IS NOT NULL
  AND co.type_code != ''stateLand''
  AND co.status_code = ''current''
  AND bas.spatial_unit_id = co.id
  AND rrr.ba_unit_id = bas.ba_unit_id
  AND rrr.is_primary = TRUE
  AND rrr.status_code = ''current''
  AND pfr.rrr_id = rrr.id
  AND p.id = pfr.party_id
  AND compare_strings(#{search_string}, COALESCE(p.name, '''') || '' '' || COALESCE(p.last_name, ''''))
  LIMIT 50 ', NULL);
INSERT INTO query (name, sql, description) VALUES ('public_display.parcels', 'SELECT co.id, co.name_firstpart || '' '' || co.name_lastpart AS label, 
        st_asewkb(st_transform(co.geom_polygon, #{srid})) AS the_geom 
 FROM cadastre.cadastre_object  co,
      application.application_spatial_unit asu
 WHERE asu.application_id = #{appId}
 AND   co.id = asu.spatial_unit_id
 AND   co.type_code = ''stateLand''
 AND   co.geom_polygon IS NOT NULL
 AND ST_Intersects(st_transform(co.geom_polygon, #{srid}), ST_SetSRID(ST_3DMakeBox(ST_Point(#{minx}, #{miny}),ST_Point(#{maxx}, #{maxy})), #{srid}))', 'Used by the Public Display Map task to retrieve state land parcels associated to the job');


ALTER TABLE query ENABLE TRIGGER ALL;

--
-- Data for Name: config_map_layer; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE config_map_layer DISABLE TRIGGER ALL;

INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('place-names', 'Places names::::Nomi di luoghi', 'pojo', true, true, 60, 'place_name.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Point,label:""', 'SpatialResult.getPlaceNames', 'dynamic.informationtool.get_place_name', NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('sug_hierarchy', 'Hierarchy', 'pojo', false, false, 9, 'sug-hierarchy.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:"",filter_category', 'SpatialResult.getHierarchy', NULL, NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('public-display-parcels-next', 'Other Systematic Registration Parcels', 'pojo_public_display', false, true, 30, 'public_display_parcel_next.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:""', 'public_display.parcels_next', NULL, NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('pending-parcels', 'Pending parcels::::Particelle pendenti', 'pojo', false, false, 30, 'pending_parcels.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:""', 'SpatialResult.getParcelsPending', 'dynamic.informationtool.get_parcel_pending', NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('survey-controls', 'Survey controls::::Piani di controllo', 'pojo', false, false, 50, 'survey_control.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Point,label:""', 'SpatialResult.getSurveyControls', 'dynamic.informationtool.get_survey_control', NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('applications', 'Applications::::Pratiche', 'pojo', false, false, 70, 'application.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:MultiPoint,label:""', 'SpatialResult.getApplications', 'dynamic.informationtool.get_application', NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('parcels-historic-current-ba', 'Historic parcels with current titles', 'pojo', false, false, 20, 'parcel_historic_current_ba.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:""', 'SpatialResult.getParcelsHistoricWithCurrentBA', 'dynamic.informationtool.get_parcel_historic_current_ba', NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('parcel-nodes', 'Parcel nodes', 'pojo', false, false, 15, 'parcel_node.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:""', 'SpatialResult.getParcelNodes', NULL, NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('roads', 'Roads::::Strade', 'pojo', true, false, 29, 'road.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:MultiPolygon,label:""', 'SpatialResult.getRoads', 'dynamic.informationtool.get_road', NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('state-land', 'State land', 'pojo', true, true, 36, 'state_land.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:"",filter_category:""', 'SpatialResult.getStateLands', 'dynamic.informationtool.get_state_land', NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('state-land-pending', 'Pending state land', 'pojo', true, true, 39, 'state_land_pending.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:"",filter_category:""', 'SpatialResult.getPendingStateLands', 'dynamic.informationtool.get_pending_state_land', NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('state-land-disposed', 'Disposed state land', 'pojo', true, false, 33, 'state_land_disposed.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:""', 'SpatialResult.getDisposedStateLands', 'dynamic.informationtool.get_disposed_state_land', NULL, NULL, NULL, false, false, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('parcels', 'Parcels::::Particelle', 'pojo', true, true, 25, 'parcel.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:""', 'SpatialResult.getParcels', 'dynamic.informationtool.get_parcel', NULL, NULL, NULL, false, true, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('orthophoto', 'Orthophoto', 'wms', true, false, 10, NULL, 'http://demo.flossola.org/geoserver/sola/wms', 'sola:nz_orthophoto', '1.1.1', 'image/jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, true, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('road-centerlines', 'Road centerlines', 'pojo', true, true, 45, 'road_centerline.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:MultiLineString,label:""', 'SpatialResult.getRoadCenterlines', NULL, NULL, NULL, NULL, false, true, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('house_num', 'House number', 'pojo', true, true, 43, 'house_num.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Point,label:""', 'SpatialResult.getHouseNum', NULL, NULL, NULL, NULL, false, true, false);
INSERT INTO config_map_layer (name, title, type_code, active, visible_in_start, item_order, style, url, wms_layers, wms_version, wms_format, wms_data_source, pojo_structure, pojo_query_name, pojo_query_name_for_select, shape_location, security_user, security_password, added_from_bulk_operation, use_in_public_display, use_for_ot) VALUES ('public-display-parcels', 'Public display parcels', 'pojo_public_display', true, true, 35, 'public_display_parcel.xml', NULL, NULL, NULL, NULL, NULL, 'theGeom:Polygon,label:""', 'public_display.parcels', NULL, NULL, NULL, NULL, false, true, false);


ALTER TABLE config_map_layer ENABLE TRIGGER ALL;

--
-- Data for Name: config_map_layer_metadata; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE config_map_layer_metadata DISABLE TRIGGER ALL;



ALTER TABLE config_map_layer_metadata ENABLE TRIGGER ALL;

--
-- Data for Name: panel_launcher_group; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE panel_launcher_group DISABLE TRIGGER ALL;

INSERT INTO panel_launcher_group (code, display_value, description, status) VALUES ('slPropertyServices', 'State Land Property Services::::::::::::::::የመንግስት መሬት ላይ ያለ ንብረት አገልግሎቶች', 'Panels used for State Land property services::::::::::::::::በመንግስት መሬት ላይ ያለ ንብረት አገልግሎቶች ፓኔሎች', 'c');
INSERT INTO panel_launcher_group (code, display_value, description, status) VALUES ('propertyServices', 'Property Services::::::::::::::::የንብረት አገልግሎቶች', 'Panels used for property services::::::::::::::::ለንብረት አገልግሎቶች የሚረዱ ፓኔሎች ', 'c');
INSERT INTO panel_launcher_group (code, display_value, description, status) VALUES ('nullConstructor', 'Nullary Constructor::::::::::::::::ኑላሪ ኮንስትራክተር', 'Panels that do not take any constructor arguments::::::::::::::::ማንኛውንም ኮንስትራክተር ሙግቶችን የማይወስዱ ፓኔሎች', 'c');
INSERT INTO panel_launcher_group (code, display_value, description, status) VALUES ('newPropServices', 'New Property Services::::::::::::::::አዲስ የንብረት አገልግሎቶች', 'Panels used for new property services::::::::::::::::ለአዲስ ንብረት አገልግሎቶች የሚረዱ ፓኔሎች', 'c');
INSERT INTO panel_launcher_group (code, display_value, description, status) VALUES ('leaseRRR', 'Lease RRR::::::::::::::::ሊዝ መገኃ', 'Panels used for Lease RRR::::::::::::::::ለሊዝ መገኃቶች የሚያገለግሉ ', 'c');
INSERT INTO panel_launcher_group (code, display_value, description, status) VALUES ('generalRRR', 'General RRR::::::::::::::::አጠቃላይ መገኃ', 'Panels used for general RRRs::::::::::::::::ለአጠቃላይ መገኃ የሚረዱ ፓኔሎች ', 'c');
INSERT INTO panel_launcher_group (code, display_value, description, status) VALUES ('documentServices', 'Document Services::::::::::::::::ሰነድ አገልግሎቶች', 'Panels used for document services::::::::::::::::ለሰነድ አገልግሎቶች የሚረዱ ፓኔሎች', 'c');
INSERT INTO panel_launcher_group (code, display_value, description, status) VALUES ('cadastreServices', 'Cadastre Services::::::::::::::::የካዳስተር አገልግሎቶች', 'Panels used for cadastre services::::::::::::::::ለካዳስተር አገልግሎቶች የሚረዱ ፓኔሎች', 'c');
INSERT INTO panel_launcher_group (code, display_value, description, status) VALUES ('generalServices', 'General Services::::::::::::::::አጠቃላይ አገልግሎት', '', 'c');


ALTER TABLE panel_launcher_group ENABLE TRIGGER ALL;

--
-- Data for Name: config_panel_launcher; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE config_panel_launcher DISABLE TRIGGER ALL;

INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('publicDisplay', 'Public Display Panel::::::::::::::::ለሕዝብ ማሳያ ፓኔል', '', 'c', 'generalServices', 'org.sola.clients.swing.desktop.workflow.PublicDisplayPanel', 'cliprgs110', 'publicDisplay');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('lease', 'Lease Panel::::::::::::::::ሊዝ ፓኔል', '', 'c', 'leaseRRR', 'org.sola.clients.swing.desktop.administrative.LeasePanel', NULL, 'leasePanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('slObjection', 'Objections List Panel::::::::::::::::የተቃውሞዎች ዝርዝር ፓኔል', '', 'c', 'generalServices', 'org.sola.clients.swing.desktop.workflow.ObjectionListPanel', NULL, 'slObjectionListPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('ownership', 'Ownership Share Panel::::::::::::::::የባለሃብትነት ድርሻ ፓኔል', '', 'c', 'generalRRR', 'org.sola.clients.swing.desktop.administrative.OwnershipPanel', NULL, 'ownershipPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('slNotify', 'Notify List Panel::::::::::::::::የፓኔል ዝርዝር ያሳውቃል', '', 'c', 'generalServices', 'org.sola.clients.swing.desktop.workflow.NotifyListPanel', NULL, 'slNotifyListPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('slValuation', 'Valuations List Panel::::::::::::::::የንብረት ግምቶች ዝርዝር', '', 'c', 'generalServices', 'org.sola.clients.swing.desktop.administrative.ValuationListPanel', NULL, 'slValuationListPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('simpleRightCondPanel', 'Simple Right Condition Panel::::::::::::::::ቀላል የመብት ሁኔታ ፓኔል', '', 'c', 'generalRRR', 'org.sola.clients.swing.desktop.administrative.SimpleRightConditionPanel', NULL, 'simpleRightCondPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('simpleRholdConPanel', 'Simple Rightholder Condition Panel::::::::::::::::ቀላል የባለመብት ሁኔታ ፓኔል', '', 'c', 'generalRRR', 'org.sola.clients.swing.desktop.administrative.SimpleRightholderConditionPanel', NULL, 'simpleRightholderCondPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('slNegotiate', 'Negotiate List Panel::::::::::::::::ዝርዝር ፓኔል ተደራደር', '', 'c', 'generalServices', 'org.sola.clients.swing.desktop.workflow.NegotiationListPanel', NULL, 'slNegotiationListPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('newSLProperty', 'New State Land Property Panel::::::::::::::::አዲስ በመንግስት መሬት ላይ ያለ መብት ፓኔል', '', 'c', 'newPropServices', 'org.sola.clients.swing.desktop.administrative.SLPropertyPanel', 'cliprgs009', 'slPropertyPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('slProperty', 'State Land Property Panel::::::::::::::::የመንግስት መሬት ላይ ያለ ንብረት የሚመለከት ፓኔል', '', 'c', 'slPropertyServices', 'org.sola.clients.swing.desktop.administrative.SLPropertyPanel', 'cliprgs009', 'slPropertyPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('checklist', 'Checklist Panel::::::::::::::::መሟላት ያለባቸው ጉዳዮች  ዝርዝር ፓኔል', '', 'c', 'generalServices', 'org.sola.clients.swing.desktop.workflow.ChecklistPanel', 'cliprgs108', 'checklistPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('map', 'Map Panel::::::::::::::::የካርታ ፓኔል', '', 'c', 'nullConstructor', 'org.sola.clients.swing.desktop.cadastre.MapPanelForm', 'cliprgs004', 'map');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('applicationSearch', 'Application Search Panel::::::::::::::::ማመልከቻ መፈለጊያ ፓኔል', '', 'c', 'nullConstructor', 'org.sola.clients.swing.desktop.application.ApplicationSearchPanel', 'cliprgs003', 'appsearch');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('publicDisplayMap', 'Public Display Map Panel::::::::::::::::ለሕዝብ የሚታይ ካርታ ፓኔል', '', 'c', 'generalServices', 'org.sola.clients.swing.desktop.cadastre.MapPublicDisplayPanel', 'cliprgs110', 'MAP_PUBLIC_DISPLAY_PANEL');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('documentTrans', 'Document Transaction Panel::::::::::::::::የግብይት ፓኔል ሰነድ', '', 'c', 'documentServices', 'org.sola.clients.swing.desktop.source.TransactionedDocumentsPanel', 'cliprgs016', 'transactionedDocumentPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('documentSearch', 'Document Search Panel::::::::::::::::ሰነድ መፈለጊያ ፓኔል', '', 'c', 'nullConstructor', 'org.sola.clients.swing.desktop.source.DocumentSearchForm', 'cliprgs007', 'documentsearch');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('cadastreTransMap', 'Cadastre Transaction Map Panel::::::::::::::::የካዳስተር ግብይት ካርታ ፓኔል', '', 'c', 'cadastreServices', 'org.sola.clients.swing.desktop.cadastre.CadastreTransactionMapPanel', 'cliprgs017', 'cadastreChange');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('property', 'Property Panel::::::::::::::::የንብረት ፓኔል', '', 'c', 'propertyServices', 'org.sola.clients.swing.desktop.administrative.PropertyPanel', 'cliprgs009', 'propertyPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('newProperty', 'New Property Panel::::::::::::::::አዲስ የንብረት ፓኔል', '', 'c', 'newPropServices', 'org.sola.clients.swing.desktop.administrative.PropertyPanel', 'cliprgs009', 'propertyPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('propertySearch', 'Property Search Panel::::::::::::::::የንብረት ፍለጋ ፓኔል', '', 'c', 'nullConstructor', 'org.sola.clients.swing.desktop.administrative.BaUnitSearchPanel', 'cliprgs006', 'baunitsearch');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('simpleRight', 'Simple Right Panel::::::::::::::::ቀላል የመብት ፓኔል', '', 'c', 'generalRRR', 'org.sola.clients.swing.desktop.administrative.SimpleRightPanel', NULL, 'simpleRightPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('simpleRightholder', 'Simple Rightholder Panel::::::::::::::::ቀላል የባለመብት ፓኔል', '', 'c', 'generalRRR', 'org.sola.clients.swing.desktop.administrative.SimpleRightholderPanel', NULL, 'simpleOwnershipPanel');
INSERT INTO config_panel_launcher (code, display_value, description, status, launch_group, panel_class, message_code, card_name) VALUES ('mortgage', 'Mortgage Panel::::::::::::::::የዋስትና ፓኔል', '', 'c', 'generalRRR', 'org.sola.clients.swing.desktop.administrative.MortgagePanel', NULL, 'mortgagePanel');


ALTER TABLE config_panel_launcher ENABLE TRIGGER ALL;

--
-- Data for Name: consolidation_config; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE consolidation_config DISABLE TRIGGER ALL;

INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.application', 'application', 'application', 'Applications that have a service of type  “recordTransfer” and that has the status ''Lodged'', or ''Requisitioned''.', 'id in (select application_id from application.service where request_type_code=''recordTransfer''  and status_code in (''lodged'', ''requisitioned''))', false, 1);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.service', 'application', 'service', 'Every service that belongs to the application being selected for transfer.', 'application_id in (select id from consolidation.application)', false, 2);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('transaction.transaction', 'transaction', 'transaction', 'Every record that references a record in consolidation.service.', 'from_service_id in (select id from consolidation.service)', false, 3);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('transaction.transaction_source', 'transaction', 'transaction_source', 'Every record that references a record in consolidation.transaction.', 'transaction_id in (select id from consolidation.transaction)', false, 4);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.cadastre_object_target', 'cadastre', 'cadastre_object_target', 'Every record that references a record in consolidation.transaction.', 'transaction_id in (select id from consolidation.transaction)', false, 5);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.cadastre_object_node_target', 'cadastre', 'cadastre_object_node_target', 'Every record that references a record in consolidation.transaction.', 'transaction_id in (select id from consolidation.transaction)', false, 6);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.application_uses_source', 'application', 'application_uses_source', 'Every record that belongs to the application being selected for transfer.', 'application_id in (select id from consolidation.application)', false, 7);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.application_property', 'application', 'application_property', 'Every record that belongs to the application being selected for transfer.', 'application_id in (select id from consolidation.application)', false, 8);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.application_spatial_unit', 'application', 'application_spatial_unit', 'Every record that belongs to the application being selected for transfer.', 'application_id in (select id from consolidation.application)', false, 9);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_unit', 'cadastre', 'spatial_unit', 'Every record that is referenced from application_spatial_unit in consolidation schema.', 'id in (select spatial_unit_id from consolidation.application_spatial_unit)', false, 10);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_unit_in_group', 'cadastre', 'spatial_unit_in_group', 'Every record that references a record in consolidation.spatial_unit', 'spatial_unit_id in (select id from consolidation.spatial_unit)', false, 11);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.cadastre_object', 'cadastre', 'cadastre_object', 'Every record that is also in consolidation.spatial_unit', 'id in (select id from consolidation.spatial_unit)', false, 12);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_unit_address', 'cadastre', 'spatial_unit_address', 'Every record that references a record in consolidation.spatial_unit.', 'spatial_unit_id in (select id from consolidation.spatial_unit)', false, 13);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_value_area', 'cadastre', 'spatial_value_area', 'Every record that references a record in consolidation.spatial_unit.', 'spatial_unit_id in (select id from consolidation.spatial_unit)', false, 14);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.survey_point', 'cadastre', 'survey_point', 'Every record that references a record in consolidation.transaction.', 'transaction_id in (select id from consolidation.transaction)', false, 15);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.legal_space_utility_network', 'cadastre', 'legal_space_utility_network', 'Every record that is also in consolidation.spatial_unit', 'id in (select id from consolidation.spatial_unit)', false, 16);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_unit_group', 'cadastre', 'spatial_unit_group', 'Every record', '', true, 17);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.ba_unit_contains_spatial_unit', 'administrative', 'ba_unit_contains_spatial_unit', 'Every record that references a record in consolidation.cadastre_object.', 'spatial_unit_id in (select id from consolidation.cadastre_object)', false, 18);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.ba_unit_target', 'administrative', 'ba_unit_target', 'Every record that references a record in consolidation.transaction.', 'transaction_id in (select id from consolidation.transaction)', false, 19);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.ba_unit', 'administrative', 'ba_unit', 'Every record that is referenced by consolidation.application_property or consolidation.ba_unit_contains_spatial_unit or consolidation.ba_unit_target.', 'id in (select ba_unit_id from consolidation.application_property) or id in (select ba_unit_id from consolidation.ba_unit_contains_spatial_unit) or id in (select ba_unit_id from consolidation.ba_unit_target)', false, 20);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.required_relationship_baunit', 'administrative', 'required_relationship_baunit', 'Every record that references a record in consolidation.ba_unit.', 'from_ba_unit_id in (select id from consolidation.ba_unit)', false, 21);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.ba_unit_area', 'administrative', 'ba_unit_area', 'Every record that references a record in consolidation.ba_unit.', 'ba_unit_id in (select id from consolidation.ba_unit)', false, 22);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.ba_unit_as_party', 'administrative', 'ba_unit_as_party', 'Every record that references a record in consolidation.ba_unit.', 'ba_unit_id in (select id from consolidation.ba_unit)', false, 23);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.source_describes_ba_unit', 'administrative', 'source_describes_ba_unit', 'Every record that references a record in consolidation.ba_unit.', 'ba_unit_id in (select id from consolidation.ba_unit)', false, 24);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.rrr', 'administrative', 'rrr', 'Every record that references a record in consolidation.ba_unit.', 'ba_unit_id in (select id from consolidation.ba_unit)', false, 25);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.rrr_share', 'administrative', 'rrr_share', 'Every record that references a record in consolidation.rrr.', 'rrr_id in (select id from consolidation.rrr)', false, 26);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.party_for_rrr', 'administrative', 'party_for_rrr', 'Every record that references a record in consolidation.rrr.', 'rrr_id in (select id from consolidation.rrr)', false, 27);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.condition_for_rrr', 'administrative', 'condition_for_rrr', 'Every record that references a record in consolidation.rrr.', 'rrr_id in (select id from consolidation.rrr)', false, 28);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.mortgage_isbased_in_rrr', 'administrative', 'mortgage_isbased_in_rrr', 'Every record that references a record in consolidation.rrr.', 'rrr_id in (select id from consolidation.rrr)', false, 29);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.source_describes_rrr', 'administrative', 'source_describes_rrr', 'Every record that references a record in consolidation.rrr.', 'rrr_id in (select id from consolidation.rrr)', false, 30);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.notation', 'administrative', 'notation', 'Every record that references a record in consolidation.ba_unit or consolidation.rrr or consolidation.transaction.', 'ba_unit_id in (select id from consolidation.ba_unit) or rrr_id in (select id from consolidation.rrr) or transaction_id in (select id from consolidation.transaction)', false, 31);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.source', 'source', 'source', 'Every source that is referenced from the consolidation.application_uses_source 
or consolidation.transaction_source
or source that references consolidation.transaction or source that is referenced from consolidation.source_describes_ba_unit or source that is referenced from consolidation.source_describes_rrr.', 'id in (select source_id from consolidation.application_uses_source)
or id in (select source_id from consolidation.transaction_source)
or transaction_id in (select id from consolidation.transaction)
or id in (select source_id from consolidation.source_describes_ba_unit)
or id in (select source_id from consolidation.source_describes_rrr)', true, 32);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.power_of_attorney', 'source', 'power_of_attorney', 'Every record that is also in consolidation.source.', 'id in (select id from consolidation.source)', true, 33);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.spatial_source', 'source', 'spatial_source', 'Every record that is also in consolidation.source.', 'id in (select id from consolidation.source)', true, 34);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.spatial_source_measurement', 'source', 'spatial_source_measurement', 'Every record that references a record in consolidation.spatial_source.', 'spatial_source_id in (select id from consolidation.spatial_source)', true, 35);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.archive', 'source', 'archive', 'Every record that is referenced from a record in consolidation.source.', 'id in (select archive_id from consolidation.source)', true, 36);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('document.document', 'document', 'document', 'Every record that is referenced by consolidation.source.', 'id in (select ext_archive_id from consolidation.source)', true, 37);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('party.party', 'party', 'party', 'Every record that is referenced by consolidation.application or consolidation.ba_unit_as_party or consolidation.party_for_rrr.', 'id in (select agent_id from consolidation.application) or id in (select contact_person_id from consolidation.application) or id in (select agent_id from consolidation.application) or id in (select party_id from consolidation.party_for_rrr) or id in (select party_id from consolidation.ba_unit_as_party)', true, 38);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('party.group_party', 'party', 'group_party', 'Every record that is also in consolidation.party.', 'id in (select id from consolidation.party)', true, 39);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('party.party_member', 'party', 'party_member', 'Every record that references a record in consolidation.party.', 'party_id in (select id from consolidation.party)', true, 40);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('party.party_role', 'party', 'party_role', 'Every record that references a record in consolidation.party.', 'party_id in (select id from consolidation.party)', true, 41);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('address.address', 'address', 'address', 'Every record that is referenced by consolidation.party or consolidation.spatial_unit_address.', 'id in (select address_id from consolidation.party) or id in (select address_id from consolidation.spatial_unit_address)', true, 42);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.source_historic', 'source', 'source_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.source)', true, 43);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.survey_point_historic', 'cadastre', 'survey_point_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.survey_point)', false, 44);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_value_area_historic', 'cadastre', 'spatial_value_area_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.spatial_value_area)', false, 45);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_unit_address_historic', 'cadastre', 'spatial_unit_address_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.spatial_unit_address)', false, 46);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.spatial_source_measurement_historic', 'source', 'spatial_source_measurement_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.spatial_source_measurement)', false, 47);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.spatial_source_historic', 'source', 'spatial_source_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.spatial_source)', true, 48);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.source_describes_rrr_historic', 'administrative', 'source_describes_rrr_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.source_describes_rrr)', false, 49);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.rrr_historic', 'administrative', 'rrr_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.rrr)', false, 50);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.required_relationship_baunit_historic', 'administrative', 'required_relationship_baunit_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.required_relationship_baunit)', false, 51);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.power_of_attorney_historic', 'source', 'power_of_attorney_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.power_of_attorney)', true, 52);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('party.party_role_historic', 'party', 'party_role_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.party_role)', true, 53);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('party.party_member_historic', 'party', 'party_member_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.party_member)', true, 54);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.party_for_rrr_historic', 'administrative', 'party_for_rrr_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.party_for_rrr)', false, 55);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.legal_space_utility_network_historic', 'cadastre', 'legal_space_utility_network_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.legal_space_utility_network)', false, 56);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('party.group_party_historic', 'party', 'group_party_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.group_party)', true, 57);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.condition_for_rrr_historic', 'administrative', 'condition_for_rrr_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.condition_for_rrr)', false, 58);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.cadastre_object_historic', 'cadastre', 'cadastre_object_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.cadastre_object)', false, 59);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.ba_unit_target_historic', 'administrative', 'ba_unit_target_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.ba_unit_target)', false, 60);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.ba_unit_contains_spatial_unit_historic', 'administrative', 'ba_unit_contains_spatial_unit_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.ba_unit_contains_spatial_unit)', false, 61);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.ba_unit_area_historic', 'administrative', 'ba_unit_area_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.ba_unit_area)', false, 62);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('source.archive_historic', 'source', 'archive_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.archive)', true, 63);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.application_property_historic', 'application', 'application_property_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.application_property)', false, 64);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.application_historic', 'application', 'application_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.application)', false, 65);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('transaction.transaction_source_historic', 'transaction', 'transaction_source_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.transaction_source)', false, 66);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('transaction.transaction_historic', 'transaction', 'transaction_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.transaction)', false, 67);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_unit_in_group_historic', 'cadastre', 'spatial_unit_in_group_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.spatial_unit_in_group)', false, 68);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_unit_group_historic', 'cadastre', 'spatial_unit_group_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.spatial_unit_group)', false, 69);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.spatial_unit_historic', 'cadastre', 'spatial_unit_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.spatial_unit)', false, 70);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.source_describes_ba_unit_historic', 'administrative', 'source_describes_ba_unit_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.source_describes_ba_unit)', false, 71);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.service_historic', 'application', 'service_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.service)', false, 72);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.rrr_share_historic', 'administrative', 'rrr_share_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.rrr_share)', false, 73);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('party.party_historic', 'party', 'party_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.party)', true, 74);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.notation_historic', 'administrative', 'notation_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.notation)', false, 75);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.mortgage_isbased_in_rrr_historic', 'administrative', 'mortgage_isbased_in_rrr_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.mortgage_isbased_in_rrr)', false, 76);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('document.document_historic', 'document', 'document_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.document)', true, 77);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.cadastre_object_target_historic', 'cadastre', 'cadastre_object_target_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.cadastre_object_target)', false, 78);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('cadastre.cadastre_object_node_target_historic', 'cadastre', 'cadastre_object_node_target_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.cadastre_object_node_target)', false, 79);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('administrative.ba_unit_historic', 'administrative', 'ba_unit_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.ba_unit)', false, 80);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.application_uses_source_historic', 'application', 'application_uses_source_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.application_uses_source)', false, 81);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('application.application_spatial_unit_historic', 'application', 'application_spatial_unit_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.application_spatial_unit)', false, 82);
INSERT INTO consolidation_config (id, schema_name, table_name, condition_description, condition_sql, remove_before_insert, order_of_execution) VALUES ('address.address_historic', 'address', 'address_historic', 'Every record that references a record in the main table in consolidation schema.', 'rowidentifier in (select rowidentifier from consolidation.address)', false, 83);


ALTER TABLE consolidation_config ENABLE TRIGGER ALL;

--
-- Data for Name: crs; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE crs DISABLE TRIGGER ALL;

INSERT INTO crs (srid, from_long, to_long, item_order) VALUES (2193, 0, 171805.08555444199, 1);


ALTER TABLE crs ENABLE TRIGGER ALL;

--
-- Data for Name: map_search_option; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE map_search_option DISABLE TRIGGER ALL;

INSERT INTO map_search_option (code, title, query_name, active, min_search_str_len, zoom_in_buffer, description) VALUES ('LOCALITY', 'Locality', 'map_search.locality', true, 3, 100.00, NULL);
INSERT INTO map_search_option (code, title, query_name, active, min_search_str_len, zoom_in_buffer, description) VALUES ('NUMBER', 'Parcel number', 'map_search.cadastre_object_by_number', true, 3, 50.00, NULL);
INSERT INTO map_search_option (code, title, query_name, active, min_search_str_len, zoom_in_buffer, description) VALUES ('BAUNIT', 'Property number', 'map_search.cadastre_object_by_baunit', true, 3, 50.00, NULL);
INSERT INTO map_search_option (code, title, query_name, active, min_search_str_len, zoom_in_buffer, description) VALUES ('OWNER_OF_BAUNIT', 'Property owner', 'map_search.cadastre_object_by_baunit_owner', true, 3, 50.00, NULL);


ALTER TABLE map_search_option ENABLE TRIGGER ALL;

--
-- Data for Name: query_field; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE query_field DISABLE TRIGGER ALL;

INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel_pending', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel_pending', 1, 'parcel_nr', 'Parcel number::::Numero Particella');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel_pending', 2, 'area_official_sqm', 'Official area (m2)::::Area ufficiale (m2)');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel_pending', 3, 'the_geom', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_place_name', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_place_name', 1, 'label', 'Name::::Nome');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_place_name', 2, 'the_geom', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_road', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_road', 1, 'label', 'Name::::Nome');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_road', 2, 'the_geom', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_application', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_application', 1, 'nr', 'Number::::Numero');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_application', 2, 'the_geom', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_survey_control', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_survey_control', 1, 'label', 'Label::::Etichetta');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_survey_control', 2, 'the_geom', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 1, 'parcel_nr', 'Parcel number::::Numero Particella');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 2, 'ba_units', 'Properties::::Proprieta');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 3, 'area_official_sqm', 'Official area (m2)::::Area ufficiale (m2)');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel_historic_current_ba', 4, 'the_geom', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel', 1, 'parcel_nr', 'Parcel');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel', 2, 'ba_units', 'Property');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel', 3, 'area_official_sqm', 'Area');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel', 4, 'locality', 'Locality');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_parcel', 5, 'the_geom', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_state_land', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_state_land', 1, 'label', 'Parcel');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_state_land', 2, 'property', 'Property');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_state_land', 3, 'area', 'Area');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_state_land', 4, 'locality', 'Locality');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_state_land', 5, 'sl_status', 'Status');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_state_land', 6, 'the_geom', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_pending_state_land', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_pending_state_land', 1, 'label', 'Parcel');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_pending_state_land', 2, 'property', 'Property');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_pending_state_land', 3, 'area', 'Area');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_pending_state_land', 4, 'locality', 'Locality');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_pending_state_land', 5, 'sl_status', 'Status');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_pending_state_land', 6, 'the_geom', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_disposed_state_land', 0, 'id', NULL);
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_disposed_state_land', 1, 'label', 'Parcel');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_disposed_state_land', 2, 'property', 'Property');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_disposed_state_land', 3, 'area', 'Area');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_disposed_state_land', 4, 'locality', 'Locality');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_disposed_state_land', 5, 'sl_status', 'Status');
INSERT INTO query_field (query_name, index_in_query, name, display_value) VALUES ('dynamic.informationtool.get_disposed_state_land', 6, 'the_geom', NULL);


ALTER TABLE query_field ENABLE TRIGGER ALL;

--
-- Data for Name: setting; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE setting DISABLE TRIGGER ALL;

INSERT INTO setting (name, vl, active, description) VALUES ('map-west', '1776400', true, 'The most west coordinate. It is used in the map control.');
INSERT INTO setting (name, vl, active, description) VALUES ('map-south', '5919888', true, 'The most south coordinate. It is used in the map control.');
INSERT INTO setting (name, vl, active, description) VALUES ('map-east', '1795771', true, 'The most east coordinate. It is used in the map control.');
INSERT INTO setting (name, vl, active, description) VALUES ('map-north', '5932259', true, 'The most north coordinate. It is used in the map control.');
INSERT INTO setting (name, vl, active, description) VALUES ('map-tolerance', '0.01', true, 'The tolerance that is used while snapping geometries to each other. If two points are within this distance are considered being in the same location.');
INSERT INTO setting (name, vl, active, description) VALUES ('map-shift-tolerance-rural', '20', true, 'The shift tolerance of boundary points used in cadastre change in rural areas.');
INSERT INTO setting (name, vl, active, description) VALUES ('map-shift-tolerance-urban', '5', true, 'The shift tolerance of boundary points used in cadastre change in urban areas.');
INSERT INTO setting (name, vl, active, description) VALUES ('public-notification-duration', '30', true, 'The notification duration for the public display.');
INSERT INTO setting (name, vl, active, description) VALUES ('system-id', '', true, 'A unique number that identifies the installed SOLA system. This unique number is used in the br that generate unique identifiers.');
INSERT INTO setting (name, vl, active, description) VALUES ('zip-pass', 'wownow3nnZv3r', true, 'A password that is used during the consolidation process. It is used only in server side.');
INSERT INTO setting (name, vl, active, description) VALUES ('max-file-size', '10000', true, 'Maximum file size in KB for uploading.');
INSERT INTO setting (name, vl, active, description) VALUES ('max-uploading-daily-limit', '100000', true, 'Maximum size of files uploaded daily.');
INSERT INTO setting (name, vl, active, description) VALUES ('moderation-days', '30', true, 'Duration of moderation time in days');
INSERT INTO setting (name, vl, active, description) VALUES ('email-enable-email-service', '0', true, 'Enables or disables email service. 1 - enable, 0 - disable');
INSERT INTO setting (name, vl, active, description) VALUES ('email-admin-address', '', true, 'Email address of server administrator. If empty, no notifications will be sent');
INSERT INTO setting (name, vl, active, description) VALUES ('email-admin-name', '', true, 'Name of server administrator');
INSERT INTO setting (name, vl, active, description) VALUES ('email-body-format', 'html', true, 'Message body format. text - for simple text format, html - for html format');
INSERT INTO setting (name, vl, active, description) VALUES ('email-send-interval1', '1', true, 'Time interval in minutes for the first attempt to send email message.');
INSERT INTO setting (name, vl, active, description) VALUES ('email-send-attempts1', '2', true, 'Number of attempts to send email with first interval');
INSERT INTO setting (name, vl, active, description) VALUES ('email-send-interval2', '120', true, 'Time interval in minutes for the second attempt to send email message.');
INSERT INTO setting (name, vl, active, description) VALUES ('email-send-attempts2', '2', true, 'Number of attempts to send email with second interval');
INSERT INTO setting (name, vl, active, description) VALUES ('email-send-interval3', '1440', true, 'Time interval in minutes for the third attempt to send email message.');
INSERT INTO setting (name, vl, active, description) VALUES ('email-send-attempts3', '1', true, 'Number of attempts to send email with third interval');
INSERT INTO setting (name, vl, active, description) VALUES ('email-msg-failed-send-subject', 'Delivery failure', true, 'Subject text for delivery failure of message');
INSERT INTO setting (name, vl, active, description) VALUES ('email-msg-failed-send-body', 'Message send to the user #{userName} has been failed to deliver after number of attempts with the following error: <br/>#{error}', true, 'Message text for delivery failure');
INSERT INTO setting (name, vl, active, description) VALUES ('account-activation-timeout', '70', true, 'Account activation timeout in hours. After this time, activation should expire.');
INSERT INTO setting (name, vl, active, description) VALUES ('email-service-interval', '10', true, 'Time interval in seconds for email service to check and process scheduled messages.');
INSERT INTO setting (name, vl, active, description) VALUES ('pword-expiry-days', '90', false, 'The number of days a users password remains valid');
INSERT INTO setting (name, vl, active, description) VALUES ('product-name', 'SOLA State Land', true, 'SOLA product name');
INSERT INTO setting (name, vl, active, description) VALUES ('product-code', 'ssl', true, 'SOLA product code. sr - SOLA Registry, ssr - SOLA Systematic Registration, ssl - SOLA State Land, scs - SOLA Community Server');
INSERT INTO setting (name, vl, active, description) VALUES ('email-mailer-jndi-name', 'mail/sola', true, 'Configured mailer service JNDI name');
INSERT INTO setting (name, vl, active, description) VALUES ('network-scan-folder', '', false, 'Scan folder path, used by digital archive service. This setting is disabled by default. It has to be specified only if specific folder path is required (e.g. network drive). By default, system will use user''s home folder + /sola/scan');


ALTER TABLE setting ENABLE TRIGGER ALL;

--
-- Data for Name: version; Type: TABLE DATA; Schema: system; Owner: postgres
--

ALTER TABLE version DISABLE TRIGGER ALL;

INSERT INTO version (version_num) VALUES ('1309a');
INSERT INTO version (version_num) VALUES ('1309b');
INSERT INTO version (version_num) VALUES ('1309c');
INSERT INTO version (version_num) VALUES ('1310a');
INSERT INTO version (version_num) VALUES ('1310b');
INSERT INTO version (version_num) VALUES ('1401a');
INSERT INTO version (version_num) VALUES ('1401b');
INSERT INTO version (version_num) VALUES ('1401c');
INSERT INTO version (version_num) VALUES ('1401d');
INSERT INTO version (version_num) VALUES ('1402a');
INSERT INTO version (version_num) VALUES ('1403a');
INSERT INTO version (version_num) VALUES ('1403b');
INSERT INTO version (version_num) VALUES ('1404a');
INSERT INTO version (version_num) VALUES ('1404b');
INSERT INTO version (version_num) VALUES ('1406a');
INSERT INTO version (version_num) VALUES ('1406b');
INSERT INTO version (version_num) VALUES ('1406x');
INSERT INTO version (version_num) VALUES ('1502a SL Release');
INSERT INTO version (version_num) VALUES ('sl1505a');


ALTER TABLE version ENABLE TRIGGER ALL;

--
-- PostgreSQL database dump complete
--

