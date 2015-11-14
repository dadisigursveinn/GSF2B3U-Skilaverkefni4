/*
@name: CreateArircraft
@role: Adds new aircraft to the fleet.
@parameters: 	aircraft_id char(6)
				aircraft_type varchar(35)
				max_number_of_passangers smallint(6)
                entered_service date
                aircraft_name varchar(55)
@created: 29.10.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Adds new aircraft to the fleet.
*/

delimiter $$
drop procedure if exists CreateAircraft$$
create procedure CreateAircraft(aircraft_id char(6), aircraft_type varchar(35), max_number_of_passangers smallint(6), entered_service date, aircraft_name varchar(55))
begin
	insert into aircrafts (aircraftID, aircraftType, maxNumberOfPassangers, enteredService, aircraftName) values(aircraft_id, aircraft_type, max_number_of_passangers, entered_service, aircraft_name);
end$$
delimiter ;


/*
@name: ReadArircraft
@role: Reads specific aircraft form the fleet
@parameters: aircraft_id char(6)
@created: 29.10.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Reads aircraft from the fleet using aircraft_id.
*/
delimiter $$
drop procedure if exists ReadAircraft$$
create procedure ReadAircraft(aircraft_id char(6))
begin
	select * from aircrafts where aircraftID = aircraft_id;
end$$
delimiter ;


/*
@name: UpdateAircraft
@role: Updates specific aircraft form the fleet
@parameters: 	aircraft_id char(6)
				aircraft_type varchar(35)
				max_number_of_passangers smallint(6)
                entered_service date
                aircraft_name varchar(55)
@created: 29.10.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Updates aircraft from the fleet.
*/
delimiter $$
drop procedure if exists UpdateAircarft$$
create procedure UpdateAircarft(aircraft_id char(6), aircraft_type varchar(35), max_number_of_passangers smallint(6), entered_service date, aircraft_name varchar(55))
begin
	UPDATE aircrafts 
SET 
	aircraftID = aircraft_id,
    aircraftType = aircraft_type,
    maxNumberOfPassangers = max_number_of_passangers,
    enteredService = entered_service,
	AircraftName = aircraft_name
WHERE aircraftID = aircraft_id;
end$$
delimiter ;


/*
@name: DeleteAircraft
@role: Deletes specific aircraft form the fleet
@parameters: aircraft_id char(6)
@created: 29.10.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Deletes aircraft from the fleet.
*/
delimiter $$
drop procedure if exists DeleteAircraft$$
create procedure DeleteAircraft(aircraft_id char(6))
begin
	delete from aircrafts
	WHERE aircraftID = aircraft_id;
end$$
delimiter ;


-- CRUD test cases for aircrafts
call CreateAircraft('TF-API','Cessna 152', '1','2015-10-29', null);
call ReadAircraft('TF-API');
call UpdateAircarft('TF-API', 'Cessna 152', 2, '2015-10-29','Kennsluflugvél');
call DeleteAircraft('TF-API');
select * from aircrafts;


/*
@name: CreatePriceCategory
@role: Creates new price category 
@parameters: category_name varchar(35)
				valid_from date
                valid_to date
                minimum_price int(11)
                _refundable tinyint(1)
                seat_number_restrictions int(11)
                class_id int(11)
@created: 29.10.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Creates new price category
*/
delimiter $$
drop procedure if exists CreatePriceCategory$$
create procedure CreatePriceCategory(category_name varchar(35), valid_from date, valid_to date, minimum_price int(11), _refundable tinyint(1), seat_number_restrictions int(11),class_id int(11))
begin
	insert into Pricecategories(categoryName,validFrom,validTo,minimumPrice,refundable,seatNumberRestrictions,classID)
	values(category_name, valid_from, valid_to, minimum_price ,_refundable, seat_number_restrictions, class_id);
end$$
delimiter ;


/*
@name: ReadPriceCategory
@role: reads specific price category 
@parameters: category_id int(11)
@created: 29.10.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Reads specific pricecategory
*/
delimiter $$
drop procedure if exists ReadPriceCategory$$
create procedure ReadPriceCategory(category_id int(11))
begin
	select * from pricecategories where categoryID = category_id;
end$$
delimiter ;


/*
@name: UpdatePriceCategory
@role: Updates specific price category 
@parameters: category_id int(11)
				category_name varchar(35)
				valid_from date
                valid_to date
                minimum_price int(11)
                _refundable tinyint(1)
                seat_number_restrictions int(11)
                class_id int(11)
@created: 29.10.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: updates specific pricecategory
*/
delimiter $$
drop procedure if exists UpdatePriceCategory$$
create procedure UpdatePriceCategory(category_id int(11),category_name varchar(35),valid_from date,valid_to date,minimum_price int(11),_refundable tinyint(1),seat_number_restrictions int(11),class_id int(11))
begin
	UPDATE pricecategories 
SET 
	categoryID = category_id,
    categoryName = category_name,
    validFrom = valid_from,
    validTo = valid_to,
    minimumPrice = minimum_price,
    refundable = _refundable,
    seatNumberRestrictions = seat_number_restrictions,
    classID = class_id 
WHERE categoryID = category_id;
end$$
delimiter ;

/*
@name: DeletePriceCategory
@role: Deletes specific price category 
@parameters: category_id int(11)
@created: 05.11.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Deletes specific pricecategory
*/
delimiter $$
drop procedure if exists DeletePriceCategory$$
create procedure DeletePriceCategory(category_id int(11))
begin
	delete from pricecategories
	WHERE categoryID = category_id;
end$$
delimiter ;

select* from priceCategories;
-- CRUD test cases for Pricecategories
call CreatePriceCategory('TestName', '2015-10-29', '2015-11-29', 44000, 0, 35, 3);
call ReadPriceCategory(9);
call UpdatePriceCategory(9,'TestName123', '2015-10-29', '2015-11-29', 44000, 0, 35, 3);
call DeletePriceCategory(9);

/*
@name: DisplayNumberOfPassengers
@role: Display the number of passengers in a specific flight

@parameters: flightNum char(5), dateFlight date

@created: 05.11.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Displays number of passengers
*/
delimiter $$
drop function if exists ReservedSeats $$

create function ReservedSeats(flightNum char(5), dateFlight date)
returns int
begin
    declare reserved int;
    declare IDplane char(6);
    declare codeFlight int(11);
    
    select flightCode into codeFlight from flights where flights.flightNumber = flightNum and flightDate = dateFlight;
    select aircraftID into IDplane from flights where flights.flightNumber = flightNum and flightDate = dateFlight;
    
    
    select count(*) into reserved
    from bookings 
    where flightCode = codeFlight;
    
    return reserved;
end $$
delimiter ;

SELECT ReservedSeats('FA502', '2014-05-01');

/*
@name: Flights with one or more passanger
@role: Display flights where there are one or more passangers

@created: 05.11.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Displays flights where there are one or more passangers
*/
delimiter $$
drop procedure if exists MoreThanOnePassanger $$

create procedure MoreThanOnePassanger() 
begin
    
	select * from bookings group by flightcode;

end $$
delimiter ;

call MoreThanOnePassanger();


/*
@name: PassengerBooker
@role: book passangers
@parameters: execution_code, passenger_info, booking_number
@created: unknown
@author: Sigruður R. Ragnarsson
@todo: Nothing known
@description: book passangers
*/
delimiter $$
drop procedure if exists PassengerBooker $$

create procedure PassengerBooker(execution_code char(10),passenger_info text,booking_number int)
begin
	declare passengerID varchar(35);
	declare passengerName varchar(55);
	declare priceID int;
	declare seatID int;
	declare strLength int;

	set strLength = char_length(passenger_info);
	
	if(execution_code = 'Z%m04/&14X') then
		while (strLength > 0) do
			set passengerID = substring_index(passenger_info,';',1);	
			set passenger_info = substring(passenger_info,locate(';',passenger_info) + 1);
	 
			set passengerName = substring_index(passenger_info,';',1);	
			set passenger_info = substring(passenger_info,locate(';',passenger_info) + 1);

			set priceID = cast(substring_index(passenger_info,';',1) as unsigned);
			set passenger_info = substring(passenger_info,locate(';',passenger_info) + 1);

			set seatID = cast(substring_index(passenger_info,';',1) as unsigned);
			set passenger_info = substring(passenger_info,locate(';',passenger_info) + 1);
			
			insert into Passengers(personID,personName,priceID,seatID,bookingNumber) 
			values(passengerID,passengerName,priceID,seatID,booking_number);

			set strLength = char_length(passenger_info); 
		end while;
	end if;
end $$
delimiter ;


/*
@name: FlightBooker
@role: book flights
@parameters: 
@created: unknown
@author: Sigruður R. Ragnarsson
@todo: Nothing known
@description: book flights
*/
delimiter $$
drop procedure if exists FlightBooker $$

create procedure FlightBooker
(
	fligt_number char(5),
	flight_date date,
	class_id int,
	cardholders_name varchar(55),
	card_issuer varchar(35),
	passenger_info text	-- format: 	passengerID;passengerName;priceID;seatID
)
begin
	declare flight_code int;
	
	set flight_code = FlightCode(fligt_number,flight_date);
	
	start transaction;
	
	insert into Bookings(timeOfbooking,paymentType,cardIssuedBy,cardholdersName,flightCode,classID)
	values(now(),1,card_issuer,cardholders_name,flight_code,class_id);
	
	call PassengerBooker('Z%m04/&14X',passenger_info,last_insert_id());
	
	commit;
end $$
delimiter ;
call FlightBooker('FA501','2014-05-01',2,'Margrét Benediktsdóttir','VISA','IS934671;Margrét Benediktsdóttir;4;3273;IS916472;Sigurður Egilsson;4;3274;IS295715;Guðmundur Sigurðsson;4;3283;IS883461;Þuríður Sigurðardóttir;4;3284;');

select * from aircrafts

-- Lists --

/*
@name: ListOfAircrafts
@role: List of aircrafts

@created: 05.11.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Displays list of aircrafts
*/
delimiter $$
drop procedure if exists ListOfAircrafts $$

create procedure ListOfAircrafts() 
begin
    
	select * from aircrafts;

end $$
delimiter ;

call ListOfAircrafts();

/*
@name: ListOfAirports
@role: List of Airports

@created: 05.11.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Displays list of airports
*/
delimiter $$
drop procedure if exists ListOfAirports $$

create procedure ListOfAirports() 
begin
    
	select airports.IATAcode, airports.airportName, cities.cityName  from airports
	inner join cities
	on airports.cityID = cities.cityID;

end $$
delimiter ;

call ListOfAirports();

/*
@name: ListOfPriceCategories
@role: List of PriceCategories

@created: 05.11.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Displays list of PriceCategories
*/
delimiter $$
drop procedure if exists ListOfPriceCategories $$

create procedure ListOfPriceCategories() 
begin
    
	select pricecategories.categoryName, pricecategories.validFrom, pricecategories.validTo, pricecategories.minimumPrice, pricecategories.refundable, pricecategories.seatNumberRestrictions, classes.className from pricecategories
    inner join classes
    on pricecategories.classID = classes.classID;

end $$
delimiter ;

call ListOfPriceCategories();

/*
@name: ListOfDestinations
@role: List of destinations

@created: 05.11.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Displays list of destinations
*/
delimiter $$
drop procedure if exists ListOfDestinations $$

create procedure ListOfDestinations() 
begin
    
	select cities.cityName, countries.countryName from cities
    inner join countries
    on cities.countryCode = countries.alpha336612;
    

end $$
delimiter ;

call ListOfDestinations();

/*
@name: ListOfFlightSchedules
@role: List of FlightSchedules

@created: 05.11.2015
@author: Daði Sigursveinn Harðarson.
@todo: Nothing known.
@des: Displays list of FlightSchedules
*/
delimiter $$
drop procedure if exists ListOfFlightSchedules $$

create procedure ListOfFlightSchedules() 
begin
    
	select * from flightschedules;
    

end $$
delimiter ;

call ListOfFlightSchedules();

