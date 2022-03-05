use master
go


if (DB_ID('OnlineTicketReservation') is not null)
drop database OnlineTicketReservation
go


create database OnlineTicketReservation
go



use OnlineTicketReservation
go


create table PASSENGER
(
	P_Id varchar(10) constraint PASSENGER_PK primary key,  --celsi primar
	P_Name varchar(20) not null,
	P_LastName varchar(20),
	P_Status varchar(20) not null,
	P_Age int,
	B_Id varchar(10) not null
)
go

create table TICKET
(
	T_Id varchar(10) constraint TICKET_PK primary key,  --celsi primar
	T_Type varchar(30),
	T_Price numeric(10,2) not null,
	T_Time datetime,
	T_NoOfSeat integer not null,
	R_Id varchar(10) not null,
	C_Id varchar(10) not null
)
Go

create table PAYMENT
(
	Pa_Card_NO varchar(40) constraint PAYMENT_PK primary key,  --celsi primar
	Pa_Sum numeric (10,2),
	Pa_CardType varchar(20) not null,
	Pa_CardHolderName varchar(20) not null,
	Pa_Expiry_Date date not null,
	Date_of_Payment date,
	P_Id varchar(10) not null constraint pid_unique unique ,
	T_Id varchar(10)not null constraint tid_unique unique,
	constraint PASSENGER_to_PAYMENT foreign key(P_Id) references PASSENGER,
	constraint TICKET_to_PAYMENT foreign key(T_Id) references TICKET
)
go


create table BUS
(
	B_Id varchar(10) constraint BUS_PK primary key, --celsi primar
	B_Name varchar(20) not null,
	B_NoOfSeats integer not null,
	B_Avaliability integer not null,
	B_Type varchar(30) not null,
	D_Id varchar(10) not null,
	C_Id varchar(10) not null
)
go


create table ROUTE
(
	R_Id varchar(10) constraint ROUTE_PK primary key, --celsi primar
	R_From varchar(30) not null,
	R_To varchar(30) not null
)
go


create table EMPLOYEE
(
	E_Id varchar(10) constraint EMPLOYEE_PK primary key, --celsi primar
	E_Name varchar(20) not null,
	E_LastName varchar(20)
)
go


create table DRIVER
(	
	D_Id varchar(10) constraint DRIVER_PK primary key, --celsi primar
	D_Age int
	constraint DRIVER_to_EMPLOYEE foreign key(D_Id) references EMPLOYEE --celsi i huaj
)
go

create table CONDUCTOR
(	
	C_Id varchar(10) constraint CONDUCTOR_PK primary key, --celsi primar
	C_Address varchar(30)
	constraint CONDUCTOR_to_EMPLOYEE foreign key(C_Id) references EMPLOYEE --celsi i huaj
)
Go



create table FUNCTIONS
(
	R_Id varchar(10) not null,
	B_Id varchar(10) not null,
	constraint FUNCTIONS_to_BUS foreign key(B_Id) references BUS,
	constraint FUNCTIONS_to_ROUTE foreign key(R_Id) references ROUTE
)
go

alter table PASSENGER add
constraint PASSENGER_to_BUS foreign key(P_Id) references BUS
go

alter table TICKET add
constraint TICKET_to_CONDUCTOR foreign key(T_Id) references CONDUCTOR
go

alter table TICKET add
constraint TICKET_to_ROUTE foreign key(R_Id) references ROUTE
go

alter table BUS add
constraint BUS_to_CONDUCTOR foreign key(C_Id) references CONDUCTOR
go

alter table BUS add
constraint BUS_to_DRIVER foreign key(D_Id) references DRIVER
go
