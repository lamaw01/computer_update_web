<?php
require '../db_connect.php';
header('Content-Type: application/json; charset=utf-8');

// make input json
$inputJSON = file_get_contents('php://input');
$input = json_decode($inputJSON, TRUE);

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $search = $input['search'];

    $concat_search = "%$search%";

    // query get new machine details
    // $sql= 'SELECT * FROM tbl_computer_details WHERE id IN (SELECT Max(id) FROM tbl_computer_details GROUP BY hostname) AND hostname LIKE :hostname ORDER BY hostname ASC;';
    $sql = 'SELECT * FROM tbl_computer_details WHERE id IN (SELECT Max(id) FROM tbl_computer_details GROUP BY hostname) AND (hostname LIKE :search OR cpu LIKE :search OR motherboard LIKE :search OR ram LIKE :search OR storage LIKE :search OR user LIKE :search OR network LIKE :search OR monitor LIKE :search OR gpu LIKE :search OR uuid LIKE :search) AND hostname != "" ORDER BY hostname ASC';

    try {
        $set=$conn->prepare("SET SQL_MODE=''");
        $set->execute();

        $get_sql = $conn->prepare($sql);
        $get_sql->bindParam(':search', $concat_search, PDO::PARAM_STR);
        $get_sql->execute();
        $result_get_sql = $get_sql->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($result_get_sql);
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


// SELECT MAX(id) as id,uuid,hostname,os,defender,cpu,motherboard,ram,storage,user,network,monitor,time_stamp FROM tbl_computer_details GROUP BY hostname ORDER BY id DESC;