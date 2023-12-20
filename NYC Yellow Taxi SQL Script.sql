create database nycyellowline_db;

use nycyellowline_db;

select* from fact_table;

-- Average fare amount by VendorID
select VendorID, round(avg(fare_amount),2)
from fact_table
group by VendorID;

-- Total Fare collected by each vendor
select VendorID, round(sum(fare_amount))
from fact_table
group by VendorID;

-- The average tip by type of payment
select b. payment_type, b.payment_type_name, avg(a.tip_amount) 
from fact_table a 
join payment_type b on a.payment_type_id = b.payment_type_id
group by b.payment_type_name;


-- Total number of tips by passenger count
select SUM(a.passenger_count), sum(b.tip_amount)
from passenger_count a join fact_table b
on a.passenger_count_id = b.passenger_count_id;


-- Average fair amount by hour of the day
select distinct(a.pickup_hour), avg(b.fare_amount)
from datetime a join fact_table b
on a.datetime_id = b.datetime_id 
group by a.pickup_hour;


select f.VendorID, d.tpep_pickup_datetime, d.tpep_dropoff_datetime,
	   pl.pickup_latitude, pl.pickup_longitude, dl.dropoff_latitude, 
	   dl.dropoff_longitude, pc.passenger_count, td.trip_distance, 
	   rc.rate_code_name, pt.payment_type_name, f.fare_amount, f.extra, 
	   f.mta_tax, f.tip_amount, f.tolls_amount, f.improvement_surcharge,
	   f.total_amount 
from fact_table f 
join datetime d on f.datetime_id = d.datetime_id
join dropoff_location dl on  f.dropoff_location_id = dl.dropoff_location_id 
join passenger_count pc on f.passenger_count_id = pc.passenger_count_id 
join payment_type pt on f.payment_type_id = pt.payment_type_id 
join pickup_location pl on f.pickup_location_id = pl.pickup_location_id 
join rate_code rc on f.rate_code_id = rc.rate_code_id 
join trip_distance td on f.trip_distance_id = td.trip_distance_id; 
