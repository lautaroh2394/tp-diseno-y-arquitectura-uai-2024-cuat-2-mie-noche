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
    values (60, '2024-11-20T13:00:46.000Z', '2024-11-20T14:00:46.000Z', 'TURNO_GENERAL', 'Román Pepe Héctor Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T15:00:46.000Z', '2024-11-20T16:00:46.000Z', 'TURNO_GENERAL', 'Román Poncho Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T16:00:46.000Z', '2024-11-20T17:00:46.000Z', 'TURNO_GENERAL', 'María Román Pepe Soso García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T19:00:46.000Z', '2024-11-20T20:00:46.000Z', 'TURNO_GENERAL', 'Sofía María Sanchez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T14:00:46.000Z', '2024-11-21T15:00:46.000Z', 'TURNO_GENERAL', 'Lucas Soso Sanchez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T16:00:46.000Z', '2024-11-21T17:00:46.000Z', 'TURNO_GENERAL', 'María Esteban García Sanchez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T18:00:46.000Z', '2024-11-21T19:00:46.000Z', 'TURNO_GENERAL', 'María Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T14:00:46.000Z', '2024-11-22T15:00:46.000Z', 'TURNO_GENERAL', 'Esteban Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T18:00:46.000Z', '2024-11-22T19:00:46.000Z', 'TURNO_GENERAL', 'Sofía García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T13:00:46.000Z', '2024-11-23T14:00:46.000Z', 'TURNO_GENERAL', 'Lucas María Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T15:00:46.000Z', '2024-11-23T16:00:46.000Z', 'TURNO_GENERAL', 'Héctor Poncho García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T14:00:46.000Z', '2024-11-24T15:00:46.000Z', 'TURNO_GENERAL', 'Sofía Soso Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T15:00:46.000Z', '2024-11-24T16:00:46.000Z', 'TURNO_GENERAL', 'Román García Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T17:00:46.000Z', '2024-11-24T18:00:46.000Z', 'TURNO_GENERAL', 'Lucas Soso García Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T18:00:46.000Z', '2024-11-24T19:00:46.000Z', 'TURNO_GENERAL', 'Sofía Sanchez García Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T13:00:46.000Z', '2024-11-25T14:00:46.000Z', 'TURNO_GENERAL', 'Lucas Sofía Román García Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T17:00:46.000Z', '2024-11-25T18:00:46.000Z', 'TURNO_GENERAL', 'Sofía Perez Marquez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T13:00:46.000Z', '2024-11-26T14:00:46.000Z', 'TURNO_GENERAL', 'Lucas Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T16:00:46.000Z', '2024-11-26T17:00:46.000Z', 'TURNO_GENERAL', 'Pepe Poncho Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T18:00:46.000Z', '2024-11-26T19:00:46.000Z', 'TURNO_GENERAL', 'Román María Esteban Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T19:00:46.000Z', '2024-11-26T20:00:46.000Z', 'TURNO_GENERAL', 'Román Pepe Sofía Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T14:00:46.000Z', '2024-11-20T15:00:46.000Z', 'CAJERO', 'Román Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T15:00:46.000Z', '2024-11-20T16:00:46.000Z', 'CAJERO', 'María Perez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T18:00:46.000Z', '2024-11-20T19:00:46.000Z', 'CAJERO', 'Román Lucas García Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T13:00:46.000Z', '2024-11-21T14:00:46.000Z', 'CAJERO', 'Sofía María Esteban Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T17:00:46.000Z', '2024-11-21T18:00:46.000Z', 'CAJERO', 'Esteban Héctor Sanchez Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T18:00:46.000Z', '2024-11-21T19:00:46.000Z', 'CAJERO', 'Lucas Héctor Soso Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T13:00:46.000Z', '2024-11-22T14:00:46.000Z', 'CAJERO', 'Lucas Sofía Pepe García Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T14:00:46.000Z', '2024-11-22T15:00:46.000Z', 'CAJERO', 'María Héctor Sanchez Quiroga Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T16:00:46.000Z', '2024-11-22T17:00:46.000Z', 'CAJERO', 'Lucas Román Sanchez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T19:00:46.000Z', '2024-11-22T20:00:46.000Z', 'CAJERO', 'María Román Lucas Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T13:00:46.000Z', '2024-11-23T14:00:46.000Z', 'CAJERO', 'Román Lucas Sofía Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T14:00:46.000Z', '2024-11-23T15:00:46.000Z', 'CAJERO', 'Sofía Sanchez Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T13:00:46.000Z', '2024-11-24T14:00:46.000Z', 'CAJERO', 'Esteban Lucas Pepe Poncho Quiroga Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T14:00:46.000Z', '2024-11-24T15:00:46.000Z', 'CAJERO', 'María Sanchez Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T15:00:46.000Z', '2024-11-24T16:00:46.000Z', 'CAJERO', 'Román Pepe Poncho García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T17:00:46.000Z', '2024-11-24T18:00:46.000Z', 'CAJERO', 'Sofía Marquez Perez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T15:00:46.000Z', '2024-11-25T16:00:46.000Z', 'CAJERO', 'Pepe Héctor María Soso Perez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T16:00:46.000Z', '2024-11-25T17:00:46.000Z', 'CAJERO', 'Pepe Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T17:00:46.000Z', '2024-11-25T18:00:46.000Z', 'CAJERO', 'Lucas Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T18:00:46.000Z', '2024-11-25T19:00:46.000Z', 'CAJERO', 'Lucas Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T19:00:46.000Z', '2024-11-25T20:00:46.000Z', 'CAJERO', 'Héctor Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T13:00:46.000Z', '2024-11-26T14:00:46.000Z', 'CAJERO', 'María Soso Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T15:00:46.000Z', '2024-11-26T16:00:46.000Z', 'CAJERO', 'Pepe Esteban Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T16:00:46.000Z', '2024-11-26T17:00:46.000Z', 'CAJERO', 'Héctor Lucas Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T18:00:46.000Z', '2024-11-26T19:00:46.000Z', 'CAJERO', 'Esteban Quiroga Soso Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T19:00:46.000Z', '2024-11-26T20:00:46.000Z', 'CAJERO', 'Pepe María Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T14:00:46.000Z', '2024-11-20T15:00:46.000Z', 'ATENCION_AL_CLIENTE', 'María Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T17:00:46.000Z', '2024-11-20T18:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Esteban Quiroga Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T19:00:46.000Z', '2024-11-20T20:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T16:00:46.000Z', '2024-11-21T17:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Lucas Poncho Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T17:00:46.000Z', '2024-11-21T18:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Héctor Sofía Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T13:00:46.000Z', '2024-11-22T14:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Esteban García Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T18:00:46.000Z', '2024-11-22T19:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Soso Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T14:00:46.000Z', '2024-11-23T15:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T18:00:46.000Z', '2024-11-23T19:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Perez Poncho Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T19:00:46.000Z', '2024-11-23T20:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Román María Perez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T17:00:46.000Z', '2024-11-24T18:00:46.000Z', 'ATENCION_AL_CLIENTE', 'María Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T19:00:46.000Z', '2024-11-24T20:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Román García Quiroga Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T15:00:46.000Z', '2024-11-25T16:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T18:00:46.000Z', '2024-11-25T19:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Esteban Quiroga Soso Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T14:00:46.000Z', '2024-11-26T15:00:46.000Z', 'ATENCION_AL_CLIENTE', 'María Sanchez Soso García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T17:00:46.000Z', '2024-11-26T18:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Pepe Esteban Lucas García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T19:00:46.000Z', '2024-11-26T20:00:46.000Z', 'ATENCION_AL_CLIENTE', 'Román Pepe García Sanchez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T15:00:46.000Z', '2024-11-20T16:00:46.000Z', 'OPERACION', 'Pepe Marquez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T16:00:46.000Z', '2024-11-20T17:00:46.000Z', 'OPERACION', 'Sofía Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T18:00:46.000Z', '2024-11-20T19:00:46.000Z', 'OPERACION', 'Pepe Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T19:00:46.000Z', '2024-11-20T20:00:46.000Z', 'OPERACION', 'Lucas García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T15:00:46.000Z', '2024-11-21T16:00:46.000Z', 'OPERACION', 'Sofía Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T16:00:46.000Z', '2024-11-21T17:00:46.000Z', 'OPERACION', 'María Pepe Lucas Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T19:00:46.000Z', '2024-11-21T20:00:46.000Z', 'OPERACION', 'Pepe Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T15:00:46.000Z', '2024-11-22T16:00:46.000Z', 'OPERACION', 'Román María Lucas Sanchez Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T16:00:46.000Z', '2024-11-22T17:00:46.000Z', 'OPERACION', 'Román García Perez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T19:00:46.000Z', '2024-11-22T20:00:46.000Z', 'OPERACION', 'Héctor Pepe María Poncho Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T13:00:46.000Z', '2024-11-23T14:00:46.000Z', 'OPERACION', 'Sofía Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T16:00:46.000Z', '2024-11-23T17:00:46.000Z', 'OPERACION', 'Héctor Marquez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T18:00:46.000Z', '2024-11-23T19:00:46.000Z', 'OPERACION', 'Esteban Héctor Pepe García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T13:00:46.000Z', '2024-11-24T14:00:46.000Z', 'OPERACION', 'Pepe Sofía Héctor Soso Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T14:00:46.000Z', '2024-11-24T15:00:46.000Z', 'OPERACION', 'Sofía Román Marquez Soso Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T15:00:46.000Z', '2024-11-24T16:00:46.000Z', 'OPERACION', 'Pepe Héctor García Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T16:00:46.000Z', '2024-11-24T17:00:46.000Z', 'OPERACION', 'Sofía Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T18:00:46.000Z', '2024-11-24T19:00:46.000Z', 'OPERACION', 'Pepe García Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T13:00:46.000Z', '2024-11-25T14:00:46.000Z', 'OPERACION', 'Sofía Román Perez Soso Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T16:00:46.000Z', '2024-11-25T17:00:46.000Z', 'OPERACION', 'Lucas María Sanchez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T13:00:46.000Z', '2024-11-26T14:00:46.000Z', 'OPERACION', 'Sofía Héctor Esteban Soso García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T14:00:46.000Z', '2024-11-26T15:00:46.000Z', 'OPERACION', 'Héctor Sofía Lucas Perez Marquez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T15:00:46.000Z', '2024-11-26T16:00:46.000Z', 'OPERACION', 'María García Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T18:00:46.000Z', '2024-11-26T19:00:46.000Z', 'OPERACION', 'María Román Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T19:00:46.000Z', '2024-11-26T20:00:46.000Z', 'OPERACION', 'Lucas María Poncho Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T13:00:46.000Z', '2024-11-20T14:00:46.000Z', 'BAJA_CUENTA', 'Héctor Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T14:00:46.000Z', '2024-11-20T15:00:46.000Z', 'BAJA_CUENTA', 'Román García Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T15:00:46.000Z', '2024-11-20T16:00:46.000Z', 'BAJA_CUENTA', 'María Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-20T17:00:46.000Z', '2024-11-20T18:00:46.000Z', 'BAJA_CUENTA', 'Lucas Sofía Perez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T14:00:46.000Z', '2024-11-21T15:00:46.000Z', 'BAJA_CUENTA', 'Lucas Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T16:00:46.000Z', '2024-11-21T17:00:46.000Z', 'BAJA_CUENTA', 'Sofía Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-21T19:00:46.000Z', '2024-11-21T20:00:46.000Z', 'BAJA_CUENTA', 'María Pepe Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T16:00:46.000Z', '2024-11-22T17:00:46.000Z', 'BAJA_CUENTA', 'Héctor Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T17:00:46.000Z', '2024-11-22T18:00:46.000Z', 'BAJA_CUENTA', 'Héctor Sofía García Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-22T18:00:46.000Z', '2024-11-22T19:00:46.000Z', 'BAJA_CUENTA', 'María Esteban Pepe Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T13:00:46.000Z', '2024-11-23T14:00:46.000Z', 'BAJA_CUENTA', 'María Román Lucas García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T16:00:46.000Z', '2024-11-23T17:00:46.000Z', 'BAJA_CUENTA', 'Héctor María Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T17:00:46.000Z', '2024-11-23T18:00:46.000Z', 'BAJA_CUENTA', 'Lucas Soso Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-23T18:00:46.000Z', '2024-11-23T19:00:46.000Z', 'BAJA_CUENTA', 'María Marquez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T13:00:46.000Z', '2024-11-24T14:00:46.000Z', 'BAJA_CUENTA', 'María Héctor Poncho Soso Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T17:00:46.000Z', '2024-11-24T18:00:46.000Z', 'BAJA_CUENTA', 'Pepe Soso García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T18:00:46.000Z', '2024-11-24T19:00:46.000Z', 'BAJA_CUENTA', 'Pepe Poncho Quiroga García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-24T19:00:46.000Z', '2024-11-24T20:00:46.000Z', 'BAJA_CUENTA', 'Román Pepe Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T15:00:46.000Z', '2024-11-25T16:00:46.000Z', 'BAJA_CUENTA', 'Héctor Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T18:00:46.000Z', '2024-11-25T19:00:46.000Z', 'BAJA_CUENTA', 'María Héctor Quiroga Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-25T19:00:46.000Z', '2024-11-25T20:00:46.000Z', 'BAJA_CUENTA', 'Sofía García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T14:00:46.000Z', '2024-11-26T15:00:46.000Z', 'BAJA_CUENTA', 'Pepe María Soso Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-11-26T19:00:46.000Z', '2024-11-26T20:00:46.000Z', 'BAJA_CUENTA', 'Pepe Esteban Perez', @creatorId);


-- Settings
insert into settings (setting_key, value) values ('OPENING_HOUR', 9), ('CLOSING_HOUR', 18), ('MAX_DURATION', 60)


