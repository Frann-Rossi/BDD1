create table categoria (
	categoria_id serial primary key,
	nombre varchar(50) not null unique,
	descripcion text,
	activa boolean default true	
);

create table libro (
	libro_id serial primary key,
	titulo varchar(100) not null,
	isbn varchar(15) unique,
	precio decimal(10,2) not null,
	stock int default 0,
	paginas int,
	fecha_publicacion date,
	fecha_registro date default current_date,
	idioma varchar(50) not null default 'Español',
	categoria_id int references categoria(categoria_id)
);

-- Preguntar por Schemas

create table libro (
    libro_id serial primary key,
    titulo varchar(100) not null,
    isbn varchar(15) unique,
    precio decimal(10,2) not null,
    stock int default 0,
    paginas int,
    fecha_publicacion date,
    fecha_registro date default current_date,
    idioma varchar(50) not null default 'Español',
    categoria_id int,
    foreign key (categoria_id) references categoria(categoria_id)
);