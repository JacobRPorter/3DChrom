<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="This is the 3D Chrom project for helping visualize genes in chromosomes. Works best in Chrome, Safari and Opera. Some functionality disabled in IE and Firefox.">
    <meta name="author" content="Jacob Ryan Porter">
    <link rel="icon" href="../../favicon.ico">

    <title>3D Chrom</title>

    <!-- JSmol library load -->
    <script type="text/javascript" src="js/JSmol.min.js"></script>

    <!-- Bootstrap JS -->
    <script type="text/javascript" src="js/bootstrap.min.js"></script>

    <!-- Jquery library -->
    <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>

    <!-- js cookie-->
    <script type="text/javascript" charset="utf8" src="js/js.cookie.js"></script>

    <!-- jQuery -->
    <script type="text/javascript" charset="utf8" src="plugins/DataTables/media/js/jquery.js"></script>
      
    <!-- DataTables -->
    <script type="text/javascript" charset="utf8" src="plugins/DataTables/media/js/jquery.dataTables.js"></script>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/jumbotron-narrow.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="plugins/DataTables/media/css/jquery.dataTables.css">

        <style>
    html {
      overflow-y: scroll
    }
    </style>

  </head>
  <?php
    // Pulling the file name from the cookie we stored it in.
    $pdbFileName = $_COOKIE['fileName'];

    // Now, we have the right pdb file. In this case, human_X_100520000_102320000.pdb

    $pdbFileRange = explode("_", $pdbFileName);
    $pdbFileRangeStart = $pdbFileRange[2];
    $pdbFileRangeEnd2 = explode(".", $pdbFileRange[3]);
    $pdbFileRangeEnd = $pdbFileRangeEnd2[0];

    // Now, we should have pdbFileRangeStart = 10520000 and pdbFileRangeEnd = 102320000

    $posFileName2 = explode(".", $pdbFileName);
    $posFileName = "files/POS/".$posFileName2[0].".pos";

    // $posFileName will now provide us with the right pos File.

    $hgdfFileName = "files/HGDF/HGDF_SEGMENTS/hgdf_".$pdbFileRangeStart."_".$pdbFileRangeEnd.".txt";

    // Stores the pos file information associated with our current structure in an array.
    $posLines = file($posFileName, FILE_IGNORE_NEW_LINES);
   
    // This foreach loop splits each $posLine by tab and stores it into a new array for easy access later.
    foreach ($posLines as $posLines2) {
      $posLinesArray[] = explode("\t", $posLines2);
    }

    // Stores the hgdf file information in an array.
    $hgdfLines = file($hgdfFileName, FILE_IGNORE_NEW_LINES);

    // This foreach loop splits each $posLine by tab and stores it into a new array for easy access later.
    foreach ($hgdfLines as $hgdfLines2) {
      $hgdfLinesArray2[] = explode("\t", $hgdfLines2);
    }

    // We're doing this again so that we can get ride of empty instances.
    foreach ($hgdfLinesArray2 as $hgdfLinesArray3) {
      if (!empty($hgdfLinesArray3[0])) {
        $hgdfLinesArray[] = $hgdfLinesArray3;
      }
    }

    // The following function creates an atom array for interaction with our POS file.
    foreach ($hgdfLinesArray as $hgdfLinesArray2) {
      if (!empty($hgdfLinesArray2)) {
        $geneStart = $hgdfLinesArray2[4];
        $geneEnd = $hgdfLinesArray2[5];

        foreach ($posLinesArray as $posArray) {
          if (($posArray[1] >= $geneStart && $posArray[2] <= $geneEnd) || ($posArray[1] >= $geneStart && $posArray[1] <= $geneEnd) || ($posArray[2] <= $geneEnd && $posArray[2] >= $geneStart) || ($posArray[1] <= $geneEnd && $posArray[2] >= $geneStart)) {
            $atomArray[$hgdfLinesArray2[0]][] = $posArray;
          }
        }
      }
    }

    // Honestly, next, we can define the actual range. We only need the first and last value of each array to select all values.
    // Now, we're taking each atomArray and making it into a range with name, start, and end for easy printing later. 
    // This is what you see on the left side of the screen when the genes are printed out.
    foreach ($atomArray as $key => $val) {
      $atomRange[$key]['name'] = $key;
      $atomRange[$key]['start'] = $val[0][0];
      $atomRange[$key]['end'] = $val[count($val)-1][0];
    }


  ?>
  <body>
    <div class="col-lg-2">  
      <table id="table_id" class="display" data-page-length='17' data-ordering='false'>
        <thead>
            <tr>
              <th></th>
            </tr>
        </thead>
        <tbody>   
        <?php 
          foreach ($atomRange as $key => $value) {
            echo "<tr><td><input type='checkbox' class='geneName' id='".$key."' data-start='".$value['start']."' data-end='".$value['end']."'/> ".$key."</tr></td>";
          }
        ?>
        </tbody>
      </table>
    </div>
    <div class="col-lg-6">
        <div class="header clearfix">
          <nav>
            <ul class="nav nav-pills pull-right">
              <li role="presentation"><a href="index.php">Home</a></li>
              <li role="presentation"><a href="index.php">Search</a></li>
            </ul>
          </nav>
          <h3 class="text-muted">3D Chrom Domain Page</h3>
        </div>
        <h3 id="3DPageHead"><?php echo $_COOKIE['fileName']; ?></h3>
        <?php 
          $scriptInfo = "set antialiasDisplay; load files/PDB/".$_COOKIE['fileName']."; spacefill on;";
        ?>

        <script>
          // We're only setting this variable to have a starting color.
          var i = 255;

          // Here, we set the info for the applet, afterwards loading it. Third, we create an optional spin in a checkbox.
          var Info = {
              height: 600,
              width:"100%",
              use: "HTML5",
         
              script: "<?php echo $scriptInfo; ?>",
          };
          Jmol.getApplet("myJmol", Info); 
          Jmol.jmolCheckbox(myJmol,"spin on","spin off","spin display");

          // Whenever we check the box it wil set or unset the genes, depending.
          $(document).on('change', '.geneName', function() {

            // 'Getting' data-attributes using getAttribute
            var geneData = document.getElementById(this.id);
            var geneName = geneData.getAttribute('id');
            var geneStart = geneData.getAttribute('data-start');
            var geneEnd = geneData.getAttribute('data-end');

            if (document.getElementById(this.id).checked) {
                Jmol.script(myJmol,'select atomno >='+geneStart+' and atomno <='+geneEnd+'; color ['+i+',0,0];');
                i = i - 40;
                $('#geneInfo'+geneName).css('display', '');
                var invisibleGene = $('#invisibleGene'+geneName).detach();
                invisibleGene.appendTo('#visibleGenes');
            } else { 
                Jmol.script(myJmol,'select atomno >='+geneStart+' and atomno <='+geneEnd+'; color none');
                $('#geneInfo'+geneName).css('display', 'none');
                var visibleGene = $('#invisibleGene'+geneName).detach();
                visibleGene.appendTo('#invisibleGenes');
          	}

         });

        $(document).ready( function () {
  
     
          // This table helps define some parameters of our DataTabls.
          var table = $('#table_id').dataTable( {
            "dom": '<"top"f>rt<"bottom"pi><"clear">',
            "oLanguage": {
              "sSearch": "Gene ID",
              "oPaginate": {
                "sPrevious": "",
                "sNext": ""
              } 
            },
          });
        });


        </script>

        <footer class="footer">
          <p>&copy; Jacob Porter 2015</p>
        </footer>
    </div> <!-- /col-lg-6 -->
    <div id="rightSidebar" class="col-lg-4">
      <div class="header clearfix"><h3 class="text-muted">Selected Gene Information</h3></div>
        <div id="visibleGenes">

        </div>
        <div id="invisibleGenes">
          <?php

          // This portion of the code echos out the information on the right side of the page. Technically,
          // it's a bit of a trick. All the information is already there, but the checkbox changes the 
          // div that contains the information to be visible and places it in the right location.
          foreach ($hgdfLinesArray as $hgdfLinesArray2) {
              $ensemblTranscriptArray = explode("*", $hgdfLinesArray2[1]);
              $ensemblProteinArray = explode("*", $hgdfLinesArray2[2]);
              $ensemblDescriptionArray = explode("*", $hgdfLinesArray2[3]);
              // $hgdfLinesArray2[4] is gene Start and there is always only one.
              // $hgdfLinesArray2[5] is gene End and there is always only one.

              $ensemblTranscriptStartArray = explode("*", $hgdfLinesArray2[6]);
              $ensemblTranscriptEndArray = explode("*", $hgdfLinesArray2[7]);

              echo "<div id=invisibleGene".$hgdfLinesArray2[0].">";
              echo "<details id='geneInfo".$hgdfLinesArray2[0]."' class='geneInfo' style='display: none;'>";
              echo "<summary><b>Gene ID:</b> ".$hgdfLinesArray2[0]."</summary>";

              echo "<div style='margin-left:24px;'>";
              if (count($ensemblTranscriptArray) > 1) {
                echo "<details>";
                echo "<summary><b>See all Transcript ID:</b></summary>";
                foreach ($ensemblTranscriptArray as $ensemblTranscriptArray2) {
                  if(!empty($ensemblTranscriptArray2)) {
                    echo "<p style='margin-left:24px;'>".$ensemblTranscriptArray2."<br>";
                  }
                }
                echo "</details>";
              } else {
                echo "<p style='margin-left:24px;'><b>Ensembl Transcript ID:</b> ".$hgdfLinesArray2[1]."<br>";
              } 

              if (count($ensemblProteinArray) > 1) {
                echo "<details>";
                echo "<summary><b>See all Ensembl Protein ID:</b></summary>";
                foreach ($ensemblProteinArray as $ensemblProteinArray2) {
                  if(!empty($ensemblProteinArray2)) {
                    echo "<p style='margin-left:24px;'>".$ensemblProteinArray2."<br>";
                  }  
                }
                echo "</details>";
              } else {
                echo "<p style='margin-left:24px;'><b>Ensembl Protein ID:</b> ".$hgdfLinesArray2[2]."<br>";
              } 

             // echo "<b>Protein ID:</b> ".$hgdfLinesArray2[2]."<br>";
              echo "<b>Description:</b> ".$hgdfLinesArray2[3]."<br>";
             // echo "<b>Chromosome Name:</b> ".$hgdfLinesArray2[4]."<br>";
              echo "<b>Gene Start:</b> ".$hgdfLinesArray2[4]."<br>";
              echo "<b>Gene End:</b> ".$hgdfLinesArray2[5]."<br>";
              echo "<b>Additional Info:</b> <a href='http://useast.ensembl.org/Homo_sapiens/Gene/Summary?g=".$hgdfLinesArray2[0]."' target='_blank'>http://useast.ensembl.org/Homo_sapiens/Gene/Summary?g=".$hgdfLinesArray2[0]."</a></p>";
              echo "</div></details><br></div>";
          }
          ?>
      </div>
    </div>
  </body>
</html>