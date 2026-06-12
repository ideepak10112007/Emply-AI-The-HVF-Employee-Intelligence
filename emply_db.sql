-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2026 at 12:33 PM
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
-- Database: `emply_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `att_id` int(11) NOT NULL,
  `emp_id` int(11) DEFAULT NULL,
  `work_date` date DEFAULT curdate(),
  `status` enum('Present','Absent','On Leave') DEFAULT 'Present'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`att_id`, `emp_id`, `work_date`, `status`) VALUES
(1, 1, '2026-05-17', 'Present'),
(2, 2, '2026-05-17', 'Present'),
(3, 3, '2026-05-17', 'Absent'),
(4, 4, '2026-05-17', 'Present'),
(5, 5, '2026-05-17', 'Present'),
(6, 6, '2026-05-17', 'Present'),
(7, 7, '2026-05-17', 'Present'),
(8, 8, '2026-05-17', 'Absent'),
(9, 9, '2026-05-17', 'On Leave'),
(10, 10, '2026-05-17', 'Present'),
(11, 11, '2026-05-17', 'Present'),
(12, 12, '2026-05-17', 'Present'),
(13, 13, '2026-05-17', 'On Leave'),
(14, 14, '2026-05-17', 'Present'),
(15, 15, '2026-05-17', 'Present');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `emp_id` int(11) NOT NULL,
  `emp_code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL,
  `joining_date` date DEFAULT curdate()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`emp_id`, `emp_code`, `name`, `designation`, `section_id`, `salary`, `blood_group`, `joining_date`) VALUES
(1, 'HVF-1001', 'R IYAPPAN', 'Senior Welder', 1, 54000.00, 'O+', '2006-05-17'),
(2, 'HVF-1002', 'Sudracholan', 'Junior Engineer', 1, 48500.00, 'B+', '2026-05-17'),
(3, 'HVF-1003', 'Aravind Swamy', 'Technical Assistant', 1, 41000.00, 'A+', '2026-05-17'),
(4, 'HVF-2001', 'Bitopan Das', 'JWM', 6, 89000.00, 'AB+', '2026-05-17'),
(5, 'HVF-2002', 'Senthil Balaji', 'Heavy Fitter', 2, 46000.00, 'O-', '2026-05-17'),
(6, 'HVF-2003', 'Rajesh Sharma', 'Hull Inspector', 2, 51000.00, 'B-', '2026-05-17'),
(7, 'HVF-3001', 'Natarajan', 'JWM', 6, 92000.00, 'A-', '2026-05-17'),
(8, 'HVF-3002', 'Manoj Kumar', 'Die Polisher', 3, 38000.00, 'O+', '2026-05-17'),
(9, 'HVF-4001', 'K. Manikandan', 'Engine Assembler', 4, 49000.00, 'AB-', '2026-05-17'),
(10, 'HVF-4002', 'Sanjay Dutt', 'Machinist Grade-I', 4, 44000.00, 'O+', '2026-05-17'),
(11, 'HVF-5001', 'Suresh Kumar', 'Assembly Supervisor', 5, 56000.00, 'B+', '2026-05-17'),
(12, 'HVF-5002', 'Amitabh Bachchan', 'Quality Controller', 5, 58000.00, 'A+', '2026-05-17'),
(13, 'HVF-5003', 'Lakshmi Priya', 'Senior Clerk', 5, 36000.00, 'O-', '2026-05-17'),
(14, 'HVF-6001', 'Sekar', 'JWM', 6, 98000.00, 'B+', '2026-05-17'),
(15, 'HVF-6002', 'Meena Kumari', 'Training Instructor', 6, 45000.00, 'A+', '2026-05-17'),
(16, 'HVF-1004', 'K. Srinivasan', 'Senior Clerk', 1, 38000.00, 'A+', '2026-05-28'),
(17, 'HVF-1005', 'M. Abdul Rahman', 'Storekeeper Grade-I', 1, 42000.00, 'O+', '2026-05-28'),
(18, 'HVF-1006', 'P. Shanthi', 'Administrative Officer', 1, 55000.00, 'B+', '2026-05-28'),
(19, 'HVF-1007', 'V. Rajesh Kumar', 'Data Entry Operator', 1, 31000.00, 'AB+', '2026-05-28'),
(20, 'HVF-1008', 'S. Meenakshi', 'Junior Accountant', 1, 44000.00, 'A-', '2026-05-28'),
(21, 'HVF-1009', 'R. Venkatesh', 'Office Superintendent', 1, 58000.00, 'O-', '2026-05-28'),
(22, 'HVF-1010', 'A. John Peter', 'Security Inspector', 1, 41000.00, 'B-', '2026-05-28'),
(23, 'HVF-1011', 'T. Kavitha', 'Stenographer Grade-I', 1, 36000.00, 'O+', '2026-05-28'),
(24, 'HVF-1012', 'G. Hariharan', 'Logistics Coordinator', 1, 46000.00, 'B+', '2026-05-28'),
(25, 'HVF-1013', 'D. Selvam', 'Inventory Controller', 1, 45000.00, 'A+', '2026-05-28'),
(26, 'HVF-1014', 'N. Lakshmi', 'Records Assistant', 1, 32000.00, 'AB-', '2026-05-28'),
(27, 'HVF-1015', 'K. Elangovan', 'Dispatch Supervisor', 1, 49000.00, 'O+', '2026-05-28'),
(28, 'HVF-1016', 'J. Sophia', 'Material Planner', 1, 47000.00, 'B+', '2026-05-28'),
(29, 'HVF-1017', 'M. Saravanan', 'SMS Supervisor', 1, 52000.00, 'A+', '2026-05-28'),
(30, 'HVF-2004', 'K. Jagadeesan', 'Structural Welder', 2, 44000.00, 'O+', '2026-05-28'),
(31, 'HVF-2005', 'M. Palanivel', 'Heavy Plate Fitter', 2, 46500.00, 'B+', '2026-05-28'),
(32, 'HVF-2006', 'S. Gunasekaran', 'Gas Cutter Grade-I', 2, 41000.00, 'A+', '2026-05-28'),
(33, 'HVF-2007', 'B. Ramachandran', 'Crane Operator Grade-II', 2, 39500.00, 'AB+', '2026-05-28'),
(34, 'HVF-2008', 'R. Thangavel', 'Senior Fabricator', 2, 52000.00, 'O-', '2026-05-28'),
(35, 'HVF-2009', 'P. Murugan', 'Grinder Specialist', 2, 38000.00, 'B-', '2026-05-28'),
(36, 'HVF-2010', 'A. Syed Ibrahim', 'Hull NDT Inspector', 2, 54000.00, 'A-', '2026-05-28'),
(37, 'HVF-2011', 'V. Anandakrishnan', 'Welding Supervisor', 2, 57000.00, 'O+', '2026-05-28'),
(38, 'HVF-2012', 'S. Vijayakumar', 'Rigging Fitter', 2, 43000.00, 'B+', '2026-05-28'),
(39, 'HVF-2013', 'D. Rajendran', 'Heavy Duty Machinist', 2, 47000.00, 'A+', '2026-05-28'),
(40, 'HVF-2014', 'C. Jayachandran', 'Safety Inspector', 2, 48000.00, 'AB-', '2026-05-28'),
(41, 'HVF-2015', 'M. Kartheesan', 'Assistant Welder', 2, 34000.00, 'O+', '2026-05-28'),
(42, 'HVF-2016', 'G. Balasubramanian', 'Hull Assembly Fitter', 2, 46000.00, 'B+', '2026-05-28'),
(43, 'HVF-2017', 'K. Devanathan', 'Metal Metallurgist', 2, 65000.00, 'A+', '2026-05-28'),
(44, 'HVF-3003', 'T. Shanmugam', 'Die Designer', 3, 61000.00, 'B+', '2026-05-28'),
(45, 'HVF-3004', 'P. Krishnamoorthy', 'CNC Programmer', 3, 55000.00, 'O+', '2026-05-28'),
(46, 'HVF-3005', 'R. Loganathan', 'Tool Room Machinist', 3, 46000.00, 'A+', '2026-05-28'),
(47, 'HVF-3006', 'M. Senthil Kumar', 'Heat Treatment Tech', 3, 44500.00, 'AB+', '2026-05-28'),
(48, 'HVF-3007', 'V. Ramakrishnan', 'Die Hardening Operator', 3, 43000.00, 'O-', '2026-05-28'),
(49, 'HVF-3008', 'K. Perumal', 'Surface Grinder Specialist', 3, 41000.00, 'A-', '2026-05-28'),
(50, 'HVF-3009', 'S. Thirunavukkarasu', 'Precision Fitter', 3, 48000.00, 'B-', '2026-05-28'),
(51, 'HVF-30010', 'A. Albert Raj', 'Die Maintenance Tech', 3, 45000.00, 'O+', '2026-05-28'),
(52, 'HVF-3011', 'G. Kathiresan', 'Tool Inspector', 3, 50000.00, 'B+', '2026-05-28'),
(53, 'HVF-3012', 'D. Chandrasekaran', 'Milling Machine Operator', 3, 42500.00, 'A+', '2026-05-28'),
(54, 'HVF-3013', 'E. Vivekanand', 'Die shop Assistant', 3, 33000.00, 'AB-', '2026-05-28'),
(55, 'HVF-3014', 'N. Mohan Raj', 'CAD/CAM Engineer', 3, 58000.00, 'O+', '2026-05-28'),
(56, 'HVF-3015', 'R. Sivakumar', 'Senior Die Maker', 3, 59000.00, 'B+', '2026-05-28'),
(57, 'HVF-3016', 'J. Baskaran', 'Metallurgical Inspector', 3, 53000.00, 'A+', '2026-05-28'),
(58, 'HVF-4003', 'V. Balaji', 'Engine Calibration Tech', 4, 52000.00, 'O+', '2026-05-28'),
(59, 'HVF-4004', 'M. Ganesan', 'Turbocharger Tester', 4, 49500.00, 'B+', '2026-05-28'),
(60, 'HVF-4005', 'S. Prakash', 'Heavy Engine Fitter', 4, 47000.00, 'A+', '2026-05-28'),
(61, 'HVF-4006', 'K. Suresh Kumar', 'Cylinder Head Machinist', 4, 46000.00, 'AB+', '2026-05-28'),
(62, 'HVF-4007', 'R. Janarthanan', 'Engine Dynamometer Op', 4, 51000.00, 'O-', '2026-05-28'),
(63, 'HVF-4008', 'P. Dharmalingam', 'Fuel Injection Specialist', 4, 54000.00, 'A-', '2026-05-28'),
(64, 'HVF-4009', 'A. Munusamy', 'Transmission Assembler', 4, 48000.00, 'B-', '2026-05-28'),
(65, 'HVF-4010', 'T. Chidambaram', 'Engine Quality Auditor', 4, 56000.00, 'O+', '2026-05-28'),
(66, 'HVF-4011', 'G. Parthiban', 'Pneumatic Tech', 4, 44000.00, 'B+', '2026-05-28'),
(67, 'HVF-4012', 'D. Sekaran', 'Crankshaft Grinder', 4, 47500.00, 'A+', '2026-05-28'),
(68, 'HVF-4013', 'M. Dinakaran', 'Engine Shop Supervisor', 4, 60000.00, 'AB-', '2026-05-28'),
(69, 'HVF-4014', 'N. Radhakrishnan', 'Lubrication Engineer', 4, 63000.00, 'O+', '2026-05-28'),
(70, 'HVF-4015', 'K. Viswanathan', 'Assembly Fitter Grade-I', 4, 45000.00, 'B+', '2026-05-28'),
(71, 'HVF-4016', 'S. Kumaresan', 'Engine Test Bed Operator', 4, 50000.00, 'A+', '2026-05-28'),
(72, 'HVF-4017', 'L. Madhavan', 'Senior Engine Tester', 4, 55000.00, 'O+', '2026-05-28'),
(73, 'HVF-5004', 'G. Ravindran', 'Track Line Fitter', 5, 46000.00, 'A+', '2026-05-28'),
(74, 'HVF-5005', 'S. Balasubramaniam', 'Turret Assembler', 5, 52000.00, 'O+', '2026-05-28'),
(75, 'HVF-5006', 'M. Paneerselvam', 'Hydraulic Systems Tech', 5, 53500.00, 'B+', '2026-05-28'),
(76, 'HVF-5007', 'K. Govindaraj', 'Armament Fitter', 5, 56000.00, 'AB+', '2026-05-28'),
(77, 'HVF-5008', 'R. Madhavan', 'Optics Alignment Tech', 5, 58000.00, 'O-', '2026-05-28'),
(78, 'HVF-5009', 'P. Veeramani', 'Electrical Harnessing Tech', 5, 44000.00, 'A-', '2026-05-28'),
(79, 'HVF-5010', 'A. Swaminathan', 'Final Assembly Inspector', 5, 61000.00, 'B-', '2026-05-28'),
(80, 'HVF-5011', 'V. Durairaj', 'Suspension Fitter', 5, 47000.00, 'O+', '2026-05-28'),
(81, 'HVF-5012', 'T. Gnanasekar', 'Paint Shop Specialist', 5, 41000.00, 'B+', '2026-05-28'),
(82, 'HVF-5013', 'D. Kalyanasundaram', 'Fitment Supervisor', 5, 59000.00, 'A+', '2026-05-28'),
(83, 'HVF-5014', 'N. Shanmughanathan', 'HVF Trial Driver', 5, 50000.00, 'AB-', '2026-05-28'),
(84, 'HVF-5015', 'K. Rajamani', 'Electronic Systems Fitter', 5, 51000.00, 'O+', '2026-05-28'),
(85, 'HVF-5016', 'S. Jayaraman', 'Under-Carriage Fitter', 5, 45500.00, 'B+', '2026-05-28'),
(86, 'HVF-5017', 'M. Thirumoorthy', 'Assembly Superintendent', 5, 68000.00, 'A+', '2026-05-28'),
(87, 'HVF-6003', 'Dr. S. Arul Raj', 'Senior Training Officer', 6, 68000.00, 'O+', '2026-05-28'),
(88, 'HVF-6004', 'K. Padmanabhan', 'Technical Instructor', 6, 48000.00, 'B+', '2026-05-28'),
(89, 'HVF-6005', 'M. Bhuvana', 'Computer Lab Instructor', 6, 43000.00, 'A+', '2026-05-28'),
(90, 'HVF-6006', 'R. Prem Kumar', 'Apprentice Coordinator', 6, 46000.00, 'AB+', '2026-05-28'),
(91, 'HVF-6007', 'S. Rajeshwari', 'Training Assistant', 6, 37000.00, 'O-', '2026-05-28'),
(92, 'HVF-6008', 'P. Thangaraj', 'Workshop Instructor', 6, 49000.00, 'A-', '2026-05-28'),
(93, 'HVF-6009', 'A. Nirmala', 'Placement Officer', 6, 52000.00, 'B-', '2026-05-28'),
(94, 'HVF-6010', 'V. Sriram', 'Safety Training Expert', 6, 55000.00, 'O+', '2026-05-28'),
(95, 'HVF-6011', 'T. Umarani', 'Vocational Counsellor', 6, 44000.00, 'B+', '2026-05-28'),
(96, 'HVF-6012', 'D. Christopher', 'Electronics Instructor', 6, 48500.00, 'A+', '2026-05-28'),
(97, 'HVF-6013', 'M. Senthamarai', 'Library In-Charge', 6, 35000.00, 'AB-', '2026-05-28'),
(98, 'HVF-6014', 'N. Gurumoorthy', 'ITC Administration Head', 6, 64000.00, 'O+', '2026-05-28'),
(99, 'HVF-6015', 'K. Subhashini', 'Curriculum Developer', 6, 51000.00, 'B+', '2026-05-28'),
(100, 'HVF-6016', 'S. Marimuthu', 'Senior Technical Assistant', 6, 50000.00, 'A+', '2026-05-28');

--
-- Triggers `employees`
--
DELIMITER $$
CREATE TRIGGER `after_employee_delete` AFTER DELETE ON `employees` FOR EACH ROW BEGIN
    UPDATE sections 
    SET employee_count = employee_count - 1 
    WHERE section_id = OLD.section_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_employee_insert` AFTER INSERT ON `employees` FOR EACH ROW BEGIN
    UPDATE sections 
    SET employee_count = employee_count + 1 
    WHERE section_id = NEW.section_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_leaves`
--

CREATE TABLE `employee_leaves` (
  `leave_id` int(11) NOT NULL,
  `emp_id` int(11) DEFAULT NULL,
  `leave_type` enum('Medical','Casual','Earned','Maternity/Paternity') DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `status` enum('Approved','Pending','Rejected') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee_leaves`
--

INSERT INTO `employee_leaves` (`leave_id`, `emp_id`, `leave_type`, `start_date`, `end_date`, `reason`, `status`) VALUES
(1, 1, 'Casual', '2026-05-01', '2026-05-02', 'Personal Work', 'Approved'),
(2, 2, 'Medical', '2026-04-10', '2026-04-12', 'Fever', 'Approved'),
(3, 6, 'Casual', '2026-05-20', '2026-05-21', 'Urgent Matter', 'Pending'),
(4, 7, 'Earned', '2026-06-01', '2026-06-10', 'Summer Vacation', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `section_id` int(11) NOT NULL,
  `section_name` varchar(100) NOT NULL,
  `office_location` varchar(100) DEFAULT NULL,
  `employee_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`section_id`, `section_name`, `office_location`, `employee_count`) VALUES
(1, 'SMS', NULL, 17),
(2, 'Hull Shop', NULL, 16),
(3, 'Tank Shop', NULL, 16),
(4, 'Turret Shop', NULL, 17),
(5, 'Assembly Shop', NULL, 17),
(6, 'I.T.C', NULL, 18);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`att_id`),
  ADD KEY `emp_id` (`emp_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_id`),
  ADD UNIQUE KEY `emp_code` (`emp_code`),
  ADD KEY `section_id` (`section_id`);

--
-- Indexes for table `employee_leaves`
--
ALTER TABLE `employee_leaves`
  ADD PRIMARY KEY (`leave_id`),
  ADD KEY `emp_id` (`emp_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`section_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `att_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `employee_leaves`
--
ALTER TABLE `employee_leaves`
  MODIFY `leave_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `section_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`emp_id`) ON DELETE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE SET NULL;

--
-- Constraints for table `employee_leaves`
--
ALTER TABLE `employee_leaves`
  ADD CONSTRAINT `employee_leaves_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`emp_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
