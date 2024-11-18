const fs = require('node:fs');
const { createHash } = require('crypto');

const FILE_NAME = `populate-reservations-db-${Date.parse(new Date())}.sql`
let script = ''

const getRandomId = () => crypto.randomUUID().substring(0,10)

const getRandomClient = () => {
    const NAMES = ["Pepe", "Román", "Esteban", "Sofía", "Lucas", "María", "Héctor"]
    const LAST_NAMES = ["García", "Perez", "Poncho", "Soso", "Quiroga", "Sanchez", "Marquez"]

    const amountOfNames = Math.floor((Math.random() * 10) % 3) + 1
    const amountOfLastNames = Math.floor((Math.random() * 10) % 3) + 1

    const names = Array.from(new Set((new Array(amountOfNames)).fill(null).map(_ => {
        const i = Math.floor(Math.random() * NAMES.length)
        return NAMES[i]
    }))).join(' ')

    const lastNames = Array.from(new Set((new Array(amountOfLastNames)).fill(null).map((_) => {
        const i = Math.floor(Math.random() * LAST_NAMES.length)
        return LAST_NAMES[i]
    }))).join(' ')
    
    return `${names} ${lastNames}`
}

const hashSHA256 = (content)=> {
  return createHash('sha256').update(content).digest('hex');
}

const addToScript = (content) => {
    try {
        fs.appendFileSync(FILE_NAME, content + '\n', { flag: 'a+'})
    }
    catch (e) { console.log('error: ', e); throw e}
}

const insertCategory = (id, name, show_name) => {
    const content = `insert into categories (id, name, show_name) values ('${id}', '${name}', '${show_name}');`
    return addToScript(content)
}

const CATEGORIES = [
    ["TURNO_GENERAL", "Turno general"],
    ["CAJERO", "Cajero"],
    ["ATENCION_AL_CLIENTE", "Atención al cliente"],
    ["OPERACION", "Operación"],
    ["BAJA_CUENTA", "Baja de cuenta"],
]

const generateCategories = async () => {
    console.log('Generating categories...')
    addToScript('-- Categories')
    CATEGORIES.map(([name, show_name]) => insertCategory(name, name, show_name))
    console.log(`Categories generated (${CATEGORIES.length})`)
    addToScript('\n')
}

const insertPermission = (name, show_name) => {
    const content = `insert into permissions (id, name, show_name) values ('${name}', '${name}', '${show_name}');`
    return addToScript(content)
}

const generatePermissions = async () => {
    console.log('Generating permissions...')
    addToScript('-- Permissions')
    const permissions = [
        ["BUSQUEDA", "Búsqueda"],
        ["RESERVA", "Reserva"],
        ["CREAR_USUARIO", "Crear usuario"],
        ["EDITAR_USUARIO", "Editar usuario"],
        ["VER_USUARIOS", "Ver usuarios"],
    ]

    permissions.map(([name, show_name]) => insertPermission(name, show_name))
    console.log(`Permissions generated (${permissions.length})`)
    addToScript('\n')
}

const createUser = (username, permissions) => {
    const content = `INSERT INTO @permissions (id) values ${permissions.map(p => `('${p}')`).join(',')};
    exec create_user @username = '${username}', @hashed_password = '${hashSHA256(username)}', @permissions_list = @permissions;
    DELETE FROM @permissions;`;
    addToScript(content)
}

const generateUsers = async () => {
    console.log('Generating users...')
    addToScript('-- Users')
    const users = [
        // usuario, permisos. se va a usar el usuario como contraseña
        ["buscador", ["BUSQUEDA"]],
        ["reservador", ["RESERVA"]],
        ["creador", ["CREAR_USUARIO"]],
        ["editor", ["EDITAR_USUARIO"]],
        ["visor", ["VER_USUARIOS"]],
        ["recepcionista", ["BUSQUEDA", "RESERVA"]],
        ["admin", ["BUSQUEDA", "RESERVA", "CREAR_USUARIO", "EDITAR_USUARIO", "VER_USUARIOS"]],
    ]
    addToScript('DECLARE @permissions PermissionsListType;')
    users.map(([name, permissions]) => createUser(name, permissions))
    console.log(`Users generated (${users.length})`)
    addToScript('\n')
}

const insertReservation = (
    duration,
    startDate,
    endDate,
    categoryId,
    clientName
    )=>{
    const content = `insert into reservations (duration, start_date, end_date, category_id, client_name, created_by) 
    values (${duration}, '${startDate}', '${endDate}', '${categoryId}', '${clientName}', @creatorId);`
    return addToScript(content)
}

const generateReservations = () => {
    /* 
        generar inserts (sin usar el sp) creando turnos para cada categoria para la prox semana.
        se crean turnos de 1h (60m), 50% de probabilidad de que a la prox hora haya turno
    */
    console.log('Generating reservations...')
    addToScript('-- Reservations')
    addToScript('declare @creatorId int')
    addToScript("set @creatorId = (select top 1 id from users where username = 'reservador')")
    const today = new Date();
    const getStartDate = (hour, offset = 0) => {
        let d = new Date(Date.parse(today))
        d.setHours(hour)
        d.setMinutes(0)
        d.setDate(today.getDate() + offset)
        return d.toISOString()
    }
    const getEndDate = (hour, offset = 0, duration = 1) => {
        return getStartDate(hour + duration, offset)
    }
    const openingHours = 10
    const closingHours = 17
    let total = 0;

    CATEGORIES.map(([id, _]) => {
        for (let offset = 0; offset < 7; offset++){
            let h = openingHours;
            while (h<closingHours){
                const shouldCreate = Math.floor((Math.random() * 2) ) == 1
                if (shouldCreate)
                    insertReservation(
                        60,
                        getStartDate(h, offset),
                        getEndDate(h, offset),
                        id,
                        getRandomClient()
                    )
                    total++
                h++
            }
        }
    })
    console.log(`Reservations generated (${total})`)
    addToScript('\n')
}

const generateDeleteAll = ()=>{
    console.log('Generating deletion of previous data...')
    addToScript('-- Delete previous data')
    addToScript('delete from reservations;')
    addToScript('delete from permissions_per_user;')
    addToScript('delete from users;')
    addToScript('delete from permissions;')
    addToScript('delete from categories;')
    addToScript('delete from settings;')
    addToScript('\n')
}

const generateSettings = ()=>{
    console.log('Generating settings...')
    addToScript('-- Settings')
    addToScript("insert into settings (setting_key, value) values ('OPENING_HOUR', 9), ('CLOSING_HOUR', 18), ('MAX_DURATION', 60)")
    console.log(`Settings generated (3)`)
    addToScript('\n')
}

function generate(){
    generateDeleteAll()
    generateCategories()
    generatePermissions()
    generateUsers()
    generateReservations()
    generateSettings()
}

generate();