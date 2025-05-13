-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2025 at 07:14 PM
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
-- Database: `ussd_library_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `available_copies` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `category`, `available_copies`) VALUES
(1, 'The Great Gatsby', 'love', 98),
(2, 'To Kill a Mockingbird', 'fiction', 100),
(3, '1984', NULL, 1),
(4, 'Pride and Prejudice', 'Romance', 100),
(5, 'The Catcher in the Rye', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `borrowed_books`
--

CREATE TABLE `borrowed_books` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `borrowed_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowed_books`
--

INSERT INTO `borrowed_books` (`id`, `user_id`, `book_id`, `borrowed_at`) VALUES
(1, 1, 4, '2025-05-13 11:32:31'),
(2, 2, 5, '2025-05-13 14:19:34'),
(3, 2, 1, '2025-05-13 14:49:28'),
(4, 15, 1, '2025-05-13 19:00:37'),
(5, 18, 1, '2025-05-13 19:11:17');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `details` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `action`, `details`, `created_at`) VALUES
(1, 1, 'register', 'User registered with phone +250786182130', '2025-05-13 11:24:58'),
(2, 1, 'search', 'Searched for: hhh', '2025-05-13 11:31:56'),
(3, 1, 'borrow', 'Borrowed book ID: 4', '2025-05-13 11:32:31'),
(4, 2, 'register', 'User registered with phone +250785275073', '2025-05-13 12:31:01'),
(5, 2, 'menu', 'Viewed main menu', '2025-05-13 14:27:50'),
(6, 2, 'menu', 'Viewed main menu', '2025-05-13 14:28:05'),
(7, 2, 'exit', 'Exited menu', '2025-05-13 14:28:12'),
(8, 2, 'menu', 'Viewed main menu', '2025-05-13 14:28:20'),
(9, 2, 'menu', 'Viewed main menu', '2025-05-13 14:28:40'),
(10, 2, 'menu', 'Viewed main menu', '2025-05-13 14:28:53'),
(11, 2, 'menu', 'Viewed main menu', '2025-05-13 14:29:05'),
(12, 2, 'menu', 'Viewed main menu', '2025-05-13 14:29:18'),
(13, 2, 'menu', 'Viewed main menu', '2025-05-13 14:29:33'),
(14, 2, 'search_prompt', 'Prompted for book category', '2025-05-13 14:29:37'),
(15, 2, 'search', 'Searched for category: love', '2025-05-13 14:30:15'),
(16, 2, 'menu', 'Viewed main menu', '2025-05-13 14:38:42'),
(17, 2, 'menu', 'Viewed main menu', '2025-05-13 14:38:50'),
(18, 2, 'search_prompt', 'Prompted for book category', '2025-05-13 14:38:59'),
(19, 2, 'search', 'Searched for category: love', '2025-05-13 14:39:07'),
(20, 2, 'search_prompt', 'Prompted for book category', '2025-05-13 14:39:27'),
(21, 2, 'search', 'Searched for category: love', '2025-05-13 14:39:36'),
(22, 2, 'menu', 'Viewed main menu', '2025-05-13 14:39:50'),
(23, 2, 'menu', 'Viewed main menu', '2025-05-13 14:40:01'),
(24, 2, 'search_prompt', 'Prompted for book category', '2025-05-13 14:40:12'),
(25, 2, 'search', 'Searched for category: love', '2025-05-13 14:40:22'),
(26, 2, 'menu', 'Viewed main menu', '2025-05-13 14:41:09'),
(27, 2, 'menu', 'Viewed main menu', '2025-05-13 14:41:19'),
(28, 2, 'search_prompt', 'Prompted for book category', '2025-05-13 14:41:29'),
(29, 2, 'search', 'Searched for category: love', '2025-05-13 14:41:42'),
(30, 2, 'menu', 'Viewed main menu', '2025-05-13 14:42:06'),
(31, 2, 'menu', 'Viewed main menu', '2025-05-13 14:42:20'),
(32, 2, 'menu', 'Viewed main menu', '2025-05-13 14:48:28'),
(33, 2, 'menu', 'Viewed main menu', '2025-05-13 14:48:53'),
(34, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 14:49:08'),
(35, 2, 'borrow', 'Tried to borrow: The Great Gatsby', '2025-05-13 14:49:28'),
(36, 2, 'menu', 'Viewed main menu', '2025-05-13 14:55:56'),
(37, 2, 'menu', 'Viewed main menu', '2025-05-13 14:56:09'),
(38, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 14:56:24'),
(39, 2, 'borrow', 'Tried to borrow: Pride and Prejudice', '2025-05-13 14:56:51'),
(40, 2, 'menu', 'Viewed main menu', '2025-05-13 14:57:02'),
(41, 2, 'menu', 'Viewed main menu', '2025-05-13 14:57:07'),
(42, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 14:57:15'),
(43, 2, 'borrow', 'Tried to borrow: Pride and Prejudice', '2025-05-13 14:57:22'),
(44, 2, 'menu', 'Viewed main menu', '2025-05-13 14:57:32'),
(45, 2, 'menu', 'Viewed main menu', '2025-05-13 14:57:37'),
(46, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 14:57:52'),
(47, 2, 'borrow', 'Tried to borrow: Pride and Prejudice', '2025-05-13 14:58:02'),
(48, 2, 'menu', 'Viewed main menu', '2025-05-13 14:58:15'),
(49, 2, 'menu', 'Viewed main menu', '2025-05-13 14:59:19'),
(50, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 14:59:27'),
(51, 2, 'borrow', 'Tried to borrow: Pride and Prejudice', '2025-05-13 14:59:35'),
(52, 2, 'menu', 'Viewed main menu', '2025-05-13 14:59:51'),
(53, 2, 'menu', 'Viewed main menu', '2025-05-13 15:00:02'),
(54, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 15:00:11'),
(55, 2, 'borrow', 'Tried to borrow: Pride and Prejudice', '2025-05-13 15:00:19'),
(56, 2, 'menu', 'Viewed main menu', '2025-05-13 15:00:35'),
(57, 2, 'menu', 'Viewed main menu', '2025-05-13 15:00:49'),
(58, 2, 'menu', 'Viewed main menu', '2025-05-13 15:01:03'),
(59, 2, 'menu', 'Viewed main menu', '2025-05-13 15:01:12'),
(60, 2, 'menu', 'Viewed main menu', '2025-05-13 15:15:09'),
(61, 2, 'menu', 'Viewed main menu', '2025-05-13 15:15:19'),
(62, 2, 'menu', 'Viewed main menu', '2025-05-13 15:15:42'),
(63, 2, 'menu', 'Viewed main menu', '2025-05-13 15:15:56'),
(64, 2, 'menu', 'Viewed main menu', '2025-05-13 15:16:09'),
(65, 2, 'menu', 'Viewed main menu', '2025-05-13 15:16:15'),
(66, 2, 'exit', 'Exited menu', '2025-05-13 15:16:26'),
(67, 1, 'menu', 'Viewed main menu', '2025-05-13 15:18:24'),
(68, 1, 'menu', 'Viewed main menu', '2025-05-13 15:18:38'),
(69, 1, 'menu', 'Viewed main menu', '2025-05-13 15:18:48'),
(70, 1, 'menu', 'Viewed main menu', '2025-05-13 15:18:51'),
(71, 1, 'menu', 'Viewed main menu', '2025-05-13 15:18:53'),
(72, 1, 'menu', 'Viewed main menu', '2025-05-13 15:18:55'),
(73, 1, 'menu', 'Viewed main menu', '2025-05-13 15:19:02'),
(74, 1, 'menu', 'Viewed main menu', '2025-05-13 15:19:09'),
(75, 2, 'menu', 'Viewed main menu', '2025-05-13 15:23:37'),
(76, 2, 'menu', 'Viewed main menu', '2025-05-13 15:23:48'),
(77, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 15:23:52'),
(78, 2, 'borrow', 'Tried to borrow: The Great Gatsby', '2025-05-13 15:24:11'),
(79, 2, 'menu', 'Viewed main menu', '2025-05-13 15:24:26'),
(80, 2, 'menu', 'Viewed main menu', '2025-05-13 15:24:50'),
(81, 2, 'menu', 'Viewed main menu', '2025-05-13 15:25:02'),
(82, 2, 'menu', 'Viewed main menu', '2025-05-13 15:25:06'),
(83, 2, 'menu', 'Viewed main menu', '2025-05-13 15:25:16'),
(84, 2, 'menu', 'Viewed main menu', '2025-05-13 15:25:22'),
(85, 2, 'menu', 'Viewed main menu', '2025-05-13 15:25:31'),
(86, 2, 'menu', 'Viewed main menu', '2025-05-13 15:25:41'),
(87, 2, 'menu', 'Viewed main menu', '2025-05-13 15:25:51'),
(88, 2, 'menu', 'Viewed main menu', '2025-05-13 15:33:48'),
(89, 2, 'menu', 'Viewed main menu', '2025-05-13 15:34:02'),
(90, 2, 'menu', 'Viewed main menu', '2025-05-13 15:34:09'),
(91, 2, 'view_borrowed', 'Viewed borrowed books', '2025-05-13 15:34:19'),
(92, 2, 'menu', 'Viewed main menu', '2025-05-13 15:35:48'),
(93, 2, 'menu', 'Viewed main menu', '2025-05-13 15:36:05'),
(94, 2, 'menu', 'Viewed main menu', '2025-05-13 15:36:17'),
(95, 2, 'menu', 'Viewed main menu', '2025-05-13 15:36:27'),
(96, 2, 'menu', 'Viewed main menu', '2025-05-13 15:36:38'),
(97, 2, 'menu', 'Viewed main menu', '2025-05-13 15:36:49'),
(98, 2, 'menu', 'Viewed main menu', '2025-05-13 15:37:00'),
(99, 2, 'menu', 'Viewed main menu', '2025-05-13 15:37:13'),
(100, 2, 'menu', 'Viewed main menu', '2025-05-13 15:43:27'),
(101, 2, 'menu', 'Viewed main menu', '2025-05-13 15:43:41'),
(102, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 15:44:11'),
(103, 2, 'borrow', 'Tried to borrow: To Kill a Mockingbird', '2025-05-13 15:44:25'),
(104, 2, 'menu', 'Viewed main menu', '2025-05-13 15:46:34'),
(105, 2, 'menu', 'Viewed main menu', '2025-05-13 15:46:47'),
(106, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 15:46:56'),
(107, 2, 'borrow', 'Tried to borrow: To Kill a Mockingbird', '2025-05-13 15:47:01'),
(108, 2, 'menu', 'Viewed main menu', '2025-05-13 15:47:13'),
(109, 2, 'menu', 'Viewed main menu', '2025-05-13 15:47:29'),
(110, 2, 'menu', 'Viewed main menu', '2025-05-13 15:47:39'),
(111, 2, 'menu', 'Viewed main menu', '2025-05-13 15:47:53'),
(112, 2, 'search_prompt', 'Prompted for book category', '2025-05-13 15:47:57'),
(113, 2, 'search', 'Searched for category: love', '2025-05-13 15:48:08'),
(114, 2, 'menu', 'Viewed main menu', '2025-05-13 15:48:20'),
(115, 2, 'menu', 'Viewed main menu', '2025-05-13 15:53:07'),
(116, 2, 'menu', 'Viewed main menu', '2025-05-13 15:53:28'),
(117, 2, 'menu', 'Viewed main menu', '2025-05-13 15:53:38'),
(118, 2, 'menu', 'Viewed main menu', '2025-05-13 15:53:42'),
(119, 2, 'view_borrowed', 'Viewed borrowed books', '2025-05-13 15:53:49'),
(120, 2, 'menu', 'Viewed main menu', '2025-05-13 15:57:07'),
(121, 2, 'menu', 'Viewed main menu', '2025-05-13 15:57:16'),
(122, 2, 'menu', 'Viewed main menu', '2025-05-13 15:57:20'),
(123, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 15:57:27'),
(124, 2, 'borrow', 'Tried to borrow: Pride and Prejudice', '2025-05-13 15:57:58'),
(125, 2, 'menu', 'Viewed main menu', '2025-05-13 15:59:55'),
(126, 2, 'menu', 'Viewed main menu', '2025-05-13 15:59:59'),
(127, 2, 'borrow_prompt', 'Prompted for book name', '2025-05-13 16:00:04'),
(128, 2, 'borrow', 'Tried to borrow: Pride and Prejudice', '2025-05-13 16:00:13'),
(129, 2, 'menu', 'Viewed main menu', '2025-05-13 16:00:21'),
(130, 2, 'menu', 'Viewed main menu', '2025-05-13 16:00:24'),
(131, 2, 'return_prompt', 'Prompted for book name to return', '2025-05-13 16:32:32'),
(132, 3, 'register', 'Registered with 0786182139', '2025-05-13 16:50:31'),
(133, 3, 'menu', 'Viewed main menu', '2025-05-13 16:55:45'),
(134, 3, 'menu', 'Viewed main menu', '2025-05-13 16:55:59'),
(135, 3, 'borrow_prompt', 'Prompted for book name', '2025-05-13 16:56:03'),
(136, 1, 'menu', 'Viewed main menu', '2025-05-13 16:59:34'),
(137, 4, 'register', 'Registered with 0786182138', '2025-05-13 17:01:07'),
(138, 5, 'register', 'Registered with +25786182138', '2025-05-13 17:05:13'),
(139, 4, 'menu', 'Viewed main menu', '2025-05-13 17:06:55'),
(140, 5, 'menu', 'Viewed main menu', '2025-05-13 17:07:56'),
(141, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:04'),
(142, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:07'),
(143, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:09'),
(144, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:18'),
(145, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:20'),
(146, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:22'),
(147, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:24'),
(148, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:26'),
(149, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:31'),
(150, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:33'),
(151, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:35'),
(152, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:41'),
(153, 5, 'menu', 'Viewed main menu', '2025-05-13 17:08:45'),
(154, 4, 'menu', 'Viewed main menu', '2025-05-13 17:09:52'),
(155, 6, 'register', 'Registered with +25786182137', '2025-05-13 17:16:20'),
(156, 5, 'menu', 'Viewed main menu', '2025-05-13 17:30:36'),
(157, 5, 'menu', 'Viewed main menu', '2025-05-13 17:30:52'),
(158, 5, 'menu', 'Viewed main menu', '2025-05-13 17:30:59'),
(159, 5, 'menu', 'Viewed main menu', '2025-05-13 17:31:07'),
(160, 5, 'menu', 'Viewed main menu', '2025-05-13 17:31:13'),
(161, 5, 'menu', 'Viewed main menu', '2025-05-13 17:32:08'),
(162, 5, 'menu', 'Viewed main menu', '2025-05-13 17:32:16'),
(163, 5, 'menu', 'Viewed main menu', '2025-05-13 17:36:51'),
(164, 7, 'register', 'Registered with +25784567890', '2025-05-13 17:37:28'),
(165, 8, 'register', 'Registered with +2567890567', '2025-05-13 17:38:07'),
(166, 9, 'register', 'Registered with +25734415510', '2025-05-13 18:21:37'),
(167, 10, 'register', 'Registered with +25782111732', '2025-05-13 18:33:51'),
(168, 11, 'register', 'Registered with +25836434', '2025-05-13 18:34:55'),
(169, 12, 'register', 'Registered with +25sdfghj', '2025-05-13 18:36:18'),
(170, 13, 'register', 'Registered with +25783456789', '2025-05-13 18:38:16'),
(171, 14, 'register', 'Registered with +250782119737', '2025-05-13 18:42:51'),
(172, 15, 'register', 'Registered with +250781943410', '2025-05-13 18:45:38'),
(173, 15, 'menu', 'Viewed main menu', '2025-05-13 18:49:29'),
(174, 15, 'menu', 'Viewed main menu', '2025-05-13 18:49:41'),
(175, 15, 'view_borrowed', 'Viewed borrowed books', '2025-05-13 18:49:45'),
(176, 15, 'menu', 'Viewed main menu', '2025-05-13 18:49:53'),
(177, 15, 'menu', 'Viewed main menu', '2025-05-13 18:49:57'),
(178, 15, 'borrow_prompt', 'Prompted for book name', '2025-05-13 18:50:00'),
(179, 15, 'menu', 'Viewed main menu', '2025-05-13 18:50:10'),
(180, 15, 'menu', 'Viewed main menu', '2025-05-13 18:50:15'),
(181, 15, 'menu', 'Viewed main menu', '2025-05-13 18:51:14'),
(182, 15, 'menu', 'Viewed main menu', '2025-05-13 18:51:17'),
(183, 15, 'view_borrowed', 'Viewed borrowed books', '2025-05-13 18:51:20'),
(184, 15, 'menu', 'Viewed main menu', '2025-05-13 18:52:23'),
(185, 15, 'menu', 'Viewed main menu', '2025-05-13 18:52:29'),
(186, 15, 'view_borrowed', 'Viewed borrowed books', '2025-05-13 18:52:33'),
(187, 15, 'menu', 'Viewed main menu', '2025-05-13 18:54:05'),
(188, 15, 'menu', 'Viewed main menu', '2025-05-13 18:54:10'),
(189, 15, 'borrow_prompt', 'Prompted for book name', '2025-05-13 18:54:14'),
(190, 15, 'borrow', 'Tried to borrow: dndnd', '2025-05-13 18:54:19'),
(191, 15, 'menu', 'Viewed main menu', '2025-05-13 18:54:57'),
(192, 15, 'menu', 'Viewed main menu', '2025-05-13 18:55:01'),
(193, 15, 'view_borrowed', 'Viewed borrowed books', '2025-05-13 18:55:07'),
(194, 15, 'menu', 'Viewed main menu', '2025-05-13 18:55:18'),
(195, 15, 'menu', 'Viewed main menu', '2025-05-13 18:55:26'),
(196, 15, 'borrow_prompt', 'Prompted for book name', '2025-05-13 18:55:30'),
(197, 15, 'borrow', 'Tried to borrow: history', '2025-05-13 18:55:38'),
(198, 15, 'menu', 'Viewed main menu', '2025-05-13 18:56:04'),
(199, 15, 'menu', 'Viewed main menu', '2025-05-13 18:56:08'),
(200, 15, 'search_prompt', 'Prompted for book category', '2025-05-13 18:56:13'),
(201, 15, 'search', 'Searched for category: aderftgfh', '2025-05-13 18:56:17'),
(202, 15, 'menu', 'Viewed main menu', '2025-05-13 18:56:33'),
(203, 15, 'menu', 'Viewed main menu', '2025-05-13 18:57:08'),
(204, 15, 'borrow_prompt', 'Prompted for book name', '2025-05-13 18:57:12'),
(205, 15, 'borrow', 'Tried to borrow: The Great Gatsby', '2025-05-13 18:57:29'),
(206, 15, 'menu', 'Viewed main menu', '2025-05-13 18:57:39'),
(207, 15, 'menu', 'Viewed main menu', '2025-05-13 18:57:42'),
(208, 15, 'borrow_prompt', 'Prompted for book name', '2025-05-13 18:57:45'),
(209, 15, 'borrow', 'Tried to borrow: The Great Gatsby', '2025-05-13 18:58:00'),
(210, 15, 'menu', 'Viewed main menu', '2025-05-13 18:58:09'),
(211, 15, 'menu', 'Viewed main menu', '2025-05-13 18:59:39'),
(212, 15, 'menu', 'Viewed main menu', '2025-05-13 18:59:42'),
(213, 15, 'borrow_prompt', 'Prompted for book name', '2025-05-13 18:59:46'),
(214, 15, 'borrow', 'Tried to borrow: dsd', '2025-05-13 18:59:50'),
(215, 15, 'menu', 'Viewed main menu', '2025-05-13 19:00:15'),
(216, 15, 'menu', 'Viewed main menu', '2025-05-13 19:00:19'),
(217, 15, 'borrow_prompt', 'Prompted for book name', '2025-05-13 19:00:22'),
(218, 15, 'borrow', 'Tried to borrow: The Great Gatsby', '2025-05-13 19:00:33'),
(219, 15, 'menu', 'Viewed main menu', '2025-05-13 19:01:31'),
(220, 15, 'menu', 'Viewed main menu', '2025-05-13 19:01:34'),
(221, 15, 'view_borrowed', 'Viewed borrowed books', '2025-05-13 19:01:38'),
(222, 16, 'register', 'Registered with +250781943 777', '2025-05-13 19:04:46'),
(223, 17, 'register', 'Registered with +250781943888', '2025-05-13 19:05:58'),
(224, 18, 'register', 'Registered with +250781943333', '2025-05-13 19:09:29'),
(225, 18, 'menu', 'Viewed main menu', '2025-05-13 19:09:56'),
(226, 18, 'menu', 'Viewed main menu', '2025-05-13 19:10:06'),
(227, 18, 'menu', 'Viewed main menu', '2025-05-13 19:10:15'),
(228, 18, 'menu', 'Viewed main menu', '2025-05-13 19:10:19'),
(229, 18, 'view_borrowed', 'Viewed borrowed books', '2025-05-13 19:10:23'),
(230, 18, 'menu', 'Viewed main menu', '2025-05-13 19:10:43'),
(231, 18, 'menu', 'Viewed main menu', '2025-05-13 19:10:55'),
(232, 18, 'borrow_prompt', 'Prompted for book name', '2025-05-13 19:10:59'),
(233, 18, 'borrow', 'Tried to borrow: Great', '2025-05-13 19:11:10'),
(234, 18, 'menu', 'Viewed main menu', '2025-05-13 19:11:44'),
(235, 18, 'menu', 'Viewed main menu', '2025-05-13 19:11:49'),
(236, 18, 'view_borrowed', 'Viewed borrowed books', '2025-05-13 19:11:54');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `phone_number`, `password`) VALUES
(1, 'claudine Uwase', '+250786182130', '$2y$10$5Dnb7vZg797o1cRfXyC9luk8JqjedN88BHIE8TuOLZw2TNN07yni6'),
(2, 'uwera judith', '+250785275073', '$2y$10$8BwoWe6F8Nex14XTodIefeJmKgE0FfYfLOu5znNp3gNQGeBtQzU0.'),
(3, 'uwae', '+250786182139', '$2y$10$FN6/1O/qkb4JXOHFkNdXKObKwx/O2L./AM5VfHqXXPm3uC1ct3MEG'),
(4, 'coco', '+250786182137', '$2y$10$e2jjh3he0ixP7HCjXc2GfOxobJVT5ELcRqNVjwEv8EQTaWRf42yBu'),
(5, 'coco', '+250786182138', '$2y$10$HWZyQU4Z0YCbEJovXInKmuLW0VjLtD8JV4D2AufFRxgvZW.3Uu982'),
(6, 'coco', '+25786182137', '$2y$10$03OCZa308BOR1Ld3pvYO.eVcsrNGAXzed3nHt5Jbo6Hw1Vitkwy3C'),
(7, 'j', '+25784567890', '$2y$10$v2zRIxafzrJv1CqDHmxTF.oWwEcVIl7OmaKOPKMsunkOjqRSEx6Y6'),
(8, 'dfghjk', '+2567890567', '$2y$10$63fhNMCptgv4FBwVl7JoGO//LeqPEykuE1lKOu65Er9iSMUYs8rKC'),
(9, 'jmv', '+25734415510', '$2y$10$2oNnS6UMzgTLFgSB3O8Z4.5tEmQY9Wy4ELbf2D1MJ6qq7EQPY9EZ.'),
(10, 'sam', '+25782111732', '$2y$10$3kL4A1M3/aQJqlj30q/kweFxqBEwGU0TIniIswAPUOfuIXmsxpnPe'),
(11, 'samm', '+25836434', '$2y$10$VJE/Ds6iptOYP4UJXoC81O8bYT0TYAA9kYBy1qvqhoQZylUKqDcta'),
(12, 'nnn', '+25sdfghj', '$2y$10$r.eL/iPE/3A/FIeytrDtruUP.ZU5A2P.WP9Fn5nkClp.P.gWvWGUG'),
(13, 'jeamm', '+25783456789', '$2y$10$KHSk6stlhYIPKEMvZEQ2veuirgSzYig3i68gcRZsn/OsP2GdoehLK'),
(14, 'jemmm', '+250782119737', '$2y$10$qBRuD7Wenhs23jnJHHfHM.ZWct9/kAdgBvcfcjuW4apfBMD17IwXO'),
(15, 'xdfdg', '+250781943410', '$2y$10$sSzuMUphaUSYzE2OEf4bMuf3V1ZKCeVBVYej6FDaj5rCMP9WRP3oC'),
(16, 'jean ric', '+250781943 777', '$2y$10$G/RJX2sq21Zx43QYt4oZ2eAfJVcXNoBlJX5XrKcAUe1kQRclMjptG'),
(17, 'eric', '+250781943888', '$2y$10$Jqi82kbIEcFCfEVRohejju9P6MemrKs8Uyy5hk/81gmq431rwSxrO'),
(18, 'emmm', '+250781943333', '$2y$10$LXETFUDlTpK4YcxbSGQVOeQEc.Zqrm7nX2B0OYiO/2nFYRzuEjhfW');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `borrowed_books`
--
ALTER TABLE `borrowed_books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `borrowed_books`
--
ALTER TABLE `borrowed_books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=237;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `borrowed_books`
--
ALTER TABLE `borrowed_books`
  ADD CONSTRAINT `borrowed_books_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `borrowed_books_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
