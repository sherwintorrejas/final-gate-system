<?php
require __DIR__ . '/../phpspreadsheet/vendor/autoload.php'; // Include PHPSpreadsheet

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

// Check if table data is received
if (isset($_POST['tableData'])) {
    $tableData = $_POST['tableData'];

    // Create a new Spreadsheet
    $spreadsheet = new Spreadsheet();
    $sheet = $spreadsheet->getActiveSheet();

    // Define column headers
    $headers = ['#', 'UID', 'Student ID', 'Name', 'Department', 'Date', 'Status'];
    $sheet->fromArray($headers, NULL, 'A1');

    // Populate the spreadsheet with table data
    $row = 2;
    foreach ($tableData as $dataRow) {
        $sheet->fromArray($dataRow, NULL, 'A' . $row);
        $row++;
    }

    // Set headers for download
    header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    header('Content-Disposition: attachment;filename="Student_Report.xlsx"');
    header('Cache-Control: max-age=0');

    // Write the file to output
    $writer = new Xlsx($spreadsheet);
    $writer->save('php://output');
    exit;
} else {
    echo "No data provided.";
}
?>
