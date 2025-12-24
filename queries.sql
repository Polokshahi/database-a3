create table users(
  user_id serial primary key,
  name varchar(150) not null,
  email varchar(100) unique not null,
  phone varchar(25),
  role varchar(20) not null
  check (role in ('Customer', 'Admin'))
);



create table vehicles (
  vehicle_id serial primary key,
  name varchar(150) not null,
  type varchar(50) not null,
  model int not null,
  registration_number varchar(50) unique not null,
  rental_price int not null,
  status varchar(20) not null
    check (status in ('available', 'rented', 'maintenance'))
);


create table bookings (
  booking_id serial primary key,
  user_id int not null,
  vehicle_id int not null,
  start_date date not null,
  end_date date not null,
  status varchar(20) not null
    check (status in ('pending', 'confirmed', 'completed')),
  total_cost int not null,

  foreign key (user_id) references users(user_id),
  foreign key (vehicle_id) references vehicles(vehicle_id)
);




insert into users (user_id, name, email, phone, role) values
(1, 'Alice', 'alice@example.com', '1234567890', 'Customer'),
(2, 'Bob', 'bob@example.com', '0987654321', 'Admin'),
(3, 'Charlie', 'charlie@example.com', '1122334455', 'Customer');


insert into vehicles (vehicle_id, name, type, model, registration_number, rental_price, status) values
(1, 'Toyota Corolla', 'car', 2022, 'ABC-123', 50, 'available'),
(2, 'Honda Civic', 'car', 2021, 'DEF-456', 60, 'rented'),
(3, 'Yamaha R15', 'bike', 2023, 'GHI-789', 30, 'available'),
(4, 'Ford F-150', 'truck', 2020, 'JKL-012', 100, 'maintenance');



insert into bookings (booking_id, user_id, vehicle_id, start_date, end_date, status, total_cost) values
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', 100);




select
    b.booking_id,
    u.name as customer_name,
    v.name as vehicle_name,
    b.start_date,
    b.end_date,
    b.status
from bookings b
inner join users u
    ON b.user_id = u.user_id
inner join vehicles v
    on b.vehicle_id = v.vehicle_id
order by b.booking_id;



select *
from vehicles v
where not exists (
    select 1
    from bookings b
    where b.vehicle_id = v.vehicle_id
);


select *
from vehicles
where status = 'available'
  and type = 'car';



select
    v.name as vehicle_name,
    count(b.booking_id) as total_bookings
from bookings b
inner join vehicles v
    on b.vehicle_id = v.vehicle_id
group by v.name
having count(b.booking_id) > 2;