const express = require("express")
const sql = require("mssql")
const cors = require("cors")

const app = express()

app.use(express.json())
app.use(cors())

const config = {
    user: "sa",
    password: "23400584",
    server: "LAPTOP-B5RLRR5O\\NOLASCO1",
    database: "ZervePOS",
    options: {
        encrypt: false,
        trustServerCertificate: true
    }
}

// Inicio de sesión
app.post("/login", async (req,res)=>{

    const {EmpleadoID,contraseña} = req.body

    try{

        await sql.connect(config)

        const result = await sql.query`
        SELECT * FROM empleados
        WHERE EmpleadoID = ${parseInt(EmpleadoID)}
        AND contrsena = ${contraseña}
        `

        if(result.recordset.length > 0){
            res.json({success:true})
        }else{
            res.json({success:false})
        }

    }catch(err){
        console.log(err)
        res.json({success:false})
    }

})

// Crear nuevo usuario
app.post("/crearUsuario", async (req, res) => {
    const {
        nombre, apellidos, fechaNacimiento,
        ciudad, codigoPostal, domicilio,
        telefono, rol, usuario, contrasena
    } = req.body;

    try {
        await sql.connect(config);
        await sql.query`
            INSERT INTO empleados 
            (Nombre, Apellidos, FechaNacimiento, Ciudad, CodigoPostal, Direccion, Telefono, Rol, Usuario, contrsena)
            VALUES 
            (${nombre}, ${apellidos}, ${new Date(fechaNacimiento)}, ${ciudad}, ${parseInt(codigoPostal)}, ${domicilio}, ${telefono}, ${rol}, ${usuario}, ${contrasena})
        `;
        res.json({ success: true, message: "Usuario creado correctamente" });
    } catch (err) {
        console.log(err);
        res.json({ success: false, message: "Error al crear el usuario" });
    }
});

app.listen(3000,()=>{
    console.log("Servidor corriendo en puerto 3000")
})