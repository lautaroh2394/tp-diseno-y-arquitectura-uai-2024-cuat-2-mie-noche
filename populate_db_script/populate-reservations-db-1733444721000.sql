-- Delete previous data
delete from reservations;
delete from permissions_per_user;
delete from users;
delete from permissions;
delete from categories;
delete from settings;


-- Categories
insert into categories (id, name, show_name) values ('TURNO_GENERAL', 'TURNO_GENERAL', 'Turno general');
insert into categories (id, name, show_name) values ('CAJERO', 'CAJERO', 'Cajero');
insert into categories (id, name, show_name) values ('ATENCION_AL_CLIENTE', 'ATENCION_AL_CLIENTE', 'Atención al cliente');
insert into categories (id, name, show_name) values ('OPERACION', 'OPERACION', 'Operación');
insert into categories (id, name, show_name) values ('BAJA_CUENTA', 'BAJA_CUENTA', 'Baja de cuenta');


-- Permissions
insert into permissions (id, name, show_name) values ('BUSQUEDA', 'BUSQUEDA', 'Búsqueda');
insert into permissions (id, name, show_name) values ('RESERVA', 'RESERVA', 'Reserva');
insert into permissions (id, name, show_name) values ('CREAR_USUARIO', 'CREAR_USUARIO', 'Crear usuario');
insert into permissions (id, name, show_name) values ('EDITAR_USUARIO', 'EDITAR_USUARIO', 'Editar usuario');
insert into permissions (id, name, show_name) values ('VER_USUARIOS', 'VER_USUARIOS', 'Ver usuarios');
insert into permissions (id, name, show_name) values ('ADMIN', 'ADMIN', 'Administrador');


-- Users
DECLARE @permissions PermissionsListType;
INSERT INTO @permissions (id) values ('BUSQUEDA');
    exec create_user @username = 'buscador', @hashed_password = 'a8b83bf02bdd6534a90627b589d7773307db9df487f7ba690bb0e7e8296460b2', @permissions_list = @permissions;
    DELETE FROM @permissions;
INSERT INTO @permissions (id) values ('RESERVA');
    exec create_user @username = 'reservador', @hashed_password = 'ae00dd9f95d52e6392e0b8963a0a2a5d48b41c708613c2159ab86da1dc321353', @permissions_list = @permissions;
    DELETE FROM @permissions;
INSERT INTO @permissions (id) values ('CREAR_USUARIO');
    exec create_user @username = 'creador', @hashed_password = '87195c91951077534f3556326da2ed3b70fb547ae967bb93790df38c2e46259a', @permissions_list = @permissions;
    DELETE FROM @permissions;
INSERT INTO @permissions (id) values ('EDITAR_USUARIO');
    exec create_user @username = 'editor', @hashed_password = '1553cc62ff246044c683a61e203e65541990e7fcd4af9443d22b9557ecc9ac54', @permissions_list = @permissions;
    DELETE FROM @permissions;
INSERT INTO @permissions (id) values ('VER_USUARIOS');
    exec create_user @username = 'visor', @hashed_password = '57c63d512fec5524bea0059b9c8a51256d02886bdb3fab649621e7142283fc81', @permissions_list = @permissions;
    DELETE FROM @permissions;
INSERT INTO @permissions (id) values ('BUSQUEDA'),('RESERVA');
    exec create_user @username = 'recepcionista', @hashed_password = 'bd2f76155a54ecf99bd3efd53dfbadf54d7b0ecd7b99f989449dfb817c0bb744', @permissions_list = @permissions;
    DELETE FROM @permissions;
INSERT INTO @permissions (id) values ('BUSQUEDA'),('RESERVA'),('CREAR_USUARIO'),('EDITAR_USUARIO'),('VER_USUARIOS');
    exec create_user @username = 'full', @hashed_password = 'a18b869b2e81c0c529552a3c4fa5c92ed08b98a4e146aed778d71d27517f83ac', @permissions_list = @permissions;
    DELETE FROM @permissions;
INSERT INTO @permissions (id) values ('BUSQUEDA'),('RESERVA'),('CREAR_USUARIO'),('EDITAR_USUARIO'),('VER_USUARIOS'),('ADMIN');
    exec create_user @username = 'fulladmin', @hashed_password = 'eb11db558c0388d33b6366af3b9ed565b92bca54d18bba9f6cea548f3de7e5bc', @permissions_list = @permissions;
    DELETE FROM @permissions;
INSERT INTO @permissions (id) values ('ADMIN');
    exec create_user @username = 'admin', @hashed_password = '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', @permissions_list = @permissions;
    DELETE FROM @permissions;


-- Reservations
declare @creatorId int
set @creatorId = (select top 1 id from users where username = 'reservador')
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T14:00:21.000Z', '2024-12-05T15:00:21.000Z', 'TURNO_GENERAL', 'Sofía María Pepe García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T16:00:21.000Z', '2024-12-05T17:00:21.000Z', 'TURNO_GENERAL', 'María Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T18:00:21.000Z', '2024-12-05T19:00:21.000Z', 'TURNO_GENERAL', 'Pepe Marquez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T15:00:21.000Z', '2024-12-06T16:00:21.000Z', 'TURNO_GENERAL', 'Lucas Soso Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T19:00:21.000Z', '2024-12-06T20:00:21.000Z', 'TURNO_GENERAL', 'Pepe Héctor Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T13:00:21.000Z', '2024-12-07T14:00:21.000Z', 'TURNO_GENERAL', 'Héctor Poncho Sanchez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T14:00:21.000Z', '2024-12-07T15:00:21.000Z', 'TURNO_GENERAL', 'Esteban Héctor Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T15:00:21.000Z', '2024-12-07T16:00:21.000Z', 'TURNO_GENERAL', 'Sofía Marquez Poncho García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T16:00:21.000Z', '2024-12-07T17:00:21.000Z', 'TURNO_GENERAL', 'Pepe Poncho García Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T18:00:21.000Z', '2024-12-07T19:00:21.000Z', 'TURNO_GENERAL', 'Pepe Sofía Lucas Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T17:00:21.000Z', '2024-12-08T18:00:21.000Z', 'TURNO_GENERAL', 'Esteban Pepe Lucas García Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T19:00:21.000Z', '2024-12-08T20:00:21.000Z', 'TURNO_GENERAL', 'Román Sofía Perez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T17:00:21.000Z', '2024-12-09T18:00:21.000Z', 'TURNO_GENERAL', 'Pepe Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T19:00:21.000Z', '2024-12-09T20:00:21.000Z', 'TURNO_GENERAL', 'María Héctor Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T14:00:21.000Z', '2024-12-10T15:00:21.000Z', 'TURNO_GENERAL', 'Lucas Héctor Perez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T16:00:21.000Z', '2024-12-10T17:00:21.000Z', 'TURNO_GENERAL', 'Sofía Quiroga Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T17:00:21.000Z', '2024-12-10T18:00:21.000Z', 'TURNO_GENERAL', 'Sofía María Soso Poncho Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T19:00:21.000Z', '2024-12-10T20:00:21.000Z', 'TURNO_GENERAL', 'Héctor María Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T14:00:21.000Z', '2024-12-11T15:00:21.000Z', 'TURNO_GENERAL', 'Esteban Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T15:00:21.000Z', '2024-12-11T16:00:21.000Z', 'TURNO_GENERAL', 'Pepe Esteban Poncho Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T16:00:21.000Z', '2024-12-11T17:00:21.000Z', 'TURNO_GENERAL', 'Sofía Román Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T14:00:21.000Z', '2024-12-05T15:00:21.000Z', 'CAJERO', 'Esteban Sanchez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T17:00:21.000Z', '2024-12-05T18:00:21.000Z', 'CAJERO', 'María Héctor Sofía Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T19:00:21.000Z', '2024-12-05T20:00:21.000Z', 'CAJERO', 'Héctor Marquez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T14:00:21.000Z', '2024-12-06T15:00:21.000Z', 'CAJERO', 'Román Esteban Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T17:00:21.000Z', '2024-12-06T18:00:21.000Z', 'CAJERO', 'María Quiroga Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T18:00:21.000Z', '2024-12-06T19:00:21.000Z', 'CAJERO', 'Lucas Marquez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T19:00:21.000Z', '2024-12-06T20:00:21.000Z', 'CAJERO', 'Lucas Quiroga García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T13:00:21.000Z', '2024-12-07T14:00:21.000Z', 'CAJERO', 'Esteban Pepe Román Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T15:00:21.000Z', '2024-12-07T16:00:21.000Z', 'CAJERO', 'Sofía Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T17:00:21.000Z', '2024-12-07T18:00:21.000Z', 'CAJERO', 'Lucas Román Héctor Perez Soso Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T19:00:21.000Z', '2024-12-07T20:00:21.000Z', 'CAJERO', 'Román Poncho García Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T15:00:21.000Z', '2024-12-08T16:00:21.000Z', 'CAJERO', 'María Sofía Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T17:00:21.000Z', '2024-12-08T18:00:21.000Z', 'CAJERO', 'Héctor Pepe Esteban García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T19:00:21.000Z', '2024-12-08T20:00:21.000Z', 'CAJERO', 'Sofía Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T13:00:21.000Z', '2024-12-09T14:00:21.000Z', 'CAJERO', 'Sofía Poncho Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T14:00:21.000Z', '2024-12-09T15:00:21.000Z', 'CAJERO', 'Román Soso Quiroga Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T15:00:21.000Z', '2024-12-09T16:00:21.000Z', 'CAJERO', 'Lucas Sanchez Soso Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T16:00:21.000Z', '2024-12-09T17:00:21.000Z', 'CAJERO', 'Héctor Lucas Román Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T17:00:21.000Z', '2024-12-09T18:00:21.000Z', 'CAJERO', 'Sofía Lucas Esteban Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T18:00:21.000Z', '2024-12-09T19:00:21.000Z', 'CAJERO', 'Lucas Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T19:00:21.000Z', '2024-12-09T20:00:21.000Z', 'CAJERO', 'Héctor Pepe Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T15:00:21.000Z', '2024-12-10T16:00:21.000Z', 'CAJERO', 'María Pepe Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T17:00:21.000Z', '2024-12-10T18:00:21.000Z', 'CAJERO', 'Pepe Soso Perez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T14:00:21.000Z', '2024-12-11T15:00:21.000Z', 'CAJERO', 'Pepe Román Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T18:00:21.000Z', '2024-12-11T19:00:21.000Z', 'CAJERO', 'Héctor Esteban Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T14:00:21.000Z', '2024-12-05T15:00:21.000Z', 'ATENCION_AL_CLIENTE', 'María Pepe Poncho Sanchez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T16:00:21.000Z', '2024-12-05T17:00:21.000Z', 'ATENCION_AL_CLIENTE', 'María Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T17:00:21.000Z', '2024-12-05T18:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Sofía María Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T19:00:21.000Z', '2024-12-05T20:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Pepe García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T13:00:21.000Z', '2024-12-06T14:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T14:00:21.000Z', '2024-12-06T15:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Pepe Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T16:00:21.000Z', '2024-12-06T17:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Esteban Héctor Marquez Poncho García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T17:00:21.000Z', '2024-12-06T18:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Esteban Sanchez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T18:00:21.000Z', '2024-12-06T19:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Román Sanchez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T19:00:21.000Z', '2024-12-06T20:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T13:00:21.000Z', '2024-12-07T14:00:21.000Z', 'ATENCION_AL_CLIENTE', 'María Soso García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T17:00:21.000Z', '2024-12-07T18:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Esteban María Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T18:00:21.000Z', '2024-12-07T19:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Román Lucas Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T19:00:21.000Z', '2024-12-07T20:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T13:00:21.000Z', '2024-12-08T14:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Esteban Héctor Soso Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T16:00:21.000Z', '2024-12-08T17:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Román Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T17:00:21.000Z', '2024-12-08T18:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Marquez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T13:00:21.000Z', '2024-12-09T14:00:21.000Z', 'ATENCION_AL_CLIENTE', 'María Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T15:00:21.000Z', '2024-12-09T16:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Román Héctor Perez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T19:00:21.000Z', '2024-12-09T20:00:21.000Z', 'ATENCION_AL_CLIENTE', 'María Pepe Quiroga Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T13:00:21.000Z', '2024-12-10T14:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Román Pepe García Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T16:00:21.000Z', '2024-12-10T17:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Román Esteban Poncho Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T18:00:21.000Z', '2024-12-10T19:00:21.000Z', 'ATENCION_AL_CLIENTE', 'María Héctor Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T19:00:21.000Z', '2024-12-10T20:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T15:00:21.000Z', '2024-12-11T16:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Sanchez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T16:00:21.000Z', '2024-12-11T17:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Román Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T17:00:21.000Z', '2024-12-11T18:00:21.000Z', 'ATENCION_AL_CLIENTE', 'Román García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T13:00:21.000Z', '2024-12-05T14:00:21.000Z', 'OPERACION', 'Pepe Román Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T14:00:21.000Z', '2024-12-05T15:00:21.000Z', 'OPERACION', 'María Soso Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T15:00:21.000Z', '2024-12-05T16:00:21.000Z', 'OPERACION', 'Héctor María Marquez Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T13:00:21.000Z', '2024-12-06T14:00:21.000Z', 'OPERACION', 'Lucas Esteban Héctor Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T14:00:21.000Z', '2024-12-06T15:00:21.000Z', 'OPERACION', 'María García Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T16:00:21.000Z', '2024-12-06T17:00:21.000Z', 'OPERACION', 'Román Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T17:00:21.000Z', '2024-12-06T18:00:21.000Z', 'OPERACION', 'Sofía Perez García Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T18:00:21.000Z', '2024-12-06T19:00:21.000Z', 'OPERACION', 'Román García Marquez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T13:00:21.000Z', '2024-12-07T14:00:21.000Z', 'OPERACION', 'Sofía Esteban Héctor Sanchez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T14:00:21.000Z', '2024-12-07T15:00:21.000Z', 'OPERACION', 'Pepe García Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T15:00:21.000Z', '2024-12-07T16:00:21.000Z', 'OPERACION', 'Lucas Sofía Sanchez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T16:00:21.000Z', '2024-12-07T17:00:21.000Z', 'OPERACION', 'María Esteban Poncho Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T17:00:21.000Z', '2024-12-07T18:00:21.000Z', 'OPERACION', 'Héctor Perez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T18:00:21.000Z', '2024-12-07T19:00:21.000Z', 'OPERACION', 'Sofía Lucas Marquez Quiroga Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T15:00:21.000Z', '2024-12-08T16:00:21.000Z', 'OPERACION', 'María Román Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T16:00:21.000Z', '2024-12-08T17:00:21.000Z', 'OPERACION', 'María Quiroga Perez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T17:00:21.000Z', '2024-12-08T18:00:21.000Z', 'OPERACION', 'Pepe Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T19:00:21.000Z', '2024-12-08T20:00:21.000Z', 'OPERACION', 'Lucas Perez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T14:00:21.000Z', '2024-12-09T15:00:21.000Z', 'OPERACION', 'Sofía Poncho Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T15:00:21.000Z', '2024-12-09T16:00:21.000Z', 'OPERACION', 'Román Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T17:00:21.000Z', '2024-12-09T18:00:21.000Z', 'OPERACION', 'Román Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T19:00:21.000Z', '2024-12-09T20:00:21.000Z', 'OPERACION', 'Sofía Román Poncho Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T13:00:21.000Z', '2024-12-10T14:00:21.000Z', 'OPERACION', 'Pepe Esteban Marquez Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T15:00:21.000Z', '2024-12-10T16:00:21.000Z', 'OPERACION', 'Esteban Poncho Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T17:00:21.000Z', '2024-12-10T18:00:21.000Z', 'OPERACION', 'María Lucas Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T19:00:21.000Z', '2024-12-10T20:00:21.000Z', 'OPERACION', 'Lucas Sofía Héctor Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T15:00:21.000Z', '2024-12-11T16:00:21.000Z', 'OPERACION', 'Esteban Lucas María Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T19:00:21.000Z', '2024-12-11T20:00:21.000Z', 'OPERACION', 'Lucas Esteban María Marquez Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T13:00:21.000Z', '2024-12-05T14:00:21.000Z', 'BAJA_CUENTA', 'Román García Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T14:00:21.000Z', '2024-12-05T15:00:21.000Z', 'BAJA_CUENTA', 'Román Esteban Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T15:00:21.000Z', '2024-12-05T16:00:21.000Z', 'BAJA_CUENTA', 'María Sofía Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-05T17:00:21.000Z', '2024-12-05T18:00:21.000Z', 'BAJA_CUENTA', 'María Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T13:00:21.000Z', '2024-12-06T14:00:21.000Z', 'BAJA_CUENTA', 'Román Lucas Esteban Quiroga García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T16:00:21.000Z', '2024-12-06T17:00:21.000Z', 'BAJA_CUENTA', 'María Lucas Poncho Quiroga Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T17:00:21.000Z', '2024-12-06T18:00:21.000Z', 'BAJA_CUENTA', 'Pepe Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-06T19:00:21.000Z', '2024-12-06T20:00:21.000Z', 'BAJA_CUENTA', 'Lucas María Román Sanchez Poncho García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T13:00:21.000Z', '2024-12-07T14:00:21.000Z', 'BAJA_CUENTA', 'María Sofía Soso Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T15:00:21.000Z', '2024-12-07T16:00:21.000Z', 'BAJA_CUENTA', 'Román Esteban Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T16:00:21.000Z', '2024-12-07T17:00:21.000Z', 'BAJA_CUENTA', 'Román Sofía Pepe Marquez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-07T17:00:21.000Z', '2024-12-07T18:00:21.000Z', 'BAJA_CUENTA', 'María Pepe Poncho Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T17:00:21.000Z', '2024-12-08T18:00:21.000Z', 'BAJA_CUENTA', 'Héctor María Sofía Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T18:00:21.000Z', '2024-12-08T19:00:21.000Z', 'BAJA_CUENTA', 'Sofía Pepe Esteban Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-08T19:00:21.000Z', '2024-12-08T20:00:21.000Z', 'BAJA_CUENTA', 'Román Sofía Pepe Poncho Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T15:00:21.000Z', '2024-12-09T16:00:21.000Z', 'BAJA_CUENTA', 'Héctor Sofía Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T16:00:21.000Z', '2024-12-09T17:00:21.000Z', 'BAJA_CUENTA', 'Lucas Soso Sanchez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T17:00:21.000Z', '2024-12-09T18:00:21.000Z', 'BAJA_CUENTA', 'Héctor García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-09T19:00:21.000Z', '2024-12-09T20:00:21.000Z', 'BAJA_CUENTA', 'María Sofía Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T15:00:21.000Z', '2024-12-10T16:00:21.000Z', 'BAJA_CUENTA', 'Sofía Héctor Quiroga Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T18:00:21.000Z', '2024-12-10T19:00:21.000Z', 'BAJA_CUENTA', 'Lucas Román Sofía Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-10T19:00:21.000Z', '2024-12-10T20:00:21.000Z', 'BAJA_CUENTA', 'María García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T13:00:21.000Z', '2024-12-11T14:00:21.000Z', 'BAJA_CUENTA', 'Lucas Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T14:00:21.000Z', '2024-12-11T15:00:21.000Z', 'BAJA_CUENTA', 'María García Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T16:00:21.000Z', '2024-12-11T17:00:21.000Z', 'BAJA_CUENTA', 'Román Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T19:00:21.000Z', '2024-12-11T20:00:21.000Z', 'BAJA_CUENTA', 'Pepe Sanchez Quiroga', @creatorId);


-- Settings
insert into settings (setting_key, value) values ('OPENING_HOUR', 9), ('CLOSING_HOUR', 18), ('MAX_DURATION', 60)


