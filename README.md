# Evalua Mi Materia
Antes: _AppEncuestadoraCreatividad_

Aplicación creada como proyecto de la materia Creatividad e Innovación en la Ingeniería, curso 5K1, año 2017

- [Manual de usuario](Evalua_Mi_Materia-Manual_De_Usuario.pdf)

## Requisitos

  - PHP
  - Apache server
  - MySql
  - (se recomienda instalar XAMPP que incluye todo lo anterior)
  - NodeJS (>= 6.0.0) + npm (>= 3.0.0)

## Para levantar la aplicación

### Clonar el repositorio
`git clone https://github.com/ignaguri/EvaluaMiMateria.git` en la carpeta `htdocs` del servidor Apache 

### Configurar base de datos
Se debe crear una base de datos MySQL utilizando la estructura que se encuentra en la carpeta `modelo BD` y configurar las credenciales al final del archivo `api.php`

### Encender motor de base de datos
Tener el motor de MySQL iniciado y corriendo

### Encender servidor
Tener el servidor Apache iniciado y corriendo

### Instalar dependencias
`npm install`
### Levantar en localhost:8080 con hot-reload
`npm start`
### Buildear para producción (static web page)
`npm run build`