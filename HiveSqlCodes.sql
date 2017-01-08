DROP TABLE IF EXISTS temp_drivers;

CREATE TABLE temp_drivers (col_value STRING);

SELECT * FROM temp_drivers;

LOAD DATA INPATH '/user/nitin/drivers.csv' OVERWRITE
INTO TABLE temp_drivers;

-- This command will remove the file from above mentioned location into Hive Datawarehouse
DROP TABLE IF EXISTS drivers;

CREATE TABLE drivers (
	driverId INT
	,NAME STRING
	,ssn BIGINT
	,location STRING
	,certified STRING
	,wageplan STRING
);

INSERT overwrite TABLE drivers
SELECT regexp_extract(col_value, '^(?:([^,]*),?){1}', 1) driverId
	,regexp_extract(col_value, '^(?:([^,]*),?){2}', 1) NAME
	,regexp_extract(col_value, '^(?:([^,]*),?){3}', 1) ssn
	,regexp_extract(col_value, '^(?:([^,]*),?){4}', 1) location
	,regexp_extract(col_value, '^(?:([^,]*),?){5}', 1) certified
	,regexp_extract(col_value, '^(?:([^,]*),?){6}', 1) wageplan
FROM temp_drivers;

SELECT *
FROM drivers;

DROP TABLE IF EXISTS temp_timesheet;

CREATE TABLE temp_timesheet (col_value string);

LOAD DATA INPATH '/user/nitin/timesheet.csv' OVERWRITE INTO TABLE temp_timesheet;

CREATE TABLE timesheet (
	driverId INT
	,week INT
	,hours_logged INT
	,miles_logged INT
	);

INSERT overwrite TABLE timesheet
SELECT regexp_extract(col_value, '^(?:([^,]*),?){1}', 1) driverId
	,regexp_extract(col_value, '^(?:([^,]*),?){2}', 1) week
	,regexp_extract(col_value, '^(?:([^,]*),?){3}', 1) hours_logged
	,regexp_extract(col_value, '^(?:([^,]*),?){4}', 1) miles_logged
FROM temp_timesheet;

SELECT *
FROM timesheet LIMIT 100;

SELECT driverId
	,sum(hours_logged)
	,sum(miles_logged)
FROM timesheet
GROUP BY driverId;

SELECT d.driverId
	,d.NAME
	,t.total_hours
	,t.total_miles
FROM drivers d
JOIN (
	SELECT driverId
		,sum(hours_logged) total_hours
		,sum(miles_logged) total_miles
	FROM timesheet
	GROUP BY driverId
	) t ON (d.driverId = t.driverId)
WHERE d.driverId IS NOT NULL;