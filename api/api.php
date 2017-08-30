<?php
require_once("Rest.inc.php");
require_once("constants.php");
require_once("MySql.php");

class API extends REST
{

    public $data = "";

    public function __construct()
    {
        parent::__construct();                // Init parent contructor
    }

    /**
     * Invoca a la función correspondiente por nombre cuando es llamada desde el cliente siempre que se use 'api' como
     * parent en la url.
     * por ej: si se hace un GET a http://url-de-la-app/api/funcionx se busca si "funcionx" existe y caso afirmativo
     * se la llama, pasandole el tipo de request y los correspondientes parametros.
     */
    public function processApi()
    {
        $func = strtolower(trim(str_replace("/", "", $_REQUEST['x'])));
        if ((int)method_exists($this, $func) > 0)
            $this->$func();
        else
            $this->response('', 404); // If the method not exist within this class "Page not found".
    }

    /**
     * Función de prueba. Borrable
     */
    private function prueba()
    {
        $payload = $this->getPayload();
        $this->response($this->json($payload), 200);
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

    /**
     * Request method: POST
     * Payload: { legajo: int, contrasena: string }
     * Si el método es el correcto y el payload contiene los campos obligatorios,
     * se llama a la funcion Mysql->verify_login() que devuelve el usuario encontrado en la BD
     * si este existe o falso si no.
     * En caso de existir, se asignan las variables de sesión Status, Rol y Persona y
     * se devuelve una respuesta con código de estado 200 y el usuario como 'data' del json.
     */
    private function login()
    {
        if ($this->get_request_method() != "POST") {
            $this->response('', 406);
        }

        $mysql = new Mysql();

        $usuario = $this->getPayload();
        $column_names = array('legajo', 'contrasena');
        $keys = array_keys($usuario);
        foreach($column_names as $desired_key){
            if(!in_array($desired_key, $keys)) {
                $this->response('Faltan datos o el formato no es correcto',406);
            }
        }

        if (!empty($usuario['legajo']) and !empty($usuario['contrasena'])) {
            $result = $mysql->verify_login($usuario['legajo'], $usuario['contrasena']);
            if ($result and !empty($result)){
                $_SESSION['status'] = 'authorized';
                $_SESSION['rol'] = $result['idRol'];
                $_SESSION['persona'] = $result['legajo'];
                $success = array('status' => "Success", "msg" => "Usuario logueado con éxito.", "data" => $result);
                $this->response($this->json($success),200);
            }
            else
                $this->response('', 204);    // If no records "No Content" status
        }
        $error = array('status' => "Failed", "msg" => "Legajo o contraseña no válido");
        $this->response($this->json($error), 400);
    }
    /**
     * Request method: POST
     * Payload: { legajo: int, nombre: string, apellido: string, email: string, idRol: int, contrasena: string }
     * Si el método es el correcto y el payload contiene los campos obligatorios,
     * se llama a la funcion Mysql->insert_usuario() que inserta el usuario en la BD y
     * devuelve el mismo si se insertó correctamente o false si no.
     * Se devuelve una respuesta con código de estado 200 y el usuario como 'data' del json.
     */
    private function registrarse(){
        if($this->get_request_method() != "POST"){
            $this->response('',406);
        }
        $mysql = new Mysql();

        $usuario = json_decode(file_get_contents("php://input"),true);
        $column_names = array('legajo', 'nombre', 'apellido', 'email', 'idRol', 'contrasena');
        $keys = array_keys($usuario);
        foreach($column_names as $desired_key){
            if(!in_array($desired_key, $keys)) {
                $this->response('Faltan datos o el formato no es correcto',406);
            }
        }
        if(!empty($usuario)){
            if($r = $mysql->insert_usuario($usuario)){
                $success = array('status' => "Success", "msg" => "Usuario registrado con éxito.", "data" => $usuario);
                $this->response($this->json($success),200);
            }
        }else
            $this->response('',204);
    }

    /**
     * Request method: GET
     * Payload: { legajo: int } -- debe pasarse en la url como query string parameter
     * (http://url-de-la-app/api/usuario?legajo=123)
     * Si el método es el correcto y el payload contiene los campos obligatorios,
     * se llama a la funcion Mysql->obtener_usuario() que busca el usuario en la BD y
     * devuelve el mismo si lo encuentra o false si no.
     * Se devuelve una respuesta con código de estado 200 y el usuario como 'data' del json.
     */
    private function usuario(){
        if($this->get_request_method() != "GET"){
            $this->response('',406);
        }

        $mysql = new Mysql();

        $legajo = $this->_request['legajo'];
        if (!empty($legajo) and !empty($result = $mysql->obtener_usuario($legajo)))
        {
            $success = array('status' => "Success", "msg" => "Usuario obtenido con éxito.", "data" => $result);
            $this->response($this->json($success),200);
        }
        else
        {
            $this->response('No existe el usuario', 204);
        }
    }
    /**
     * Request method: POST
     * Payload: { legajo: int, nombre: string, apellido: string, email: string, idRol: int, contrasena: string }
     * Si el método es el correcto y el payload contiene los campos obligatorios,
     * se llama a la funcion Mysql->update_usuario() que actualiza los campos del usuario en la BD y
     * devuelve el mismo si se actualizó correctamente o false si no.
     * Se devuelve una respuesta con código de estado 200 y el usuario como 'data' del json.
     */
    private function actualizar(){
        if($this->get_request_method() != "POST"){
            $this->response('',406);
        }
        $mysql = new Mysql();

        $usuario = json_decode(file_get_contents("php://input"),true);
        $column_names = array('legajo', 'nombre', 'apellido', 'email', 'idRol', 'contrasena');
        $keys = array_keys($usuario);
        foreach($column_names as $desired_key){
            if(!in_array($desired_key, $keys)) {
                $this->response('Faltan datos o el formato no es correcto',406);
            }
        }
        if(!empty($usuario)){
            if($r = $mysql->update_usuario($usuario)){
                unset($usuario['contrasena']);
                $success = array('status' => "Success", "msg" => "Usuario actualizado con éxito.", "data" => $usuario);
                $this->response($this->json($success),200);
            }
        }else
            $this->response('',204);
    }

    /**
     * Request method: DELETE
     * Payload: { legajo: int } -- debe pasarse en la url como query string parameter
     * (http://url-de-la-app/api/eliminar?legajo=123)
     * Si el método es el correcto y el payload contiene los campos obligatorios,
     * se llama a la funcion Mysql->borrar_usuario() que busca el usuario en la BD y
     * elimina el mismo si lo encuentra o devuelve false si no.
     * Se devuelve una respuesta con código de estado 200 y el legajo del usuario eliminado como 'data' del json.
     */
    private function eliminar(){
        if($this->get_request_method() != "DELETE"){
            $this->response('',406);
        }

        $mysql = new Mysql();

        $legajo = $this->_request['legajo'];
        if (!empty($legajo) and $result = $mysql->borrar_usuario($legajo))
        {
            $success = array('status' => "Success", "msg" => "Usuario eliminado con éxito.", "data" => $legajo);
            $this->response($this->json($success),200);
        }
        else
        {
            $this->response('No existe el usuario', 204);
        }
    }

    //TODO: incompleto. falta cambiar BD antes
    private function new_materia(){
        if($this->get_request_method() != "POST"){
            $this->response('',406);
        }
        $mysql = new Mysql();

        $materia = $this->getPayload();
        $column_names = array('nombre', 'nombre', 'apellido', 'email', 'idRol', 'contrasena');
        $keys = array_keys($materia);
        foreach($column_names as $desired_key){
            if(!in_array($desired_key, $keys)) {
                $this->response('Faltan datos o el formato no es correcto',406);
            }
        }
        if(!empty($materia)){
            if($r = $mysql->insert_usuario($materia)){
                $success = array('status' => "Success", "msg" => "Usuario registrado con éxito.", "data" => $materia);
                $this->response($this->json($success),200);
            }
        }else
            $this->response('',204);
    }

    private function getPayload()
    {
        return json_decode(file_get_contents("php://input"),true);
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