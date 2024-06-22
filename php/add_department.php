<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $department = $input['department'];

    // query insert new update status
    $insert_sql= 'INSERT INTO tbl_department(department) VALUES (:department)';

    try {
        $set=$conn->prepare("SET SQL_MODE=''");
        $set->execute();

        $sql_insert = $conn->prepare($insert_sql);
        $sql_insert->bindParam(':department', $department, PDO::PARAM_STR);
    
        $sql_insert->execute();
        echo json_encode(array('success'=>true,'message'=>'insert'));
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