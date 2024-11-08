<?php
// Include the database connection file
include '..\..\rfid2\Includes\dbcon.php'; // Adjust the path as necessary

// SQL query to fetch today's "IN" entries with student and staff details
$sql = "
SELECT 
    dl.lid,
    dl.datetime, 
    CASE 
        WHEN dl.sid IS NOT NULL THEN s.sid
        ELSE NULL 
    END AS sid,
    CASE 
        WHEN dl.stid IS NOT NULL THEN st.stid
        ELSE NULL 
    END AS stid,
    s.image AS student_image,
    st.image AS staff_image,
    i.name,
    i.department
FROM 
    dailylogs AS dl
LEFT JOIN 
    registudent AS s ON dl.sid = s.sid
LEFT JOIN 
    registaff AS st ON dl.stid = st.stid
LEFT JOIN 
    information AS i ON (s.did = i.did OR st.did = i.did)
WHERE 
    dl.category = 'OUT' AND DATE(dl.datetime) = CURDATE()
ORDER BY 
    dl.datetime DESC 
LIMIT 3";

// Fetch the latest "IN" entries with student and staff details
$result = $conn->query($sql);

// Prepare an array to store entries
$latestEntries = []; 
if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $latestEntries[] = $row;
    }
}

// Close the database connection
$conn->close();

// Output card for the "Left" position with default or entry data
$entry = $latestEntries[2] ?? [];
$image = !empty($entry['sid']) ? $entry['student_image'] : (!empty($entry['staff_image']) ? $entry['staff_image'] : ''); // No fallback image
$name = $entry['name'] ?? 'Name';
$department = $entry['department'] ?? 'Department';
$time = isset($entry['datetime']) ? date('h:i:s A', strtotime($entry['datetime'])) : '--:--:--';

echo '<div class="student-cards2">'; // Left card class
echo '<div class="pic">';
if ($image) { // Only show image if it exists
    echo '<img src="../' . basename($image) . '" alt="Image" class="pic" style="margin-top: 5px;">';
}
echo '</div>';
echo '<div class="details">';
echo '<h2>' . $name . '</h2>';
echo '<p class="dep">' . $department . '</p>';
echo '<p class="tim">' . $time . '</p>';
echo '</div>';
echo '</div>';

// Output card for the "Center" position with default or entry data
$entry = $latestEntries[0] ?? [];
$image = !empty($entry['sid']) ? $entry['student_image'] : (!empty($entry['staff_image']) ? $entry['staff_image'] : ''); // No fallback image
$name = $entry['name'] ?? 'Name';
$department = $entry['department'] ?? 'Department';
$time = isset($entry['datetime']) ? date('h:i:s A', strtotime($entry['datetime'])) : '--:--:--';

echo '<div class="student-cards1">'; // Center card class
echo '<div class="pic">';
if ($image) { // Only show image if it exists
    echo '<img src="../' . basename($image) . '" alt="Image" class="pic" style="margin-top: 5px;">';
}
echo '</div>';
echo '<div class="details1">';
echo '<h3>' . $name . '</h3>';
echo '<p>' . $department . '</p>';
echo '<p>' . $time . '</p>';
echo '</div>';
echo '</div>';

// Output card for the "Right" position with default or entry data
$entry = $latestEntries[1] ?? [];
$image = !empty($entry['sid']) ? $entry['student_image'] : (!empty($entry['staff_image']) ? $entry['staff_image'] : ''); // No fallback image
$name = $entry['name'] ?? 'Name';
$department = $entry['department'] ?? 'Department';
$time = isset($entry['datetime']) ? date('h:i:s A', strtotime($entry['datetime'])) : '--:--:--';

echo '<div class="student-cards2">'; // Right card class
echo '<div class="pic">';
if ($image) { // Only show image if it exists
    echo '<img src="../' . basename($image) . '" alt="Image" class="pic" style="margin-top: 5px;">';
}
echo '</div>';
echo '<div class="details">';
echo '<h2>' . $name . '</h2>';
echo '<p class="dep">' . $department . '</p>';
echo '<p class="tim">' . $time . '</p>';
echo '</div>';
echo '</div>';
?>
