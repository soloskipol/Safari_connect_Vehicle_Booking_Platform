-- Safari Connect Operations Analysis
-- PostgreSQL data loading, cleaning and validation

--Creating the table

CREATE TABLE IF NOT EXISTS operations_data(
	booking_id VARCHAR(20) PRIMARY KEY NOT NULL,
	passenger_name VARCHAR(50) NOT NULL,
	passenger_phone VARCHAR (20),
	passenger_gender VARCHAR(10)NOT NULL,
	passenger_city VARCHAR(20),
	route_code VARCHAR(20) NOT NULL,
	route_from VARCHAR(20) NOT NULL,
	route_to VARCHAR(20) NOT NULL,
	vehicle_plate VARCHAR(10) NOT NULL,
	vehicle_type VARCHAR(8),
	driver_name VARCHAR(50)NOT NULL,
	driver_rating NUMERIC(3,1),
	departure_date DATE NOT NULL,
	departure_time TIME NOT NULL,
	seat_class VARCHAR(15),
	seats_booked INTEGER NOT NULL,
	fare_per_seat NUMERIC(10,2) NOT NULL,
	total_fare NUMERIC(14,2),
	payment_method VARCHAR(15),
	booking_status VARCHAR(15),
	trip_rating INTEGER);


--CHECKING FOR DUPLICATES IN THE BOOKING_ID COLUMN
SELECT 
	booking_id,
	COUNT (*) AS appearance_count
FROM operations_data
GROUP BY booking_id
HAVING COUNT(*)>1;

--CLEANING PASSANGER_NAMES
UPDATE operations_data

SET passenger_name= INITCAP(TRIM(passenger_name));

--CLEANING PASSANGER PHONE NUMBERS 

 --Step 1: Expand scientific notation and rebuild the 10-digit number
UPDATE operations_data
SET passenger_phone = '0' || SUBSTRING(
    CAST(CAST(passenger_phone AS FLOAT) AS BIGINT)::text 
    FROM 4
)
WHERE passenger_phone LIKE '%E+%';

--Step 2: Clean any remaining normal '+254' prefixes
UPDATE operations_data 
SET passenger_phone = '0' || SUBSTRING(REGEXP_REPLACE(passenger_phone, '[^0-9]', '', 'g') FROM 4)
WHERE passenger_phone LIKE '+254%' OR passenger_phone LIKE '254%';

-- Step 3: Strip any random dashes or spaces from normal numbers
UPDATE operations_data 
SET passenger_phone = REGEXP_REPLACE(passenger_phone, '[^0-9]', '', 'g')
WHERE passenger_phone IS NOT NULL;

--To add a zero to numbers that lost zero prefix
UPDATE operations_data
SET passenger_phone = '0' || passenger_phone
WHERE LENGTH(passenger_phone) = 9;


--CLEANING THE PASSANGER GENDER COLUMN

UPDATE operations_data
SET passenger_gender= CASE 
	WHEN UPPER(TRIM(passenger_gender)) IN ('F','FEMALE') THEN 'Female'
	WHEN UPPER(TRIM(passenger_gender)) IN ('M','MALE') THEN 'Male'
	ELSE passenger_gender
	END

WHERE (passenger_gender) NOT IN ('Female', 'Male')
						
--CLEANING THE PASSENGER CITY COLUMN
UPDATE operations_data
SET passenger_city= INITCAP(TRIM(passenger_city))

WHERE passenger_city IS NOT NULL AND passenger_city!=INITCAP(TRIM(passenger_city))


--ROUTE FROM AND ROUTE TO was already standardized

--VEHICLE PLATE COLUMN WAS ALSO CLEAN

--CLEANING THE VEHICLE_TYPE COLUMN

UPDATE operations_data

SET vehicle_type= INITCAP(TRIM(vehicle_type))

WHERE vehicle_type IS NOT NULL AND vehicle_type !=INITCAP(TRIM(vehicle_type))


--CLEANING THE DRIVERS NAMES COLUMN
UPDATE operations_data

SET driver_name= INITCAP(TRIM(driver_name))

WHERE driver_name IS NOT NULL AND driver_name != INITCAP(TRIM(driver_name))

--CLEANING THE SEAT_CLASS COLUMN 

UPDATE operations_data

SET seat_class= CASE
	WHEN LOWER(TRIM(seat_class)) IN ('business', 'bus','business class') THEN 'Business Class'
	WHEN LOWER(TRIM(seat_class)) IN ('eco','economy','economy class')  THEN 'Economy Class'
	ELSE seat_class
	END

WHERE seat_class NOT IN ('Business Class','Economy Class')


--CLEANING THE SEATS_BOOKED COLUMN
--There was a negative value (-1) , the rows were deleted
DELETE FROM operations_data

WHERE seats_booked<0

--CLEANING THE PAYMENT_METHOD COLUMN
UPDATE operations_data

SET payment_method= CASE
	WHEN LOWER(TRIM(payment_method)) IN ('m-pesa','mpesa')  THEN 'M_Pesa'
	WHEN LOWER(TRIM(payment_method)) IN ('cash') THEN 'Cash'
	WHEN LOWER(TRIM(payment_method)) IN ('card') THEN 'Card'
	ELSE payment_method
	END


--CLEANING THE BOOKING-STATUS COLUMN 

UPDATE operations_data

SET booking_status= INITCAP(TRIM(booking_status))

WHERE booking_status!=INITCAP(TRIM(booking_status))

--CLEANING THE trips_rating COLUMN
--all ratings below 1, above 5 and all uncompleted trips rating were converted to nulls
UPDATE operations_data
SET trip_rating = NULL

WHERE LOWER(booking_status) IN ('cancelled', 'no show') 
   OR trip_rating < 1 
   OR trip_rating > 5

