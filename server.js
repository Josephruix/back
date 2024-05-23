const express = require('express')
const mysql = require("mysql")
const bodyParser = require('body-parser')
const cors = require('cors')
const multer = require('multer')


const app = express()

let conexion = mysql.createConnection({
    host: "localhost",
    database: "proyecto",
    user: "root",
    password: ""
})

app.use(cors());
app.use(bodyParser.json())
const storage=multer.memoryStorage();
const upload=multer({storage:storage});

app.post("/guardar-datos", function (req, res) {
    const datos = req.body;

    const nombre = datos.nombre;
    const Contrasena = datos.Contrasena;
    const Correo = datos.Correo;
    const Rol = datos.Rol;

    // Verificar si el correo ya está registrado
    conexion.query(
        `SELECT * FROM usuarios WHERE Correo = ?`,
        [Correo],
        function (error, resultados) {
            if (error) {
                console.error('Error en la consulta:', error);
                return res.status(500).json({
                    mensaje: 'Error en la consulta a la base de datos'
                });
            } else {
                if (resultados.length > 0) {
                    return res.status(400).json({
                        mensaje: "El usuario ya existe"
                    });
                } else {
                    let insertar = `INSERT INTO usuarios (Nombre, Correo, Contraseña, Rol) VALUES (?, ?, ?, ?)`;
                    conexion.query(insertar, [nombre, Correo, Contrasena, Rol], function (error) {
                        if (error) {
                            console.error('Error al insertar datos:', error);
                            return res.status(500).json({
                                mensaje: 'Error al insertar datos en la base de datos'
                            });
                        } else {
                            console.log("Datos almacenados");
                            res.json({
                                mensajeD: "Datos almacenados correctamente"
                            });
                        }
                    });
                }
            }
        }
    );
});



/*verificacion-usuario*/


app.post("/verificar-usuario", function (req, res) {
    const { usuario, Contrasena } = req.body;
    console.log({ usuario, Contrasena });
    

    conexion.query(
        `SELECT * FROM usuarios WHERE Correo = '${usuario}'`,
        function (error, resultados) {
            if (error) {
                console.error('Error en la consulta:', error);
                res.status(500).json({ mensaje: 'Error en la consulta a la base de datos' });
            } else {
                if (resultados.length > 0) {
                    if (resultados[0].Contraseña === Contrasena) {
                        res.json({ mensaje: "Inicio de sesión exitoso" });
                    } else {
                        res.status(401).json({ mensaje: "Contraseña incorrecta" });
                    }
                } else {
                    res.status(404).json({ mensaje: "Usuario no encontrado" });
                }
            }
        }
    );
});



/* Guardar datos de equipos*/
app.post('/G-Equipos', upload.single('imagen'), function(req, res) {
    const datos = req.body;
    const { Marca, Descripcion, Estado, Empresa, Equipo, Sala, serial } = datos;
    const img = req.file ? req.file.buffer : null;

    conexion.query('SELECT idsalas FROM salas WHERE Nombre = ?', [Sala], function(error, resultados) {
        if (error) {
            throw error;
        }
        if (resultados.length > 0) {
            const idSala = resultados[0].idsalas;

            let insertar = 'INSERT INTO equipos (idEquipos, Marca, Descripcion, Estado, Empresa, Tipo_de_Equipo, fkidsalas, Serial, img) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';
            conexion.query(insertar, [serial, Marca, Descripcion, Estado, Empresa, Equipo, idSala, serial, img], function(error) {
                if (error) {
                    throw error;
                }
                console.log('Datos del equipo almacenados correctamente');
                res.json({ mensaje: 'Datos del equipo almacenados correctamente' });
            });
        } else {
            res.status(404).json({ mensaje: 'No se encontró la sala especificada' });
        }
    });
});

/* Guardar datos de salas */
app.post('/G-Salas', function (req, res) {
    const {
        Nombre,
        Ubicacion,
        PuertosR,
        CapacidadE,
        SalaE
    } = req.body;

    console.log(req.body);

    const sqlQuery = 'INSERT INTO salas (Nombre, ubicacion, `N-PR`, Capacidad_de_Equipos, `Equipos-en-sala`) VALUES (?, ?, ?, ?, ?)';

    conexion.query(sqlQuery, [Nombre, Ubicacion, PuertosR, CapacidadE, SalaE], function (error, results) {
        if (error) {
            console.error('Error al insertar datos en la base de datos:', error);
            return res.status(500).json({
                mensaje: 'Error al guardar los datos en la base de datos'
            });
        } else {
            console.log('Datos de la sala almacenados correctamente en la base de datos');
            res.json({
                mensaje: 'Datos de la sala almacenados correctamente'
            });
        }
    });
});

//Informacion Salas
app.get('/Salas', (req, res) => {
    conexion.query('SELECT * FROM salas', (error, resultados) => {
        if (error) {
            console.error('Error al obtener información de los equipos:', error);
            // res.status(500).json({ error: 'Error al obtener información de los equipos' });
            throw error
            /*return;*/

        } else {
            res.json(resultados);
            console.log(resultados)
        }

    });
});
//relacion de equipos y salas
app.get('/consulta/:sala', (req, res) => {
    const sala = req.params.sala;
    console.log('Sala parameter received:', sala);
    
    const query = `
        SELECT salas.Nombre, equipos.* 
        FROM salas 
        JOIN equipos ON salas.idsalas = equipos.fkidsalas 
        WHERE salas.Nombre = ?;
    `;
    conexion.query(query, [sala], (error, resultados) => {
        if (error) {
            console.error('Error en la consulta:', error);
            res.status(500).send('Error en la consulta');
            return;
        }else{
            resultados.forEach(resultado => {
                if (resultado.img) {
                    console.log(resultado.img)
                    resultado.img=resultado.img.toString("base64")
                    
                } else {
                    resultado.img= null;
                }
                
            });
            console.log('Query resultados:', resultados);
            res.json(resultados);
        }
       
    });
});
/*Guardar eventos*/
app.post('/G-Eventos', (req, res) => {
    const datos = req.body;
    const FechaE = datos.FechaE;
    const Descripcion = datos.Descripcion;

   

    const query = 'INSERT INTO eventos (fecha, descripcion) VALUES (?, ?)';

    conexion.query(query, [FechaE, Descripcion], (error, resultados) => {
        if (error) {
            console.error('Error al enviar información del evento:', error);
            res.status(500).json({ mensaje: 'Error al guardar los datos en la base de datos' });
            return;
        } else {
            console.log('Datos del evento almacenados correctamente en la base de datos');
            res.json({ mensaje: 'Datos del evento almacenados correctamente' });
        }
    });
});
/* Mover equipos */
app.post('/mover-equipo', (req, res) => {
    const { equipoId, nuevaSala } = req.body;

    conexion.query('SELECT idsalas FROM salas WHERE Nombre = ?', [nuevaSala], (error, resultados) => {
        if (error) {
            console.error('Error en la consulta:', error);
            res.status(500).json({ mensaje: 'Error en la consulta a la base de datos' });
            return;
        }

        if (resultados.length > 0) {
            const nuevaSalaId = resultados[0].idsalas;

            conexion.query('UPDATE equipos SET fkidsalas = ? WHERE serial = ?', [nuevaSalaId, equipoId], (error) => {
                if (error) {
                    console.error('Error al actualizar equipo:', error);
                    res.status(500).json({ mensaje: 'Error al actualizar equipo en la base de datos' });
                    return;
                }

                res.json({ mensaje: 'Equipo movido correctamente' });
            });
        } else {
            res.status(404).json({ mensaje: 'No se encontró la sala especificada' });
        }
    });
});


app.listen(3000, function () {
    console.log('Servidor escuchando en el puerto 3000');
});