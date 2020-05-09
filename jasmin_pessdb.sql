-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2020 at 12:05 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jasmin_pessdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `dispatch`
--

CREATE TABLE `dispatch` (
  `incidentld` int(11) NOT NULL,
  `patrolcarId` varchar(10) CHARACTER SET latin1 NOT NULL,
  `timeDispatched` datetime NOT NULL,
  `timeArrived` datetime DEFAULT NULL,
  `timeCompleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `dispatch`
--

INSERT INTO `dispatch` (`incidentld`, `patrolcarId`, `timeDispatched`, `timeArrived`, `timeCompleted`) VALUES
(10, 'QX1111J', '2020-05-08 00:29:43', NULL, NULL),
(11, 'QX1111J', '2020-05-08 00:29:47', NULL, NULL),
(12, 'QX1234A', '2020-05-08 00:30:17', '2020-05-08 17:35:19', NULL),
(13, 'QX1234A', '2020-05-08 00:31:34', '2020-05-08 17:35:19', NULL),
(14, 'QX2288D', '2020-05-08 00:31:39', NULL, NULL),
(15, 'QX2222K', '2020-05-08 00:31:53', NULL, NULL),
(16, 'QX1111J', '2020-05-08 13:10:31', NULL, NULL),
(17, 'QX1234A', '2020-05-08 15:51:42', '2020-05-08 17:35:19', NULL),
(18, 'QX2222K', '2020-05-08 17:36:59', NULL, NULL),
(19, 'QX2288D', '2020-05-08 17:39:08', NULL, NULL),
(20, 'QX1111J', '2020-05-08 17:42:39', NULL, NULL),
(21, 'QX1111J', '2020-05-08 17:45:19', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `incident`
--

CREATE TABLE `incident` (
  `incidentld` int(11) NOT NULL,
  `callerName` varchar(30) CHARACTER SET latin1 NOT NULL,
  `phoneNumber` varchar(10) CHARACTER SET latin1 NOT NULL,
  `incidentTypeId` varchar(3) CHARACTER SET latin1 NOT NULL,
  `incidentLocation` varchar(50) CHARACTER SET latin1 NOT NULL,
  `incidentDesc` varchar(100) CHARACTER SET latin1 NOT NULL,
  `incidentStatusId` varchar(1) CHARACTER SET latin1 NOT NULL,
  `timeCalled` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `incident`
--

INSERT INTO `incident` (`incidentld`, `callerName`, `phoneNumber`, `incidentTypeId`, `incidentLocation`, `incidentDesc`, `incidentStatusId`, `timeCalled`) VALUES
(16, 'annoyomus', '12345678', '010', 'ITE COLLEGE CENTRAL', 'There is a fire the school!', '2', '2020-05-08 05:10:31'),
(17, 'Jerry Lee', '81327689', '010', 'Yishun', 'There is a fire near my house.', '2', '2020-05-08 07:51:42'),
(18, 'Jerry Lee', '12345678', '010', 'Yishun', 'Fire in the house!', '2', '2020-05-08 09:36:59'),
(19, 'Jerry Lee', '12345678', '010', 'Yishun', 'Fire in the house!', '2', '2020-05-08 09:39:08'),
(20, 'annoyomus', '12345678', '020', 'ITE COLLEGE CENTRAL', 'Riot in the nearby street!', '2', '2020-05-08 09:42:39'),
(21, 'Jerry Lee', '12345678', '030', 'Yishun', 'There is a Burglary in the house!', '2', '2020-05-08 09:45:19');

-- --------------------------------------------------------

--
-- Table structure for table `incidenttype`
--

CREATE TABLE `incidenttype` (
  `incidentTypeId` varchar(3) CHARACTER SET latin1 NOT NULL,
  `incidentTypeDesc` varchar(20) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `incidenttype`
--

INSERT INTO `incidenttype` (`incidentTypeId`, `incidentTypeDesc`) VALUES
('010', 'Fire'),
('020', 'Riot'),
('030', 'Burglary'),
('040', 'Domestic Violent'),
('050', 'Fallen Tree'),
('060', 'Traffic Accident '),
('070', 'Loan Shark'),
('999', 'Other');

-- --------------------------------------------------------

--
-- Table structure for table `incident_status`
--

CREATE TABLE `incident_status` (
  `statusId` varchar(1) CHARACTER SET latin1 NOT NULL,
  `statusDesc` varchar(20) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `incident_status`
--

INSERT INTO `incident_status` (`statusId`, `statusDesc`) VALUES
('1', 'Pending'),
('2', 'Dispatched'),
('3', 'Completed'),
('4', 'Duplicate');

-- --------------------------------------------------------

--
-- Table structure for table `patrolcar`
--

CREATE TABLE `patrolcar` (
  `patrolcarId` varchar(10) CHARACTER SET latin1 NOT NULL,
  `patrolcarStatusId` varchar(1) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patrolcar`
--

INSERT INTO `patrolcar` (`patrolcarId`, `patrolcarStatusId`) VALUES
('QX1111J', '3'),
('QX1234A', '4'),
('QX1342G', '4'),
('QX2222K', '3'),
('QX2288D', '3'),
('QX3456B', '2'),
('QX5555D', '4'),
('QX8723W', '4'),
('QX8769P', '4'),
('QX8923T', '2');

-- --------------------------------------------------------

--
-- Table structure for table `patrolcar_status`
--

CREATE TABLE `patrolcar_status` (
  `statusId` varchar(1) CHARACTER SET latin1 NOT NULL,
  `statusDesc` varchar(20) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patrolcar_status`
--

INSERT INTO `patrolcar_status` (`statusId`, `statusDesc`) VALUES
('1', 'Dispatched'),
('2', 'Patrol'),
('3', 'Free'),
('4', 'Arrived');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dispatch`
--
ALTER TABLE `dispatch`
  ADD PRIMARY KEY (`incidentld`,`patrolcarId`);

--
-- Indexes for table `incident`
--
ALTER TABLE `incident`
  ADD PRIMARY KEY (`incidentld`);

--
-- Indexes for table `incidenttype`
--
ALTER TABLE `incidenttype`
  ADD PRIMARY KEY (`incidentTypeId`);

--
-- Indexes for table `incident_status`
--
ALTER TABLE `incident_status`
  ADD PRIMARY KEY (`statusId`);

--
-- Indexes for table `patrolcar`
--
ALTER TABLE `patrolcar`
  ADD PRIMARY KEY (`patrolcarId`);

--
-- Indexes for table `patrolcar_status`
--
ALTER TABLE `patrolcar_status`
  ADD PRIMARY KEY (`statusId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `incident`
--
ALTER TABLE `incident`
  MODIFY `incidentld` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
