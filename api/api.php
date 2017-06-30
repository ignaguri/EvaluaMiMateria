<?php
require_once("Rest.inc.php");
require_once("constants.php");
require_once("MySql.php");

class API extends REST
{

    public $data = "";

    //const DB_SERVER = "127.0.0.1";
    //const DB_USER = "root";
    //const DB_PASSWORD = "";
    //const DB = "angularcode_customer";

    private $db = NULL;
    private $mysqli = NULL;

    public function __construct()
    {
        parent::__construct();                // Init parent contructor
        //$this->dbConnect();					// Initiate Database connection
    }

    /*
     *  Connect to Database
    *
    private function dbConnect(){
        $this->mysqli = new mysqli(DB_SERVER, DB_USER, DB_PASSWORD, DB_NAME);
    }
*/
    /*
     * Dynmically call the method based on the query string
     */
    public function processApi()
    {
        $func = strtolower(trim(str_replace("/", "", $_REQUEST['x'])));
        if ((int)method_exists($this, $func) > 0)
            $this->$func();
        else
            $this->response('', 404); // If the method not exist with in this class "Page not found".
    }

    private function prueba()
    {
        /*  $js = array(
              'prueba' => 'probando',
              'anda?' => true
          );
          $this->response($this->json($js), 200);*/
        $payload = $this->getPayload();
        print_r(($payload));
    }

    /* EJEMPLOS
    private function customers(){
        if($this->get_request_method() != "GET"){
            $this->response('',406);
        }
        $query="SELECT distinct c.customerNumber, c.customerName, c.email, c.address, c.city, c.state, c.postalCode, c.country FROM angularcode_customers c order by c.customerNumber desc";
        $r = $this->mysqli->query($query) or die($this->mysqli->error.__LINE__);

        if($r->num_rows > 0){
            $result = array();
            while($row = $r->fetch_assoc()){
                $result[] = $row;
            }
            $this->response($this->json($result), 200); // send user details
        }
        $this->response('',204);	// If no records "No Content" status
    }
    private function customer(){
        if($this->get_request_method() != "GET"){
            $this->response('',406);
        }
        $id = (int)$this->_request['id'];
        if($id > 0){
            $query="SELECT distinct c.customerNumber, c.customerName, c.email, c.address, c.city, c.state, c.postalCode, c.country FROM angularcode_customers c where c.customerNumber=$id";
            $r = $this->mysqli->query($query) or die($this->mysqli->error.__LINE__);
            if($r->num_rows > 0) {
                $result = $r->fetch_assoc();
                $this->response($this->json($result), 200); // send user details
            }
        }
        $this->response('',204);	// If no records "No Content" status
    }

    private function insertCustomer(){
        if($this->get_request_method() != "POST"){
            $this->response('',406);
        }

        $customer = json_decode(file_get_contents("php://input"),true);
        $column_names = array('customerName', 'email', 'city', 'address', 'country');
        $keys = array_keys($customer);
        $columns = '';
        $values = '';
        foreach($column_names as $desired_key){ // Check the customer received. If blank insert blank into the array.
           if(!in_array($desired_key, $keys)) {
                   $$desired_key = '';
            }else{
                $$desired_key = $customer[$desired_key];
            }
            $columns = $columns.$desired_key.',';
            $values = $values."'".$$desired_key."',";
        }
        $query = "INSERT INTO angularcode_customers(".trim($columns,',').") VALUES(".trim($values,',').")";
        if(!empty($customer)){
            $r = $this->mysqli->query($query) or die($this->mysqli->error.__LINE__);
            $success = array('status' => "Success", "msg" => "Customer Created Successfully.", "data" => $customer);
            $this->response($this->json($success),200);
        }else
            $this->response('',204);	//"No Content" status
    }
    private function updateCustomer(){
        if($this->get_request_method() != "POST"){
            $this->response('',406);
        }
        $customer = json_decode(file_get_contents("php://input"),true);
        $id = (int)$customer['id'];
        $column_names = array('customerName', 'email', 'city', 'address', 'country');
        $keys = array_keys($customer['customer']);
        $columns = '';
        $values = '';
        foreach($column_names as $desired_key){ // Check the customer received. If key does not exist, insert blank into the array.
           if(!in_array($desired_key, $keys)) {
                   $$desired_key = '';
            }else{
                $$desired_key = $customer['customer'][$desired_key];
            }
            $columns = $columns.$desired_key."='".$$desired_key."',";
        }
        $query = "UPDATE angularcode_customers SET ".trim($columns,',')." WHERE customerNumber=$id";
        if(!empty($customer)){
            $r = $this->mysqli->query($query) or die($this->mysqli->error.__LINE__);
            $success = array('status' => "Success", "msg" => "Customer ".$id." Updated Successfully.", "data" => $customer);
            $this->response($this->json($success),200);
        }else
            $this->response('',204);	// "No Content" status
    }

    private function deleteCustomer(){
        if($this->get_request_method() != "DELETE"){
            $this->response('',406);
        }
        $id = (int)$this->_request['id'];
        if($id > 0){
            $query="DELETE FROM angularcode_customers WHERE customerNumber = $id";
            $r = $this->mysqli->query($query) or die($this->mysqli->error.__LINE__);
            $success = array('status' => "Success", "msg" => "Successfully deleted one record.");
            $this->response($this->json($success),200);
        }else
            $this->response('',204);	// If no records "No Content" status
    }
    */

    private function login()
    {
        if ($this->get_request_method() != "POST") {
            $this->response('', 406);
        }
        $payload = $this->getPayload();
        $mysql = new Mysql();

        $legajo = $this->$payload['legajo'];
        $password = $this->$payload['pwd'];
        if (!empty($legajo) and !empty($password)) {
            $result = $mysql->verify_login($legajo, $password);
            if ($result and !empty($result)){
                $_SESSION['status'] = 'authorized';
                $_SESSION['rol'] = $result['idRol'];
                $_SESSION['persona'] = $result['legajo'];
                $this->response($this->json($result), 200);
            }

            else
                $this->response('', 204);    // If no records "No Content" status
        }
        $error = array('status' => "Failed", "msg" => "Legajo o contraseña no válido");
        $this->response($this->json($error), 400);
    }
    private function registrarse(){
        if($this->get_request_method() != "POST"){
            $this->response('',406);
        }
        $mysql = new Mysql();

        $usuario = json_decode(file_get_contents("php://input"),true);
        $column_names = array('legajo', 'nombre', 'apellido', 'email', 'idRol', 'contrasena');
        $keys = array_keys($usuario);
        $columns = '';
        $values = '';
        foreach($column_names as $desired_key){
            if(!in_array($desired_key, $keys)) {
                $$desired_key = '';
            }else{
                $$desired_key = $usuario[$desired_key];
            }
            $columns = $columns.$desired_key.',';
            $values = $values."'".$$desired_key."',";
        }

        if(!empty($usuario)){
            if($r = $mysql->insert_usuario($usuario)){
                $success = array('status' => "Success", "msg" => "Usuario registrado con éxito.", "data" => $usuario);
                $this->response($this->json($success),200);
            }
        }else
            $this->response('',204);
    }

    private function getPayload()
    {
        return (array)json_decode(file_get_contents('php://input'));
    }
    private function json($data)
    {
        if (is_array($data)) {
            return json_encode($data);
        }
    }
}

$api = new API;
$api->processApi();
?>