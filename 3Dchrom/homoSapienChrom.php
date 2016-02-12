<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>3D Chrom</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/jumbotron-narrow.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="plugins/DataTables/media/css/jquery.dataTables.css">

    <!-- JSmol library load -->
    <script type="text/javascript" src="js/JSmol.min.js"></script>

    <!-- Bootstrap JS -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <!-- Jquery library -->
    <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
      
    <!-- jQuery -->
    <script type="text/javascript" charset="utf8" src="plugins/DataTables/media/js/jquery.js"></script>
      
    <!-- DataTables -->
    <script type="text/javascript" charset="utf8" src="plugins/DataTables/media/js/jquery.dataTables.js"></script>

    <!-- js cookie-->
    <script type="text/javascript" charset="utf8" src="js/js.cookie.js"></script>

  </head>
  <body>
    <div class="container">
      <div class="header clearfix">
        <nav>
          <ul class="nav nav-pills pull-right">
            <li role="presentation"><a href="index.php">Home</a></li>
            <li role="presentation"><a href="homoSapienChrom">Search</a></li>
          </ul>
        </nav>
        <h3 class="text-muted">3D Chrom Project - Domain Selection Page</h3>
      </div>
      <div>
        <table id="table_id" class="display">
          <thead>
              <tr>
                <th>File Name</th>
              </tr>
          </thead>
          <tbody>   

        <?php 

        $dir = 'files/PDB/';

        if ($handle = opendir($dir)) {
          while (false !== ($entry = readdir($handle))) {
            if($entry !== ".." && $entry !== ".") {
              echo "<tr><td>$entry</td></tr>";
            }
          }
          closedir($handle);
        }  ?>

        </tbody>
      </table>

      <script type="text/javascript">

      $(document).ready( function () {
      // We want to define this table for later use.
      var table = $('#table_id').DataTable();
        // This function wil allow us to grab the table data.
        $('#table_id tbody').on('click', 'tr', function() {
          // We are grabbing the table row data, which in this case is just the file name.
          var fileName = table.row(this).data();
          // Setting a cookie with the file name.
          Cookies.set('fileName', fileName.toString());
          // Redirecting to the geneInfo.php page.
          window.location = "homoSapienDomain.php";
        });
      });

      </script>

    </div> <!-- /container -->
      <footer class="footer">
        <p>&copy; Jacob Porter 2015</p>
      </footer>   
  </body>
</html>