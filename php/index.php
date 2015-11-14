<!DOCTYPE html>
<html>
<head>
	<title>Fresh Air datamanager</title>
	<?php 
		include_once 'class.datamanager.php';
		include 'dbcon.php'; //Býr til db_man úr DatabaseManager klassanum
	?>
</head>
<body>
<h1>Test for datamanager</h1>
<a>
<?php
	/*
	 * Test cases fyrir datamanager
	 *
	 * @author: Daði Sigursveinn Harðarson
	 *
	 */
	//$db_man->deleteAircraft("TF-API");
	//print_r($db_man->getAircraft("TF-API"));
	//$db_man->newAircraft('TF-API','Cessna 152', '1','2015-10-29', null);
	/*if($db_man->updateAircraft('TF-API','Cessna 152', '2','2015-10-29', 'Bomber'))
	{
		print_r($db_man->getAircraft("TF-API"));
	}
	else
	{

	}*/
	//print_r ($db_man->numOfPassangers('FA502', '2014-05-01'));
	/*
	//print_r($passengerInfo);
	$a = "'FA501','2014-05-01',2,'Margrét Benediktsdóttir','VISA'";
	$b = ",'";
	foreach ($passengerInfo as $passenger) {
		foreach ($passenger as $key) {
			$b .= $key;
			$b .= ";";
		}
	}
	$b .= "'";
	print $a . $b;*/
	/*$passengers = array(
		array("IS934671", "Margrét Benediktsdóttir", "4", "3273"),
		array("IS916472", "Sigurður Egilsson", "4", "3274"),
		array("IS295715", "Guðmundur Sigurðsson", "4", "3283"),
		array("IS883461", "Þuríður Sigurðardóttir", "4", "3284")
		);
	if($db_man->bookFlight('FA501','2014-05-01',2,'Margrét Benediktsdóttir','VISA',$passengers))
	{
		print "Success";

	}
	else
	{
		print "failed";
	}*/
	//print_r($db_man->listAircrafts());
	//print_r($db_man->listAirports());
	//print_r($db_man->listPriceCategories());
	//print_r($db_man->listDestinations());
	//print_r($db_man->listFlightSchedules());
?>
</a>
</body>
</html>