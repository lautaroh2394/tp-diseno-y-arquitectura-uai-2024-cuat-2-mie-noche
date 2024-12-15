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
    values (60, '2024-12-11T14:00:53.000Z', '2024-12-11T15:00:53.000Z', 'TURNO_GENERAL', 'María Quiroga Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T15:00:53.000Z', '2024-12-11T16:00:53.000Z', 'TURNO_GENERAL', 'Román Sofía Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T16:00:53.000Z', '2024-12-11T17:00:53.000Z', 'TURNO_GENERAL', 'Román Lucas Marquez Poncho Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T17:00:53.000Z', '2024-12-11T18:00:53.000Z', 'TURNO_GENERAL', 'Sofía Román Sanchez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T18:00:53.000Z', '2024-12-11T19:00:53.000Z', 'TURNO_GENERAL', 'Esteban Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T17:00:53.000Z', '2024-12-12T18:00:53.000Z', 'TURNO_GENERAL', 'Pepe Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T19:00:53.000Z', '2024-12-12T20:00:53.000Z', 'TURNO_GENERAL', 'Esteban Sofía Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T13:00:53.000Z', '2024-12-13T14:00:53.000Z', 'TURNO_GENERAL', 'Román Sanchez García Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T15:00:53.000Z', '2024-12-13T16:00:53.000Z', 'TURNO_GENERAL', 'Esteban Lucas Perez Poncho García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T16:00:53.000Z', '2024-12-13T17:00:53.000Z', 'TURNO_GENERAL', 'Sofía Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T17:00:53.000Z', '2024-12-13T18:00:53.000Z', 'TURNO_GENERAL', 'Pepe Román Sanchez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T18:00:53.000Z', '2024-12-13T19:00:53.000Z', 'TURNO_GENERAL', 'Lucas María Román Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T13:00:53.000Z', '2024-12-14T14:00:53.000Z', 'TURNO_GENERAL', 'Esteban Sofía Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T15:00:53.000Z', '2024-12-14T16:00:53.000Z', 'TURNO_GENERAL', 'María Esteban Poncho Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T17:00:53.000Z', '2024-12-14T18:00:53.000Z', 'TURNO_GENERAL', 'Sofía Pepe Marquez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T15:00:53.000Z', '2024-12-15T16:00:53.000Z', 'TURNO_GENERAL', 'Sofía Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T16:00:53.000Z', '2024-12-15T17:00:53.000Z', 'TURNO_GENERAL', 'Román Pepe Soso Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T17:00:53.000Z', '2024-12-15T18:00:53.000Z', 'TURNO_GENERAL', 'Sofía Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T18:00:53.000Z', '2024-12-15T19:00:53.000Z', 'TURNO_GENERAL', 'Lucas Pepe Román Poncho Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T13:00:53.000Z', '2024-12-16T14:00:53.000Z', 'TURNO_GENERAL', 'Esteban Perez Marquez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T16:00:53.000Z', '2024-12-16T17:00:53.000Z', 'TURNO_GENERAL', 'Esteban Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T19:00:53.000Z', '2024-12-16T20:00:53.000Z', 'TURNO_GENERAL', 'Esteban Héctor García Perez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T13:00:53.000Z', '2024-12-17T14:00:53.000Z', 'TURNO_GENERAL', 'Sofía Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T15:00:53.000Z', '2024-12-17T16:00:53.000Z', 'TURNO_GENERAL', 'Sofía Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T16:00:53.000Z', '2024-12-17T17:00:53.000Z', 'TURNO_GENERAL', 'Lucas Pepe Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T17:00:53.000Z', '2024-12-17T18:00:53.000Z', 'TURNO_GENERAL', 'Héctor Lucas García Poncho Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T19:00:53.000Z', '2024-12-17T20:00:53.000Z', 'TURNO_GENERAL', 'Sofía María Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T13:00:53.000Z', '2024-12-11T14:00:53.000Z', 'CAJERO', 'Héctor Quiroga Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T14:00:53.000Z', '2024-12-11T15:00:53.000Z', 'CAJERO', 'Héctor Román María Sanchez Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T16:00:53.000Z', '2024-12-11T17:00:53.000Z', 'CAJERO', 'Pepe Héctor Esteban García Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T18:00:53.000Z', '2024-12-11T19:00:53.000Z', 'CAJERO', 'Sofía Lucas García Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T19:00:53.000Z', '2024-12-11T20:00:53.000Z', 'CAJERO', 'Román María Esteban Sanchez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T13:00:53.000Z', '2024-12-12T14:00:53.000Z', 'CAJERO', 'María Lucas García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T15:00:53.000Z', '2024-12-12T16:00:53.000Z', 'CAJERO', 'María Sanchez Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T16:00:53.000Z', '2024-12-12T17:00:53.000Z', 'CAJERO', 'Pepe María Quiroga García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T13:00:53.000Z', '2024-12-13T14:00:53.000Z', 'CAJERO', 'María Lucas Héctor García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T14:00:53.000Z', '2024-12-13T15:00:53.000Z', 'CAJERO', 'Esteban María Quiroga Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T15:00:53.000Z', '2024-12-13T16:00:53.000Z', 'CAJERO', 'Lucas Pepe Héctor Quiroga Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T17:00:53.000Z', '2024-12-13T18:00:53.000Z', 'CAJERO', 'Lucas Héctor María Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T19:00:53.000Z', '2024-12-14T20:00:53.000Z', 'CAJERO', 'Lucas Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T13:00:53.000Z', '2024-12-15T14:00:53.000Z', 'CAJERO', 'Héctor Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T15:00:53.000Z', '2024-12-15T16:00:53.000Z', 'CAJERO', 'Sofía Lucas Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T16:00:53.000Z', '2024-12-15T17:00:53.000Z', 'CAJERO', 'María Lucas Sofía Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T17:00:53.000Z', '2024-12-15T18:00:53.000Z', 'CAJERO', 'Román Esteban María Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T18:00:53.000Z', '2024-12-15T19:00:53.000Z', 'CAJERO', 'Sofía María Soso Sanchez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T13:00:53.000Z', '2024-12-16T14:00:53.000Z', 'CAJERO', 'Sofía Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T15:00:53.000Z', '2024-12-16T16:00:53.000Z', 'CAJERO', 'Román García Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T18:00:53.000Z', '2024-12-16T19:00:53.000Z', 'CAJERO', 'Lucas Pepe García Quiroga Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T19:00:53.000Z', '2024-12-16T20:00:53.000Z', 'CAJERO', 'Héctor Sanchez Soso Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T14:00:53.000Z', '2024-12-17T15:00:53.000Z', 'CAJERO', 'Héctor García Perez Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T16:00:53.000Z', '2024-12-17T17:00:53.000Z', 'CAJERO', 'Esteban Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T17:00:53.000Z', '2024-12-17T18:00:53.000Z', 'CAJERO', 'Esteban Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T19:00:53.000Z', '2024-12-17T20:00:53.000Z', 'CAJERO', 'Pepe Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T15:00:53.000Z', '2024-12-11T16:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Héctor María Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T17:00:53.000Z', '2024-12-11T18:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Pepe Poncho Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T13:00:53.000Z', '2024-12-12T14:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Pepe Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T14:00:53.000Z', '2024-12-12T15:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Román Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T16:00:53.000Z', '2024-12-12T17:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Sofía García Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T13:00:53.000Z', '2024-12-13T14:00:53.000Z', 'ATENCION_AL_CLIENTE', 'María Lucas Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T14:00:53.000Z', '2024-12-13T15:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Esteban Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T16:00:53.000Z', '2024-12-13T17:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Esteban Poncho Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T17:00:53.000Z', '2024-12-13T18:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Román Sofía Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T13:00:53.000Z', '2024-12-14T14:00:53.000Z', 'ATENCION_AL_CLIENTE', 'María Esteban Sofía Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T16:00:53.000Z', '2024-12-14T17:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Pepe Perez Poncho Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T18:00:53.000Z', '2024-12-14T19:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Román Sofía Lucas Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T19:00:53.000Z', '2024-12-14T20:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Soso Quiroga Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T16:00:53.000Z', '2024-12-15T17:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Sofía Román García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T18:00:53.000Z', '2024-12-15T19:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Esteban Perez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T19:00:53.000Z', '2024-12-15T20:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Lucas Sanchez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T13:00:53.000Z', '2024-12-16T14:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Román Sofía García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T14:00:53.000Z', '2024-12-16T15:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Pepe Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T15:00:53.000Z', '2024-12-16T16:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Román Sofía Marquez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T18:00:53.000Z', '2024-12-16T19:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Esteban Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T13:00:53.000Z', '2024-12-17T14:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Héctor Esteban Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T15:00:53.000Z', '2024-12-17T16:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Román Perez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T18:00:53.000Z', '2024-12-17T19:00:53.000Z', 'ATENCION_AL_CLIENTE', 'Sofía Esteban Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T13:00:53.000Z', '2024-12-11T14:00:53.000Z', 'OPERACION', 'Sofía María Sanchez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T14:00:53.000Z', '2024-12-11T15:00:53.000Z', 'OPERACION', 'Héctor María García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T15:00:53.000Z', '2024-12-11T16:00:53.000Z', 'OPERACION', 'Héctor Perez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T16:00:53.000Z', '2024-12-11T17:00:53.000Z', 'OPERACION', 'Román Poncho Marquez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T18:00:53.000Z', '2024-12-11T19:00:53.000Z', 'OPERACION', 'Román García Poncho Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T19:00:53.000Z', '2024-12-11T20:00:53.000Z', 'OPERACION', 'Román Poncho Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T13:00:53.000Z', '2024-12-12T14:00:53.000Z', 'OPERACION', 'Lucas Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T15:00:53.000Z', '2024-12-12T16:00:53.000Z', 'OPERACION', 'Sofía Román Lucas Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T16:00:53.000Z', '2024-12-12T17:00:53.000Z', 'OPERACION', 'María Pepe Marquez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T17:00:53.000Z', '2024-12-12T18:00:53.000Z', 'OPERACION', 'Sofía Pepe Soso Sanchez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T18:00:53.000Z', '2024-12-12T19:00:53.000Z', 'OPERACION', 'Sofía Soso Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T13:00:53.000Z', '2024-12-13T14:00:53.000Z', 'OPERACION', 'Lucas Marquez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T14:00:53.000Z', '2024-12-13T15:00:53.000Z', 'OPERACION', 'María Pepe Poncho Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T17:00:53.000Z', '2024-12-13T18:00:53.000Z', 'OPERACION', 'Pepe Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T19:00:53.000Z', '2024-12-13T20:00:53.000Z', 'OPERACION', 'Lucas Marquez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T14:00:53.000Z', '2024-12-14T15:00:53.000Z', 'OPERACION', 'Pepe María Héctor Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T16:00:53.000Z', '2024-12-14T17:00:53.000Z', 'OPERACION', 'Pepe Lucas Esteban García Perez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T18:00:53.000Z', '2024-12-14T19:00:53.000Z', 'OPERACION', 'Héctor Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T19:00:53.000Z', '2024-12-14T20:00:53.000Z', 'OPERACION', 'Lucas Perez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T13:00:53.000Z', '2024-12-15T14:00:53.000Z', 'OPERACION', 'María Sofía Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T17:00:53.000Z', '2024-12-15T18:00:53.000Z', 'OPERACION', 'Román Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T18:00:53.000Z', '2024-12-15T19:00:53.000Z', 'OPERACION', 'Esteban Pepe Sofía Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T19:00:53.000Z', '2024-12-15T20:00:53.000Z', 'OPERACION', 'Román Lucas Héctor García Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T13:00:53.000Z', '2024-12-16T14:00:53.000Z', 'OPERACION', 'Esteban Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T16:00:53.000Z', '2024-12-16T17:00:53.000Z', 'OPERACION', 'Román Sofía Perez Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T18:00:53.000Z', '2024-12-16T19:00:53.000Z', 'OPERACION', 'Héctor Poncho Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T16:00:53.000Z', '2024-12-17T17:00:53.000Z', 'OPERACION', 'Pepe García Perez Poncho', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-17T19:00:53.000Z', '2024-12-17T20:00:53.000Z', 'OPERACION', 'Héctor Quiroga Marquez Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T15:00:53.000Z', '2024-12-11T16:00:53.000Z', 'BAJA_CUENTA', 'Lucas María Esteban Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T17:00:53.000Z', '2024-12-11T18:00:53.000Z', 'BAJA_CUENTA', 'Pepe Héctor Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-11T19:00:53.000Z', '2024-12-11T20:00:53.000Z', 'BAJA_CUENTA', 'María Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T14:00:53.000Z', '2024-12-12T15:00:53.000Z', 'BAJA_CUENTA', 'Esteban Román Lucas Perez García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T16:00:53.000Z', '2024-12-12T17:00:53.000Z', 'BAJA_CUENTA', 'Héctor Soso Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-12T19:00:53.000Z', '2024-12-12T20:00:53.000Z', 'BAJA_CUENTA', 'Román Perez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T14:00:53.000Z', '2024-12-13T15:00:53.000Z', 'BAJA_CUENTA', 'María Lucas Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T17:00:53.000Z', '2024-12-13T18:00:53.000Z', 'BAJA_CUENTA', 'Sofía García Sanchez Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-13T19:00:53.000Z', '2024-12-13T20:00:53.000Z', 'BAJA_CUENTA', 'Sofía Quiroga', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T14:00:53.000Z', '2024-12-14T15:00:53.000Z', 'BAJA_CUENTA', 'Román Sofía Poncho Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-14T17:00:53.000Z', '2024-12-14T18:00:53.000Z', 'BAJA_CUENTA', 'Pepe Román Quiroga Poncho García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T13:00:53.000Z', '2024-12-15T14:00:53.000Z', 'BAJA_CUENTA', 'Sofía Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T17:00:53.000Z', '2024-12-15T18:00:53.000Z', 'BAJA_CUENTA', 'Sofía Marquez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-15T18:00:53.000Z', '2024-12-15T19:00:53.000Z', 'BAJA_CUENTA', 'Román Soso', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T15:00:53.000Z', '2024-12-16T16:00:53.000Z', 'BAJA_CUENTA', 'Esteban Sanchez', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T16:00:53.000Z', '2024-12-16T17:00:53.000Z', 'BAJA_CUENTA', 'Román García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T18:00:53.000Z', '2024-12-16T19:00:53.000Z', 'BAJA_CUENTA', 'María Sofía Lucas García', @creatorId);
insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (60, '2024-12-16T19:00:53.000Z', '2024-12-16T20:00:53.000Z', 'BAJA_CUENTA', 'Sofía Sanchez', @creatorId);


-- Settings
insert into settings (setting_key, value) values ('OPENING_HOUR', 9), ('CLOSING_HOUR', 18), ('MAX_DURATION', 60)


