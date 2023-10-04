<?php
//Connect to database
require'connectDB.php';

$output = '';

if (isset($_POST['Submit_Sub_Log'])) {
    echo 'inside subject log';

    // Output the values for debugging
    $date_sel = $_POST['date_sel'];
    $teacherName = $_POST['teacher_name'];
    $subjectName = $_POST['subject_name'];
    $timeslot = $_POST['timeslot'];

    echo "Date: $date_sel<br>";
    echo "Teacher Name: $teacherName<br>";
    echo "Subject Name: $subjectName<br>";
    echo "Timeslot: $timeslot<br>";

    $sql = "INSERT INTO teacher_details (date_sel, subject_teacher, subject_name, subject_timeslot) VALUES (?, ?, ?, ?)";
    $stmt = mysqli_stmt_init($conn);

    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo '<p class="error">SQL Error</p>';
    } else {
        mysqli_stmt_bind_param($stmt, "ssss", $date_sel, $teacherName, $subjectName, $timeslot);
        mysqli_stmt_execute($stmt);
        echo '<p class="success">Subject log inserted successfully</p>';
    }
}

// if(isset($_POST["Submit_Sub_Log"])){
//     echo "Submit clicked and inside logic.";
//     if ( empty($_POST['date_sel'])) {
//         $Log_date = date("Y-m-d");
//     }
//     else if ( !empty($_POST['date_sel'])) {
//         $Log_date = $_POST['date_sel']; 
//     }
//         $sql = "";
//         $result = mysqli_query($conn, $sql);
//         if($result->num_rows > 0){
//             $output .= '
//                         <table class="table" bordered="1">  
//                           <TR>
//                             <TH>Jahanvi</TH>
//                             <TH>IOE  10:45</TH>
//                           </TR>
//                           <TR>
//                             <TH>ID</TH>
//                             <TH>Name</TH>
//                             <TH>Serial Number</TH>
//                             <TH>Fingerprint ID</TH>
//                             <TH>Date log</TH>
//                             <TH>Checked in at</TH>
                            
//                           </TR>';
//               while($row=$result->fetch_assoc()) {
//                   $output .= '
//                               <TR> 
//                                   <TD> '.$row['id'].'</TD>
//                                   <TD> '.$row['username'].'</TD>
//                                   <TD> '.$row['serialnumber'].'</TD>
//                                   <TD> '.$row['fingerprint_id'].'</TD>
//                                   <TD> '.$row['checkin_date'].'</TD>
//                                   <TD> '.$row['checkin_time'].'</TD>
//                               </TR>';
//               }
//               $output .= '</table>';
//               header('Content-Type: application/xls');
//               header('Content-Disposition: attachment; filename=User_Log'.$Log_date.'.xls');
              
//               echo $output;
//               exit();
//         }
//         else{
//             header( "location: UsersLog.php" );
//             exit();
//         }
// }
?>