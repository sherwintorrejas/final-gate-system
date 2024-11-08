-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2024 at 04:24 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gatesystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `aid` int(100) NOT NULL,
  `stid` int(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `category` enum('HR','REGISTRAR','TECHNICAL SUPPORT','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`aid`, `stid`, `password`, `category`) VALUES
(12, 2, '$2y$10$6xBuak369Bg3Kvmp3sPSYuvCns8ZTSRKw8uE.m9DJxb3p63plXVq.', 'REGISTRAR');

-- --------------------------------------------------------

--
-- Table structure for table `blockrfd`
--

CREATE TABLE `blockrfd` (
  `bid` int(10) NOT NULL,
  `sid` int(20) DEFAULT NULL,
  `stid` int(20) DEFAULT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dailylogs`
--

CREATE TABLE `dailylogs` (
  `lid` int(10) NOT NULL,
  `sid` int(20) DEFAULT NULL,
  `stid` int(20) DEFAULT NULL,
  `datetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category` enum('IN','OUT','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dailylogs`
--

INSERT INTO `dailylogs` (`lid`, `sid`, `stid`, `datetime`, `category`) VALUES
(282, 18, NULL, '2024-10-28 06:12:46', 'IN'),
(283, 18, NULL, '2024-10-28 06:14:07', 'OUT'),
(284, 24, NULL, '2024-10-28 06:14:21', 'IN'),
(285, 24, NULL, '2024-10-28 06:14:45', 'OUT'),
(286, 34, NULL, '2024-10-28 06:14:51', 'IN'),
(287, 34, NULL, '2024-10-28 06:15:01', 'OUT'),
(288, 37, NULL, '2024-10-28 06:15:23', 'IN'),
(289, 37, NULL, '2024-10-28 06:15:34', 'OUT'),
(290, 28, NULL, '2024-10-28 06:15:48', 'IN'),
(291, 36, NULL, '2024-10-28 06:16:15', 'IN'),
(292, 36, NULL, '2024-10-28 06:16:25', 'OUT'),
(293, 18, NULL, '2024-10-28 06:16:38', 'IN'),
(294, 18, NULL, '2024-10-28 06:16:46', 'OUT'),
(295, 36, NULL, '2024-10-28 06:16:55', 'IN'),
(296, 37, NULL, '2024-10-28 06:17:08', 'IN'),
(297, 18, NULL, '2024-10-28 06:17:50', 'IN'),
(298, 18, NULL, '2024-10-28 06:18:00', 'OUT'),
(299, 24, NULL, '2024-10-28 06:18:08', 'IN'),
(300, 24, NULL, '2024-10-28 06:18:47', 'OUT'),
(301, 24, NULL, '2024-10-28 06:18:50', 'IN'),
(302, 24, NULL, '2024-10-28 06:19:11', 'OUT'),
(303, 24, NULL, '2024-10-28 06:19:18', 'IN'),
(304, 18, NULL, '2024-10-28 06:45:19', 'IN'),
(305, 18, NULL, '2024-10-28 06:46:16', 'OUT'),
(306, 18, NULL, '2024-10-28 06:46:31', 'IN'),
(307, 18, NULL, '2024-10-28 06:49:11', 'OUT'),
(308, 18, NULL, '2024-10-28 06:49:36', 'IN'),
(309, 18, NULL, '2024-10-28 06:51:14', 'OUT'),
(310, 18, NULL, '2024-10-28 06:52:21', 'IN'),
(311, 18, NULL, '2024-10-28 06:52:43', 'OUT'),
(312, NULL, 1, '2024-10-28 06:57:16', 'IN'),
(313, NULL, 1, '2024-10-28 06:57:19', 'OUT'),
(314, NULL, 4, '2024-10-28 06:57:22', 'IN'),
(315, NULL, 4, '2024-10-28 06:57:25', 'OUT'),
(316, NULL, 2, '2024-10-28 06:57:31', 'IN'),
(317, NULL, 2, '2024-10-28 06:57:33', 'OUT'),
(318, 37, NULL, '2024-10-29 02:57:33', 'IN'),
(319, NULL, 2, '2024-10-29 02:58:07', 'IN'),
(320, NULL, 1, '2024-10-29 02:58:15', 'IN'),
(321, NULL, 1, '2024-10-29 03:03:19', 'OUT'),
(322, NULL, 2, '2024-10-29 03:03:23', 'OUT'),
(323, 37, NULL, '2024-10-29 03:03:27', 'OUT');

-- --------------------------------------------------------

--
-- Table structure for table `information`
--

CREATE TABLE `information` (
  `did` int(100) NOT NULL,
  `schoolid` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL,
  `category` enum('student','staff','','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `information`
--

INSERT INTO `information` (`did`, `schoolid`, `name`, `department`, `category`) VALUES
(1, 'SCC-STFF-0002', 'Cruz, Brehwin ', 'Registrar', 'staff'),
(2, 'SCC-STFF-0003', 'Sayaboc, Kia Shaendy ', 'Accounting', 'staff'),
(3, 'SCC-STFF-0004', 'Canoy, Ronaly ', 'Registrar', 'staff'),
(4, 'SCC-STFF-0005', 'Libusana, Marivic', 'Registrar', 'staff'),
(5, 'SCC-STFF-0006', 'Rondes, Leneth ', 'Registrar', 'staff'),
(6, 'SCC-STFF-0007', 'Baroman, Gabrielle  ', 'Scholarship', 'staff'),
(7, 'SCC-STFF-0008', 'Daguplo, Gemini', 'Scholarship', 'staff'),
(8, 'SCC-STFF-0009', 'Deiparine , James', 'Scholarship', 'staff'),
(9, 'SCC-STFF-0010', 'Sacol, Micheal', 'HR', 'staff'),
(10, 'SCC-STFF-0011', 'Fernandez, Sheila', 'HR', 'staff'),
(11, 'SCC-STFF-0012', 'Cutas,Jericho Vic', 'HR', 'staff'),
(12, 'SCC-21-00013582', 'Acidillo , Baby John', 'BSIT ', 'student'),
(13, 'SCC-21-00013583', 'Amante , Christel Mae', 'BSIT ', 'student'),
(14, 'SCC-21-00013584', 'Bendanillo , Christine', 'BSIT ', 'student'),
(15, 'SCC-21-00013585', 'Celis , Rodel', 'BSIT ', 'student'),
(16, 'SCC-21-00013586', 'Caminos , Sarah', 'BSIT ', 'student'),
(17, 'SCC-21-00013587', 'Canono , Christian', 'BSIT ', 'student'),
(18, 'SCC-21-00013588', 'Casia , Sweet Venice', 'Grade 5', 'student'),
(19, 'SCC-21-00013589', 'Deiparine , Caryll Jean', 'BSIT ', 'student'),
(20, 'SCC-21-00013590', 'Gabutero , Angel', 'BSIT ', 'student'),
(21, 'SCC-21-00013591', 'Delicano , Ryle Aeron', 'BSIT ', 'student'),
(22, 'SCC-21-00013592', 'Ipon , Darla Kayla', 'BSIT ', 'student'),
(23, 'SCC-21-00013593', 'Isidoro , Kyle', 'BSIT ', 'student'),
(24, 'SCC-21-00013594', 'Labora , Justine', 'BSIT ', 'student'),
(25, 'SCC-21-00013595', 'Lapiz , Maria Ana', 'BSIT ', 'student'),
(26, 'SCC-21-00013596', 'Laroa , Ryan ky', 'BSIT ', 'student'),
(27, 'SCC-21-00013597', 'Macua , Cosam John', 'BSIT ', 'student'),
(28, 'SCC-21-00013598', 'Omambac , Junmark', 'BSIT ', 'student'),
(29, 'SCC-21-00013599', 'Ortega , Matt Lovell', 'BSIT ', 'student'),
(30, 'SCC-21-00013600', 'Padigos , Vhaugn Vincent', 'BSIT ', 'student'),
(31, 'SCC-21-00013601', 'Puerto , Jeralyn', 'BSIT ', 'student'),
(32, 'SCC-21-00013602', 'Recaña , Gian Heinrich', 'BSIT ', 'student'),
(33, 'SCC-21-00013603', 'Requinto , Bernadette', 'BSIT ', 'student'),
(34, 'SCC-21-00013604', 'Requinto , Rico Zen', 'BSIT ', 'student'),
(35, 'SCC-21-00013605', 'Siton , Edgardo', 'BSIT ', 'student'),
(36, 'SCC-21-00013606', 'Tapere , Judy', 'BSIT ', 'student'),
(37, 'SCC-21-00013607', 'Torrejas , Sherwin', 'BSIT ', 'student'),
(38, 'SCC-21-00013608', 'Ubas , Jose Nathaniel', 'BSIT ', 'student'),
(39, 'SCC-21-00013609', 'Villafuerte , Aeron', 'BSIT ', 'student'),
(40, 'SCC-21-00013610', 'Villareal , Arthur', 'BSIT ', 'student');

-- --------------------------------------------------------

--
-- Table structure for table `registaff`
--

CREATE TABLE `registaff` (
  `stid` int(10) NOT NULL,
  `did` int(10) NOT NULL,
  `cid` int(10) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registaff`
--

INSERT INTO `registaff` (`stid`, `did`, `cid`, `image`) VALUES
(1, 1, 15, '../../idpic/Staffinformation.png'),
(2, 2, 2, '../../idpic/man.png'),
(3, 3, 3, '../../idpic/REgistration Process.png'),
(4, 4, 19, '../../idpic/REports.png'),
(6, 6, 13, '../../idpic/Desktop - 1.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `registudent`
--

CREATE TABLE `registudent` (
  `sid` int(10) NOT NULL,
  `did` int(10) NOT NULL,
  `cid` int(10) NOT NULL,
  `guardiannumber` varchar(20) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registudent`
--

INSERT INTO `registudent` (`sid`, `did`, `cid`, `guardiannumber`, `image`) VALUES
(18, 18, 11, '+639981994340', '../../idpic/pexels-midlox-28734043.jpg'),
(20, 20, 21, '+639981994340', '../../idpic/notification.png'),
(24, 24, 17, '+639981994340', '../../idpic/man.png'),
(28, 28, 16, '+639981994340', '../../idpic/Import Process.png'),
(34, 34, 20, '+639981994340', '../../idpic/USecasemodel.png'),
(36, 36, 18, '+639981994340', '../../idpic/pexels-midlox-28734044.jpg'),
(37, 37, 4, '+639981994340', '../../idpic/heart.png');

-- --------------------------------------------------------

--
-- Table structure for table `rfid`
--

CREATE TABLE `rfid` (
  `cid` int(10) NOT NULL,
  `uid` varchar(20) NOT NULL,
  `timedate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rfid`
--

INSERT INTO `rfid` (`cid`, `uid`, `timedate`) VALUES
(2, 'd4224ca0', '2024-10-21 03:53:29'),
(3, '936dbfe4', '2024-10-21 03:53:39'),
(4, 'a4455ea1', '2024-10-22 07:07:19'),
(6, 'eca9422', '2024-10-22 07:07:45'),
(7, 'd4634a0', '2024-10-22 07:31:16'),
(8, '3c682d2', '2024-10-22 09:18:12'),
(11, '3C682D02', '2024-10-22 10:34:19'),
(12, 'D46304A0', '2024-10-22 10:36:10'),
(13, '69562D02', '2024-10-22 10:36:42'),
(14, 'ECA94202', '2024-10-22 10:37:15'),
(15, '43272E02', '2024-10-22 10:37:44'),
(16, 'F9873E02', '2024-10-22 10:38:16'),
(17, '1B96B502', '2024-10-22 10:38:57'),
(18, '557D2D02', '2024-10-22 10:39:31'),
(19, 'AED84002', '2024-10-22 10:39:52'),
(20, 'F49B2C02', '2024-10-22 10:40:39'),
(21, '54962D02', '2024-10-22 11:07:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`aid`),
  ADD KEY `stid` (`stid`);

--
-- Indexes for table `blockrfd`
--
ALTER TABLE `blockrfd`
  ADD PRIMARY KEY (`bid`),
  ADD KEY `sid` (`sid`),
  ADD KEY `stid` (`stid`);

--
-- Indexes for table `dailylogs`
--
ALTER TABLE `dailylogs`
  ADD PRIMARY KEY (`lid`),
  ADD KEY `sid` (`sid`),
  ADD KEY `stid` (`stid`);

--
-- Indexes for table `information`
--
ALTER TABLE `information`
  ADD PRIMARY KEY (`did`);

--
-- Indexes for table `registaff`
--
ALTER TABLE `registaff`
  ADD PRIMARY KEY (`stid`),
  ADD KEY `did` (`did`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `registudent`
--
ALTER TABLE `registudent`
  ADD PRIMARY KEY (`sid`),
  ADD KEY `did` (`did`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `rfid`
--
ALTER TABLE `rfid`
  ADD PRIMARY KEY (`cid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `aid` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `blockrfd`
--
ALTER TABLE `blockrfd`
  MODIFY `bid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `dailylogs`
--
ALTER TABLE `dailylogs`
  MODIFY `lid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=324;

--
-- AUTO_INCREMENT for table `information`
--
ALTER TABLE `information`
  MODIFY `did` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `registaff`
--
ALTER TABLE `registaff`
  MODIFY `stid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `registudent`
--
ALTER TABLE `registudent`
  MODIFY `sid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `rfid`
--
ALTER TABLE `rfid`
  MODIFY `cid` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`stid`) REFERENCES `registaff` (`stid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `blockrfd`
--
ALTER TABLE `blockrfd`
  ADD CONSTRAINT `blockrfd_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `registudent` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `blockrfd_ibfk_2` FOREIGN KEY (`stid`) REFERENCES `registaff` (`stid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dailylogs`
--
ALTER TABLE `dailylogs`
  ADD CONSTRAINT `dailylogs_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `registudent` (`sid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dailylogs_ibfk_2` FOREIGN KEY (`stid`) REFERENCES `registaff` (`stid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `registaff`
--
ALTER TABLE `registaff`
  ADD CONSTRAINT `registaff_ibfk_1` FOREIGN KEY (`did`) REFERENCES `information` (`did`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `registaff_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `rfid` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `registudent`
--
ALTER TABLE `registudent`
  ADD CONSTRAINT `registudent_ibfk_1` FOREIGN KEY (`did`) REFERENCES `information` (`did`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `registudent_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `rfid` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
