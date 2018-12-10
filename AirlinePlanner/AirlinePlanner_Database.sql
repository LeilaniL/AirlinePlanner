-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Dec 10, 2018 at 10:35 PM
-- Server version: 5.6.35
-- PHP Version: 7.0.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `airline-planner`
--

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`) VALUES
(1, 'Seattle'),
(2, 'New York');

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `dept_time` datetime NOT NULL,
  `dept_city_id` int(11) NOT NULL,
  `arr_time` datetime NOT NULL,
  `arr_city_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`id`, `status_id`, `dept_time`, `dept_city_id`, `arr_time`, `arr_city_id`) VALUES
(1, 1, '2018-09-11 14:00:00', 1, '2018-09-11 19:00:00', 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `flights_with_names`
-- (See below for the actual view)
--
CREATE TABLE `flights_with_names` (
`id` int(11)
,`status_id` int(11)
,`status_name` enum('On time','Delayed','Cancelled','Complete')
,`dept_time` datetime
,`dept_city_id` int(11)
,`dept_city_name` varchar(255)
,`arr_time` datetime
,`arr_city_id` int(11)
,`arr_city_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `name` enum('On time','Delayed','Cancelled','Complete') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `name`) VALUES
(1, 'On time'),
(2, 'Delayed'),
(3, 'Cancelled'),
(4, 'Complete');

-- --------------------------------------------------------

--
-- Structure for view `flights_with_names`
--
DROP TABLE IF EXISTS `flights_with_names`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `flights_with_names`  AS  (select `flights`.`id` AS `id`,`flights`.`status_id` AS `status_id`,`status`.`name` AS `status_name`,`flights`.`dept_time` AS `dept_time`,`flights`.`dept_city_id` AS `dept_city_id`,`dept_cities`.`name` AS `dept_city_name`,`flights`.`arr_time` AS `arr_time`,`flights`.`arr_city_id` AS `arr_city_id`,`arr_cities`.`name` AS `arr_city_name` from (((`flights` join `cities` `dept_cities` on((`flights`.`dept_city_id` = `dept_cities`.`id`))) join `cities` `arr_cities` on((`flights`.`arr_city_id` = `arr_cities`.`id`))) join `status` on((`flights`.`status_id` = `status`.`id`)))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status_id foreign key` (`status_id`),
  ADD KEY `dept_city_id foreign key` (`dept_city_id`),
  ADD KEY `arr_city_id foreign key` (`arr_city_id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `flights`
--
ALTER TABLE `flights`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `flights`
--
ALTER TABLE `flights`
  ADD CONSTRAINT `arr_city_id foreign key` FOREIGN KEY (`arr_city_id`) REFERENCES `cities` (`id`),
  ADD CONSTRAINT `dept_city_id foreign key` FOREIGN KEY (`dept_city_id`) REFERENCES `cities` (`id`),
  ADD CONSTRAINT `status_id foreign key` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);
