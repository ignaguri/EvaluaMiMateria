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
        $query = "SELECT idRol
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
                $stmt->bind_result($idRol);
                $stmt->fetch();
                $stmt->free_result();
            } else {
                print_r($this->conn->error);
                return false;
            }

            $stmt->close();
            $this->conn->close();

            return $idRol;
        } catch (Exception $e) {
            $this->conn->close();
            return null;
        }

    }
}
