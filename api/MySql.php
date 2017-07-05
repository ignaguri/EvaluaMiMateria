<?php
require_once 'constants.php';

class Mysql
{
    private $conn;

    function __construct()
    {
        try {
            $this->conn = new mysqli(DB_SERVER, DB_USER, DB_PASSWORD, DB_NAME);
        } catch (Exception $e) {
            echo 'Error: ', $e->getMessage();
        }
    }

    function verify_login($legajo, $pwd)
    {
        $query = "SELECT legajo, nombre, apellido, mail, id_rol
				FROM Usuario u
				WHERE u.legajo = ?
				AND u.contrasena = ?
				LIMIT 1";

        try {

            if (!$stmt = $this->conn->prepare($query)) {
                print_r($this->conn->error);
                return false;
            }

            $stmt->bind_param('is', $legajo, $pwd);

            if ($stmt->execute()) {
                $stmt->store_result();
                $stmt->bind_result($leg, $nom, $ape, $mail, $idRol);
                $stmt->fetch();
                $stmt->free_result();
                $salida = array(
                    "legajo" => $leg,
                    "nombre" => $nom,
                    "apellido" => $ape,
                    "mail" => $mail,
                    "idRol" => $idRol);
            } else {
                print_r($this->conn->error);
                return false;
            }

            $stmt->close();
            $this->conn->close();

            return $salida;
        } catch (Exception $e) {
            $this->conn->close();
            return false;
        }

    }

    function insert_usuario($usuario){
        $query = "INSERT INTO usuario (`id_rol`,`legajo`,`nombre`,`apellido`,`mail`,`contrasena`)
                  VALUES(?,?,?,?,?,?);";

        try {

            if (!$stmt = $this->conn->prepare($query)) {
                print_r($this->conn->error);
                return false;
            }

            $stmt->bind_param('iissss', $usuario['idRol'],$usuario['legajo'],$usuario['nombre'],$usuario['apellido'],$usuario['email'],$usuario['contrasena']);

            if (!$stmt->execute() || $stmt->affected_rows < 1) {
                print_r($this->conn->error);
                return false;
            }
            $stmt->close();
            $this->conn->close();

            return true;

        } catch (Exception $e) {
            $this->conn->close();
            return false;
        }
    }

    function obtener_usuario($legajo){
        $query = "SELECT legajo, nombre, apellido, mail, id_rol
				FROM Usuario u
				WHERE u.legajo = ?
				LIMIT 1";

        try {

            if (!$stmt = $this->conn->prepare($query)) {
                print_r($this->conn->error);
                return false;
            }

            $stmt->bind_param('i', $legajo);

            if ($stmt->execute()) {
                $stmt->store_result();
                $stmt->bind_result($leg, $nom, $ape, $mail, $idRol);
                $stmt->fetch();
                $stmt->free_result();
                $salida = array(
                    "legajo" => $leg,
                    "nombre" => $nom,
                    "apellido" => $ape,
                    "mail" => $mail,
                    "idRol" => $idRol);
            } else {
                print_r($this->conn->error);
                return false;
            }

            $stmt->close();
            $this->conn->close();

            return $salida;
        } catch (Exception $e) {
            $this->conn->close();
            return false;
        }

    }

    function update_usuario($usuario){
        //no se puede cambiar el legajo
        $query = "UPDATE usuario
                  SET `id_rol` = ?,
                  `nombre` = ?,
                  `apellido` = ?,
                  `mail` = ?,
                  `contrasena` = ?
                  WHERE legajo = ?";

        try {

            if (!$stmt = $this->conn->prepare($query)) {
                print_r($this->conn->error);
                return false;
            }

            $stmt->bind_param('issssi', $usuario['idRol'],$usuario['nombre'],$usuario['apellido'],$usuario['email'],$usuario['contrasena'],$usuario['legajo']);

            if (!$stmt->execute() || $stmt->affected_rows < 1) {
                print_r($this->conn->error);
                return false;
            }
            $stmt->close();
            $this->conn->close();

            return true;

        } catch (Exception $e) {
            $this->conn->close();
            return false;
        }
    }

    function borrar_usuario($legajo){
        $query = "DELETE FROM Usuario WHERE legajo = ?";

        try {

            if (!$stmt = $this->conn->prepare($query)) {
                print_r($this->conn->error);
                return false;
            }

            $stmt->bind_param('i', $legajo);

            if ($stmt->execute()) {
                $stmt->close();
                $this->conn->close();
                return true;
            } else {
                print_r($this->conn->error);
                return false;
            }
        } catch (Exception $e) {
            $this->conn->close();
            return false;
        }
    }
}
