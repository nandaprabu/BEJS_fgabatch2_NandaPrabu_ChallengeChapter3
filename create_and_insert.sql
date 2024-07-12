-- create table
-- create table nasabah
create table nasabah(
	id uuid default gen_random_uuid(),
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
	id uuid default gen_random_uuid(),
	id_nasabah uuid not null,
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
	id uuid default gen_random_uuid(),
	id_akun uuid not null,
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
	('bbe3585f-d8a5-4bc1-976a-b5a222efe71a', 1, 15500000),
	('444cfd5d-5ff9-4d8b-b971-29c10e49a670', 2, 22750000),
	('b5125855-1ab5-463b-8be0-95cd04cb7fab', 3, 8200000),
	('818f403d-8c2d-4a26-805a-e10ac9221b85', 4, 12500000),
	('5c294c08-0e42-4a6a-9cab-f8b6d12358cb', 5, 17300000),
	('b857d137-7f88-449d-b87e-7b55ae9db762', 5, 25600000),
	('1c86cb67-c16a-4003-a3f8-d6c0f0530bd0', 4, 14750000),
	('2f24cbbe-1785-4ff8-865c-6d7cacc7502a', 3, 19850000),
	('ef4c3267-979c-4928-83f0-b9d1b0d02c3c', 2, 11400000),
	('c78d01d4-6e81-465e-8389-e3a29adb853f', 1, 23900000);

-- insert into table transaksi
insert into transaksi(id_akun, type, balance, status)
values 
	('052fd311-a76d-49aa-9d78-585948304052', 'deposit', '100000', 'success'),
	('0d056100-d299-4247-ba03-fd708d4cbba9', 'withdraw', '200000', 'pending'),
	('5dc99cc2-231d-42a2-a59f-2afd4c4ff13d','withdraw', '5000000000', 'fail'),
	('6a7ebba7-7aa1-4de6-83c1-c340fad49636','deposit', '350000', 'success'),
	('c667d014-d3bf-4a3f-9737-df22a6b00f55','deposit', '1500000', 'success');

-- read data
-- read each table data
select * from nasabah;
select * from account_type;
select * from akun;
select * from transaksi;

-- read data id nasabah, their name, their account type and their balance.
select 
	n.id as nasabah_id,
	n.name as nasabah_name,
	at.name as type_account,
	a.balance as account_balance
from 
	nasabah n
join 
	akun a on n.id = a.id_nasabah
join 
	account_type at on at.id = a.id_account_type;


-- read name, account type, amount and the status of transaction, which has withdraw their balance more than 1 million
select 
	n.name as nasabah_name,
	at.name as type_account,
	t.type as transaction_action,
	t.status as transaction_status
from 
	nasabah n
join 
	akun a on n.id = a.id_nasabah
join 
	account_type at on at.id = a.id_account_type
join 
	transaksi t on t.id_akun = a.id
where 
	t.type = 'withdraw' and t.balance < 1000000;

-- update data
-- update data nasabah name from table nasabah
update nasabah 
set
	name = 'Lucas Old'
where
	id = 'c78d01d4-6e81-465e-8389-e3a29adb853f';



-- delete data
-- delete data from table transaksi
delete from transaksi
where 
	id = 'e39940fe-9a0d-4bed-a6d8-a1ec9c0b5c0a';