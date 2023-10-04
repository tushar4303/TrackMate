<?php
	//Connect to database
    $servername = "localhost";
    $username = "root";		//put your phpmyadmin username.(default is "root")
    $password = "";			//if your phpmyadmin has a password put it here.(default is "root")
    $dbname = "";
    
	$conn = new mysqli($servername, $username, $password, $dbname);

	// Create database
	$sql = "CREATE DATABASE biometricattendace";
	if ($conn->query($sql) === TRUE) {
	    echo "Database created successfully";
	} else {
	    echo "Error creating database: " . $conn->error;
	}

	echo "<br>";

	$dbname = "biometricattendace";
    
	$conn = new mysqli($servername, $username, $password, $dbname);

	//subject master table 
	$sql = "CREATE TABLE IF NOT EXISTS `teacher_details` (
		`id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
		`date_sel` date NOT NULL,
		`subject_name` varchar(50) NOT NULL,
		`subject_teacher` varchar(50) NOT NULL,
		`subject_timeslot` varchar(50) NOT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=latin1";

	if ($conn->query($sql) === TRUE) {
		echo "Table users created successfully";
	} else {
		echo "Error creating table: " . $conn->error;
	}

	// sql to create table
	$sql = "CREATE TABLE IF NOT EXISTS `users` (
			`id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
			`username` varchar(100) NOT NULL,
			`serialnumber` double NOT NULL,
			`gender` varchar(10) NOT NULL,
			`email` varchar(50) NOT NULL,
			`fingerprint_id` int(11) NOT NULL,
			`fingerprint_select` tinyint(1) NOT NULL DEFAULT '0',
			`user_date` date,
			`enrolled_at` time,
			`del_fingerid` tinyint(1) NOT NULL DEFAULT '0',
			`add_fingerid` tinyint(1) NOT NULL DEFAULT '0',
			`subject_id` int(20)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1";
	// $sql = "CREATE TABLE IF NOT EXISTS `users` (
	// 	`id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	// 	`username` varchar(100) NOT NULL,
	// 	`serialnumber` double NOT NULL,
	// 	`gender` varchar(10) NOT NULL,
	// 	`email` varchar(50) NOT NULL,
	// 	`fingerprint_id` int(11) NOT NULL,
	// 	`fingerprint_select` tinyint(1) NOT NULL DEFAULT '0',
	// 	`user_date` date,
	// 	`enrolled_at` time,
	// 	`del_fingerid` tinyint(1) NOT NULL DEFAULT '0',
	// 	`add_fingerid` tinyint(1) NOT NULL DEFAULT '0',
	// 	`subject_id` int(20),
	// 	FOREIGN KEY (`subject_id`) REFERENCES `subject`(`id`)
	// ) ENGINE=InnoDB DEFAULT CHARSET=latin1";
	

	if ($conn->query($sql) === TRUE) {
	    echo "Table users created successfully";
	} else {
	    echo "Error creating table: " . $conn->error;
	}
	


	$sql = "CREATE TABLE IF NOT EXISTS `users_logs` (
			`id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
			`username` varchar(100) NOT NULL,
			`serialnumber` double NOT NULL,
			`fingerprint_id` int(5) NOT NULL,
			`checkin_date` date NOT NULL,
			`checkin_time` time
	) ENGINE=InnoDB DEFAULT CHARSET=latin1";

	if ($conn->query($sql) === TRUE) {
	    echo "Table users_logs created successfully";
	} else {
	    echo "Error creating table: " . $conn->error;
	}
		
	$conn->close();
?>