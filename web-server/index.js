const http = require('http');
const sql = require('mssql/msnodesqlv8');
const url = require('url');


var config = {
    server : "WINDOWS-J8OE48L\\SQLEXPRESS",
    //user:"WINDOWS-J8OE48L\\lau", 
    user: "webserver",
    password: "webserver",
    database: "sistema_turnos",
     options :{
       trustedConnection:true,
     },
    driver:"msnodesqlv8",
}

const getReservation = (id)=> {
    return new Promise((res) => {
        sql.connect(config, function(err){
            if(err) console.log(err)
            const request = new sql.Request();
            const query = `select top 1 * from reservations where id = ${id};`;
            request.query(query, function(err, records){
                if(err) console.log(err);
                else {
                   res(records.recordset[0])
                }
            })
        })
    })
}


http.createServer(async function (req, res) {
    const path = url.parse(req.url).path.split("/").filter(e => !!e);
    const apiMethod = path[0]
    const id = path[1]
    console.log(apiMethod, id)
    let response = "No se pudo encontrar la página";
    let status = 404;
    if (apiMethod == "reservations" && !!id && !isNaN(id)){
        const r = await getReservation(id);
        if (r){
            response = reservationModal(r);
            status = 200;
        }
    }
    res.writeHead(200, {"Content-Type": "text/html; charset=utf-8"})
    res.write(response,"utf-8");
    res.statusCode = status
    res.end();
}).listen(8080);

const reservationModal = ({duration, id, client_name, start_date, end_date, category_id}) => {
    return `<!DOCTYPE html>
    <html>
        <head>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"></link>
            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        </head>
        <body>
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Reserva ${id} de ${client_name.trim()}</h5>
                    </div>
                    <div class="modal-body">
                        <p>Fecha: ${new Date(start_date).toLocaleString().substring(0,17)}</p>
                        <p>Duración: ${duration} minutos</p>
                        <p>Motivo: ${category_id}</p>
                    </div>
                    <div class="modal-footer">
                        <button id="button" type="button" class="btn btn-primary">Imprimir</button>
                    </div>
                </div>
            </div>
            <script>
                button.addEventListener("click", ()=> {
                    button.style.display = "none"
                    print();
                    button.style.display = ""
                })
            </script>
        </body>
    </html>`
}