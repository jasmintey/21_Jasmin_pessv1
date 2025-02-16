<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Police Emergency Service System</title>
<link href="mystyle.css" rel="stylesheet" type="text/css">
</head>
<body>
<?php require_once 'nav.php'; ?>
	

<?php // if post back
if (isset($_POST["btnDispatch"]))
{
	require_once 'db_config.php';
	
	// create database connection
	$mysqli = mysqli_connect(DB_SERVER, DB_USER, DB_PASSWORD, DB_DATABASE);
	// Checck connection
	if ($mysqli->connect_errno)
	{
		die("Failed to connect to MySQL: ".$mysqli->connect_errno);
	}
	
	$patrolcarDispatched = $_POST["chkPatrolcar"]; // array of patrolcar being dispatched from post back 
	$numofpatrolcarDispatched = count($patrolcarDispatched);
	
	// insert new incident
	$incidentstatus;
	if ($numofpatrolcarDispatched > 0) {
	$incidentstatus='2'; // incident status to be set as Dispatched
} else {
		$incidentstatus='1'; // incident status to be set as Pending
	}
	
	$sql = "INSERT INTO incident (callerName, phoneNumber, incidentTypeId, incidentLocation, incidentDesc, incidentStatusId) VALUES (?, ?, ?, ?, ?, ?)";
	
	if (!($stmt = $mysqli->prepare($sql)))
	{
		die("Prepare failed1: ".$mysqli->errno);
	}
	
	if (!$stmt->bind_param('ssssss', $_POST['callerName'], $_POST['contactNo'], $_POST['incidenttype'], $_POST['Location'], $_POST['incidentDesc'], $incidentstatus))

	{
		die("Binding parameters failed: ".$stmt->errno);
	}
	
	if (!$stmt->execute())
	{
		die("Insert incident table failed: ".$stmt->errno);
	}
	
	// retrieve incident_id for the newly inserted incident
	$incidentId=mysqli_insert_id($mysqli);;
	
	// update patrolcar status table and add into disptach table
	for($i=0; $i < $numofpatrolcarDispatched; $i++)
	{
		// update patro car status
		$sql = "UPDATE patrolcar SET patrolcarStatusId = '1' WHERE patrolcarId = ?";
		
		if (!($stmt = $mysqli->prepare($sql))){
			die("Prepare failed2: ".$mysqli->errno);
		}
		
		if (!$stmt->bind_param('s', $patrolcarDispatched[$i])){
			die("Binding parameters failed: ".$stmt->errno);
		}
		
		if (!$stmt->execute()){
			die("Update patrolcar_status table failed: ".$stmt->errno);
		}
		
		// insert dispatch data 
		$sql = "INSERT INTO dispatch (incidentld, patrolcarId, timeDispatched) VALUES (?, ?, NOW())";
		
		if (!($stmt = $mysqli->prepare($sql)))
		{
			die("Prepare failed3: ".$mysqli->errno);
		}
		
		if (!$stmt->bind_param('ss', $incidentId, $patrolcarDispatched[$i])){
			die("Binding paramters failed: ".$stmt->errno);
		}
		
		if (!$stmt->execute()){
			die("Insert dispatch table failed: ".$stmt->errno);
		}
	
	}
	$stmt->close();
	
	$mysqli->close();
	
} ?>
<!--display the incident informtion passed from logcall.php-->
<form name="form1" method="post" action="<?php echo htmlentities($_SERVER['PHP_SELF']); ?> ">
<table>
<tr>
<td colspan="2">Incident Detail</td>
</tr>
<tr>
<td>Caller's Name :</td>
<td><?php echo $_POST['callerName'] ?>
<input type="hidden" name="callerName" id="callerName" value="<?php echo $_POST['callerName'] ?>"></td>
</tr>
<tr>
<td>Contact No :</td>
<td><?php echo $_POST['contactNo']?><input type="hidden" name="contactNo" id="contactNo" value="<?php echo $_POST['contactNo']?>"></td>
</tr>
<tr>
<td>Location :</td>
<td><?php echo $_POST['Location'] ?> <input type="hidden" name="Location" id="Location" value="<?php echo $_POST['Location'] ?>"></td>
</tr>
<tr>
<td>Incident Type :</td>
<td><?php echo $_POST['incidenttype'] ?> <input type="hidden" name="incidenttype" id="incidenttype" value="<?php echo $_POST['incidenttype'] ?>"></td>
</tr>
<tr>
<td>Description :</td>
<td><textarea name="incidentDesc" cols="45" rows="5" readonly id="incidentDesc"><?php echo $_POST['incidentDesc'] ?></textarea><input name="incidentDesc" type="hidden" id="incidentDesc" value="<?php echo $_POST['incidentDesc'] ?>"></td>
</tr>
</table>
<?php
// connect to a database
require_once 'db_config.php';
	
// create database connection
$mysqli = mysqli_connect(DB_SERVER, DB_USER, DB_PASSWORD, DB_DATABASE);
// Check connection
if ($mysqli->connect_errno) {
	die("Failed to connect to MySQL: ".$mysqli->connect_errno);
}

// retrieve from patrolcar table those patrolcar table  those patrol cars that are 2:Patrol or 3:Free
$sql = "SELECT patrolcarId, statusDesc FROM patrolcar JOIN patrolcar_status
ON patrolcar.patrolcarStatusId=patrolcar_status.statusId
WHERE patrolcar.patrolcarStatusId='2' OR patrolcar.patrolcarStatusId='3'";

if (!($stmt = $mysqli->prepare($sql))) {
	die("Prepare failed4: ".$mysqli->errno);
}
	
if (!$stmt->execute()) {
	die("Execute failed: ".$stmt->errno);
}
	
if (!($resultset = $stmt->get_result())) {
	die("Getting result set failed: ".$stmt->errno);
}

$patrolcarArray;
	
while ($row = $resultset->fetch_assoc()) {
	$patrolcarArray[$row['patrolcarId']] = $row['statusDesc'];
}
	
$stmt->close();
	
$resultset->close();
	
$mysqli->close();
?>
	
<!-- populate table with patrol car data -->
<br><br><table border="1" align="center">
<tr>
<td colspan="3">Dispatch Patrolcar Panel</td>	
</tr>
<?php
foreach($patrolcarArray as $key=>$value){
?>
<tr>
<td><input type="checkbox" name="chkPatrolcar[]" value="<?php echo $key?>"></td>
<td><?php echo $key ?></td>
<td><?php echo $value ?></td>
</tr>
<?php } ?>
<tr>
<td><input type="reset" name="btnCancel" id="btnCancel" value="Reset"</td>
<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="btnDispatch" id="btnDispatch" value="Dispatch">
</td>
</tr>
</table>
</form>
</body>
</html>