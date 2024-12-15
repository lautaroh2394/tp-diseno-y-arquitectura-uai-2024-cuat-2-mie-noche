const Service = require('node-windows').Service;
const service = new Service({
    name: "UAI TP Web server",
    description: "Web server for reservations",
    script: "D:\\Users\\Lau\\Documents\\Facu\\UAI\\Diseño y arquitectura\\TP 2024\\web-server\\index.js"
})

service.on("uninstall", ()=>{
    console.log('uninstalled!')
})

service.uninstall();