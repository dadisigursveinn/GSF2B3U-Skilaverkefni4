<?php
	/*
	 * @name: FreshAirDatabaseManager
	 * @role: manages all database transactions in freshair_international
	 * @version: 1.0.0
	 * @author: Daði Sigursveinn Harðarson
	 * @sice: 13-Nov-15
	 * @system: GSF2B3U - Tækniskólinn
	 */
	class DatabaseManager {

		private $connection;
		/*
		 * The class Constructor
		 * 
		 * @param string $server
		 * @param string $database
		 * @param string $user
		 * @param string $password
		 *
		 * @usage example $db_man = new DatabaseManager('127.0.0.1','feshair_international','user','password');
		 */
		public function __construct($server,$database,$user,$password)
		{
			try
			{
				$this->connection = new PDO("mysql:host=$server;dbname=$database", $user, $password);
			}
			catch (PDOException $e)
			{
				print $e;
			}
		}

		/*
		 * AircraftCRUD
		 * 
		 * @desc CRUD for table aircrafts
		 */
		public function newAircraft($id,$type,$maxPassangers,$enteredService,$name)
		{
			$statement = $this->connection->prepare('call CreateAircraft(?,?,?,?,?)');
			$statement->bindParam(1,$id);
			$statement->bindParam(2,$type);
			$statement->bindParam(3,$maxPassangers);
			$statement->bindParam(4,$enteredService);
			$statement->bindParam(5,$name);

			try
			{
				$statement->execute();
				
				return true;
			}
			catch(PDOException $e)
			{
				return false;
			}

		}
		public function getAircraft($id)
		{
			$statement = $this->connection->prepare('call ReadAircraft(?)');
			$statement->bindParam(1,$id);

			try
			{
				$statement->execute();
				
				$row = $statement->fetch(PDO::FETCH_NUM);
				return $row;
			}
			catch(PDOException $e)
			{
				return false;
			}
		}
		public function updateAircraft($id,$type,$maxPassangers,$enteredService,$name)
		{
			$statement = $this->connection->prepare('call UpdateAircarft(?,?,?,?,?)');
			$statement->bindParam(1,$id);
			$statement->bindParam(2,$type);
			$statement->bindParam(3,$maxPassangers);
			$statement->bindParam(4,$enteredService);
			$statement->bindParam(5,$name);

			try
			{
				$statement->execute();
				
				return true;
			}
			catch(PDOException $e)
			{
				return false;
			}
		}
		public function deleteAircraft($id)
		{
			$statement = $this->connection->prepare('call DeleteAircraft(?)');
			$statement->bindParam(1,$id);

			try
			{
				$statement->execute();
				
				return true;
			}
			catch(PDOException $e)
			{
				return false;
			}
		}

		/*
		 * numOfPassangers
		 *
		 * @param string $flightNumber
		 * @param string $flightDate
		 *
		 * @descDisplay number of passengers in a specific flight
		 */
		public function numOfPassangers($flightNumber, $flightDate)
		{
			$statement = $this->connection->prepare('SELECT ReservedSeats(?,?)');
			$statement->bindParam(1,$flightNumber);
			$statement->bindParam(2,$flightDate);

			try
			{
				$statement->execute();
				
				$row = $statement->fetch(PDO::FETCH_NUM);
				return $row;
			}
			catch(PDOException $e)
			{
				return false;
			}
		}

		/*
		 * Book passangers
		 *
		 * @param string $flightNumber
		 * @param date $flightDate
		 * @param string $classId
		 * @param string $cardholderName
		 * @param string $cardIssuer
		 * @param array $passengerInfo
		 * 
		 * passenger info skal vera tvívíð array
		 * passengerInfo inniheldur array af farþegum
		 * hver farþegi inniheldur
		 * $passengerID
		 * $passengerName
		 * $priceID
		 * $seatID
		 */
		public function bookFlight($flightNumber, $flightDate, $classId, $cardholderName, $cardIssuer, $passengerInfo)
		{
			$b = "";
			foreach ($passengerInfo as $passenger) {
				foreach ($passenger as $key) {
					$b .= $key;
					$b .= ";";
				}
			}
			$b .= "";
			$statement = $this->connection->prepare('call FlightBooker(?,?,?,?,?,?)');
			$statement->bindParam(1,$flightNumber);
			$statement->bindParam(2,$flightDate);
			$statement->bindParam(3,$classId);
			$statement->bindParam(4,$cardholderName);
			$statement->bindParam(5,$cardIssuer);
			$statement->bindParam(6,$b);

			try
			{
				$statement->execute();
				//return $b;
				return true;
			}
			catch(PDOException $e)
			{
				return false;
			}
			
		}
		/*
		 * Lists
		 *
		 * @author: Daði Sigursveinn Harðarson
		 *
		 */
		public function listAircrafts()
		{
			$statement = $this->connection->prepare('call ListOfAircrafts()');
			try
			{
				$arr = array();
				$statement->execute();
					while ($row = $statement->fetch(PDO::FETCH_NUM)) 
				{
					array_push($arr, $row);
				}
				return $arr;
				}
			catch(PDOException $e)
			{
				return array();
			}
		}
		public function listAirports()
		{
			$statement = $this->connection->prepare('call ListOfAirports()');
			try
			{
				$arr = array();
				$statement->execute();
					while ($row = $statement->fetch(PDO::FETCH_NUM)) 
				{
					array_push($arr, $row);
				}
				return $arr;
				}
			catch(PDOException $e)
			{
				return array();
			}
		}
		public function listPriceCategories()
		{
			$statement = $this->connection->prepare('call ListOfPriceCategories()');
			try
			{
				$arr = array();
				$statement->execute();
					while ($row = $statement->fetch(PDO::FETCH_NUM)) 
				{
					array_push($arr, $row);
				}
				return $arr;
				}
			catch(PDOException $e)
			{
				return array();
			}
		}
		public function listDestinations()
		{
			$statement = $this->connection->prepare('call ListOfDestinations()');
			try
			{
				$arr = array();
				$statement->execute();
					while ($row = $statement->fetch(PDO::FETCH_NUM)) 
				{
					array_push($arr, $row);
				}
				return $arr;
				}
			catch(PDOException $e)
			{
				return array();
			}
		}
		public function listFlightSchedules()
		{
			$statement = $this->connection->prepare('call ListOfFlightSchedules()');
			try
			{
				$arr = array();
				$statement->execute();
					while ($row = $statement->fetch(PDO::FETCH_NUM)) 
				{
					array_push($arr, $row);
				}
				return $arr;
				}
			catch(PDOException $e)
			{
				return array();
			}
		}
	}

?>