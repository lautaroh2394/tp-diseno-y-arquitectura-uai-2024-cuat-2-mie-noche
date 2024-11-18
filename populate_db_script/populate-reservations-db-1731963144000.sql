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
    exec create_user @username = 'admin', @hashed_password = '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', @permissions_list = @permissions;
    DELETE FROM @permissions;


-- Reservations
declare @creatorId int
set @creatorId = (select top 1 id from users where username = 'reservador')
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T13:00:24.000Z', '2024-11-18T14:00:24.000Z', 'TURNO_GENERAL', ' Esteban Román Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T14:00:24.000Z', '2024-11-18T15:00:24.000Z', 'TURNO_GENERAL', 'Héctor Pepe  Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T17:00:24.000Z', '2024-11-18T18:00:24.000Z', 'TURNO_GENERAL', 'Román García Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T19:00:24.000Z', '2024-11-18T20:00:24.000Z', 'TURNO_GENERAL', 'María Héctor Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T14:00:24.000Z', '2024-11-19T15:00:24.000Z', 'TURNO_GENERAL', 'Román María Lucas García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T18:00:24.000Z', '2024-11-19T19:00:24.000Z', 'TURNO_GENERAL', 'Sofía Esteban Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T18:00:24.000Z', '2024-11-20T19:00:24.000Z', 'TURNO_GENERAL', 'Pepe  Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T13:00:24.000Z', '2024-11-21T14:00:24.000Z', 'TURNO_GENERAL', 'Esteban Pepe Lucas Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T14:00:24.000Z', '2024-11-21T15:00:24.000Z', 'TURNO_GENERAL', 'Lucas Pepe Esteban Quiroga Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T16:00:24.000Z', '2024-11-21T17:00:24.000Z', 'TURNO_GENERAL', 'Sofía García Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T17:00:24.000Z', '2024-11-21T18:00:24.000Z', 'TURNO_GENERAL', 'Román Soso Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T13:00:24.000Z', '2024-11-22T14:00:24.000Z', 'TURNO_GENERAL', 'Sofía Perez García ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T14:00:24.000Z', '2024-11-22T15:00:24.000Z', 'TURNO_GENERAL', 'Pepe Lucas Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T18:00:24.000Z', '2024-11-22T19:00:24.000Z', 'TURNO_GENERAL', 'Héctor Pepe Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T16:00:24.000Z', '2024-11-23T17:00:24.000Z', 'TURNO_GENERAL', 'María Lucas Marquez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T17:00:24.000Z', '2024-11-23T18:00:24.000Z', 'TURNO_GENERAL', 'Sofía Héctor María Sanchez Quiroga ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T18:00:24.000Z', '2024-11-23T19:00:24.000Z', 'TURNO_GENERAL', 'María Héctor Poncho Quiroga Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T13:00:24.000Z', '2024-11-24T14:00:24.000Z', 'TURNO_GENERAL', 'Sofía Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T17:00:24.000Z', '2024-11-24T18:00:24.000Z', 'TURNO_GENERAL', 'María Román García Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T13:00:24.000Z', '2024-11-18T14:00:24.000Z', 'CAJERO', 'Sofía Román Esteban ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T14:00:24.000Z', '2024-11-18T15:00:24.000Z', 'CAJERO', 'María Sofía Poncho Sanchez ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T15:00:24.000Z', '2024-11-18T16:00:24.000Z', 'CAJERO', 'María Marquez ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T18:00:24.000Z', '2024-11-18T19:00:24.000Z', 'CAJERO', 'Héctor Lucas Perez ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T19:00:24.000Z', '2024-11-18T20:00:24.000Z', 'CAJERO', 'Román Poncho ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T14:00:24.000Z', '2024-11-19T15:00:24.000Z', 'CAJERO', 'Lucas Pepe Sofía Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T15:00:24.000Z', '2024-11-19T16:00:24.000Z', 'CAJERO', 'Pepe  Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T16:00:24.000Z', '2024-11-19T17:00:24.000Z', 'CAJERO', ' Román García  Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T19:00:24.000Z', '2024-11-19T20:00:24.000Z', 'CAJERO', 'Esteban Román Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T14:00:24.000Z', '2024-11-20T15:00:24.000Z', 'CAJERO', 'Lucas Perez García Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T15:00:24.000Z', '2024-11-20T16:00:24.000Z', 'CAJERO', 'Román Héctor Pepe Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T17:00:24.000Z', '2024-11-20T18:00:24.000Z', 'CAJERO', 'Héctor Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T19:00:24.000Z', '2024-11-20T20:00:24.000Z', 'CAJERO', 'Héctor Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T16:00:24.000Z', '2024-11-21T17:00:24.000Z', 'CAJERO', 'Sofía Esteban Héctor  Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T16:00:24.000Z', '2024-11-22T17:00:24.000Z', 'CAJERO', 'María Lucas Héctor Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T17:00:24.000Z', '2024-11-22T18:00:24.000Z', 'CAJERO', 'Lucas Perez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T18:00:24.000Z', '2024-11-22T19:00:24.000Z', 'CAJERO', 'Román García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T19:00:24.000Z', '2024-11-22T20:00:24.000Z', 'CAJERO', ' Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T16:00:24.000Z', '2024-11-23T17:00:24.000Z', 'CAJERO', 'María Esteban Poncho Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T19:00:24.000Z', '2024-11-23T20:00:24.000Z', 'CAJERO', 'María Héctor Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T13:00:24.000Z', '2024-11-24T14:00:24.000Z', 'CAJERO', 'Esteban  Héctor Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T16:00:24.000Z', '2024-11-24T17:00:24.000Z', 'CAJERO', 'Román Poncho ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T14:00:24.000Z', '2024-11-18T15:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Pepe Héctor Poncho Quiroga Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T16:00:24.000Z', '2024-11-18T17:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T18:00:24.000Z', '2024-11-18T19:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Héctor María Pepe Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T13:00:24.000Z', '2024-11-19T14:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T16:00:24.000Z', '2024-11-19T17:00:24.000Z', 'ATENCION_AL_CLIENTE', ' María Soso Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T17:00:24.000Z', '2024-11-19T18:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Román ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T19:00:24.000Z', '2024-11-19T20:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Poncho ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T14:00:24.000Z', '2024-11-20T15:00:24.000Z', 'ATENCION_AL_CLIENTE', 'María Pepe Lucas Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T17:00:24.000Z', '2024-11-20T18:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Perez Soso Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T18:00:24.000Z', '2024-11-20T19:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Esteban Poncho García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T19:00:24.000Z', '2024-11-20T20:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Lucas  Quiroga Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T13:00:24.000Z', '2024-11-21T14:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Pepe Esteban Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T14:00:24.000Z', '2024-11-21T15:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Román Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T16:00:24.000Z', '2024-11-21T17:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Sofía Román Poncho Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T17:00:24.000Z', '2024-11-21T18:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Pepe García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T15:00:24.000Z', '2024-11-22T16:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Román ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T17:00:24.000Z', '2024-11-22T18:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T19:00:24.000Z', '2024-11-22T20:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Esteban Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T13:00:24.000Z', '2024-11-23T14:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Román Esteban Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T14:00:24.000Z', '2024-11-23T15:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Román García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T18:00:24.000Z', '2024-11-23T19:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Pepe Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T14:00:24.000Z', '2024-11-24T15:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T15:00:24.000Z', '2024-11-24T16:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Pepe Lucas García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T16:00:24.000Z', '2024-11-24T17:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Román Héctor Sofía Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T19:00:24.000Z', '2024-11-24T20:00:24.000Z', 'ATENCION_AL_CLIENTE', 'Pepe  Soso Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T13:00:24.000Z', '2024-11-18T14:00:24.000Z', 'OPERACION', 'Román María Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T14:00:24.000Z', '2024-11-18T15:00:24.000Z', 'OPERACION', 'Lucas Román Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T15:00:24.000Z', '2024-11-18T16:00:24.000Z', 'OPERACION', 'Sofía Soso Sanchez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T16:00:24.000Z', '2024-11-18T17:00:24.000Z', 'OPERACION', 'Esteban Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T19:00:24.000Z', '2024-11-18T20:00:24.000Z', 'OPERACION', 'Pepe García Poncho Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T18:00:24.000Z', '2024-11-19T19:00:24.000Z', 'OPERACION', ' Esteban Lucas Quiroga Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T19:00:24.000Z', '2024-11-19T20:00:24.000Z', 'OPERACION', 'Pepe Héctor Perez Poncho ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T13:00:24.000Z', '2024-11-20T14:00:24.000Z', 'OPERACION', 'Pepe Quiroga Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T14:00:24.000Z', '2024-11-20T15:00:24.000Z', 'OPERACION', 'Héctor Soso Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T18:00:24.000Z', '2024-11-20T19:00:24.000Z', 'OPERACION', 'Héctor García Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T13:00:24.000Z', '2024-11-21T14:00:24.000Z', 'OPERACION', 'Sofía Román Sanchez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T14:00:24.000Z', '2024-11-21T15:00:24.000Z', 'OPERACION', ' Sofía Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T15:00:24.000Z', '2024-11-21T16:00:24.000Z', 'OPERACION', 'Lucas Pepe Sanchez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T16:00:24.000Z', '2024-11-21T17:00:24.000Z', 'OPERACION', 'Héctor Soso Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T17:00:24.000Z', '2024-11-21T18:00:24.000Z', 'OPERACION', 'Román Lucas Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T18:00:24.000Z', '2024-11-21T19:00:24.000Z', 'OPERACION', 'Román  María Sanchez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T19:00:24.000Z', '2024-11-21T20:00:24.000Z', 'OPERACION', 'Román María Héctor Soso Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T13:00:24.000Z', '2024-11-22T14:00:24.000Z', 'OPERACION', 'Esteban Pepe  Quiroga Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T14:00:24.000Z', '2024-11-22T15:00:24.000Z', 'OPERACION', 'María  Pepe Marquez Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T18:00:24.000Z', '2024-11-22T19:00:24.000Z', 'OPERACION', 'Héctor  Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T19:00:24.000Z', '2024-11-22T20:00:24.000Z', 'OPERACION', 'Sofía Esteban Pepe Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T13:00:24.000Z', '2024-11-23T14:00:24.000Z', 'OPERACION', 'María Román Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T14:00:24.000Z', '2024-11-23T15:00:24.000Z', 'OPERACION', 'Héctor Pepe Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T15:00:24.000Z', '2024-11-23T16:00:24.000Z', 'OPERACION', ' Perez García Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T16:00:24.000Z', '2024-11-23T17:00:24.000Z', 'OPERACION', 'Lucas María Quiroga García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T18:00:24.000Z', '2024-11-23T19:00:24.000Z', 'OPERACION', ' Lucas Pepe Quiroga Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T19:00:24.000Z', '2024-11-23T20:00:24.000Z', 'OPERACION', 'Pepe Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T16:00:24.000Z', '2024-11-24T17:00:24.000Z', 'OPERACION', 'Pepe Héctor Quiroga García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T19:00:24.000Z', '2024-11-24T20:00:24.000Z', 'OPERACION', 'Héctor Quiroga Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T15:00:24.000Z', '2024-11-18T16:00:24.000Z', 'BAJA_CUENTA', 'Lucas  Marquez Soso Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-18T19:00:24.000Z', '2024-11-18T20:00:24.000Z', 'BAJA_CUENTA', ' Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T13:00:24.000Z', '2024-11-19T14:00:24.000Z', 'BAJA_CUENTA', 'Esteban Pepe  Soso Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T15:00:24.000Z', '2024-11-19T16:00:24.000Z', 'BAJA_CUENTA', 'María  Poncho García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T17:00:24.000Z', '2024-11-19T18:00:24.000Z', 'BAJA_CUENTA', 'Lucas Esteban Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T18:00:24.000Z', '2024-11-19T19:00:24.000Z', 'BAJA_CUENTA', 'Héctor Lucas Quiroga Marquez ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-19T19:00:24.000Z', '2024-11-19T20:00:24.000Z', 'BAJA_CUENTA', 'Lucas Esteban  Perez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T13:00:24.000Z', '2024-11-20T14:00:24.000Z', 'BAJA_CUENTA', 'Esteban Soso García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T17:00:24.000Z', '2024-11-20T18:00:24.000Z', 'BAJA_CUENTA', 'Pepe Sanchez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T14:00:24.000Z', '2024-11-21T15:00:24.000Z', 'BAJA_CUENTA', 'Esteban García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T16:00:24.000Z', '2024-11-21T17:00:24.000Z', 'BAJA_CUENTA', 'Pepe Lucas García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T13:00:24.000Z', '2024-11-22T14:00:24.000Z', 'BAJA_CUENTA', 'Pepe Esteban Quiroga Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T15:00:24.000Z', '2024-11-22T16:00:24.000Z', 'BAJA_CUENTA', 'Lucas Sofía Esteban Perez ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T18:00:24.000Z', '2024-11-22T19:00:24.000Z', 'BAJA_CUENTA', ' Héctor Esteban ', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T19:00:24.000Z', '2024-11-22T20:00:24.000Z', 'BAJA_CUENTA', 'Sofía Pepe Lucas Perez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T14:00:24.000Z', '2024-11-23T15:00:24.000Z', 'BAJA_CUENTA', 'Lucas Esteban Marquez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T15:00:24.000Z', '2024-11-23T16:00:24.000Z', 'BAJA_CUENTA', ' Sofía Marquez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T16:00:24.000Z', '2024-11-23T17:00:24.000Z', 'BAJA_CUENTA', 'María Héctor  Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T18:00:24.000Z', '2024-11-24T19:00:24.000Z', 'BAJA_CUENTA', ' Quiroga', @creatorId);


-- Settings
insert into settings (setting_key, value) values ('OPENING_HOUR', 9), ('CLOSING_HOUR', 18), ('MAX_DURATION', 60)


