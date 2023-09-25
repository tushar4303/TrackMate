<!DOCTYPE html>
<html>
  <head>
    <title>Users Logs</title>
    <link rel="stylesheet" type="text/css" href="css/userslog.css" />
    <script>
      $(window)
        .on("load resize ", function () {
          var scrollWidth =
            $(".tbl-content").width() - $(".tbl-content table").width();
          $(".tbl-header").css({ "padding-right": scrollWidth });
        })
        .resize();
    </script>
    <script
      src="https://code.jquery.com/jquery-3.3.1.js"
      integrity="sha1256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
      crossorigin="anonymous"
    ></script>
    <script src="js/jquery-2.2.3.min.js"></script>
    <script src="js/user_log.js"></script>
    <script>
      $(document).ready(function () {
        $.ajax({
          url: "user_log_up.php",
          type: "POST",
          data: {
            select_date: 1,
          },
        });
        setInterval(function () {
          $.ajax({
            url: "user_log_up.php",
            type: "POST",
            data: {
              select_date: 0,
            },
          }).done(function (data) {
            $("#userslog").html(data);
          });
        }, 5000);
        $("#teacher").change(function () {
          var selectedTeacher = $(this).val();
          var subjectInput = $("#subject");
          switch (selectedTeacher) {
            case "Janhavi Ma'am":
              subjectInput.val("IOE");
              break;
            case "Mrudul Ma'am":
              subjectInput.val("MIS");
              break;
            case "Prasad Sir":
              subjectInput.val("STQA");
              break;
            case "Sunantha Ma'am":
              subjectInput.val("AIDS 2");
              break;
            case "Aruna Ma'am":
              subjectInput.val("IRS");
              break;
            default:
              subjectInput.val(""); // Clear the subject input if no teacher is selected
              break;
          }
        });
      });
    </script>
    <script
      src="https://kit.fontawesome.com/dee439f8c1.js"
      crossorigin="anonymous"
    ></script>
  </head>
  <body>
    <?php include'header.php'; ?>
    <main>
      <section>
        <h1 class="slideInDown animated">
          <i class="fa-solid fa-hospital-user"></i> Lecture Attendance Details
        </h1>
        <div class="form-style-5 slideInDown animated">
          <form method="POST" action="Export_Excel.php" class="cust_form">
            <input type="date" name="date_sel" id="date_sel" />
            <button type="button" name="user_log" id="user_log">
              Submit
            </button>
            <input type="submit" name="To_Excel" value="Export to Excel" />
            <select name="teacher" id="teacher">
              <option value="">Select Teacher</option>
              <option value="Janhavi Ma'am">Janhavi Ma'am</option>
              <option value="Mrudul Ma'am">Mrudul Ma'am</option>
              <option value="Prasad Sir">Prasad Sir</option>
              <option value="Sunantha Ma'am">Sunantha Ma'am</option>
              <option value="Aruna Ma'am">Aruna Ma'am</option>
            </select>
            <input
              type="text"
              id="subject"
              name="subject"
              placeholder="Subject"
              disabled
            />
            <select name="timeslot" id="cars">
              <option value="">Select Lecture Time</option>
              <option value="">9:00 - 10:00</option>
              <option value="">10:00 - 11:00</option>
              <option value="">11:15 - 12:15</option>
              <option value="">12:15 - 1:15</option>
              <option value="">14:00 - 15:00</option>
              <option value="">15:00 - 16:00</option>
              <option value="">16:00 - 17:00</option>
            </select>
            <input type="submit" value="Submit">
          </form>
          <div>
            <div class="tbl-header slideInRight animated">
              <table cellpadding="0" cellspacing="0" border="0">
                <thead>
                  <tr>
                    <th>Teacher</th>
                    <th>Subject</th>
                    <th>Lecture Time</th>
                    <th>Date</th>
                  </tr>
                </thead>
              </table>
            </div>
            <div class="tbl-content slideInRight animated">
              <div id=""></div>
            </div>

          </div>
        </div>
        <div class="tbl-header slideInRight animated">
          <table cellpadding="0" cellspacing="0" border="0">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Serial Number</th>
                <th>Fingerprint ID</th>
                <th>Date</th>
                <th>Checked in at</th>
              </tr>
            </thead>
          </table>
        </div>
        <div class="tbl-content slideInRight animated">
          <div id="userslog"></div>
        </div>
      </section>
    </main>
  </body>
</html>
