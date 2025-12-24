

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









