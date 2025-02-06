create database flight_reservation_system;
use flight_reservation_system;




create table flight(
Flightid int,
Flight_number varchar(50),
Departure datetime,
Arrival datetime,
OriginAirportCode varchar(5),
DestinationAirportCode varchar(55),
AvailableSeats int
);

insert into flight values(001,"103","2024-06-16 11:30:00","2024-06-15 12:30:00","BOM","GOA",10);
insert into flight values(002,"223","2024-06-17 13:30:00","2024-06-17 14:30:00","HYD","BOM",15);
insert into flight values(003,"143","2024-06-18 15:30:00","2024-06-18 16:30:00","BLR","GOA",22);
insert into flight values(004,"163","2024-06-19 18:30:00","2024-06-19 20:30:00","PNQ","DLH",18);
insert into flight values(005,"173","2024-06-20 21:30:00","2024-06-20 23:30:00","DLH","BOM",21);

select * from flight;



create table Passenger(
Passngerid int,
first_name varchar(50),
last_name varchar(50),
email varchar(50),
passcode_number varchar(50)
);

insert into Passenger values(121,"mahesh","ghorpade","mg23@gmail.com","2376");
insert into Passenger values(122,"sandip","ghatge","sg23@gmail.com","2356");
insert into Passenger values(123,"ganesh","kale","gk@gmail.com","2276");
insert into Passenger values(124,"shruti","bhati","sb23@gmail.com","2176");
insert into Passenger values(125,"aman","dadiala","ad@gmail.com","2375");

select * from Passenger;

select * from Passenger;

create table Airport(
AirportCode varchar(3),
AirportName varchar(100),
Location varchar(255),
Facilities varchar(255)
);
select * from Airport;

insert into Airport values("ABJ","CHTRAPATI SHIVAJI MAHARAJ INT","NEAR SANTACRUZ","Includes runways, taxiways, aprons, aircraft fueling, maintenance, and air traffic control"); 
insert into Airport values("IDG","INDIRA GANDHI INT","OLD DELHI","Includes runways, taxiways, aircraft fueling, maintenance, and air traffic control"); 
insert into Airport values("GOA","VASCO INT ","SOUTH GOA","Includes runways, taxiways, aircraft fueling, SHOPPING, maintenance, and air traffic control"); 
insert into Airport values("ARB","SAMBHAJI NAAGR INT ","MG ROAD","Includes runways, taxiways, aircraft fueling, air traffic control"); 
insert into Airport values("AMD","NARENDRA MODI INT","CENTRAL ROAD","Includes runways,  aircraft fueling, maintenance, and air traffic control"); 




create table Airline(
AirlineID int,
AirlineName varchar(100),
ContactNumber varchar(20),
OperatingRegion varchar(100)
);
insert into Airline values(123,"star air","1823558","maharashtra");
insert into Airline values(122,"vistara","1834558","delhi");
insert into Airline values(125,"jetway","167558","goa");
insert into Airline values(127,"spice","183458","karnataka");
insert into Airline values(126,"emrates","177558","dubai");

select * from Airline;
create table Booking(
BookingID INT,
FlightID INT,
PassengerID INT,
PaymentStatus VARCHAR(20)
);

insert into Booking value(123,23413,123,"yes");
insert into Booking value(133,234343,113,"yes");
insert into Booking value(153,23413453,173,"yes");
insert into Booking value(143,23413345,153,"yes");
insert into Booking value(183,2341378,127,"yes");

create table payments(
PaymentID INT,
BookingID INT UNIQUE,
PaymentMethod VARCHAR(50),
Amount DECIMAL(10, 2),
TransactionDateTime DATETIME
);

insert into payments value(12124,124124,"card","23423.00","2024-06-16 11:30:00");
insert into payments value(12134,113124,"card","23413.00","2024-06-17 11:30:00");
insert into payments value(12127,122324,"card","23422.00","2024-06-18 11:30:00");
insert into payments value(12128,1245674,"card","23413.00","2024-06-19 11:30:00");
insert into payments value(12129,1241574,"card","23433.00","2024-06-20 11:30:00");

select * from payments;

-- practice queries 

set sql_safe_updates=0;

update payments
set Amount = "23333.00"
where Amount = "23423.00";

select Amount
from payments
where PaymentMethod = "card";

select AirlineName 
from Airline
where operatingRegion <> "karnataka";

select bookingid
from payments
where Amount > 23333.00;

select bookingid 
from payments 
where amount < 23422;

select * from payments;

select paymentid
from payments
where amount >= 23422;

select paymentid
from payments
where amount <= 23413;

select paymentid
from payments
where amount like ("%3.00");

select bookingid
from payments
where amount like ("__%3____");

select * from payments;

select min(amount) as smallestprice from payments;
select max(amount) as biggestamount from payments;
select amount
from payments 
where paymentmethod = "card" limit 3;

select bookingid 
from payments
where not amount = "23333.00";  -- not query


select paymentid
from payments
where bookingid = "124124" and paymentmethod = "card";

select paymentid 
from payments
where Amount = 23422.00 or Bookingid = 124124;


select paymentid
from payments
where amount in ("23413.00","23422.00");

select paymentid
from payments
where paymentmethod in ("card");

select paymentid
from payments 
where bookingid in ("124124","1241574");
