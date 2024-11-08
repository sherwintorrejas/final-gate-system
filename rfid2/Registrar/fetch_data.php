<?php
include '../Includes/dbcon.php';

header('Content-Type: application/json');

// Query to fetch the latest data from the RFID table
$sql = "
SELECT rfid.*
FROM rfid
LEFT JOIN registudent rs ON rfid.cid = rs.cid
LEFT JOIN registaff raf ON rfid.cid = raf.cid
WHERE rs.cid IS NULL AND raf.cid IS NULL  -- Exclude rows where UID is already present in registudent or registaff
ORDER BY rfid.timedate DESC
";
$result = $conn->query($sql);

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);
?>
