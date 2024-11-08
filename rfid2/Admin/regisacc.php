<?php
error_reporting(0);
include '../Includes/dbcon.php';  // Database connection
include '../Includes/session.php';  // Session handling

// Check if the form is submitted
if (isset($_POST['register'])) {
    // Get form input
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $category = mysqli_real_escape_string($conn, $_POST['category']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    // Query to get stid and did based on the staff name
    $sql = "SELECT i.did, r.stid FROM information i 
            JOIN registaff r ON i.did = r.did
            WHERE i.name = '$name' AND i.category = 'staff' LIMIT 1"; // Ensure the category is 'staff'

    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        // Fetch the did and stid
        $row = mysqli_fetch_assoc($result);
        $did = $row['did'];
        $stid = $row['stid'];

        // Check if the staff is already registered in the admin table
        $checkSql = "SELECT * FROM admin WHERE stid = '$stid'";
        $checkResult = mysqli_query($conn, $checkSql);

        if (mysqli_num_rows($checkResult) > 0) {
            // Staff already registered in the admin table
            $statusMsg = "Account already registered for this staff.";
            header("Location: registeracc.php?status=error&msg=" . urlencode($statusMsg));
            exit();
        } else {
            // Hash the password
            $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

            // Insert into the admin table
            $insertSql = "INSERT INTO admin (stid, password, category) VALUES ('$stid', '$hashedPassword', '$category')";

            if (mysqli_query($conn, $insertSql)) {
                // Success message and redirect back to registeracc.php
                $statusMsg = "Registration successful!";
                header("Location: registeracc.php?status=success&msg=" . urlencode($statusMsg));
                exit();  // Make sure to exit after the redirect
            } else {
                // Error inserting into admin table
                $statusMsg = "Error: " . mysqli_error($conn);
                header("Location: registeracc.php?status=error&msg=" . urlencode($statusMsg));
                exit();
            }
        }
    } else {
        // Handle case where no matching record is found for the staff name
        $statusMsg = "No staff found with the provided name.";
        header("Location: registeracc.php?status=error&msg=" . urlencode($statusMsg));
        exit();
    }
}
?>
