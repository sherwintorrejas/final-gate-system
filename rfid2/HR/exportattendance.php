<?php
require '../phpspreadsheet/vendor/autoload.php'; // Adjust the path to the autoload.php file
include '../Includes/dbcon.php';
include '../Includes/session.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

// Get search parameters
$dateSelected = isset($_POST['date']) ? $_POST['date'] : '';
$nameSearch = isset($_POST['name']) ? $_POST['name'] : '';

// Prepare the query dynamically based on input
$query = "
SELECT r.stid, i.name, i.department,
       MIN(CASE WHEN d.category = 'IN' THEN DATE_FORMAT(TIME(d.datetime), '%h:%i %p') END) AS time_in,
       MAX(CASE WHEN d.category = 'OUT' THEN DATE_FORMAT(TIME(d.datetime), '%h:%i %p') END) AS time_out,
       DATE_FORMAT(DATE(d.datetime), '%d/%m/%Y') AS log_date
FROM dailylogs d
JOIN registaff r ON d.stid = r.stid
JOIN information i ON r.did = i.did
WHERE 1 = 1";

// If a date is selected, filter by date
if ($dateSelected) {
    $query .= " AND DATE(d.datetime) = '$dateSelected'";
} elseif (empty($nameSearch)) {
    $query .= " AND DATE(d.datetime) = CURDATE()";
}

// If a name is searched, filter by name
if ($nameSearch) {
    $query .= " AND i.name LIKE '%$nameSearch%'";
}

// Group by staff and log date
$query .= " GROUP BY r.stid, i.name, i.department, DATE(d.datetime)
        ORDER BY r.stid ASC, DATE(d.datetime) DESC";

$result = mysqli_query($conn, $query);

// Create a new Spreadsheet object
$spreadsheet = new Spreadsheet();
$sheet = $spreadsheet->getActiveSheet();

// Set header row
$sheet->setCellValue('A1', '#')
      ->setCellValue('B1', 'Name')
      ->setCellValue('C1', 'Department')
      ->setCellValue('D1', 'Time In')
      ->setCellValue('E1', 'Time Out')
      ->setCellValue('F1', 'Date');

// Populate data rows
$rowNumber = 2;
$count = 1;
while ($row = mysqli_fetch_assoc($result)) {
    $time_in = $row['time_in'] ?? '-';
    $time_out = $row['time_out'] ?? '-';
    $log_date = $row['log_date'];
    
    $sheet->setCellValue('A' . $rowNumber, $count)
          ->setCellValue('B' . $rowNumber, $row['name'])
          ->setCellValue('C' . $rowNumber, $row['department'])
          ->setCellValue('D' . $rowNumber, $time_in)
          ->setCellValue('E' . $rowNumber, $time_out)
          ->setCellValue('F' . $rowNumber, $log_date);
    
    $rowNumber++;
    $count++;
}

// Set headers for download
header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="attendance_report.xlsx"');
header('Cache-Control: max-age=0');

// Write the file to output
$writer = new Xlsx($spreadsheet);

// Clear the output buffer before sending the file
ob_clean();
flush();

// Write the file to the output
$writer->save('php://output');
exit;
?>
