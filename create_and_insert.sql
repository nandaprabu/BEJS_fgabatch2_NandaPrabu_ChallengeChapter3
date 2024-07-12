-- create table
-- create table nasabah
create table nasabah(
	id bigserial not null,
	name varchar(255) not null,
	address varchar not null,
	phone varchar(14) not null,
	constraint pk_nasabah primary key (id)
);

-- create table account_type
create table account_type(
	id bigserial not null,
	name varchar(100) not null,
	description varchar(255),
	constraint pk_account_type primary key (id)
);

-- create table akun
create table akun(
	id bigserial not null,
	id_nasabah bigserial,
	id_account_type bigserial,
	balance bigint not null,
	constraint pk_akun primary key (id),
	constraint fk_id_nasabah foreign key (id_nasabah) references nasabah(id),
	constraint fk_id_account_type foreign key (id_account_type) references account_type(id)
);

-- create enum type for column 'type' and 'status' in transaksi table
create type type_transaksi as enum('deposit','withdraw');
create type type_status as enum('success','pending','fail');

-- create table transaksi
create table transaksi(
	id bigserial not null,
	id_akun bigserial,
	time timestamp default current_timestamp not null,
	type type_transaksi not null,
	balance bigint default 0 not null,
	status type_status not null,
	constraint pk_transaksi primary key (id),
	constraint fk_id_akun foreign key (id_akun) references akun(id)
);


-- insert data
-- insert into table nasabah
insert into nasabah(name, address, phone)
values
	('Alice Taylor', '123 Cherry Lane, Springfield, IL 62714', '555-6780'),
	('Robert Harris', '456 Walnut Street, Springfield, IL 62715', '555-1235'),
	('Maria Clark', '789 Maple Drive, Springfield, IL 62716', '555-7891'),
	('William Lewis', '321 Pine Street, Springfield, IL 62717', '555-3210'),
	('Sophia Walker', '654 Oak Avenue, Springfield, IL 62718', '555-6543'),
	('James King', '987 Birch Road, Springfield, IL 62719', '555-9876'),
	('Isabella Wright', '258 Cedar Lane, Springfield, IL 62720', '555-2589'),
	('Benjamin Scott', '369 Poplar Court, Springfield, IL 62721', '555-3694'),
	('Mia Green', '741 Ash Way, Springfield, IL 62722', '555-7412'),
	('Lucas Young', '852 Fir Drive, Springfield, IL 62723', '555-8527');

-- insert into table account_type
insert into account_type(name, description)
values
	('Tabungan Ceria', 'Tabungan Ceria menawarkan kemudahan menabung dengan bunga kompetitif dan tanpa biaya administrasi bulanan.'),
	('Tabungan Mapan', 'Tabungan Mapan dirancang untuk Anda yang ingin mempersiapkan masa depan finansial yang lebih baik.'),
	('Tabungan Flexi', 'Tabungan Flexi memberikan fleksibilitas maksimal dengan akses mudah ke dana Anda kapan saja tanpa biaya penalti.'),
	('Tabungan Edukasi', 'Tabungan Edukasi adalah solusi tepat bagi Anda yang ingin mempersiapkan biaya pendidikan anak sejak dini.'),
	('Tabungan Sehat', 'Tabungan Sehat membantu Anda menyiapkan dana kesehatan dengan bunga menarik dan fitur khusus yang memudahkan pembayaran premi asuransi kesehatan.')

-- insert into table akun
insert into akun(id_nasabah, id_account_type, balance)
values 
	(1, 5, 15500000),
	(2, 4, 22750000),
	(3, 3, 8200000),
	(4, 2, 12500000),
	(5, 1, 17300000),
	(6, 1, 25600000),
	(7, 2, 14750000),
	(8, 3, 19850000),
	(9, 4, 11400000),
	(10, 5, 23900000);
	
-- insert into table transaksi
insert into transaksi (type, balance, status)
values 
	('deposit', '100000', 'success'),
	('withdraw', '200000', 'pending'),
	('withdraw', '5000000000', 'fail'),
	('deposit', '350000', 'success'),
	('deposit', '1500000', 'success');

-- read each table data
select * from nasabah;
select * from account_type;
select * from akun;
select * from transaksi;

-- update data
update nasabah 
set
	name = 'Lucas Old'
where
	id = 10;
	
-- delete data
delete from transaksi
where 
	id = 5;
