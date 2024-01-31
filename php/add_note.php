<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $note = $input['note'];
    $uuid = $input['uuid'];
    $update_id = $input['update_id'];

    // query insert new note
    $insert_sql= 'INSERT INTO tbl_notes(note,uuid,update_id) VALUES (:note,:uuid,:update_id)';

    try {
        $set=$conn->prepare("SET SQL_MODE=''");
        $set->execute();

        $sql_insert = $conn->prepare($insert_sql);
        $sql_insert->bindParam(':note', $note, PDO::PARAM_STR);
        $sql_insert->bindParam(':uuid', $uuid, PDO::PARAM_STR);
        $sql_insert->bindParam(':update_id', $update_id, PDO::PARAM_STR);
        $sql_insert->execute();
        echo json_encode(array('success'=>true,'message'=>'insert note'));
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