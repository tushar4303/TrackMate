$(document).ready(function () {
  // Get Report passenger
  // $(document).on("click", "#user_log", function () {
  //   var date_sel = $("#date_sel").val();

  //   $.ajax({
  //     url: "user_log_up.php",
  //     type: "POST",
  //     data: {
  //       log_date: 1,
  //       date_sel: date_sel,
  //     },
  //     success: function (response) {
  //       $.ajax({
  //         url: "user_log_up.php",
  //         type: "POST",
  //         data: {
  //           log_date: 1,
  //           date_sel: date_sel,
  //           select_date: 0,
  //         },
  //       }).done(function (data) {
  //         $("#userslog").html(data);
  //       });
  //     },
  //   });
  // });
  $(document).on("click", "#Submit_Sub_Log", function () {
    console.log("hello vendra");
    var date_sel = $("#date_sel").val();
    var teacher_name = $("#teacher_name").val();
    var subject_name = $("#subject_name").val();
    var timeslot = $("#timeslot").val();
    console.log(date_sel, teacher_name, subject_name, timeslot);
    $.ajax({
      url: "http://localhost/Smart_Attendance_system_IOE/subject_log.php",
      type: "POST",
      data: {
        date_sel: date_sel,
        teacher_name: teacher_name,
        subject_name: subject_name,
        timeslot: timeslot,
      },
      success: function (response) {
        $.ajax({
          url: "http://localhost/Smart_Attendance_system_IOE/subject_log.php",
          type: "POST",
          data: {
            date_sel: date_sel,
            teacher_name: teacher_name,
            subject_name: subject_name,
            timeslot: timeslot,
          },
        }).done(function (data) {
          $("#subjectLog").html(data);
        });
      },
    });
  });
});
