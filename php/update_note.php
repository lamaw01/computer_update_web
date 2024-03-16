<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $id = $input['id'];
    $uuid = $input['uuid'];
    $note = $input['note'];

    // update tbl_notes
    $update_sql = 'UPDATE tbl_notes SET note=:note WHERE id=:id';

    try {
        $sql_update = $conn->prepare($update_sql);
        $sql_update->bindParam(':note', $note, PDO::PARAM_STR);
        $sql_update->bindParam(':id', $id, PDO::PARAM_INT);
        $sql_update->execute();
        echo json_encode(array('success'=>true,'message'=>'update note'));
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