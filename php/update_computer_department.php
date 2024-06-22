<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $department_id = $input['department_id'];
    $uuid = $input['uuid'];

    // update tbl_notes
    $update_sql = 'UPDATE tbl_department_computer SET department_id=:department_id WHERE uuid=:uuid';

    try {
        $sql_update = $conn->prepare($update_sql);
        $sql_update->bindParam(':department_id', $department_id, PDO::PARAM_INT);
        $sql_update->bindParam(':uuid', $uuid, PDO::PARAM_STR);
        $sql_update->execute();
        echo json_encode(array('success'=>true,'message'=>'update department'));
    } catch (PDOException $e) {
        echo json_encode(array('success'=>false,'message'=>$e->getMessage()));
    } finally{
        // Closing the connection.
        $conn = null;
    }
}else{
    echo json_encode(array('success'=>false,'message'=>'Error input'));
    die();
}
?>