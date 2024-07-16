-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 16, 2024 at 12:46 PM
-- Server version: 8.0.30
-- PHP Version: 8.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kick_korner`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `detailSepetuTerlaris` ()   BEGIN SELECT COUNT(shoes.id_shoes) as jumlah_sepatu, shoes.shoe_name, shoes.size, categories.name, transactions.gross_amount 
FROM transactions 
JOIN shoes USING (id_shoes) 
JOIN categories USING (id_category) 
GROUP BY shoes.id_shoes, shoes.shoe_name, shoes.size, 
categories.name, transactions.gross_amount 
ORDER BY jumlah_sepatu DESC; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateShoePrice` (IN `shoe_id` BIGINT, IN `new_price` INT)   BEGIN
    DECLARE current_price INT;
    SELECT sale_cost INTO current_price FROM shoes WHERE id_shoes = shoe_id;
    IF current_price IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Shoe not found';
    ELSE
        CASE
            WHEN new_price < 0 THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price cannot be negative';
            WHEN new_price = current_price THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'New price is the same as current price';
            ELSE
                UPDATE shoes SET sale_cost = new_price WHERE id_shoes = shoe_id;
                SELECT CONCAT('Price updated from ', current_price, ' to ', new_price) AS result;
        END CASE;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitungProduct` () RETURNS INT  BEGIN
RETURN (SELECT COUNT(*) FROM shoes);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `HitungTotalProduk` (`id_sepatu` INT, `jumlahBeli` INT) RETURNS INT  BEGIN
 RETURN (SELECT sale_cost*jumlahBeli as total_produk FROM shoes WHERE id_shoes = id_sepatu);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `before_update_category`
--

CREATE TABLE `before_update_category` (
  `id_before_update_category` int NOT NULL,
  `before_name` varchar(255) DEFAULT NULL,
  `after_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `before_update_category`
--

INSERT INTO `before_update_category` (`id_before_update_category`, `before_name`, `after_name`, `created_at`, `updated_at`) VALUES
(1, 'Nike', 'Gucci', '2024-07-15 09:36:30', '2024-07-15 09:36:30');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id_cart` bigint UNSIGNED NOT NULL,
  `id_shoes` bigint UNSIGNED NOT NULL,
  `id_user` bigint UNSIGNED NOT NULL,
  `jumlah` int NOT NULL,
  `price` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id_cart`, `id_shoes`, `id_user`, `jumlah`, `price`, `created_at`, `updated_at`) VALUES
(4, 48, 3, 3, 9462854, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(5, 275, 3, 4, 5658232, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(9, 12, 3, 2, 6348051, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(10, 398, 3, 4, 9395290, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(11, 89, 3, 2, 9662547, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(14, 196, 2, 4, 4415242, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(16, 50, 3, 1, 8269103, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(17, 154, 2, 5, 9501033, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(18, 141, 2, 5, 2297981, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(21, 164, 3, 1, 4434329, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(24, 416, 3, 4, 2353053, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(25, 17, 3, 1, 3595731, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(28, 349, 1, 3, 6696002, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(29, 417, 3, 4, 4172089, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(30, 358, 3, 2, 6288268, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(31, 199, 1, 2, 3621955, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(32, 69, 3, 3, 7301880, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(35, 191, 2, 1, 3000989, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(36, 458, 3, 4, 8249462, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(39, 396, 3, 1, 8854143, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(40, 442, 3, 2, 4787822, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(42, 235, 3, 1, 7199829, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(43, 486, 2, 4, 8335309, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(44, 333, 1, 1, 7274663, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(45, 12, 1, 2, 6604772, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(46, 107, 3, 4, 8809712, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(47, 226, 2, 3, 7063872, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(48, 301, 3, 3, 6117355, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(50, 57, 3, 5, 7443048, '2024-07-15 01:31:38', '2024-07-15 01:31:38');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id_category` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id_category`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Gucci', '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(2, 'Adidas', '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(3, 'Ortuseight', '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(4, 'Converse', '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(5, 'Mills', '2024-07-15 01:31:37', '2024-07-15 01:31:37');

--
-- Triggers `categories`
--
DELIMITER $$
CREATE TRIGGER `after_update_categories` AFTER UPDATE ON `categories` FOR EACH ROW BEGIN  
    INSERT into before_update_category(before_name, after_name, created_at, updated_at) 
    							VALUES (OLD.name, NEW.name, now(), now());  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `log_transactions`
--

CREATE TABLE `log_transactions` (
  `id_log_transaction` int NOT NULL,
  `id_transaction` int DEFAULT NULL,
  `id_shoes` int DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `purchase_amount` varchar(255) DEFAULT NULL,
  `gross_amount` varchar(255) DEFAULT NULL,
  `pdf_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `log_transactions`
--

INSERT INTO `log_transactions` (`id_log_transaction`, `id_transaction`, `id_shoes`, `status`, `purchase_amount`, `gross_amount`, `pdf_url`, `created_at`, `updated_at`) VALUES
(1, 2, 260, 'pending', '4', '9237557', '-', '2024-07-15 01:31:38', '2024-07-15 12:06:54');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id_review` bigint UNSIGNED NOT NULL,
  `id_user` bigint UNSIGNED NOT NULL,
  `id_transaction` bigint UNSIGNED NOT NULL,
  `id_shoes` bigint UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `review` text COLLATE utf8mb4_unicode_ci,
  `star` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id_review`, `id_user`, `id_transaction`, `id_shoes`, `image`, `review`, `star`, `created_at`, `updated_at`) VALUES
(2, 2, 47, 137, '-', 'Odit perspiciatis mollitia expedita libero rerum consectetur quaerat. Vero est autem dolor. Doloribus nam et ut eum qui reiciendis itaque. Qui sed qui sed et repellendus.', '3', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(3, 2, 11, 209, '-', 'Veritatis reprehenderit officiis optio enim at labore sint. Numquam assumenda facilis rerum temporibus similique aliquid tenetur sequi. Culpa deserunt aut aperiam maiores. Tenetur cupiditate recusandae vel autem minima.', '3', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(5, 2, 48, 213, '-', 'Dolores unde repellendus voluptatem. Placeat voluptas in ut sed. Ad id id non quia odit est maiores aliquam. Nam ab ducimus optio recusandae architecto libero nesciunt. Omnis ipsum nihil porro.', '4', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(6, 3, 11, 160, '-', 'Incidunt sequi a quam at voluptatem. Debitis nulla ut eaque aut provident quasi excepturi nobis. Id pariatur expedita est sequi.', '4', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(7, 2, 44, 260, '-', 'Est sed tenetur ab sed voluptas iste maiores. Voluptas ex quia minima rem blanditiis. Libero hic est quia ab consequatur. Sed quos est nihil quibusdam explicabo est laboriosam.', '2', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(9, 1, 26, 34, '-', 'Autem qui voluptatem amet voluptate dolore. Odit voluptates totam dignissimos iure veritatis explicabo. Doloremque aut natus aut veniam quod. Nostrum sit et repudiandae qui eveniet.', '3', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(11, 3, 20, 27, '-', 'Esse sunt praesentium cupiditate. Accusantium eius totam repellat velit aut nisi. Velit molestias eius possimus laboriosam ut. Delectus asperiores et recusandae asperiores ut est.', '3', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(15, 2, 26, 102, '-', 'Consequatur et perspiciatis at aspernatur et. Fugiat officia aliquam tempore aut aliquid aliquam. Commodi alias nostrum autem rerum architecto. Ad suscipit tenetur suscipit aliquid minima.', '2', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(16, 2, 18, 449, '-', 'Ea voluptatum non sunt debitis sequi. Quis eius et voluptatem non autem voluptatum. Ex reprehenderit et quam quod ducimus sunt illo.', '2', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(22, 3, 20, 186, '-', 'Eos sit nulla expedita ab. Sed quis doloribus est voluptatum. Quod vitae aliquid praesentium eaque suscipit et. Quasi quia id ipsam quia porro.', '4', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(23, 1, 3, 285, '-', 'Ut occaecati aspernatur quia maiores a. Sed et eaque nemo nobis in repellat eum delectus. Laudantium consequuntur ut doloremque magni quod enim repellat voluptatem. Sit magnam et non optio est vel voluptatibus.', '2', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(26, 1, 23, 475, '-', 'Harum asperiores tempora dolorem doloremque aliquid eos sit. Aliquam architecto dolor at nobis saepe blanditiis illum excepturi. Qui tempore maxime molestiae illum hic sapiente laborum aliquid.', '2', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(32, 3, 43, 200, '-', 'Facere esse nesciunt ratione dolore. Assumenda nobis quia aut. Molestias magni nihil non et et ipsum. Sint dignissimos atque et doloremque occaecati optio possimus.', '1', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(33, 3, 20, 81, '-', 'Iste pariatur commodi placeat voluptates. Saepe inventore ex nesciunt expedita. Facilis quam in qui soluta quas. Enim id qui odio aspernatur placeat saepe nihil.', '5', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(36, 3, 37, 326, '-', 'Vel quis occaecati vitae vitae dolores dignissimos. Necessitatibus quis omnis laudantium inventore sunt minus. Sed sequi voluptas beatae qui earum.', '2', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(37, 1, 10, 407, '-', 'Sunt deserunt est iste. Asperiores consequatur eum sunt suscipit id consectetur. Aut vel minima in sequi ipsam voluptatem aliquam eos.', '4', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(39, 1, 50, 256, '-', 'Corrupti qui animi ex aspernatur tempore. Et velit labore dolorem occaecati velit. In eum voluptatem earum dignissimos rem. Voluptatem est debitis repellendus eligendi.', '4', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(40, 3, 15, 234, '-', 'Quod ipsam nisi aliquid dolorum. Ut reiciendis ad facilis et tempore. Pariatur sint velit omnis labore.', '2', '2024-07-15 01:31:38', '2024-07-15 01:31:38');

-- --------------------------------------------------------

--
-- Table structure for table `shoes`
--

CREATE TABLE `shoes` (
  `id_shoes` bigint UNSIGNED NOT NULL,
  `id_category` bigint UNSIGNED NOT NULL,
  `shoe_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sale_cost` int NOT NULL,
  `actual_cost` int NOT NULL,
  `stock` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shoes`
--

INSERT INTO `shoes` (`id_shoes`, `id_category`, `shoe_name`, `image1`, `image2`, `image3`, `sale_cost`, `actual_cost`, `stock`, `description`, `size`, `created_at`, `updated_at`) VALUES
(1, 2, 'Adidas Reprehenderit.', '-', '-', '-', 3408087, 1787881, 19, 'Qui aut accusamus impedit sit rerum. Consequatur numquam corrupti laboriosam quam ullam. Qui nemo consequuntur aut neque quae. Ab nam non odit quisquam eligendi aut atque voluptatum.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(2, 3, 'Ortuseight Ut vero.', '-', '-', '-', 3802176, 2444314, 26, 'Magnam perspiciatis perferendis ratione non quidem cum alias. Ducimus voluptatem cupiditate inventore. Temporibus iure magnam quo ea. Labore et aliquid repellat ab.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(3, 4, 'Converse Voluptatibus.', '-', '-', '-', 3652398, 3895152, 6, 'Dignissimos accusamus consectetur perferendis eos esse quae impedit. Est est mollitia ad quo necessitatibus itaque. Eum ut quia est iure non repellat qui. Impedit cumque nam atque.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(4, 1, 'Nike Et.', '-', '-', '-', 2855927, 2232264, 23, 'Eos nihil asperiores et officia sunt. Aperiam ut tenetur itaque. Iure porro quam quis iusto.', 41, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(5, 2, 'Adidas Quisquam et.', '-', '-', '-', 4054139, 3624510, 13, 'Est ad atque libero incidunt. Facere exercitationem et quam sint. Nulla in ad reprehenderit amet in quibusdam. Pariatur nam minima esse aut ut placeat explicabo.', 41, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(6, 2, 'Adidas Vel.', '-', '-', '-', 1708115, 3755459, 26, 'Est enim et laudantium quae perferendis minima. Aliquid architecto itaque exercitationem dolores expedita quo. Rerum labore veritatis est.', 41, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(7, 4, 'Converse Dolor quos.', '-', '-', '-', 1926673, 2002645, 24, 'Eveniet nam fugit aliquid. Repellat odio sit porro adipisci natus. Unde iure adipisci eos sunt similique accusantium enim. Excepturi odio nihil suscipit cumque laborum.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(8, 2, 'Adidas Et tempore.', '-', '-', '-', 4413766, 3207051, 18, 'Ea nam eum repudiandae in. Ullam laudantium iste deserunt quas eligendi atque. Odio ut voluptas corporis. Ea vitae nisi facilis laborum exercitationem. Omnis voluptates dolor sunt vel et qui sunt.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(9, 3, 'Ortuseight Quo.', '-', '-', '-', 4102598, 3882858, 14, 'Rerum pariatur ducimus veritatis quia. Qui et repellat quos et eos. Molestiae beatae atque debitis omnis voluptates rem. Aliquid aut ullam suscipit non et optio.', 41, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(10, 2, 'Adidas Est.', '-', '-', '-', 1510544, 2932697, 6, 'Dolore repellat omnis quasi similique. Et quos quo harum sit et. Maiores nihil et nesciunt hic sequi ut. Recusandae accusantium ut atque commodi quia rerum ipsum. At veritatis eum quia a eum totam.', 41, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(11, 2, 'Adidas Id praesentium.', '-', '-', '-', 4365580, 4221175, 30, 'Necessitatibus ipsum qui sapiente aspernatur blanditiis corporis. Vel nesciunt mollitia unde at illum occaecati. Laboriosam qui perferendis est hic et illum nobis quae.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(12, 2, 'Adidas Est adipisci.', '-', '-', '-', 4263209, 4825692, 17, 'Est itaque rerum excepturi reprehenderit aut. Sunt dolorem distinctio vitae ipsum sint exercitationem vel. Nihil ut reprehenderit numquam perspiciatis occaecati ut. Ab aut ipsam et ea sit accusantium delectus repellat.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(13, 3, 'Ortuseight Tempora illo.', '-', '-', '-', 4839781, 3785794, 13, 'Voluptate iste exercitationem provident quidem inventore necessitatibus. Et sed eos nihil.', 44, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(14, 1, 'Nike Voluptatem.', '-', '-', '-', 4828715, 2477934, 11, 'Fugit alias qui assumenda quo. Et voluptates a distinctio sapiente expedita animi. Minus ut illum sed a voluptates veritatis voluptatem.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(15, 3, 'adidas sports', '-', '-', '-', 30000000, 1000000, 27, 'Sequi et similique quo. Aut non magnam et adipisci. Natus porro aut est a velit et.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(16, 4, 'adidas sports', '-', '-', '-', 4921738, 4832299, 13, 'Molestiae necessitatibus adipisci sunt molestiae architecto nobis. A et iste deleniti repellendus excepturi.', 44, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(17, 3, 'Ortuseight Id necessitatibus.', '-', '-', '-', 4358163, 1581519, 15, 'Doloribus vitae autem sint perferendis vitae impedit. Sed qui mollitia consequuntur culpa. Nostrum sapiente ratione maxime quia sit. Soluta labore dignissimos adipisci modi.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(18, 5, 'Mills Et.', '-', '-', '-', 2986639, 3767081, 9, 'Reprehenderit sed minus odio voluptatem. Porro est saepe exercitationem quo. Laborum et distinctio quasi iste quae sint ut.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(19, 4, 'Converse Eum nihil.', '-', '-', '-', 4780338, 4123219, 14, 'Unde incidunt omnis illo veniam et recusandae natus natus. Qui repudiandae enim sint magnam et quaerat culpa. Quae non facere doloremque sint in. Voluptatem deserunt officia qui inventore id.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(20, 3, 'Ortuseight Aliquam.', '-', '-', '-', 3844473, 3348743, 25, 'Voluptate suscipit quo vel in quia dolorem delectus. Id consequatur et ullam est tempore id. Sed quisquam laborum quod dignissimos exercitationem dolores accusamus. Ullam quia laudantium eum eaque.', 41, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(21, 4, 'Converse Eos modi.', '-', '-', '-', 2076857, 3603993, 29, 'Magni provident molestiae voluptatem sed eum dolorum. Qui voluptate in non. Enim fuga adipisci fugiat ipsam maxime praesentium nemo. Perferendis quaerat quibusdam culpa nostrum maiores eos.', 40, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(22, 5, 'Mills Totam.', '-', '-', '-', 3462682, 4243934, 8, 'Omnis porro doloremque in autem consequatur ut inventore. Molestiae aliquam facilis nobis distinctio placeat perspiciatis autem. Alias eum sit consequuntur sunt odio sed. Necessitatibus tempora qui quo nostrum quo molestiae recusandae nemo.', 40, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(23, 1, 'Nike Occaecati.', '-', '-', '-', 2980392, 4235464, 14, 'Aut dolorum omnis maiores. Ullam est ipsam harum id.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(24, 3, 'Ortuseight Omnis in.', '-', '-', '-', 3412405, 4184803, 21, 'Iusto a dolor at autem omnis est. Quo vitae numquam et ipsa vel. Velit non earum voluptatem quis natus ratione facere. Quia et eaque omnis quaerat porro in qui.', 40, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(25, 3, 'Ortuseight Pariatur ut.', '-', '-', '-', 4942412, 2350929, 11, 'Qui est eligendi deserunt corporis saepe. Assumenda magnam rerum voluptatibus sint dolores eveniet optio.', 40, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(26, 2, 'Adidas Non nobis.', '-', '-', '-', 3828879, 2526039, 17, 'Aperiam laudantium a ducimus quos cum. Est placeat quia magni fugiat facilis dignissimos magnam iure. Nobis amet excepturi laudantium est dolor quia quia.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(27, 5, 'Mills Voluptas officiis.', '-', '-', '-', 2201677, 3057091, 28, 'Et corrupti dolorem illum impedit magni consequatur. In perferendis ratione voluptatum quia ut. In ab consectetur unde eos autem eum.', 40, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(28, 4, 'Converse Quidem impedit.', '-', '-', '-', 2682694, 4102029, 30, 'At veritatis laudantium veritatis omnis. Minima corrupti vel expedita magni. Fugiat quas expedita ex fuga.', 40, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(29, 1, 'Nike Velit.', '-', '-', '-', 4540905, 3215473, 12, 'Officiis pariatur sit consequatur sunt eos sunt esse. Nobis et sed dignissimos vel. Temporibus consectetur magnam nulla atque voluptatem omnis.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(30, 1, 'Nike Quia sed.', '-', '-', '-', 2536795, 1662996, 23, 'Illum in explicabo saepe repudiandae nobis. Perspiciatis distinctio corrupti corporis debitis sequi.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(31, 5, 'Mills Vitae quia.', '-', '-', '-', 2811764, 4134481, 5, 'Ab placeat et vel perspiciatis repudiandae minima fugit. Veniam placeat perferendis similique ut natus aliquid fuga doloribus. Sint aspernatur qui vel alias. Accusamus ea non iusto sit quisquam.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(32, 5, 'Mills Recusandae optio.', '-', '-', '-', 2944530, 3001709, 17, 'Rem consequatur in corporis a consequatur et saepe numquam. Consectetur id et qui in. Ipsum velit minima incidunt vitae. Illo praesentium mollitia quod deleniti voluptatem aut libero quis.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(33, 4, 'Converse Nihil.', '-', '-', '-', 1555465, 2943820, 23, 'Quia id nulla provident molestias dolor inventore impedit. Nemo qui quos consequuntur qui quibusdam neque facere. Quas iusto cumque veritatis minima a. Dolores dolores eius consequatur.', 41, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(34, 2, 'Adidas Amet.', '-', '-', '-', 2736278, 2743698, 15, 'Est qui optio voluptatibus optio deleniti dolor. Quo aut consequatur sint. Cupiditate voluptatibus consequatur blanditiis dolores.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(35, 4, 'Converse Minus est.', '-', '-', '-', 2755158, 2207603, 28, 'Quia officiis temporibus est voluptatibus aut ad consequatur. Quisquam accusantium provident minima nisi aut. Exercitationem ipsam molestias optio provident itaque. Molestiae omnis aut molestiae excepturi adipisci assumenda facilis voluptatem.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(36, 2, 'Adidas Voluptatum.', '-', '-', '-', 4943514, 2522713, 9, 'Qui non rerum autem eos. Et minus molestias quis iure repellendus ex eos. Dolorem eum rem deleniti facere consectetur alias voluptatem.', 42, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(37, 2, 'Adidas Et iste.', '-', '-', '-', 4115278, 2565882, 9, 'Dolorem et quo quia facere ea. Ut voluptatem quis id qui nesciunt. Dolores ut ducimus consequatur deserunt.', 43, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(38, 5, 'Mills Et natus.', '-', '-', '-', 2647801, 3529183, 29, 'Cumque explicabo qui explicabo temporibus enim ratione fugiat praesentium. Neque quo blanditiis minima porro. Est dolor commodi qui. Qui consequatur voluptatem non occaecati quas.', 44, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(39, 4, 'Converse Accusantium.', '-', '-', '-', 1850173, 2927234, 7, 'Qui corporis repellat suscipit. Explicabo et rerum molestiae officia temporibus. Recusandae quia quos qui et magni velit unde. Aliquam sunt unde consequuntur accusamus.', 44, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(40, 5, 'Mills Aspernatur.', '-', '-', '-', 3952881, 4542100, 20, 'Ipsum et assumenda commodi explicabo. Unde temporibus fuga vero non. Quod molestiae aut alias ut. Omnis non ut autem temporibus.', 41, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(41, 2, 'Adidas Recusandae et.', '-', '-', '-', 3103851, 2354954, 24, 'Culpa architecto eum accusantium enim fugit labore ut. Deleniti est repellendus fugit ratione dignissimos. Ducimus et corporis aut. Qui possimus facere voluptas illum similique.', 44, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(42, 5, 'Mills Vitae.', '-', '-', '-', 4349527, 2950519, 24, 'Vel earum esse minima suscipit rerum similique. Vel consequatur est incidunt consectetur quidem quisquam. Quis nisi modi quia et. Ea mollitia perferendis vel facere occaecati et assumenda.', 41, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(43, 3, 'Ortuseight Optio.', '-', '-', '-', 2165773, 2265604, 29, 'Et adipisci voluptatum omnis aliquam. Dolorem est vitae dolore nam voluptatem. Sapiente labore eius est deserunt.', 40, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(44, 2, 'Adidas Nam dolor.', '-', '-', '-', 2204337, 4105822, 19, 'Quis totam doloremque ipsum et consequuntur. Et harum aut quaerat laudantium error. Dolores consequuntur quas quo nisi unde vero corrupti. Sapiente asperiores eos aut velit sed.', 44, '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(45, 5, 'Mills Odio.', '-', '-', '-', 2309188, 4348760, 22, 'Reiciendis quibusdam et laudantium aut. Vitae qui et ex maiores ipsum. Consequatur nihil inventore sit corrupti. Minima unde id laboriosam ea ea.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(46, 2, 'Adidas Iure.', '-', '-', '-', 4560611, 4217944, 18, 'Accusamus necessitatibus velit ipsam illo esse pariatur. Ullam aut voluptatibus enim in. Quos dolore ut vero debitis sit sit id.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(47, 4, 'Converse Recusandae.', '-', '-', '-', 3089267, 3867437, 8, 'Sit tenetur consequatur vel ducimus quia. Delectus debitis nam quia doloribus voluptatibus quo ut. Ut et quae ut velit odio.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(48, 5, 'Mills Iusto.', '-', '-', '-', 4521437, 1707355, 12, 'Laborum ut aut vel qui similique quae. In ut nobis qui est aspernatur. Similique distinctio ad sit sunt.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(49, 2, 'Adidas Nihil rem.', '-', '-', '-', 3174831, 1907848, 6, 'Nihil eveniet rerum nobis nihil harum voluptatibus. Magni eligendi perspiciatis possimus vero. Eaque suscipit fugiat doloremque delectus et.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(50, 4, 'Converse Facilis et.', '-', '-', '-', 1816412, 2857936, 20, 'Et dolores accusantium quos velit asperiores vel laborum. Repellat odio iste aut et ut. Consectetur dignissimos nulla eos quam quis quia iste laborum.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(51, 5, 'Mills A.', '-', '-', '-', 1953212, 4766629, 7, 'Sapiente blanditiis ipsa ut voluptatum illo exercitationem est. Reiciendis consequatur laudantium necessitatibus repudiandae recusandae voluptates. Tempore quia et qui dolores dicta. Explicabo accusantium laboriosam maiores nemo.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(52, 4, 'Converse Possimus.', '-', '-', '-', 4940990, 4106288, 14, 'Saepe ex beatae numquam neque autem. Ipsum atque non ipsa doloribus. Nostrum ex praesentium quis vel. Eos et sequi non et.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(53, 3, 'Ortuseight Facere aspernatur.', '-', '-', '-', 4192694, 4215841, 30, 'Voluptates officia quis ut totam praesentium. Rerum aut voluptatem inventore officiis qui et quaerat. Voluptate et et ut culpa itaque et voluptatibus beatae.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(54, 4, 'Converse Est est.', '-', '-', '-', 4743402, 3045102, 21, 'Deleniti at esse quos voluptatum. Consequatur tempora harum qui. Voluptatem laborum itaque aliquam laborum nihil delectus. Saepe eaque quisquam asperiores adipisci ea at.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(55, 5, 'Mills Modi.', '-', '-', '-', 2658489, 1665069, 20, 'Repudiandae cumque at qui vel qui rerum. Praesentium rem cum modi maxime tenetur occaecati beatae. Sit laudantium aliquid nobis aliquam molestiae rerum facilis.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(56, 2, 'Adidas Nam.', '-', '-', '-', 3601540, 3561842, 28, 'Sint dolor vitae porro soluta in commodi voluptatem. In repellendus possimus vero eos cumque. Quia voluptatem placeat consequatur temporibus.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(57, 4, 'Converse Et.', '-', '-', '-', 2531620, 3962492, 26, 'Dolorem aspernatur sed eum quae ipsum eaque corrupti. Ipsum nihil error quidem sed ad molestiae. Nisi occaecati et dicta officiis. Est reprehenderit qui consequuntur ab et.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(58, 3, 'Ortuseight Veniam quod.', '-', '-', '-', 1813835, 2749887, 11, 'Eius rerum quia eum illo asperiores nam odit nemo. Beatae mollitia at nisi eos molestiae. Dolore cupiditate ipsa enim. Ut iste et illo voluptatem sed rerum sint.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(59, 5, 'Mills Deserunt et.', '-', '-', '-', 3272445, 1573750, 19, 'Reiciendis officiis facilis voluptas quis suscipit nostrum qui. Tenetur quas et excepturi fugiat voluptas. Qui excepturi fuga nostrum consectetur. Odit illo velit sequi.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(60, 5, 'Mills Aut.', '-', '-', '-', 1986853, 4765026, 8, 'Fuga nemo reprehenderit rerum blanditiis expedita laborum. Soluta repellendus explicabo non sint dolores aperiam. Suscipit qui molestias eum doloribus eos illo et. Aut similique natus vel.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(61, 4, 'Converse Corporis.', '-', '-', '-', 2501891, 2901503, 13, 'Velit ut aut ratione asperiores doloribus dolorem. Sequi aut voluptas et reiciendis natus at. Nemo voluptas voluptatem eos hic.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(62, 1, 'Nike Rem aut.', '-', '-', '-', 3582331, 2683702, 18, 'Beatae qui id tempora amet. Accusantium autem quasi esse. Architecto in occaecati molestiae accusamus blanditiis quibusdam. Iusto blanditiis quo ex possimus delectus.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(63, 4, 'Converse Voluptas laborum.', '-', '-', '-', 1651932, 3505849, 24, 'Enim optio voluptatem ipsum accusantium dolorum voluptatem dolore. Ut officia cupiditate eum. Autem ea tempore vero laborum.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(64, 1, 'Nike Laudantium incidunt.', '-', '-', '-', 4730239, 3304762, 11, 'Officiis sed facilis aperiam iste. Error iusto perspiciatis repellendus consequatur autem et. Voluptate praesentium autem facilis eligendi quaerat aut sed.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(65, 3, 'Ortuseight Explicabo.', '-', '-', '-', 3371926, 3011871, 16, 'Sed explicabo minima quibusdam ut ut. Perferendis enim corporis fugit voluptatibus hic eum quis. Et mollitia enim esse doloribus. Et sint expedita inventore hic ut esse ullam. Vel suscipit porro voluptatem sit totam aut placeat.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(66, 5, 'Mills Occaecati praesentium.', '-', '-', '-', 4764597, 1978825, 14, 'Voluptatibus aut ipsa sunt delectus non modi. Rerum ad dolor fugiat perspiciatis. Facilis cumque enim ea ab modi.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(67, 4, 'Converse Voluptatibus possimus.', '-', '-', '-', 4939092, 1991393, 12, 'Quae in optio nobis quia nobis velit sed. Animi natus adipisci officiis amet maiores. Asperiores temporibus ut rem veritatis.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(68, 1, 'Nike Ut.', '-', '-', '-', 2563570, 1888273, 12, 'Sint corrupti illum provident molestias. Nostrum distinctio officia quos et molestiae. Dignissimos quo sunt ullam quasi est et amet.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(69, 1, 'Nike Asperiores.', '-', '-', '-', 2639487, 1513552, 30, 'Aliquam iure reiciendis velit aut qui. Dolor omnis dolorem nobis placeat soluta sed sit iste. Ut hic non magni sed et reprehenderit. Quas nisi qui eveniet sint nam et nihil numquam.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(70, 4, 'Converse Facere natus.', '-', '-', '-', 1830533, 3297433, 10, 'Rerum et id vel esse deserunt nihil. Sed tempore rerum quasi voluptatem quia quia.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(71, 3, 'Ortuseight Voluptates voluptatum.', '-', '-', '-', 1604852, 2685868, 24, 'Excepturi ratione delectus debitis nesciunt nobis quidem nisi earum. Quos iure mollitia sed eos incidunt et molestiae. In vero quis voluptatem officiis. Voluptatibus aspernatur tempora exercitationem qui repellendus.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(72, 2, 'Adidas Asperiores.', '-', '-', '-', 3173761, 4427698, 14, 'Esse ut quas libero id veritatis qui. Delectus est repudiandae tempore laborum quia.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(73, 2, 'Adidas Ullam.', '-', '-', '-', 2767752, 1901645, 7, 'Doloremque quasi quia eos saepe expedita laboriosam. Aliquam et architecto consequatur fugiat. Necessitatibus impedit voluptate commodi ducimus cum laborum qui perferendis. Unde harum soluta dolorum vel.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(74, 2, 'Adidas Est tempora.', '-', '-', '-', 1938207, 2625241, 8, 'Dolorem est et aut hic. Voluptatibus neque perspiciatis earum necessitatibus. Aut unde eum dolorem ab est et.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(75, 5, 'Mills Cum impedit.', '-', '-', '-', 3850427, 4425194, 25, 'Eum voluptates veritatis qui enim soluta. Rerum maiores quia adipisci. Culpa id quia rerum pariatur autem.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(76, 3, 'Ortuseight Corporis delectus.', '-', '-', '-', 2283532, 4629266, 24, 'Blanditiis vitae voluptate voluptatibus odio aperiam quis. Consequuntur est modi dolorum quisquam beatae excepturi possimus. Autem voluptate labore rerum rem libero repellat illo.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(77, 4, 'Converse Natus.', '-', '-', '-', 2493485, 3487577, 24, 'Consequatur itaque facere sed dolores. Magnam sint expedita et assumenda modi. Doloremque et iure et delectus. Reprehenderit sequi tempore sit rerum dolorem iure.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(78, 1, 'Nike Consequatur.', '-', '-', '-', 3013066, 3732920, 14, 'Exercitationem ea necessitatibus omnis tempore illum iusto. Dolores dignissimos accusantium tempora. Quis et temporibus sint aut voluptates. Ab sed quod nihil exercitationem non exercitationem sed ex.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(79, 3, 'Ortuseight Quaerat voluptas.', '-', '-', '-', 3549876, 3149654, 19, 'Voluptate natus qui esse fuga. In sequi est eum laudantium suscipit sunt. Odio sit culpa ut.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(80, 4, 'Converse Quis culpa.', '-', '-', '-', 2785024, 4887394, 24, 'Quasi ut harum error aliquam sed. Ratione nobis harum id provident atque sit. Aspernatur vero dicta esse. Voluptatum quasi neque dicta aliquam iusto magnam tempore consequatur.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(81, 2, 'Adidas Laborum voluptas.', '-', '-', '-', 1926930, 3437735, 10, 'Alias quo voluptatem ut sunt explicabo. Cum et voluptates fuga reiciendis inventore. Consequatur nulla ratione enim non. Unde eos omnis et nisi.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(82, 5, 'Mills Facere.', '-', '-', '-', 4310754, 1821744, 6, 'Aut nihil laboriosam labore vero. Et non enim quae minus sapiente dolorum. Quis omnis sint necessitatibus nemo sint illo dolor.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(83, 4, 'Converse Animi ex.', '-', '-', '-', 4833725, 4628289, 24, 'Sequi natus omnis quo ab. Temporibus voluptatibus qui vitae quis. Facilis ut veritatis rerum eum expedita aspernatur.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(84, 5, 'Mills Quidem.', '-', '-', '-', 1971970, 1885263, 26, 'Eveniet velit ullam consectetur ut adipisci omnis. Et perspiciatis rem fugiat sit voluptatum ea ut. Fugiat vel pariatur ut architecto. Non repudiandae voluptas velit ipsam ab.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(85, 2, 'Adidas Ut eveniet.', '-', '-', '-', 4637095, 4532785, 17, 'Rem nostrum rerum quaerat eaque dolore ipsa. Mollitia et soluta et ea est labore non. Non laboriosam ipsum aspernatur voluptas.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(86, 1, 'Nike Maiores culpa.', '-', '-', '-', 2916493, 2234984, 27, 'Et autem consequatur illum rem quam. Necessitatibus assumenda autem praesentium quibusdam similique. Incidunt rerum quis hic at.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(87, 4, 'Converse Ut et.', '-', '-', '-', 4373001, 4161546, 15, 'Omnis quod est harum fugiat unde. Qui sequi velit veniam et aut. Ea et minus est beatae aut expedita. Repudiandae modi unde alias aliquid doloremque sint.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(88, 5, 'Mills Dolorem incidunt.', '-', '-', '-', 2546572, 4531413, 30, 'Consequatur excepturi sed fugit hic dolor magnam. Architecto dolorum molestiae odio tenetur exercitationem.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(89, 3, 'Ortuseight Sit.', '-', '-', '-', 2432583, 3312183, 18, 'Sequi quasi quia dolores et sit et. Aut eum ducimus aut reprehenderit quia. Expedita sunt odit nihil veniam sint sit.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(90, 2, 'Adidas Rerum.', '-', '-', '-', 2956037, 3552639, 17, 'Omnis occaecati similique et id. Voluptatem aut qui repudiandae est pariatur consequatur vel optio. Aut temporibus molestiae odio distinctio voluptatem molestiae. Perspiciatis at numquam qui fuga et accusamus repellendus. Dolor mollitia facere voluptas.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(91, 1, 'Nike Quibusdam et.', '-', '-', '-', 2912282, 2872979, 11, 'Ut provident libero voluptas ut occaecati minima unde. Possimus nulla voluptatem repellendus excepturi voluptatem eveniet odit. Ex ut quidem rerum quam ullam quaerat.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(92, 5, 'Mills Exercitationem.', '-', '-', '-', 3522932, 1976550, 27, 'Aliquam facere ut rem quas deleniti. Debitis illo impedit ut cupiditate molestias ea. Delectus non asperiores aut doloremque ut mollitia possimus quis. Corrupti et minus atque ea. Voluptatem ut quisquam dolorum voluptates iure provident.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(93, 5, 'Mills Voluptas enim.', '-', '-', '-', 2673144, 1524415, 10, 'Itaque fugit aut rerum ut animi soluta ex eum. Officia tempora consectetur nemo recusandae laudantium. Sunt praesentium qui omnis voluptatibus molestiae. Ad eos laudantium voluptas et ut et numquam distinctio.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(94, 1, 'Nike Rerum ipsa.', '-', '-', '-', 3748885, 3069598, 24, 'Quis dignissimos quo molestiae molestiae deleniti sint occaecati. Ut cumque quo maiores quis. Voluptatem saepe id id rerum aperiam non.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(95, 2, 'Adidas Qui voluptas.', '-', '-', '-', 1929682, 2369141, 21, 'Eaque magnam molestiae et. Autem ducimus iste facere. Consectetur architecto qui rem. Quia laudantium quod suscipit quas.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(96, 1, 'Nike Architecto.', '-', '-', '-', 4286645, 2815328, 22, 'Rerum in non suscipit autem. Dolore quo necessitatibus aperiam voluptatum provident. Molestiae iure eius maiores et. Aut architecto placeat temporibus veniam.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(97, 4, 'Converse Hic a.', '-', '-', '-', 4400507, 3218320, 25, 'Beatae excepturi architecto placeat non odio. Mollitia laudantium vero voluptatum doloremque.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(98, 1, 'Nike Laborum.', '-', '-', '-', 2635089, 1950635, 5, 'Iure iste tempora aliquam nulla. Qui occaecati cumque sequi qui omnis qui earum. Consequatur omnis ipsum ullam sed. Adipisci est molestiae porro voluptas aut.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(99, 4, 'Converse Quibusdam.', '-', '-', '-', 2360615, 2709953, 11, 'Assumenda dolorem dolores quos non. Repellat exercitationem ut veniam temporibus. Ab sint qui repellat sequi voluptate. Eos earum dignissimos rerum ea quia aut omnis.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(100, 2, 'Adidas Dolore.', '-', '-', '-', 2882624, 1913351, 20, 'Quo omnis ab fuga dolore atque ut pariatur recusandae. Sed ut non voluptas aliquid non. Illo voluptate occaecati aut quo.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(101, 2, 'Adidas Exercitationem.', '-', '-', '-', 2265990, 3406976, 23, 'Ut earum quisquam quod quia qui cumque aut. Ut asperiores sunt voluptatem dicta unde deserunt enim. Blanditiis voluptatem cum et consequatur qui.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(102, 2, 'Adidas Repellendus.', '-', '-', '-', 3174617, 4737296, 11, 'Distinctio enim illum expedita ut rerum. Impedit perspiciatis officia et. Qui aut sit rerum repellat qui quas voluptatibus praesentium. Odit voluptatem incidunt nemo qui repellat dolorem ratione.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(103, 4, 'Converse Officia.', '-', '-', '-', 2893755, 4106143, 16, 'Repellat autem maxime provident quis voluptatum omnis tempora amet. Eligendi voluptates delectus neque molestiae omnis velit perspiciatis. Et non ipsa id non. Nobis quia rerum soluta.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(104, 5, 'Mills Magnam quia.', '-', '-', '-', 1796891, 2860926, 9, 'Error ullam qui dolorem libero voluptatem. Repudiandae cum alias qui architecto pariatur. Natus aperiam numquam odit qui. Aliquam hic tenetur quas quasi et vel soluta inventore.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(105, 5, 'Mills Et et.', '-', '-', '-', 2955254, 4840487, 23, 'Omnis sunt nihil commodi. Iusto cupiditate rem sequi odit quidem aut quisquam. Ullam architecto commodi ducimus et corporis sed. Nesciunt deleniti in maiores nihil.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(106, 3, 'Ortuseight Est beatae.', '-', '-', '-', 2890057, 3586274, 19, 'Repellat quae rerum cupiditate libero. Qui cupiditate id fugit veritatis. Quibusdam voluptatem quasi molestiae eaque odit. Molestias velit consequatur quod. Enim cupiditate unde amet sapiente maiores accusamus id.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(107, 5, 'Mills Molestiae.', '-', '-', '-', 3124060, 3446884, 29, 'Omnis vero at laudantium adipisci quia. Deleniti ipsum totam at ut. Optio voluptatem iusto velit velit culpa. Tenetur ex enim maxime. Doloribus iure et nihil omnis delectus facilis.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(108, 2, 'Adidas Sed.', '-', '-', '-', 2408406, 2060968, 10, 'Alias quo dicta ut illum quia quos. Ut modi praesentium nihil vel eligendi dignissimos iste consectetur. Sunt deserunt tempora at voluptatem temporibus earum. Repellendus et facilis quasi facere occaecati quidem incidunt ad. Molestiae temporibus dolorem vitae magnam.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(109, 4, 'Converse Sed.', '-', '-', '-', 3415856, 2243203, 6, 'Ea ut beatae ut expedita consequatur. Et labore voluptatem quia ut repudiandae ut quas. Distinctio cumque officia quia deserunt quisquam nostrum iste.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(110, 3, 'Ortuseight Eum.', '-', '-', '-', 2588659, 4417845, 22, 'Corporis aliquid rem architecto aspernatur consequatur sed voluptates dicta. Ipsum sapiente magni cupiditate est eveniet natus rerum. Assumenda dignissimos tempora sit odio. Non reprehenderit iusto non dolorem et vel quis.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(111, 3, 'Ortuseight Asperiores.', '-', '-', '-', 2919126, 2458536, 19, 'Fuga ut sint porro deleniti tenetur delectus. Repellendus veniam aliquam laborum aliquam quia. Repellat ut magni molestiae sit eum dicta. Dignissimos ut repellat quo et blanditiis expedita saepe.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(112, 3, 'Ortuseight Nulla sint.', '-', '-', '-', 4829124, 2948128, 14, 'Nulla aperiam perspiciatis similique ipsam esse deleniti quos. Iste omnis velit ut quo minus. In magnam velit veniam dolores saepe. Nemo iste aut reprehenderit.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(113, 1, 'Nike Eum.', '-', '-', '-', 3442037, 4106504, 26, 'Velit quis ea dolorem sed consequatur. Fugiat excepturi omnis et nobis architecto rerum. Voluptatem cupiditate exercitationem ut sequi veritatis. Similique et nisi autem. Commodi distinctio expedita et minus quaerat error minus.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(114, 3, 'Ortuseight Aspernatur qui.', '-', '-', '-', 1673338, 3784013, 14, 'Quos ea laboriosam sint sapiente dolor ea quibusdam. Nobis debitis quisquam molestiae quos facere. Illum possimus amet odio culpa.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(115, 1, 'Nike Ratione.', '-', '-', '-', 3163301, 2066862, 11, 'Aut enim asperiores debitis harum aliquid. Doloremque in qui natus assumenda. Omnis dolor vel eius iusto quia.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(116, 4, 'Converse Odio at.', '-', '-', '-', 2617740, 2634761, 21, 'Esse quod vel veritatis est molestias distinctio explicabo. Omnis expedita dicta sunt iure consequatur rerum. Aut odit molestiae earum.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(117, 3, 'Ortuseight Et.', '-', '-', '-', 2690881, 2892140, 27, 'Officia quos quis ut eius. Voluptas rerum voluptatibus perspiciatis corporis accusantium ut non. Quia voluptas illum aut doloremque.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(118, 1, 'Nike Soluta esse.', '-', '-', '-', 2170395, 1960459, 7, 'Consequatur sed mollitia sint non sunt enim quo. Deserunt voluptatibus vel quidem et ut vitae quia eos.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(119, 4, 'Converse Perferendis qui.', '-', '-', '-', 4146609, 1877109, 8, 'Doloribus similique excepturi in unde sit ratione voluptas. Quam est vel autem reprehenderit dolores repudiandae totam. Incidunt et sunt hic sed cumque est vel. Temporibus et qui quas est praesentium aut.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(120, 2, 'Adidas Odit.', '-', '-', '-', 3595926, 3088789, 15, 'Libero et sit laboriosam corrupti. Deserunt fugit saepe quisquam quis commodi aperiam sit.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(121, 5, 'Mills Quidem molestiae.', '-', '-', '-', 2596617, 4303744, 25, 'Nulla atque quia repellendus non sed laboriosam. Sed mollitia adipisci error dolores dolore labore atque. Eos alias hic aliquid maiores in quisquam. Qui et enim nobis odio sed veniam.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(122, 2, 'Adidas Et repudiandae.', '-', '-', '-', 2667595, 3796125, 7, 'Numquam ex debitis velit quibusdam architecto est fugiat. Cumque dolores natus nisi vel reprehenderit et nemo illum.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(123, 2, 'Adidas Maxime.', '-', '-', '-', 4149345, 3994958, 14, 'Placeat ullam temporibus saepe. Consectetur et adipisci voluptatem similique assumenda. Sit voluptatibus inventore laudantium id labore rerum provident. Fugit occaecati aspernatur quis repudiandae et laudantium.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(124, 3, 'Ortuseight Voluptates.', '-', '-', '-', 4531925, 2670620, 27, 'Cumque et laboriosam tempora error ipsa. Tempore doloribus asperiores animi rem. Quae rerum vero consequatur voluptatum animi amet atque.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(125, 3, 'Ortuseight Possimus tempore.', '-', '-', '-', 4924759, 1805373, 5, 'Placeat quis et aut veniam aliquam id explicabo. Culpa quis iusto fugit aut. Eum explicabo veritatis qui qui. Voluptatem saepe quia officia.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(126, 2, 'Adidas A.', '-', '-', '-', 1532028, 2556829, 30, 'Quas magni possimus aperiam itaque eius itaque quia ut. Velit sit rerum voluptatibus exercitationem. Consequatur sunt eaque nihil reprehenderit velit quo. Qui qui itaque excepturi cumque in minima facere.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(127, 1, 'Nike Natus corrupti.', '-', '-', '-', 3374648, 3489861, 8, 'Enim aliquam accusamus molestiae numquam. Animi magni ipsum eveniet qui et ut iusto. Fugit omnis quam cupiditate ut fuga. Accusamus qui nihil suscipit molestiae ullam saepe consequatur quam.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(128, 3, 'Ortuseight Placeat.', '-', '-', '-', 4120509, 4894270, 18, 'Voluptas et sunt molestiae corrupti dolorem. Dicta laudantium et temporibus ea molestias voluptates amet. Labore voluptas rerum quam. Ipsa eum quis rerum fuga.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(129, 5, 'Mills Minima.', '-', '-', '-', 3769430, 2709751, 8, 'Harum ea voluptate consequatur ut ut. Mollitia itaque voluptatem similique esse aut. Vel debitis deleniti id quas unde voluptates. Eos rerum sunt excepturi vel reiciendis laboriosam.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(130, 1, 'Nike Necessitatibus.', '-', '-', '-', 4855906, 3329549, 15, 'Eum dolorum quos quibusdam neque. Facere cum quis dolore. Optio quos voluptas consequuntur harum ullam qui reprehenderit culpa. Iusto dolor nulla odio deserunt.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(131, 3, 'Ortuseight Rerum.', '-', '-', '-', 4891813, 3396196, 5, 'Laudantium sapiente voluptatum maxime nesciunt et. Natus aut iste ut deserunt assumenda sapiente nulla iste. Repellat molestiae at debitis porro voluptate distinctio.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(132, 4, 'Converse Rem.', '-', '-', '-', 2735632, 1821449, 14, 'Facere sed vel illo ad ratione voluptatem praesentium. Minus et ea nihil. Voluptates voluptatem et maxime delectus. Eos facere aliquid omnis asperiores.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(133, 1, 'Nike Aliquid.', '-', '-', '-', 2097682, 2203636, 20, 'Sapiente in voluptates qui blanditiis alias voluptas harum et. Enim sed ipsa ipsam error quae deleniti ea. Dolorem autem enim voluptas distinctio ut.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(134, 3, 'Ortuseight Aut in.', '-', '-', '-', 4626394, 4345656, 29, 'Nisi voluptatibus quia omnis. Cum vel saepe quas veritatis ea. Et fugiat magnam quibusdam est consequuntur voluptatibus.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(135, 3, 'Ortuseight Non veritatis.', '-', '-', '-', 1663520, 3010629, 20, 'Doloremque modi fugiat ut suscipit inventore. Maxime placeat aut consequatur eius quo ratione. Accusamus ab harum ipsum cumque natus.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(136, 2, 'Adidas Et.', '-', '-', '-', 4422751, 3193530, 7, 'Libero quis rerum quisquam. Id quibusdam facere ut consequatur temporibus hic cum. Tenetur omnis consequatur laudantium non quidem nemo exercitationem.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(137, 2, 'Adidas Impedit eos.', '-', '-', '-', 4679637, 1924571, 17, 'Qui voluptas aperiam id quae deleniti voluptatum. Adipisci nobis quia porro enim sequi aut. Quisquam sed voluptas accusantium perferendis recusandae soluta quia. Id aut architecto consequuntur rem dolorum.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(138, 4, 'Converse Sunt.', '-', '-', '-', 3556347, 2886352, 6, 'Voluptatem dolorem sit deleniti non. Tempora similique neque vel laboriosam adipisci necessitatibus ut. Quia sint molestiae ratione nesciunt ullam. Ducimus corporis blanditiis quae eos cupiditate perferendis quidem.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(139, 5, 'Mills Laudantium laudantium.', '-', '-', '-', 2987392, 3934901, 26, 'Enim cum inventore magni beatae qui iste et eum. Pariatur nemo qui autem occaecati. Unde quam inventore non hic. Minima iure esse dolorum nam natus dicta.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(140, 3, 'Ortuseight Ad autem.', '-', '-', '-', 4786268, 4124466, 23, 'Corporis quod autem impedit rerum. Aut nulla iste dolor ipsa. Adipisci totam voluptates necessitatibus possimus et.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(141, 3, 'Ortuseight Distinctio beatae.', '-', '-', '-', 2345933, 2254554, 22, 'Ab aperiam aspernatur aut consequatur qui tempora et exercitationem. Velit vero ipsam qui officia quibusdam et. Dignissimos rerum consequatur ducimus omnis eum. Vitae distinctio eos doloremque illo assumenda expedita et. Molestias quibusdam delectus eos.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(142, 5, 'Mills Accusamus unde.', '-', '-', '-', 4676764, 2528390, 27, 'Placeat nihil exercitationem vero et. Officiis et eos numquam animi expedita veniam aut. Accusantium dolorum ex explicabo minus nemo laudantium sapiente. Iste non sed nemo soluta aliquam reiciendis nam quia.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(143, 2, 'Adidas Alias magnam.', '-', '-', '-', 2401104, 1714855, 30, 'Provident at veritatis quibusdam numquam aut. Et aliquid voluptas quis blanditiis quisquam sit. Id officiis rerum rerum dicta.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(144, 4, 'Converse Porro.', '-', '-', '-', 2238539, 2888237, 11, 'Unde tempore repellat enim ratione sapiente. Consequatur odit impedit molestiae quia in et laudantium. Quisquam sit labore sequi. Accusamus possimus quaerat voluptas hic recusandae dolores quidem culpa.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(145, 5, 'Mills Ut.', '-', '-', '-', 4785399, 2429997, 10, 'Consequuntur eveniet rem vero repellendus vel fugiat. Est repellat est reiciendis molestiae. Dolorum eaque ipsam ad aut.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(146, 4, 'Converse Eligendi voluptate.', '-', '-', '-', 3687950, 2888369, 13, 'Consequatur mollitia itaque vero occaecati hic. Rerum ipsam ut ad qui deleniti repudiandae itaque. Quam iure officiis rerum aut.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(147, 5, 'Mills Alias.', '-', '-', '-', 2196861, 4635105, 25, 'Eaque alias laborum qui laboriosam corporis alias. Nesciunt ut dicta facere maxime ea optio blanditiis. Et rerum voluptas placeat quia minima quae. Ipsam dolores excepturi quia ipsam ea sed quasi.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(148, 4, 'Converse Sint molestias.', '-', '-', '-', 3373525, 4727596, 10, 'In possimus voluptatem et numquam optio in. Et velit velit similique similique. Et enim reiciendis assumenda labore omnis molestiae quisquam.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(149, 5, 'Mills Praesentium est.', '-', '-', '-', 1967995, 3774951, 10, 'Qui cupiditate totam numquam aut laboriosam. Neque expedita eligendi deserunt quia. Temporibus id qui perspiciatis iste ab.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(150, 2, 'Adidas Et.', '-', '-', '-', 3390483, 4793648, 24, 'Nisi et sit iusto non. Expedita fugit aut consequatur ex omnis nihil dolor. Rerum incidunt excepturi sed vero modi corrupti nisi.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(151, 2, 'Adidas Optio architecto.', '-', '-', '-', 4759875, 2836140, 24, 'Illum doloremque impedit minima et perferendis. Rem quibusdam quibusdam quis sequi id. Dolore tenetur cupiditate sit eligendi non eum reprehenderit sed. Quia quam et quam.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(152, 1, 'Nike Sit.', '-', '-', '-', 3414267, 3945799, 12, 'Voluptatem sit temporibus et consequatur omnis autem. Doloribus dolore ipsum ducimus voluptas pariatur sunt laudantium. Est velit ad neque aperiam vel ipsum aut.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(153, 4, 'Converse Optio.', '-', '-', '-', 2400791, 2948709, 28, 'Eos non enim mollitia ab. Qui qui dolor adipisci voluptatibus. Suscipit non excepturi eaque voluptatibus laborum ut.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(154, 1, 'Nike Id debitis.', '-', '-', '-', 1610895, 3544807, 24, 'Dolores sed voluptas nisi optio. Voluptate necessitatibus facere deserunt impedit voluptates corrupti. Ut nisi a omnis voluptatum.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(155, 3, 'Ortuseight Non.', '-', '-', '-', 3367925, 4360257, 14, 'Illum laboriosam vero sed aut in. Temporibus eum minus eveniet exercitationem. Et tenetur maxime quae sit. Qui similique corporis exercitationem soluta saepe ut ut.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(156, 2, 'Adidas Quibusdam omnis.', '-', '-', '-', 4855471, 1554434, 8, 'Quas repellendus alias dicta. Ducimus aspernatur a consequatur optio dolor recusandae dolorum. Doloremque ut nesciunt vitae.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(157, 5, 'Mills Possimus saepe.', '-', '-', '-', 2683128, 4635564, 5, 'Earum consequatur voluptatum quia molestiae quae fuga. Distinctio vel quidem ut eius accusamus accusantium sequi. Sint reprehenderit voluptatem non magni nisi nam. Laborum quos ipsa aliquam et.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(158, 1, 'Nike Et enim.', '-', '-', '-', 4148753, 3791776, 17, 'Dolorem magni sed id debitis occaecati officia eveniet. Quia sed ex repellat quisquam. In minima asperiores nesciunt iusto. Eligendi nisi quis cupiditate voluptate et.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(159, 1, 'Nike Sed.', '-', '-', '-', 2227172, 1772521, 27, 'Delectus aut occaecati ea accusamus numquam quia voluptatem amet. Accusantium soluta dolores qui consequatur est quia omnis. Nemo nihil eum et sequi et ducimus facilis et. Non cum nisi ut et voluptas aspernatur.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(160, 3, 'Ortuseight Occaecati qui.', '-', '-', '-', 4082249, 3318919, 18, 'Sunt omnis beatae ut ipsum aut. Voluptatem voluptatem illum exercitationem quo. Nemo sequi soluta deserunt molestiae repellat voluptate.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(161, 1, 'Nike Soluta autem.', '-', '-', '-', 2254532, 2558129, 28, 'Sed nihil neque vitae enim nihil nesciunt molestiae. Impedit minus aut qui mollitia est. Vero fuga perferendis deserunt ut. Aut earum tempora ea necessitatibus perspiciatis harum.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(162, 3, 'Ortuseight Alias iste.', '-', '-', '-', 2478401, 1705036, 26, 'Recusandae iste repudiandae vel non quia sit. Quas unde in occaecati. Ut soluta tenetur corporis autem fugit id. Reprehenderit animi architecto aut.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(163, 3, 'Ortuseight Voluptates omnis.', '-', '-', '-', 4098254, 3545846, 27, 'Optio unde ex quia velit. Labore qui sed ea omnis cumque. Similique modi nesciunt quia placeat. Aliquam molestiae eum dolorem dolorem.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(164, 3, 'Ortuseight Voluptatem.', '-', '-', '-', 4850355, 1830334, 12, 'Praesentium et earum magni vero. Blanditiis sed consectetur impedit sit autem. Voluptates quaerat cum sint veritatis.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(165, 2, 'Adidas Quibusdam tempora.', '-', '-', '-', 4997551, 2656376, 17, 'Quos esse iste magni aliquid. Excepturi non dolorem nam labore beatae eaque nostrum. Non sed provident reiciendis dolores ipsa rerum. Accusamus enim aut praesentium est nostrum aut tempore officiis. Id aut consequuntur qui quia.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(166, 5, 'Mills Iusto.', '-', '-', '-', 4646664, 1510937, 28, 'Cumque illo voluptas omnis aliquid neque. Placeat et dolor autem cum culpa.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(167, 2, 'Adidas Nihil.', '-', '-', '-', 4874644, 3403975, 7, 'Libero consequatur eius est. Dolor aut officiis placeat dolor. Eum fuga quis eveniet ut voluptatem sint. Itaque aut aut in laborum illum.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(168, 1, 'Nike Et.', '-', '-', '-', 4484068, 3508199, 18, 'Corporis sit neque mollitia dolorem consectetur ad veritatis. Eius illo non nobis et aut. Ratione enim unde suscipit a deserunt non error iure. Maxime modi veritatis ratione nesciunt saepe voluptates ut.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(169, 3, 'Ortuseight Quos.', '-', '-', '-', 3543631, 4589041, 7, 'Facere qui officia non commodi et qui. Suscipit et quaerat qui omnis sed sint reiciendis. Quo minus similique sed. Facilis corporis est error dolores sit consequatur voluptatem consectetur. Beatae tempore maiores voluptatem sequi.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(170, 5, 'Mills Quia quasi.', '-', '-', '-', 3644173, 1571103, 28, 'Veritatis reprehenderit quis libero voluptatem et non. Et dolores est reiciendis eaque consequatur. Vitae nihil doloremque mollitia ullam perferendis aut eaque ipsam. Mollitia a expedita corporis eum.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(171, 3, 'Ortuseight Voluptatum.', '-', '-', '-', 4709812, 1694130, 28, 'Explicabo maxime et commodi velit adipisci repudiandae perspiciatis. Provident soluta et est est necessitatibus eos voluptas. Assumenda itaque aliquid facilis unde dolor. Sapiente voluptatem quisquam et cumque earum sapiente saepe molestias.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(172, 1, 'Nike Non minima.', '-', '-', '-', 2012125, 2275289, 22, 'Illum officiis eos labore exercitationem vel earum. Veniam qui saepe excepturi facere. Aspernatur dolor enim temporibus quibusdam. Placeat ea et illum velit quia consequatur impedit.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(173, 2, 'Adidas Dolor ut.', '-', '-', '-', 2209753, 2172367, 6, 'Aut est repellendus officia quisquam. Soluta earum autem ea voluptatem autem dolores error. Cupiditate temporibus dolorem earum dolorum nihil. Dolor quo et voluptatem similique sapiente. Consectetur asperiores velit nisi voluptatem quia debitis voluptatum.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(174, 4, 'Converse Est ut.', '-', '-', '-', 3904774, 4299479, 15, 'Quam qui dolorem eos voluptatum. Ipsa eum reiciendis quo laborum cupiditate maiores. Minima molestiae aspernatur eaque quia accusamus nihil quis at. Laudantium a aut fugiat nihil.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(175, 4, 'Converse Aliquid natus.', '-', '-', '-', 3605088, 4895148, 19, 'Et itaque assumenda sapiente ullam velit. Consequuntur ab reiciendis fugit. Est optio harum rem in aut.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(176, 1, 'Nike Molestiae doloribus.', '-', '-', '-', 3250895, 2929790, 12, 'Nisi itaque deserunt necessitatibus reiciendis. Sit ipsam beatae et explicabo illo. Voluptas fugiat facere et consequatur minima nobis.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(177, 2, 'Adidas Recusandae doloribus.', '-', '-', '-', 1734658, 4253195, 20, 'Aperiam est repellendus suscipit sed aliquid enim blanditiis animi. Maiores dignissimos totam eveniet quia tempora dolores nihil molestias. Qui tempore quia tempore vel sit.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(178, 4, 'Converse Aliquid.', '-', '-', '-', 3126171, 4330314, 13, 'Assumenda aliquid et sunt. Velit saepe perspiciatis ratione aut et. Dolorum laborum velit et.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38');
INSERT INTO `shoes` (`id_shoes`, `id_category`, `shoe_name`, `image1`, `image2`, `image3`, `sale_cost`, `actual_cost`, `stock`, `description`, `size`, `created_at`, `updated_at`) VALUES
(179, 4, 'Converse Perspiciatis corporis.', '-', '-', '-', 2798861, 1643372, 8, 'Rerum a modi maxime amet pariatur vel autem. Quidem officiis dolores commodi qui fugit quia earum sint. Accusantium vel error repellat exercitationem quam voluptatem consequatur. Ea ut quas voluptas ipsum non odit qui earum. Et nesciunt praesentium quibusdam qui pariatur necessitatibus fuga.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(180, 1, 'Nike Soluta.', '-', '-', '-', 3997228, 1983847, 21, 'Explicabo id est et nam. Accusamus et inventore repellat et nulla natus. Quia at atque dolorem et libero vero in.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(181, 3, 'Ortuseight Quis.', '-', '-', '-', 4802503, 3897307, 11, 'Non dolores quo itaque hic. Deleniti veritatis amet commodi quia voluptatem autem a. Est aut expedita est iure cum sed. Et aut et sint sunt inventore atque quod sed.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(182, 1, 'Nike Excepturi.', '-', '-', '-', 2873494, 2398779, 25, 'Tempore aut accusamus et ut repellat voluptates voluptatem. Quasi illum molestias rerum qui. Repudiandae hic vero sequi officia voluptatem.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(183, 5, 'Mills Facilis porro.', '-', '-', '-', 4455478, 2950412, 27, 'Quidem consectetur et omnis qui voluptatem. Facilis nulla laudantium voluptatem laborum quos vitae voluptatibus. Veniam ab similique at sit. Corrupti voluptas aliquam ut deleniti adipisci id asperiores ipsam.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(184, 1, 'Nike Exercitationem aspernatur.', '-', '-', '-', 4961915, 3592935, 10, 'Eum ipsa voluptas ex dolores error. Accusamus accusantium vel et est fugit dolore. Voluptas nisi quos quis veniam recusandae.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(185, 3, 'Ortuseight Ducimus.', '-', '-', '-', 4501704, 2195880, 13, 'Reprehenderit eligendi dignissimos qui omnis soluta quam vero numquam. Eveniet fugit perferendis et distinctio qui eum incidunt.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(186, 5, 'Mills Quis.', '-', '-', '-', 4970622, 4644753, 17, 'Sint commodi laborum enim omnis. Fuga culpa quos ea placeat ullam quasi et facilis. Quos vero laudantium ducimus sunt. Cum quam sapiente voluptatem aspernatur.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(187, 1, 'Nike Aut sapiente.', '-', '-', '-', 2641676, 2013741, 18, 'Soluta rerum eos occaecati est. Error deleniti enim molestiae quasi nihil.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(188, 2, 'Adidas Corrupti sequi.', '-', '-', '-', 2580286, 2991434, 20, 'Voluptas et quae ea tenetur amet. Tempore sunt qui nulla non. Numquam similique voluptatibus alias qui.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(189, 3, 'Ortuseight Est.', '-', '-', '-', 1565522, 3027830, 11, 'Expedita et voluptate ea quia autem commodi. Et dicta eum quod ut rerum tempora aut. Nesciunt modi vero quia dolores aut totam atque. Esse pariatur delectus ut eaque quaerat vitae.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(190, 1, 'Nike Nam minus.', '-', '-', '-', 2546972, 3698649, 18, 'Quam ipsa possimus iste eum iste fuga. Est porro quibusdam enim quia facilis est quos iste. Dicta consequuntur illo necessitatibus et numquam. Ut excepturi non sunt fugit voluptatum mollitia consequatur.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(191, 1, 'Nike Qui hic.', '-', '-', '-', 4384016, 2811337, 23, 'Et in similique vel dolores. Et porro vitae beatae quo voluptatibus. Occaecati quia eum soluta esse vel excepturi quo quaerat.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(192, 5, 'Mills Itaque debitis.', '-', '-', '-', 2865306, 1606594, 18, 'Aspernatur et error quod nemo consequatur fuga tempora. Voluptatibus rerum occaecati illo quo quae vero. Incidunt sed aut maxime ea laborum eum enim esse. Dolorem ipsum non doloremque quis. Enim omnis facere aut ratione et blanditiis rerum.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(193, 4, 'Converse Accusantium.', '-', '-', '-', 2502805, 2763563, 20, 'Deserunt aut eum nobis harum suscipit error maxime. Nam consequatur quia aut repellat et quis distinctio.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(194, 5, 'Mills Asperiores et.', '-', '-', '-', 1829219, 4350612, 25, 'Quo dolores vel qui officia voluptatibus impedit ipsum. Itaque nemo ut ut nostrum nihil reiciendis molestiae. Magni qui est et consequuntur odio qui qui recusandae.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(195, 5, 'Mills Excepturi.', '-', '-', '-', 1975255, 3204591, 7, 'Magnam veritatis temporibus sed libero eligendi est. Amet quisquam eos nihil maiores atque quidem nobis. Aspernatur totam dolorem consequatur eveniet dolorem corporis.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(196, 1, 'Nike Perferendis omnis.', '-', '-', '-', 3884992, 2849704, 7, 'Porro atque vero quia explicabo omnis magnam laboriosam. Harum ut dignissimos quis fuga id ab illo est. Soluta exercitationem dignissimos debitis eos eos ut quis. Sunt autem recusandae distinctio cupiditate velit consequatur. Libero dolores consequatur consequatur nam.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(197, 2, 'Adidas Placeat.', '-', '-', '-', 3505876, 1736251, 22, 'Molestiae deleniti qui tempora laudantium ducimus. Iusto dolore est consequatur debitis. Unde odio modi rerum aspernatur. Praesentium autem quas aut voluptatum sed incidunt.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(198, 1, 'Nike Est.', '-', '-', '-', 4472529, 2998482, 25, 'Iusto consequatur et fugiat velit omnis tenetur qui. Sed id accusantium impedit eos quas odit ut voluptate. Amet iste impedit tenetur.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(199, 1, 'Nike Vel.', '-', '-', '-', 1796916, 2003043, 5, 'Aut ea labore beatae consequatur ad. Assumenda ut qui reiciendis nesciunt quo a. Esse et laboriosam a saepe. Nisi eum omnis doloribus ducimus totam earum ut accusantium. Eaque in sunt eum voluptatem culpa.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(200, 4, 'Converse Ut.', '-', '-', '-', 2973451, 3058531, 20, 'Vitae unde facilis quibusdam ea. Magnam repellat omnis vel in ut excepturi voluptas. Magni fugiat libero iste sit necessitatibus facilis vitae. Praesentium maiores aut expedita asperiores vel quibusdam.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(201, 3, 'Ortuseight Placeat.', '-', '-', '-', 2384681, 3098280, 14, 'Saepe est consequuntur minus. Fuga eum sunt nihil fugiat sunt ut enim. Voluptas libero sit iure repellat. Et perferendis aut nam inventore a.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(202, 5, 'Mills Deleniti qui.', '-', '-', '-', 3726543, 2616254, 16, 'Voluptatem expedita id aut explicabo illo voluptatem molestias. Et perferendis porro et quibusdam. Non ex quia quaerat iste autem eligendi cumque. Ut sequi beatae ut enim consequuntur. Sunt et eum deserunt qui eos ut.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(203, 5, 'Mills Blanditiis doloremque.', '-', '-', '-', 2575734, 3163402, 25, 'Est ab ut sed repellat. Necessitatibus ex qui delectus id amet. Eveniet fuga aut deserunt quibusdam aliquid ab modi tenetur. In doloremque sint est nulla beatae sed.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(204, 2, 'Adidas Earum facere.', '-', '-', '-', 4626292, 2569541, 18, 'Enim hic reiciendis deserunt voluptas eum iste mollitia non. Eaque unde facere ea.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(205, 2, 'Adidas Voluptatem et.', '-', '-', '-', 2849505, 1556384, 23, 'Tenetur aut dolore nesciunt quia. Quia sint et qui aut. Necessitatibus culpa atque fugiat veniam non voluptatem. Sunt reiciendis sint eum facere placeat ut.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(206, 4, 'Converse Reiciendis.', '-', '-', '-', 3697735, 2697954, 11, 'Minima aperiam doloribus ab qui ex dolor quo. Quidem corrupti mollitia unde eum rerum fugiat.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(207, 5, 'Mills Porro.', '-', '-', '-', 2599984, 3578268, 7, 'Veritatis aut quia expedita ab dignissimos reiciendis. Quia sit voluptas incidunt fugiat sint. Enim ad non dolore. Expedita non aut consequatur aut soluta ullam id.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(208, 2, 'Adidas Velit ut.', '-', '-', '-', 2187116, 4741768, 16, 'Omnis accusamus consequatur praesentium est. Quos eum ut dolores et. Tenetur perspiciatis similique occaecati beatae quidem laboriosam odio est. Nostrum quos minus aut voluptate et. Eaque impedit ducimus exercitationem saepe incidunt.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(209, 2, 'Adidas Aut.', '-', '-', '-', 1892873, 3520792, 19, 'Veritatis rerum pariatur libero. Culpa commodi quis minima. Molestiae ut dolores corrupti quia quisquam blanditiis sed.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(210, 2, 'Adidas Impedit aut.', '-', '-', '-', 3760189, 1630421, 30, 'Doloribus architecto molestiae cum omnis. Cumque sunt voluptas saepe praesentium laborum. Quos nemo sunt nulla.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(211, 3, 'Ortuseight Quia numquam.', '-', '-', '-', 4737339, 1599807, 25, 'Tenetur consequatur sunt impedit omnis dolore. Eligendi sequi non incidunt eos. Nam omnis quas soluta et neque ut.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(212, 1, 'Nike Aliquid est.', '-', '-', '-', 4432771, 4618084, 17, 'Atque illum veniam doloribus ex. Ut commodi laudantium minus commodi in dicta. Aut ad qui veniam itaque est. Dolorum asperiores sapiente est accusantium voluptas. Est et dolor nobis suscipit.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(213, 4, 'Converse Deleniti saepe.', '-', '-', '-', 3707070, 2681808, 30, 'Earum minima dolor necessitatibus debitis. Amet quidem vitae minima fugiat odit asperiores eveniet dolorem. Vero consequatur iure deserunt sunt aut omnis.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(214, 2, 'Adidas Fuga.', '-', '-', '-', 2159700, 4570766, 22, 'Omnis rem quam aperiam ex sed omnis eveniet. Placeat cupiditate qui commodi hic magni maxime voluptas. Consectetur ab voluptatem vel autem. Quo debitis molestias perferendis consequatur et nihil ducimus sit.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(215, 4, 'Converse At ut.', '-', '-', '-', 4287546, 4148592, 23, 'Laborum velit occaecati voluptates minus excepturi atque. Adipisci alias animi quia cumque culpa hic iste. Est quasi vel omnis quas est. Ut aut necessitatibus corporis tempora.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(216, 5, 'Mills Inventore.', '-', '-', '-', 3061939, 4258379, 9, 'Aperiam amet odit est similique in iusto dolor voluptatem. Aut fugit culpa occaecati rerum mollitia eos ipsam. In ut inventore velit molestias sit quis. Sed est ut ut dolore rerum est voluptatem.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(217, 2, 'Adidas Eius.', '-', '-', '-', 2995036, 3475825, 7, 'Molestias et corporis rerum nihil qui. Exercitationem enim molestias consequatur voluptas.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(218, 3, 'Ortuseight Consequatur.', '-', '-', '-', 4059862, 4595789, 15, 'Dolorum assumenda minima earum iusto earum voluptatem aut. Maxime repudiandae quia veniam qui ad unde. Praesentium consequatur nihil aperiam ipsum ut aperiam. Vel dolore voluptas in.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(219, 3, 'Ortuseight Error veritatis.', '-', '-', '-', 2342342, 3568479, 11, 'Architecto ad in sapiente iure corporis sed. Velit voluptatem perspiciatis eligendi ex odio quibusdam. Deserunt facere reprehenderit qui velit minima laboriosam ad. Voluptatem rerum tempora sit cupiditate et.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(220, 3, 'Ortuseight Sunt.', '-', '-', '-', 4402728, 3681456, 22, 'Quae unde eius facilis atque quis expedita. Maxime consequatur inventore ipsam laudantium exercitationem. Consequatur iste labore occaecati nesciunt fugit beatae. Non corporis natus culpa fugit earum explicabo.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(221, 2, 'Adidas Iusto.', '-', '-', '-', 4350435, 3142307, 27, 'Nihil neque ipsa itaque consequatur eum. Eos rerum vero architecto id.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(222, 3, 'Ortuseight Sit.', '-', '-', '-', 2327059, 1772459, 7, 'Error possimus laudantium et cum eius hic. Sed et sed rerum facilis iste. Sed est repellendus temporibus tempore aperiam. Aspernatur corporis totam a non.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(223, 5, 'Mills Magni.', '-', '-', '-', 4448270, 3118630, 7, 'Magnam excepturi vero voluptates voluptas iure dicta similique. Dolores et dolor consequatur illum eligendi. Ipsam corporis debitis non sed. Molestiae aut commodi facilis placeat.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(224, 2, 'Adidas Qui qui.', '-', '-', '-', 2356763, 2813551, 11, 'Culpa unde aliquid suscipit ut quo et tenetur. Fuga nihil possimus quod iste corrupti libero. Ducimus atque quia animi quae ut voluptas sit. Error nostrum qui tenetur perferendis tempora in illum.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(225, 1, 'Nike Nobis quod.', '-', '-', '-', 4410901, 3379788, 17, 'Enim doloribus quas fugit culpa placeat reprehenderit nesciunt. Ut delectus suscipit voluptas. Repellendus nulla pariatur iusto non a distinctio. Aut laborum aut vel vel ut labore dicta.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(226, 4, 'Converse Repellendus.', '-', '-', '-', 2288512, 3753256, 28, 'Labore sed quibusdam amet voluptatem dolor facilis consequuntur voluptate. Eaque debitis officiis placeat. Nostrum est qui eligendi aperiam et.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(227, 4, 'Converse Molestiae reiciendis.', '-', '-', '-', 2587652, 3574773, 20, 'Sit aliquam voluptatem nihil voluptatibus. Et quis mollitia velit eos rerum magnam. Doloribus sed facilis explicabo non eligendi accusantium. Doloremque dicta dolores pariatur doloremque ut error.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(228, 2, 'Adidas Qui.', '-', '-', '-', 1993897, 4341515, 8, 'Iure quia ut quibusdam libero dolores quaerat. Blanditiis dignissimos ex voluptatem qui doloribus et dolor sunt.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(229, 1, 'Nike Corporis.', '-', '-', '-', 2049985, 3958614, 11, 'Non natus ut eum omnis aut corrupti quo. Est quia iste quis adipisci aut ullam. Id est iure consectetur blanditiis sit repellat quis.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(230, 5, 'Mills Sapiente.', '-', '-', '-', 3979000, 3801721, 8, 'Iusto facere tempora adipisci ut ipsam sed. Dolor ducimus magnam rerum fugiat dolorem aspernatur facilis. Voluptas eius nemo labore sed est est veritatis. Non eos rerum veniam et est dolor nesciunt.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(231, 4, 'Converse Amet.', '-', '-', '-', 4478970, 2697126, 30, 'Nobis corporis harum iure rerum deserunt ipsa doloribus. Reiciendis aut quae voluptas maiores nam vel laboriosam. Accusantium qui iusto laborum quia iure eos.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(232, 2, 'Adidas Fuga soluta.', '-', '-', '-', 4897859, 4263687, 25, 'Quaerat quos id nemo ipsa magni. Qui reprehenderit vitae earum quis quia iste ratione. Suscipit aut et ut vero ab voluptas est.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(233, 5, 'Mills At dolor.', '-', '-', '-', 3626401, 2927118, 30, 'Culpa nobis beatae id rem ex est. Voluptate corporis nobis voluptatibus eveniet quam. Distinctio nihil minus ipsa tenetur eos voluptatem fugiat. Aspernatur autem nemo placeat.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(234, 1, 'Nike Tempore omnis.', '-', '-', '-', 4393719, 4412953, 12, 'Et illum occaecati odit eos et temporibus ducimus. Excepturi qui facilis et eaque mollitia. Aut sit enim voluptatibus excepturi exercitationem ut.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(235, 1, 'Nike Et voluptatem.', '-', '-', '-', 4485287, 4063185, 25, 'Porro voluptates labore et et blanditiis qui accusamus corrupti. Perferendis veritatis iusto aut ex fugit sed. Nostrum harum sit quidem perspiciatis quis molestiae.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(236, 3, 'Ortuseight Ipsa.', '-', '-', '-', 3822577, 4201533, 21, 'Ut ipsum excepturi harum aspernatur odit consequatur molestias. Fugit dolorem minima saepe illum tenetur voluptas iusto. Expedita et qui saepe et minus. Libero dolorem fuga eaque.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(237, 5, 'Mills Blanditiis in.', '-', '-', '-', 1605833, 4885668, 16, 'Laudantium dolores consequuntur iste dolorum ratione in perferendis expedita. Nesciunt rerum sed velit. Enim non id modi et veniam hic.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(238, 1, 'Nike Voluptatem.', '-', '-', '-', 4216846, 2802971, 9, 'Reprehenderit magnam in qui. Ad illum maxime esse mollitia quo.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(239, 3, 'Ortuseight Voluptatem eum.', '-', '-', '-', 3907003, 1640991, 11, 'Voluptatem expedita cupiditate quo rerum harum aut eligendi. Corporis totam ex esse esse nihil et. Dolorem molestiae labore quia quis repellendus perspiciatis. Ut quisquam deserunt distinctio quam vel et ratione.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(240, 3, 'Ortuseight Quia sint.', '-', '-', '-', 3877975, 4130153, 12, 'Repellat delectus pariatur repellendus maiores possimus et amet. Quos mollitia occaecati eum maxime cupiditate. Molestias et id eum minima natus. Animi sapiente natus quis.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(241, 1, 'Nike Dolores.', '-', '-', '-', 4272827, 4489094, 30, 'Sit consequatur neque blanditiis beatae quibusdam et. Perferendis exercitationem velit quam dolores expedita rerum molestiae. Perspiciatis quis eos sed.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(242, 2, 'Adidas Autem.', '-', '-', '-', 4363140, 2878984, 10, 'Sed ut corrupti omnis eos ratione nostrum ad. Doloribus ipsum veritatis nobis vitae voluptatem. Sit illo iusto dolor commodi.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(243, 4, 'Converse Inventore aliquam.', '-', '-', '-', 4366316, 3827858, 5, 'Voluptatem soluta aliquid et. Dolorem non suscipit qui temporibus atque impedit ad. Officia hic totam dolores et aliquid natus. Illo est velit qui corporis dolore qui est.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(244, 4, 'Converse Possimus distinctio.', '-', '-', '-', 4806885, 2514717, 19, 'Sit consequatur ut et minus. Voluptas qui sed voluptas est.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(245, 4, 'Converse Et.', '-', '-', '-', 3861494, 1984219, 24, 'Distinctio ipsum et et sint aperiam. Dolorum ab quidem quasi. Asperiores ut quibusdam ut eum itaque sit unde maxime.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(246, 5, 'Mills Magni.', '-', '-', '-', 2699894, 3579134, 23, 'Dolorem qui laborum laudantium omnis tempora sunt. Modi corporis accusantium voluptatem sequi ipsam quidem. Veritatis tenetur delectus eos occaecati consequuntur quo.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(247, 3, 'Ortuseight Sint.', '-', '-', '-', 4258492, 4376816, 6, 'Dicta placeat sunt enim quos. Aperiam quae quam eum eos et dicta. Aut ut molestiae rerum mollitia.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(248, 3, 'Ortuseight Quis.', '-', '-', '-', 2860680, 2493401, 25, 'Tenetur officiis ut quia temporibus aut dolore. Laboriosam numquam deleniti placeat. Architecto fuga debitis pariatur quo nihil quia voluptatem. Autem ut temporibus dolorum culpa quidem hic omnis voluptatem.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(249, 1, 'Nike Sint.', '-', '-', '-', 2712593, 4073926, 15, 'Animi veritatis magni assumenda consequatur ducimus voluptate unde. Consequatur ut vel hic quaerat beatae. Vero odio rem magnam ullam aut voluptate. Alias porro dolorem voluptatem omnis asperiores dolorem. Ut voluptatem hic eius excepturi vitae aut.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(250, 5, 'Mills Id.', '-', '-', '-', 4868754, 4439264, 9, 'Ut eum eveniet exercitationem. Rerum sed est est nam illo accusamus. Explicabo molestiae eveniet velit dolorum aut placeat.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(251, 4, 'Converse Quos.', '-', '-', '-', 4820852, 1964290, 27, 'Cupiditate magnam tempora mollitia fuga. Placeat nobis nesciunt reprehenderit dolor tempore dolorum. Amet deserunt alias officia ratione ut. Est est sed corporis dignissimos quam aut ab.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(252, 2, 'Adidas Amet aut.', '-', '-', '-', 3803622, 2364337, 11, 'Et ad qui velit voluptas. Ut perferendis voluptatem ea nesciunt qui molestiae. Qui eius quia sunt repellat perferendis et accusamus.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(253, 5, 'Mills Libero.', '-', '-', '-', 2657459, 4359500, 15, 'Sit tempora at ut consectetur est nisi quas. Sit distinctio deserunt et sint nemo corrupti. Maxime voluptatem corrupti non molestiae.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(254, 3, 'Ortuseight Minus porro.', '-', '-', '-', 3158517, 3945470, 21, 'Dicta molestiae est qui. In consectetur deleniti delectus soluta eos et. Et non autem repellendus nam accusamus excepturi labore. Amet nobis nulla odit voluptatem odio nesciunt impedit ratione.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(255, 4, 'Converse Non quia.', '-', '-', '-', 1900701, 2094269, 23, 'Fugiat omnis quisquam fugiat. Aliquid dolor hic recusandae minus. Et ex rerum voluptas quo dolorum occaecati ut et.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(256, 4, 'Converse Fugit excepturi.', '-', '-', '-', 1973815, 2389005, 27, 'Laudantium consequatur saepe eligendi occaecati. Tempore consequuntur deserunt earum voluptates voluptates sit architecto. Culpa reprehenderit odio est dolorem aut. Recusandae consequatur porro est maxime vero officiis. Sunt provident mollitia ut sed enim totam libero.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(257, 5, 'Mills Velit perferendis.', '-', '-', '-', 2353163, 1967757, 28, 'Beatae repudiandae officiis earum sit mollitia reprehenderit. Fuga deserunt beatae placeat fuga perspiciatis est. Voluptatem officia corrupti inventore labore voluptate est earum sint. Accusantium ut ex odit veniam tempora sit sed est. Ducimus ad quia qui voluptatem ut.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(258, 3, 'Ortuseight Quos suscipit.', '-', '-', '-', 1516765, 4836296, 16, 'Enim quo id exercitationem facilis ex repudiandae officia. Dolores consequatur quibusdam dolorem eius et necessitatibus. Voluptatem architecto ut voluptatem architecto. Possimus doloribus et dolore eius nemo error.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(259, 4, 'Converse Tempore sint.', '-', '-', '-', 2887072, 1991052, 22, 'Quasi iure accusamus pariatur est officiis magni. Tempora vitae est est dicta sed. Debitis aut odit ad. Voluptates sit nisi eos voluptate id ipsa esse.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(260, 2, 'Adidas Et.', '-', '-', '-', 2587641, 1512223, 7, 'Doloribus esse in commodi pariatur praesentium voluptas. Voluptas illo quae officia quos sint est culpa. Aperiam consequatur ut voluptatem excepturi magnam. Qui voluptatem labore nulla laboriosam et ut vero dolore.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(261, 4, 'Converse Est.', '-', '-', '-', 4910083, 3368516, 6, 'Ex reiciendis quasi omnis. Vitae nobis accusamus animi ut. Facilis atque magnam non fugit debitis laudantium nisi. Fuga voluptatem voluptatem neque corrupti enim molestiae a. Sit ducimus quidem qui ut architecto est quam illum.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(262, 4, 'Converse Consectetur.', '-', '-', '-', 4258534, 3433719, 13, 'Et aperiam id et sint cumque harum. Est enim cupiditate amet distinctio ea est facere. Voluptatem et qui occaecati totam animi nemo omnis.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(263, 5, 'Mills Labore.', '-', '-', '-', 2852349, 2598235, 17, 'Soluta nobis in nulla pariatur ut. Eligendi odit labore et aspernatur rerum perspiciatis dolor. Dignissimos vero quas molestiae explicabo.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(264, 2, 'Adidas Aut sit.', '-', '-', '-', 4345378, 1582712, 7, 'Quod corrupti aut aut dolor sapiente est. Ad voluptatem quia est consectetur reiciendis. Deleniti cum doloremque et illo reiciendis et.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(265, 4, 'Converse Ducimus repellendus.', '-', '-', '-', 2377595, 3279157, 15, 'Dignissimos nostrum doloribus corrupti libero. Consectetur autem amet dolorum a in voluptatem similique vitae. Repellat qui qui blanditiis. Sunt qui atque autem adipisci soluta delectus sapiente voluptas.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(266, 4, 'Converse Pariatur et.', '-', '-', '-', 2501354, 3267188, 30, 'Dolor eum cupiditate possimus dicta. Non necessitatibus impedit cupiditate quae. Amet esse labore quos et facilis dolore.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(267, 1, 'Nike Quia.', '-', '-', '-', 3800525, 2144829, 21, 'Quisquam tempora libero dolores nesciunt. Voluptas dolores eum laborum. In molestiae cum debitis et in et quisquam. Pariatur sit sapiente ut et.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(268, 3, 'Ortuseight Distinctio.', '-', '-', '-', 4515119, 2669187, 27, 'Et pariatur fugiat nobis soluta. Voluptas consequatur fugiat quo occaecati placeat eligendi saepe. Quod cumque delectus exercitationem. Ut autem delectus placeat pariatur.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(269, 3, 'Ortuseight Debitis ea.', '-', '-', '-', 1576114, 2785380, 18, 'Molestiae et provident maxime aliquid. Et illo ut cumque atque. Eaque sed sed maiores cupiditate architecto voluptatem. Quasi aut similique dolores laudantium.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(270, 5, 'Mills Omnis.', '-', '-', '-', 3358478, 2852957, 24, 'Qui sunt modi sunt suscipit. Quia ut deserunt nisi excepturi magni praesentium. Dolore perspiciatis excepturi sit quis.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(271, 2, 'Adidas Id reprehenderit.', '-', '-', '-', 2269520, 2053721, 27, 'Et ipsa et labore. Accusantium doloremque doloribus voluptatem quas. Cupiditate voluptatem voluptas illum ullam voluptas.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(272, 5, 'Mills Pariatur.', '-', '-', '-', 1517917, 2508518, 20, 'Animi cum id molestiae rerum. Voluptate provident qui id dolorem eos praesentium saepe minima. Voluptas culpa quam fugit voluptatem. Beatae id velit temporibus exercitationem.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(273, 5, 'Mills Et.', '-', '-', '-', 2214506, 2522439, 8, 'Eos quia tempora expedita vero non ipsa et. Recusandae reiciendis sunt aut blanditiis commodi consequatur. Aut ut fuga doloribus consequatur.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(274, 2, 'Adidas Temporibus earum.', '-', '-', '-', 2291569, 2412117, 6, 'Voluptas pariatur dolorem quam officia sequi id sit. Ea nihil autem mollitia velit laboriosam. Enim maxime harum et ad.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(275, 1, 'Nike Molestiae.', '-', '-', '-', 1721454, 2698966, 16, 'Dolores temporibus laboriosam sunt omnis. Non omnis et ea sed provident esse. Doloremque fugit omnis quidem et voluptas sunt minima. Nam quo hic assumenda ut et debitis.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(276, 1, 'Nike Ut.', '-', '-', '-', 2195978, 4815188, 30, 'Ea iusto nam accusamus sunt velit. Impedit qui dolor ea repellat quam pariatur.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(277, 2, 'Adidas Quasi aspernatur.', '-', '-', '-', 2136800, 3486556, 17, 'Soluta quia est qui accusamus voluptatem. Eum et dolor ratione distinctio et aut eum. Soluta qui aut aut et modi. Sit debitis vel hic sit.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(278, 5, 'Mills Ipsa quibusdam.', '-', '-', '-', 1659594, 2265907, 23, 'Laboriosam ratione consequatur explicabo nesciunt et voluptas ipsa. Quibusdam eos dignissimos voluptate eligendi illo accusantium. Omnis tempore porro enim labore excepturi repellendus ex inventore. Repellendus voluptate qui reiciendis animi ex.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(279, 4, 'Converse Voluptas.', '-', '-', '-', 4398696, 3620041, 7, 'Ullam ut atque nemo repellat aliquid officiis inventore. Nihil sed et aperiam id. Minima ex autem ad iure animi.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(280, 2, 'Adidas Et dicta.', '-', '-', '-', 3852609, 3602769, 6, 'Ex tenetur dolor vel eos facere voluptas mollitia. Eligendi id reiciendis in natus rem veritatis est. Dignissimos ad suscipit molestiae voluptatem dignissimos dolores.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(281, 4, 'Converse Et.', '-', '-', '-', 2666052, 2913033, 19, 'Perferendis atque inventore et accusantium vitae. Excepturi a aperiam sapiente amet eaque ab pariatur. Nihil voluptatem ut culpa et.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(282, 3, 'Ortuseight Est omnis.', '-', '-', '-', 3378539, 2640923, 12, 'Non architecto non recusandae. Voluptatem nisi neque labore natus omnis enim dolor doloribus. Fuga cupiditate et labore. Neque sunt quia voluptatem modi.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(283, 3, 'Ortuseight Voluptate ullam.', '-', '-', '-', 2478370, 2572750, 8, 'Quia quis et nobis qui exercitationem incidunt. Itaque omnis sed adipisci recusandae cum tempora. Rem accusantium id laborum incidunt veritatis ullam.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(284, 2, 'Adidas Occaecati.', '-', '-', '-', 2907257, 1924080, 12, 'Consequatur et sit quia ad repellendus ipsam. Explicabo odit consequatur est sed facere odit nihil est. Dolor mollitia sunt alias qui cum. Asperiores sequi eaque nam quas.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(285, 2, 'Adidas Accusamus.', '-', '-', '-', 3925405, 3030328, 15, 'Dignissimos non eaque eligendi aliquid. Ut sequi inventore consequatur rerum. Quae ullam recusandae qui harum minima.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(286, 4, 'Converse Architecto.', '-', '-', '-', 4366270, 2354032, 9, 'Architecto corrupti placeat et dolore dolore tenetur. Sapiente voluptas et illum exercitationem velit sed omnis asperiores. Optio non perspiciatis quia odit voluptas consequatur ullam.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(287, 3, 'Ortuseight Porro est.', '-', '-', '-', 3537334, 2861615, 21, 'Maiores laudantium consequatur quasi neque non dolores. Quos et in quos natus sint debitis. Quaerat et praesentium et.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(288, 1, 'Nike Iste.', '-', '-', '-', 4446261, 3873157, 17, 'Molestiae provident qui quaerat earum quaerat quibusdam laboriosam. Id quia rerum ut delectus enim. Eos vero aut ut impedit ea distinctio quam.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(289, 2, 'Adidas Quo eum.', '-', '-', '-', 4378952, 3081880, 20, 'Consectetur enim laboriosam ea officiis. Velit cumque vero non ratione voluptatem aut facere. Quis quidem distinctio vitae mollitia.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(290, 1, 'Nike Alias.', '-', '-', '-', 3432999, 4835706, 23, 'Suscipit atque expedita culpa laudantium est eaque nihil aspernatur. Et nam sit vero sit quo. Commodi qui provident dolores facere sint blanditiis consectetur. Et accusamus voluptas soluta at error.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(291, 1, 'Nike Harum est.', '-', '-', '-', 3108995, 4711585, 25, 'Sunt possimus molestias et facilis esse adipisci. Minus ut ad nobis incidunt. Est qui qui fugiat nam porro consequatur sapiente. Omnis voluptatem officiis voluptate sit.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(292, 2, 'Adidas Omnis quia.', '-', '-', '-', 2009504, 4029244, 22, 'Delectus dolorem cupiditate dignissimos. Et dignissimos totam maxime a et. Qui et rerum dolores ut. Nulla eum dolore qui recusandae quia.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(293, 5, 'Mills Cum.', '-', '-', '-', 4322770, 1578816, 29, 'Aut soluta cum quod ut. Rerum voluptatum suscipit quas consequatur omnis in. Alias nihil maiores magni. Accusamus delectus culpa libero voluptatibus illo.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(294, 3, 'Ortuseight Nulla ut.', '-', '-', '-', 2938648, 4566920, 29, 'Ea doloremque quas fugit ratione. Optio atque est amet consequatur sit id. Repudiandae blanditiis deserunt fuga dolorum qui officia ut.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(295, 3, 'Ortuseight Rerum.', '-', '-', '-', 3106883, 4200036, 6, 'Aperiam nesciunt repellat illum et et perferendis quis et. Minima non eligendi maiores voluptatem. Natus amet nam voluptas facilis.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(296, 1, 'Nike Saepe.', '-', '-', '-', 2222318, 3452650, 8, 'Dolor perspiciatis commodi hic laboriosam aut. Iste mollitia et ipsum sapiente quia impedit. Sint reiciendis corporis unde dolorem labore.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(297, 3, 'Ortuseight Placeat.', '-', '-', '-', 3794464, 2305589, 11, 'Vero ea accusamus voluptatem non. Illum saepe expedita inventore. Qui voluptatem optio cupiditate quam et reprehenderit. Voluptas laudantium adipisci quasi in.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(298, 4, 'Converse Nihil ut.', '-', '-', '-', 2002208, 2203108, 16, 'Accusantium libero illum doloribus doloribus et autem incidunt. Maiores fuga nam eaque ea minus cum aut distinctio. Repellendus enim mollitia in.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(299, 5, 'Mills Qui.', '-', '-', '-', 2386875, 1869223, 18, 'Alias iste libero eum nemo dignissimos. Explicabo consectetur qui dolores nulla qui. Dicta enim quam culpa ut.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(300, 1, 'Nike Labore.', '-', '-', '-', 4907439, 2284617, 8, 'Asperiores sed molestiae ut aut a officia magnam commodi. Molestiae quo saepe excepturi quia facilis. Quas recusandae fuga delectus provident fugit.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(301, 5, 'Mills Aut.', '-', '-', '-', 1549030, 4024283, 30, 'Voluptas ex voluptatibus quisquam repudiandae architecto quia sed. Est eius ut numquam. Et illo nihil amet recusandae error libero corrupti dolor.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(302, 1, 'Nike Cumque quia.', '-', '-', '-', 2140824, 3679059, 25, 'Corporis nulla reprehenderit nulla perspiciatis quia voluptatibus. Quia voluptatem voluptatibus et voluptas rerum laborum ad iste.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(303, 5, 'Mills Eaque.', '-', '-', '-', 3272567, 2495783, 12, 'Aperiam sint sed deleniti id. Repellendus enim dolore itaque repellendus veniam soluta eligendi exercitationem. Voluptas quod quia assumenda inventore et. Occaecati harum asperiores ab rerum omnis atque voluptatem.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(304, 3, 'Ortuseight Qui quibusdam.', '-', '-', '-', 3848689, 4948993, 8, 'Odio distinctio fuga fuga possimus eius. Et eveniet fugit accusamus nihil quod rerum. Inventore aspernatur eos eos et.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(305, 1, 'Nike Sit.', '-', '-', '-', 2728069, 3564830, 11, 'Autem deserunt pariatur aut nostrum ut qui dolor. Non aliquam suscipit ratione autem eaque consequatur excepturi.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(306, 2, 'Adidas Nostrum optio.', '-', '-', '-', 3287458, 1924148, 24, 'Doloremque quo officia cumque. At consequatur incidunt ea accusantium qui suscipit. Qui debitis ut quae recusandae accusamus dolorem.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(307, 3, 'Ortuseight Repellat.', '-', '-', '-', 4540718, 3840923, 17, 'Iste pariatur quis cumque esse enim. Possimus aliquid asperiores ea et. Eum voluptatibus laudantium sed molestiae id sed. Aperiam qui dolor facere voluptatibus beatae.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(308, 1, 'Nike Hic.', '-', '-', '-', 3023603, 1538948, 18, 'Quo illum dolore rerum fuga et nihil consequatur. Dolores nesciunt numquam voluptatem aut dolor quod. Qui eos ut ipsum.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(309, 3, 'Ortuseight Consequatur.', '-', '-', '-', 3056618, 4213403, 23, 'Id officiis a aliquid animi ipsam. Accusamus quia nemo quaerat quisquam et iusto minus. Optio quia officiis odit at earum ea. Beatae perferendis similique et reprehenderit ut ipsam dolores.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(310, 1, 'Nike Qui.', '-', '-', '-', 4691418, 2928092, 6, 'Quaerat sint dolor ratione voluptates quos magnam. Quis voluptas eius et ea. Mollitia reprehenderit voluptates voluptatibus quia.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(311, 4, 'Converse Omnis eius.', '-', '-', '-', 3640646, 2407758, 7, 'Quibusdam qui expedita magni perspiciatis. Cum harum ea iusto et praesentium asperiores. Et molestias rerum quae libero quo omnis.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(312, 3, 'Ortuseight In.', '-', '-', '-', 2608377, 3831812, 25, 'Sed quidem rerum amet. Sapiente ea voluptatem et eveniet eos qui. Quos aut quos commodi hic. Consequatur ut fuga aut quam fugiat eveniet sunt quae.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(313, 5, 'Mills Et expedita.', '-', '-', '-', 3735498, 4584783, 19, 'Sit aut beatae sit temporibus perspiciatis quis. Ut nesciunt eum aut aut possimus. Assumenda ipsum eum laboriosam aut mollitia.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(314, 2, 'Adidas Explicabo facilis.', '-', '-', '-', 3628879, 4372331, 29, 'Repudiandae consequatur vel est voluptate et laborum quia. Dolores nostrum adipisci doloremque ipsa eos nisi. Ea nisi enim tempore animi. Et voluptas sed et laborum distinctio quod at.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(315, 3, 'Ortuseight Aperiam officia.', '-', '-', '-', 3073118, 4632205, 28, 'Magnam nulla exercitationem magni recusandae provident iure aut. Fuga nihil ex doloribus iste ut debitis. A libero est incidunt omnis tempore.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(316, 3, 'Ortuseight Quis.', '-', '-', '-', 2228978, 1913544, 26, 'Sed dignissimos impedit perferendis blanditiis accusamus enim. Rerum in dolor itaque sunt ut reprehenderit omnis. Culpa rerum unde quis expedita dignissimos. Eum dolorem ea beatae asperiores placeat aut.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(317, 3, 'Ortuseight Qui qui.', '-', '-', '-', 4730606, 4200617, 26, 'Non est ratione iste consectetur earum quo. Aut quisquam rem et ullam similique numquam sapiente et. Ea beatae rerum amet quae sit veniam laudantium. Officiis rerum et praesentium eaque.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(318, 4, 'Converse Numquam.', '-', '-', '-', 2143596, 2348568, 8, 'Totam illum non minima consequatur. Qui aspernatur unde qui voluptatem a aliquam similique. Est eligendi quia molestiae ex repudiandae soluta dolorum. Quia assumenda voluptate doloremque reiciendis laborum deleniti ipsum.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(319, 3, 'Ortuseight Veritatis et.', '-', '-', '-', 3559208, 4806879, 26, 'Ut pariatur qui iusto. Sit quia et impedit esse magnam. Sapiente quia dolorem est doloremque eaque ratione.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(320, 5, 'Mills Perferendis.', '-', '-', '-', 2536125, 4165743, 10, 'Ea aut dolores velit omnis ut quo et. Eligendi itaque nostrum labore voluptas tempora inventore rerum. Facere velit est a reprehenderit et. Quae repellendus repellendus ut expedita consequuntur.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(321, 1, 'Nike Voluptas.', '-', '-', '-', 4120339, 3972378, 9, 'Nihil eveniet nulla commodi. Laboriosam nihil minima repellendus fugit odit autem consequatur reprehenderit. Et voluptatem molestiae temporibus repellat est. Dolor quo modi sequi perferendis aliquam est vel.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(322, 1, 'Nike Qui aut.', '-', '-', '-', 4029102, 2198205, 30, 'Et nobis nemo ut et ipsam. Omnis architecto aut omnis autem molestias sed. Et nesciunt sint blanditiis. Rerum alias exercitationem hic reiciendis id aliquid aut ut.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(323, 3, 'Ortuseight Et eos.', '-', '-', '-', 4556643, 3796589, 10, 'Corporis expedita vero ad voluptatem doloribus tempora. Libero reiciendis et consequuntur eum. Labore occaecati alias maxime ea doloribus vel. Perspiciatis quod autem saepe neque iusto repellendus.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(324, 3, 'Ortuseight Magni ab.', '-', '-', '-', 1903758, 2607692, 20, 'Quam ut eligendi sunt et quia. Est provident officiis aspernatur dolores odit deleniti voluptas. Laudantium optio necessitatibus magni minima quidem sed.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(325, 5, 'Mills Laboriosam sit.', '-', '-', '-', 3010506, 3686248, 19, 'Voluptates facere optio occaecati saepe. Illo sit eligendi a modi quis eos. Debitis qui explicabo hic ea. Reprehenderit quia suscipit quos repellat cum nesciunt.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(326, 2, 'Adidas Distinctio placeat.', '-', '-', '-', 1943806, 2326821, 23, 'Vel maxime iure laboriosam quis. Et repudiandae nemo rem qui voluptatem quae. Unde dolorem amet sit architecto. Veritatis totam at ut voluptatem at corporis consequuntur.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(327, 4, 'Converse Dolor.', '-', '-', '-', 2043408, 4636761, 22, 'Et commodi eaque consequatur ea quia labore dignissimos architecto. Officia voluptatem laudantium rerum atque. Quia omnis quod dolorem. Distinctio delectus suscipit delectus officiis id.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(328, 1, 'Nike Hic.', '-', '-', '-', 2517094, 2370534, 24, 'Qui nemo quia enim iure. Iste nobis officiis itaque omnis ab assumenda. At earum delectus dolorem velit.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(329, 3, 'Ortuseight Tenetur hic.', '-', '-', '-', 3033062, 3273469, 9, 'Nihil fugiat in nostrum repudiandae dolore. Fuga consequatur dolorem architecto eos perferendis. Dolores corporis corrupti quae reiciendis quis.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(330, 2, 'Adidas Omnis.', '-', '-', '-', 2238073, 2443450, 13, 'Est enim occaecati magnam quasi quas illum. Vel pariatur qui hic dolor. Et est saepe nostrum ratione consectetur qui nemo. Atque qui deleniti reiciendis eum quia sunt qui.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(331, 1, 'Nike Ut.', '-', '-', '-', 2252386, 3062862, 8, 'Quam eius et autem velit dignissimos. Pariatur officia ratione in. Voluptas ipsum nisi voluptatibus et. Nihil natus odio asperiores rerum quod earum.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(332, 4, 'Converse Sunt facere.', '-', '-', '-', 4409461, 2512018, 17, 'Eum doloribus quasi suscipit. Alias at illo asperiores et sit. Ratione id quis est doloremque dolores inventore eos. Assumenda odio quo temporibus nihil quos et eligendi quia.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(333, 1, 'Nike Explicabo hic.', '-', '-', '-', 1935259, 4850387, 15, 'Aut laborum corporis animi sapiente maiores. Eos quia et aut ea illo. Ipsa reiciendis ut ipsa velit vel at. Aut qui accusantium neque beatae. Aut totam totam odio nobis iusto cumque.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(334, 2, 'Adidas Natus.', '-', '-', '-', 2707852, 2996195, 8, 'Ea iusto autem consectetur molestiae odit. Facere voluptas dolorem recusandae. Rerum quibusdam nesciunt quia expedita velit eveniet ut. Id libero dolores voluptas enim exercitationem quia nesciunt.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(335, 1, 'Nike Molestias.', '-', '-', '-', 3502480, 1526719, 29, 'Pariatur ipsam sint quis voluptas eos. Laboriosam repudiandae beatae saepe quasi cum optio repellendus dignissimos. Ipsum reprehenderit et voluptas suscipit.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(336, 1, 'Nike Ut aperiam.', '-', '-', '-', 4003896, 3220370, 17, 'Unde enim non id excepturi ipsum. Modi reiciendis molestiae perspiciatis ea. Odit nulla doloremque doloribus commodi doloremque. Sint quae ut voluptatibus sed qui sed voluptates.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(337, 4, 'Converse Repellendus omnis.', '-', '-', '-', 2970469, 2209994, 27, 'Adipisci reprehenderit dolores ducimus tempore. Corporis aliquid nemo maiores totam. Aut esse consequuntur porro quidem vero porro.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(338, 5, 'Mills Vero voluptates.', '-', '-', '-', 2733555, 4572227, 9, 'Ea corporis numquam dicta repellat ipsam molestiae quia. Mollitia repudiandae officia saepe. Ut totam animi sit.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(339, 4, 'Converse Voluptatibus.', '-', '-', '-', 1547691, 2171933, 9, 'Et fuga iste libero. Modi sit atque sunt quaerat. Et ipsam cumque temporibus voluptatem qui adipisci ab. Dignissimos unde eligendi dicta est vel reprehenderit repellendus.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(340, 4, 'Converse Qui fuga.', '-', '-', '-', 2852893, 4181629, 18, 'Esse numquam sunt exercitationem quia suscipit voluptatem. Corporis fuga omnis rem maxime esse aut. Sunt accusamus sunt sit temporibus vel optio. Quod a praesentium eos pariatur et.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(341, 2, 'Adidas Deserunt in.', '-', '-', '-', 2364058, 1643553, 28, 'Ut quae unde voluptates odio inventore consequatur quas. Eius dicta dolor asperiores deserunt tempora. Ut magnam dolores voluptatibus sit non vel non.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(342, 4, 'Converse Laborum omnis.', '-', '-', '-', 2863500, 1996040, 30, 'Assumenda ut officiis est quia iure. Rerum modi ipsa quaerat non. Omnis temporibus provident magni ipsum consectetur. Eos sint consequatur itaque accusantium veritatis voluptatem.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(343, 1, 'Nike Velit.', '-', '-', '-', 1943409, 2699228, 5, 'Et inventore at commodi laboriosam est aut. Dignissimos non modi eius explicabo. Et qui voluptatem quasi ipsum ut.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(344, 4, 'Converse Vel.', '-', '-', '-', 2476922, 3720536, 23, 'Temporibus quo quas placeat laborum sed eveniet et. Optio placeat dolorem vel provident.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(345, 5, 'Mills Eum optio.', '-', '-', '-', 2018068, 4498272, 27, 'Atque nihil quisquam esse et sit. Nesciunt omnis modi est veritatis et quia. Aspernatur provident dolor ea eos dolores. Ipsam consequatur neque a quod.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(346, 4, 'Converse Rerum voluptatem.', '-', '-', '-', 3727335, 2304519, 24, 'Labore dolorem temporibus sed debitis expedita et. Officia ipsum ut id dolorum nam nulla pariatur. Exercitationem omnis dolores aut nesciunt. Quas reiciendis sunt quis dolor fugiat molestiae qui.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(347, 3, 'Ortuseight Atque aut.', '-', '-', '-', 4631910, 3301767, 15, 'Quis odit sed soluta ut deserunt. Deleniti consectetur vel omnis aperiam voluptates quidem. Doloremque odio qui qui officia. Ipsum provident beatae laborum.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(348, 2, 'Adidas Quia.', '-', '-', '-', 4099299, 1775182, 23, 'Repellat ipsum qui et quis neque et nam. Consequatur voluptates natus sed recusandae aliquam illo veritatis. Rerum ut eius dolores et distinctio numquam molestiae. Maiores ea minus corrupti quidem eum cum molestiae.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(349, 2, 'Adidas At minima.', '-', '-', '-', 2721699, 2933140, 30, 'Pariatur ratione quia similique. Porro enim aut aut perspiciatis. Possimus perspiciatis laboriosam laudantium possimus cumque laboriosam at. Blanditiis omnis dolore dolorem numquam.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(350, 4, 'Converse Molestiae.', '-', '-', '-', 2644109, 2827852, 12, 'Aut pariatur consequatur consequatur sapiente. Illo molestiae dolores omnis non numquam quisquam.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(351, 5, 'Mills Asperiores aliquid.', '-', '-', '-', 4511982, 1537258, 17, 'Mollitia quis itaque molestias sed architecto commodi. Eveniet aspernatur voluptas quis numquam sed saepe.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(352, 3, 'Ortuseight Iste.', '-', '-', '-', 3160457, 4536028, 25, 'Dolores veritatis minus in. Blanditiis tempore qui accusantium tempore nam. Facilis consequuntur temporibus at consequuntur quo adipisci rerum. Fugiat ut debitis dolorum veniam ipsam.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(353, 3, 'Ortuseight Dolore eligendi.', '-', '-', '-', 2767060, 3172751, 29, 'Dicta aperiam sit ut suscipit voluptate quae fugit molestiae. Asperiores rem autem eaque. Ut quo molestiae numquam libero architecto qui rerum quod.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(354, 2, 'Adidas Atque.', '-', '-', '-', 2593738, 2273661, 20, 'Necessitatibus optio dolorem fugiat nostrum aut. Voluptatum voluptatem quos distinctio quas enim rerum quia. Vitae nobis laudantium ut sit.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(355, 5, 'Mills Repudiandae sit.', '-', '-', '-', 3554545, 4553956, 21, 'Reprehenderit rem molestiae enim eos deserunt. Sed eum autem odio laudantium. Vel possimus eligendi ipsa voluptatibus sint.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(356, 1, 'Nike Modi.', '-', '-', '-', 2034668, 2361619, 15, 'Vero quos magnam voluptatem est. Provident sit reiciendis neque. Sed fugit nulla veniam est sapiente. Qui nisi accusamus neque modi.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(357, 5, 'Mills Minus est.', '-', '-', '-', 4032211, 2134648, 15, 'Enim dicta corporis harum doloremque omnis illo quia. Quisquam sint molestias quis qui dolorum harum. Qui sint nihil accusamus ut vitae ut dolores earum. Velit et non neque non ut dolorum. Impedit architecto dolorum nihil fugit illum velit ut eius.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38');
INSERT INTO `shoes` (`id_shoes`, `id_category`, `shoe_name`, `image1`, `image2`, `image3`, `sale_cost`, `actual_cost`, `stock`, `description`, `size`, `created_at`, `updated_at`) VALUES
(358, 1, 'Nike Error et.', '-', '-', '-', 4987734, 3307080, 26, 'Voluptatem aperiam adipisci et cum maxime id officia. Blanditiis tempore optio hic amet qui ab.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(359, 1, 'Nike Omnis.', '-', '-', '-', 2271535, 3809942, 21, 'Eligendi amet ut dolores sunt iste velit. In iure explicabo adipisci eveniet cum natus delectus. Maxime autem nihil voluptas animi tempore harum autem. Est officia non consectetur velit rem impedit ut.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(360, 3, 'Ortuseight Doloremque.', '-', '-', '-', 2989095, 2838122, 20, 'Est et facilis rerum voluptatibus est laudantium non. In impedit nostrum minima voluptatem odio earum iusto eum. Nisi quisquam tenetur eum enim est accusamus.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(361, 3, 'Ortuseight Maxime.', '-', '-', '-', 2067027, 2594686, 8, 'Harum commodi nisi omnis fugiat harum. Aut perferendis nostrum illum voluptate.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(362, 4, 'Converse Fugit nostrum.', '-', '-', '-', 3355364, 3180587, 25, 'Ex doloremque debitis id ea. Unde est et sapiente animi. Ut omnis rerum occaecati nisi possimus incidunt distinctio. Alias aspernatur sunt ipsa quod.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(363, 1, 'Nike Deleniti eligendi.', '-', '-', '-', 2183566, 1517751, 21, 'Itaque sit quaerat eos inventore esse mollitia ducimus. Tempora ipsa nihil corporis minima quibusdam laboriosam ea. Molestiae et pariatur qui est. Ipsum voluptates provident quidem repellendus facere et sunt.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(364, 5, 'Mills Repellendus.', '-', '-', '-', 1666680, 3917024, 27, 'In repudiandae distinctio voluptatum at. Eum et autem quo ullam. Nesciunt qui optio sapiente sunt inventore error.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(365, 4, 'Converse Quos sed.', '-', '-', '-', 4838273, 4767081, 12, 'Repellendus exercitationem corporis debitis est asperiores maiores. A deleniti non ut quia reiciendis quod. Recusandae nostrum est aliquam repellat voluptatem.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(366, 1, 'Nike Pariatur autem.', '-', '-', '-', 4493559, 4404749, 30, 'Voluptas eligendi eveniet qui exercitationem suscipit aut itaque quos. Doloribus repellendus et repudiandae magnam. Quidem rem culpa rem cum.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(367, 5, 'Mills Aut.', '-', '-', '-', 4388280, 1795482, 29, 'Voluptas voluptates voluptatibus eius earum. Voluptates quisquam ex enim vel delectus qui. Quis accusantium dolor sapiente ipsum recusandae sed. Et et nulla non.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(368, 2, 'Adidas Dolores ab.', '-', '-', '-', 2686465, 2182971, 9, 'Ratione voluptates autem pariatur repellendus. Eos adipisci nulla quasi sunt quo.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(369, 2, 'Adidas Omnis.', '-', '-', '-', 4503151, 4879916, 28, 'Sequi rem consectetur omnis. Sapiente adipisci est quod quas soluta facere. Et ea fuga cum impedit quia minus. Excepturi quidem est quibusdam quae iste quibusdam et.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(370, 3, 'Ortuseight Provident.', '-', '-', '-', 2598050, 3192523, 20, 'Officiis incidunt et quod quia veritatis minima porro. Perferendis suscipit doloremque laborum est nesciunt.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(371, 4, 'Converse Nobis.', '-', '-', '-', 4773577, 3309394, 10, 'Vel amet nostrum nemo rerum eligendi hic eligendi rerum. Mollitia vitae quis quas omnis aliquam. Praesentium earum ipsam possimus numquam doloribus voluptas architecto.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(372, 4, 'Converse Omnis distinctio.', '-', '-', '-', 4406461, 3429258, 14, 'Magni officiis ut a voluptatum. Quibusdam praesentium delectus facilis accusamus tempora consectetur accusamus. Dolore facilis facere odit. Nesciunt autem earum nobis neque possimus repellat tempore.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(373, 1, 'Nike Dolorem et.', '-', '-', '-', 3005398, 4727589, 26, 'Dolorum placeat delectus beatae quaerat dolor. Explicabo et doloremque earum ut. Repellendus sunt et recusandae.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(374, 1, 'Nike Et occaecati.', '-', '-', '-', 3413137, 2578614, 30, 'Quia omnis nihil dolorem eum voluptates. Facere distinctio aliquid repudiandae omnis velit eius. Eius itaque accusamus qui aperiam alias accusantium repudiandae corrupti. Tenetur nihil porro ea assumenda consectetur assumenda nam ducimus. Dicta rerum nobis quia quis ipsam saepe.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(375, 2, 'Adidas Libero ut.', '-', '-', '-', 2368311, 2490559, 17, 'Enim sapiente voluptatem saepe expedita aut rem qui. Dolores accusantium ad provident aut.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(376, 3, 'Ortuseight Ut.', '-', '-', '-', 4203501, 1531228, 5, 'Itaque animi accusantium est blanditiis enim cumque. Est beatae omnis pariatur accusamus. Et dolorum est tenetur voluptate nihil sit in. Praesentium sed sit et neque non sed est.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(377, 3, 'Ortuseight Optio.', '-', '-', '-', 4637074, 1772323, 16, 'Optio odio at sequi illo et ut nisi. Dolores eius magnam quia rerum nihil.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(378, 5, 'Mills Eligendi.', '-', '-', '-', 3366396, 1792504, 24, 'Illum fuga delectus qui ipsum officiis. Aut quis adipisci ut fugiat. Vel mollitia eum autem.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(379, 5, 'Mills Adipisci.', '-', '-', '-', 4994284, 2962679, 5, 'Accusantium et commodi dolorem nostrum ea. Autem sed corrupti aut. Enim qui tempore fugiat modi quis.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(380, 5, 'Mills Vel.', '-', '-', '-', 3035767, 2879675, 22, 'Temporibus quia sapiente debitis corrupti facilis minima labore laborum. Minima totam enim tempore magni. Fugit unde mollitia incidunt doloribus nulla. Aut neque natus quod cupiditate velit voluptatem dolores aperiam.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(381, 1, 'Nike Et sit.', '-', '-', '-', 2697424, 3047121, 13, 'Nam itaque aut fugit id magnam quidem a. Dolor voluptatibus velit beatae ratione ea repellendus quia.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(382, 1, 'Nike Molestiae sit.', '-', '-', '-', 1896545, 2882729, 11, 'Voluptatibus quidem sed in voluptatem voluptatum ut dolor. Occaecati molestiae ad maiores ut voluptatem provident eius dolor. Mollitia omnis atque fugit. Error ut ut voluptate soluta.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(383, 2, 'Adidas Omnis quis.', '-', '-', '-', 1570259, 3558737, 8, 'Deleniti deserunt omnis velit laudantium aspernatur. Aspernatur quidem et tenetur animi.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(384, 5, 'Mills Odio.', '-', '-', '-', 3221257, 1670510, 30, 'Sit eligendi deserunt et. Voluptatem dolores blanditiis voluptatem ut reiciendis est asperiores. Est quibusdam ipsum rerum in ut ipsa magnam. Neque repellat sed quidem laboriosam dolores maiores qui. Maxime aut et vitae animi ratione in omnis.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(385, 1, 'Nike Perspiciatis illo.', '-', '-', '-', 3762304, 4924136, 17, 'Impedit aut dicta quo voluptatem consequatur. Aut rem qui quae praesentium laudantium et maiores. A ab in ut. Suscipit et fuga quo sunt suscipit et optio.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(386, 2, 'Adidas Cum.', '-', '-', '-', 4726507, 1828220, 14, 'Ut enim est nostrum molestiae non at. Ea enim sunt voluptatum enim autem. Sed velit ex provident et laudantium aut. Eius quae facilis omnis magni sint accusamus non occaecati.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(387, 3, 'Ortuseight Rem.', '-', '-', '-', 3394393, 3471879, 30, 'Consequuntur esse ipsam vel asperiores aut. Aspernatur et cum ut aut quisquam aut necessitatibus. Fugit officia officiis vel rerum. Suscipit consequuntur dignissimos ex dolorem totam saepe earum.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(388, 3, 'Ortuseight Ut ea.', '-', '-', '-', 2959857, 2375170, 5, 'Quas ut ad corporis libero veritatis mollitia. Porro nulla fuga nesciunt non non id. Autem recusandae et placeat ab qui rerum omnis in.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(389, 2, 'Adidas Est.', '-', '-', '-', 4268139, 3755970, 13, 'Reprehenderit ea sunt distinctio provident occaecati earum. Voluptate dolorum ex ea mollitia repellat. Consequatur natus voluptate aut ad praesentium. Laboriosam pariatur alias ipsum quis officia et.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(390, 3, 'Ortuseight A neque.', '-', '-', '-', 3942476, 1872995, 19, 'Sit ipsum vel cupiditate cum. Ad aut aut neque doloribus culpa facere. Nisi accusamus vel cupiditate in consequuntur corrupti est. Doloribus quam dolor velit voluptatem quia.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(391, 1, 'Nike Enim ab.', '-', '-', '-', 3612740, 2991953, 17, 'Sed inventore harum atque rem culpa explicabo corporis. Suscipit et reprehenderit ab reiciendis. Ut hic qui nobis recusandae sint voluptate adipisci. Praesentium sunt est quis quidem in.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(392, 2, 'Adidas Sequi.', '-', '-', '-', 4240180, 4965588, 14, 'Sapiente minus quam autem quas magnam. Illum tenetur id dolor consequatur voluptatem id sunt. Vitae impedit corrupti accusamus.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(393, 4, 'Converse Cum.', '-', '-', '-', 1861313, 3275431, 5, 'Doloremque provident optio distinctio est impedit et eius. Sunt laboriosam consequatur voluptatem doloremque quo qui expedita. Quam quibusdam corrupti atque veritatis repudiandae qui. Cumque sed libero voluptatem voluptatem.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(394, 2, 'Adidas Corporis cumque.', '-', '-', '-', 4941883, 2136420, 14, 'Quaerat occaecati officia qui. Ipsa soluta tempore sit voluptatem culpa pariatur. Quisquam similique cupiditate quaerat laudantium deleniti qui harum. Ipsa nihil quas sint et totam ipsam reiciendis. At nihil tempore tempore veritatis iusto.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(395, 3, 'Ortuseight Quia reprehenderit.', '-', '-', '-', 2707800, 3423727, 26, 'Doloremque est consequatur reprehenderit necessitatibus delectus nostrum illum. Omnis nobis culpa culpa quidem. Qui deserunt est enim minus laudantium. Voluptatum maiores tenetur rem nihil repellat et voluptates.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(396, 4, 'Converse Expedita fuga.', '-', '-', '-', 4920791, 1911832, 18, 'Ea nisi error fugiat laborum sint velit ut. Magnam ut omnis et fuga. Consequuntur distinctio consequatur quisquam dolores expedita nam quos. Odit exercitationem sed sint et qui nemo. Quia totam repellendus consequuntur temporibus accusantium.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(397, 5, 'Mills Soluta sequi.', '-', '-', '-', 2570218, 2180352, 19, 'Consequatur nam perspiciatis quod aut natus. Reprehenderit reiciendis culpa sunt animi. Error nobis dolore qui deserunt quidem doloremque eveniet. Eos ex iste eligendi. Ipsum distinctio pariatur saepe ea.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(398, 1, 'Nike Adipisci eos.', '-', '-', '-', 4219450, 2823173, 21, 'Laudantium dolor at enim. Tenetur ratione repellendus ut quisquam inventore ipsam qui quam. Repellendus aut soluta ut asperiores.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(399, 4, 'Converse Dolores.', '-', '-', '-', 3574940, 2218198, 28, 'Quis commodi voluptas vero quia soluta tempora. Sunt sed est qui amet et ullam necessitatibus. Quasi deserunt laborum minus praesentium.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(400, 3, 'Ortuseight Rem cumque.', '-', '-', '-', 2678594, 2317770, 7, 'Eius mollitia ut modi quos quia ut qui. Ipsam voluptatum saepe cum atque nostrum. Ut nemo et deleniti error deleniti suscipit.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(401, 2, 'Adidas Est.', '-', '-', '-', 2638416, 3679808, 27, 'Qui nobis quod autem excepturi ut. Ut tempore ipsum voluptatem similique omnis temporibus. Doloremque rem amet debitis in quisquam. Porro ut fuga impedit qui voluptates amet est. Et quia delectus possimus veritatis molestiae qui est.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(402, 4, 'Converse Dicta repellat.', '-', '-', '-', 2887224, 1792304, 13, 'Maiores est fugit dignissimos omnis molestiae consectetur illum. Sed vitae error exercitationem quae et nemo. Mollitia ex cupiditate fuga qui voluptatem quos maxime.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(403, 3, 'Ortuseight Quidem.', '-', '-', '-', 3974744, 4753109, 19, 'Nesciunt quibusdam quia eum porro eaque ut. Consequatur ratione ut autem quae voluptatum voluptas quibusdam. Est ipsum a et et qui. Qui error impedit amet.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(404, 1, 'Nike Fugiat iure.', '-', '-', '-', 3377838, 2555755, 11, 'Earum repellat dolorem nihil magni. Autem similique necessitatibus ducimus delectus qui deserunt quia. Pariatur sint iste sequi.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(405, 1, 'Nike Exercitationem consequatur.', '-', '-', '-', 2182744, 2243148, 19, 'Sit qui voluptas dolor fugit possimus. Recusandae ut eaque et ea. Accusantium distinctio est quo quibusdam vitae voluptate autem amet.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(406, 3, 'Ortuseight Nobis.', '-', '-', '-', 3088894, 3466513, 29, 'Quae nam sapiente iusto vero non nobis culpa. Reiciendis illum expedita vero sed tempora reprehenderit qui. Ab atque dignissimos voluptatem architecto qui ex. Qui possimus corrupti facere veniam. In harum atque harum repudiandae.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(407, 1, 'Nike Porro saepe.', '-', '-', '-', 2795542, 4359592, 19, 'Iusto sequi similique quod quaerat dicta sed et. Recusandae ipsa recusandae quo nesciunt qui. Non atque ipsum labore eum et nam omnis. Explicabo et repellendus eius nesciunt vero laudantium.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(408, 1, 'Nike Tenetur minima.', '-', '-', '-', 1769525, 1726237, 30, 'Et reiciendis est error. Ut rem eos fuga necessitatibus. Unde debitis ab nihil.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(409, 5, 'Mills Est quas.', '-', '-', '-', 3511515, 1659124, 27, 'Rerum asperiores aliquid et in ut quas beatae. Quia commodi assumenda voluptatem tempora. Eveniet nemo magnam sed. Eum quod ab provident maxime vel iusto debitis et.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(410, 5, 'Mills Nihil pariatur.', '-', '-', '-', 1616346, 4779096, 16, 'Debitis cupiditate dolorem consequuntur repellendus maiores ducimus. Ipsum suscipit qui ad maiores nisi sint. Reiciendis animi ullam sit aliquam culpa. Optio rerum sed rerum.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(411, 5, 'Mills Odit quia.', '-', '-', '-', 3767608, 3752792, 13, 'Fugit autem aut cum sed praesentium molestiae. Aliquid vel non eaque dolores aut voluptas ratione. Dolorem enim omnis voluptatem et ut. Quo dignissimos totam eos explicabo harum modi.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(412, 4, 'Converse Molestias sint.', '-', '-', '-', 2244664, 3633423, 19, 'Voluptates sed esse iusto nulla neque iure ipsum fugiat. Sit accusamus qui dolores. At repudiandae expedita et voluptatem perferendis qui dolor sint.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(413, 3, 'Ortuseight Quas rerum.', '-', '-', '-', 4986051, 2445105, 12, 'At enim quia dolorem est. Voluptates eligendi ut optio. Accusantium iusto odio veniam qui et. Sunt enim accusantium veritatis architecto ad aperiam.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(414, 5, 'Mills Quam officiis.', '-', '-', '-', 1674630, 2002265, 19, 'Quibusdam qui cupiditate non quod. Minima quam consequatur et. Molestiae reprehenderit commodi minima suscipit nostrum alias harum. Reprehenderit unde voluptate unde iste rem incidunt mollitia.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(415, 1, 'Nike Reiciendis.', '-', '-', '-', 2671340, 2167286, 12, 'Animi in aliquam sit aspernatur nesciunt. Architecto rerum qui aut culpa et voluptatem et. Dolorem ducimus consectetur dolorem autem vel dolorum pariatur.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(416, 4, 'Converse Enim nihil.', '-', '-', '-', 4445634, 2194691, 27, 'Minima quisquam repellendus cumque laboriosam. Ullam expedita dolorem accusantium fugit dolor eos dolores. Qui sint dolores voluptatem corrupti quidem est et. Placeat culpa perspiciatis sed autem nostrum nisi iste.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(417, 2, 'Adidas Ex.', '-', '-', '-', 2526294, 4085056, 13, 'Debitis placeat tenetur exercitationem veritatis voluptatem. Repellat ut ut ut unde et iusto quae ipsum. Non enim facilis iusto veniam.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(418, 5, 'Mills Qui.', '-', '-', '-', 2284235, 3782710, 26, 'Vitae nemo exercitationem sed cumque labore aut voluptatem. Possimus molestiae minima voluptatum velit. Et voluptatem quae consequatur quis aperiam. Recusandae ullam voluptatum vel et beatae.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(419, 4, 'Converse Tempore.', '-', '-', '-', 2865641, 4066709, 28, 'Recusandae ut quia enim beatae veritatis. Sunt aut aut nesciunt aliquid magnam porro ipsam. Consectetur harum sunt aliquam error. Reprehenderit ut nam est eos laborum et vero et. Aperiam officiis sint dolores modi.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(420, 4, 'Converse Nulla.', '-', '-', '-', 4429521, 1987750, 24, 'Et eum velit non est quia. Aut fugit quibusdam maxime voluptatum adipisci beatae. Similique ducimus et maiores ut maxime. Eos et omnis ea error dolor.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(421, 2, 'Adidas Et sit.', '-', '-', '-', 3180436, 4948512, 7, 'Facere quidem qui enim est. Ut voluptate magni et sit nisi rem quibusdam quibusdam. Velit sit illum neque qui. Omnis incidunt dolore velit consequatur ullam.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(422, 5, 'Mills Voluptatum.', '-', '-', '-', 2324425, 2521289, 6, 'Vel quia veniam nesciunt ut enim deserunt vitae et. Cum eos dignissimos quia deserunt fugit molestias voluptatum. Dolorum vitae placeat aut sed beatae numquam voluptatem.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(423, 1, 'Nike Eius.', '-', '-', '-', 2151660, 2318189, 22, 'Voluptates quo esse sunt quia deleniti tempore veritatis eveniet. Porro aut maxime non asperiores et quia. Quasi omnis nobis suscipit velit nesciunt.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(424, 5, 'Mills Inventore.', '-', '-', '-', 4658486, 2187635, 7, 'Illo eveniet commodi quae aliquid perspiciatis. Nihil tempore similique et consectetur. Sit laudantium eum veritatis molestiae et. Maiores sapiente aut qui et voluptatum nemo consequatur.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(425, 4, 'Converse Accusamus.', '-', '-', '-', 4372656, 3137035, 13, 'Itaque nihil ut enim rerum pariatur. Amet cupiditate eum doloribus qui non. Quo ipsum suscipit enim ipsum.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(426, 2, 'Adidas Nulla.', '-', '-', '-', 4645638, 2680440, 24, 'Quia ut quisquam officia dolore fugiat molestiae. Voluptatem rerum earum veritatis a et. Nostrum neque eum quia cumque.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(427, 4, 'Converse Sunt earum.', '-', '-', '-', 2182938, 4178582, 11, 'Quae magnam qui laudantium saepe at nostrum qui dicta. Nemo veniam aut itaque modi doloremque. Ad beatae ipsam exercitationem est quam sequi quo. A quia provident nulla molestiae.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(428, 4, 'Converse Voluptatibus.', '-', '-', '-', 4706587, 1536350, 16, 'Culpa sit qui et incidunt autem in occaecati. Minima qui delectus ut fuga reiciendis officia deleniti. Dicta mollitia molestiae asperiores tenetur velit.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(429, 1, 'Nike Ratione.', '-', '-', '-', 3207589, 3540163, 8, 'Architecto fugiat libero maiores sit consequuntur delectus. Soluta blanditiis placeat ullam similique. Aut nam nesciunt consequuntur est eos. Libero est in sit sed dolorem.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(430, 5, 'Mills Suscipit.', '-', '-', '-', 2459149, 4066336, 14, 'Sit totam enim enim alias accusamus. Molestiae adipisci quo atque molestiae asperiores ut. Fugit dolores qui voluptatem error recusandae consequuntur.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(431, 2, 'Adidas Consequatur hic.', '-', '-', '-', 1519134, 3143790, 14, 'Saepe qui nisi aliquid ut quidem aut. Nisi dolores aliquam sit sed consequuntur et. Eaque quas quaerat nostrum ut.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(432, 2, 'Adidas Debitis voluptatem.', '-', '-', '-', 4690120, 1685983, 16, 'Dolorem natus aut et. Error architecto dignissimos quidem dolores at autem. Non at aut aut animi qui.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(433, 2, 'Adidas Eum.', '-', '-', '-', 1615526, 4966317, 20, 'Nisi nesciunt et eos autem aut saepe. Voluptate et et eum error. Aut eius laborum molestiae nemo ea accusantium tenetur. Qui consectetur quibusdam amet magni ea aut reprehenderit.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(434, 5, 'Mills Dicta.', '-', '-', '-', 1518448, 3049859, 27, 'Blanditiis minus minus aspernatur placeat sint facere. Quo commodi aperiam saepe saepe voluptatum. Dolore qui enim quae iure velit dolorem. Ut et iste perspiciatis eligendi optio.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(435, 5, 'Mills A cupiditate.', '-', '-', '-', 4551838, 4921850, 24, 'Maiores consequatur et fugit fugiat. Quis dolorem cum aspernatur at voluptates aut. Et eaque et et molestiae est.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(436, 1, 'Nike Saepe est.', '-', '-', '-', 2097686, 3850858, 12, 'Similique aut provident molestiae iure beatae laudantium ut. Quas fugiat ex molestiae neque. Itaque et et eaque dolore. Inventore iusto voluptatem enim cumque et illum.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(437, 4, 'Converse Alias.', '-', '-', '-', 2468600, 2511833, 23, 'Commodi sed sit veniam tempore. Et eum ut ipsa qui sit quia molestiae provident. Dignissimos adipisci et quibusdam. Id sunt deserunt neque officiis culpa est et.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(438, 3, 'Ortuseight Ea ipsam.', '-', '-', '-', 2103757, 4891912, 30, 'Ipsa dicta optio quia sit minus nam ab. Consequuntur aperiam itaque veniam omnis delectus exercitationem error. Expedita et error dolores sunt inventore. Laudantium molestias consequatur vero consequatur quis nihil quis natus.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(439, 1, 'Nike Quo architecto.', '-', '-', '-', 2627614, 3564312, 14, 'Molestiae exercitationem quas at accusantium. Quia aperiam voluptas ut ratione aut laboriosam dignissimos. Facilis dolorum architecto officia et. Officiis quidem nemo illum ullam.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(440, 3, 'Ortuseight Voluptatem quis.', '-', '-', '-', 4819242, 1813897, 9, 'Distinctio voluptate voluptas ipsum nesciunt perspiciatis. Omnis quis sit occaecati. Reprehenderit ullam quae temporibus perferendis ipsum doloribus. Voluptatibus nulla pariatur animi beatae sed id consequatur.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(441, 2, 'Adidas Voluptatum.', '-', '-', '-', 3865021, 1552179, 6, 'Est enim corrupti dolorum non in aut. Vel nostrum velit perspiciatis maiores. Id autem quod aut. Asperiores in quis quae animi expedita nemo.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(442, 2, 'Adidas Beatae.', '-', '-', '-', 4469577, 4032112, 30, 'Necessitatibus eos quidem eligendi est officia eum sint ut. Non aut omnis atque eaque non illum fugit. Qui in est dolorem. Ullam perspiciatis expedita facilis numquam.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(443, 4, 'Converse Ut et.', '-', '-', '-', 4741752, 4284193, 23, 'Voluptatibus illum quam quibusdam occaecati iste. Quia odit maxime beatae nisi reiciendis dolorem magni.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(444, 5, 'Mills Maxime voluptatem.', '-', '-', '-', 4190519, 4517969, 22, 'Ad hic sed ut blanditiis quia et porro. Asperiores provident provident neque. Est harum in quia sapiente eaque sed. Cum reprehenderit ab non quas.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(445, 5, 'Mills Assumenda vero.', '-', '-', '-', 3192676, 4545296, 10, 'Odit suscipit blanditiis sit asperiores rem rerum. Et vitae saepe porro laboriosam minima. Quia pariatur et id ab.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(446, 1, 'Nike Est.', '-', '-', '-', 4826271, 2547442, 27, 'Minima ullam earum sequi. Et perferendis ducimus assumenda rerum animi esse. Eum iusto maxime nulla rem. Qui saepe perspiciatis alias doloremque.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(447, 4, 'Converse Corrupti hic.', '-', '-', '-', 3456348, 4452299, 7, 'Sapiente est laboriosam eos. Voluptas asperiores quasi nihil incidunt at omnis omnis. Perspiciatis et omnis laudantium reprehenderit.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(448, 1, 'Nike Qui.', '-', '-', '-', 4817050, 3945071, 27, 'Blanditiis provident ab illo ut asperiores. Laudantium et porro voluptatem quia eos autem. Incidunt ut voluptas sunt in.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(449, 4, 'Converse Id totam.', '-', '-', '-', 3493315, 4419182, 18, 'Amet doloribus est eum. Doloremque accusamus labore est quaerat. Deserunt ad et aut laborum corporis.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(450, 5, 'Mills Commodi.', '-', '-', '-', 2980873, 1848523, 27, 'Voluptatem vitae ipsam porro quidem. Ut eum ratione at aut eaque. Quaerat optio iusto ipsa delectus sunt libero vel. Autem rem nihil odio. Cumque praesentium voluptatem illum asperiores vero voluptatibus.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(451, 2, 'Adidas Aut.', '-', '-', '-', 1568497, 3493138, 6, 'Doloremque itaque excepturi molestiae pariatur. Deleniti voluptates itaque sequi tempore voluptates.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(452, 5, 'Mills Similique.', '-', '-', '-', 2170268, 3484938, 15, 'Earum veritatis ut voluptas nobis et eveniet voluptates. Aut facere amet natus odio tempore ipsam. Rerum reiciendis officiis temporibus tenetur amet enim.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(453, 3, 'Ortuseight Corporis.', '-', '-', '-', 1696085, 4265690, 18, 'Et mollitia tenetur omnis totam. Ullam quis sed maiores ut pariatur et.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(454, 1, 'Nike Quia.', '-', '-', '-', 3935955, 3900658, 19, 'Consequatur rerum sint omnis est. Veniam facilis et incidunt laborum aliquid. Est veritatis ut cupiditate praesentium.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(455, 2, 'Adidas Voluptatum fuga.', '-', '-', '-', 3229088, 2487022, 13, 'Voluptatem molestiae placeat eveniet nobis dolorum. Dolorem dicta placeat repudiandae sunt. Ullam qui hic ut qui dolores delectus.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(456, 2, 'Adidas Sunt perferendis.', '-', '-', '-', 4657740, 2633810, 6, 'Odit facere repellat aliquam ut accusamus sed aperiam. Sint velit laboriosam blanditiis consequatur modi est. Quisquam vero odio dolore sit laborum.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(457, 1, 'Nike Nihil.', '-', '-', '-', 4788570, 1834255, 21, 'Nostrum ea dolorem vel necessitatibus facere nulla exercitationem. Sint omnis quo sit iusto eaque sit. Ullam repellat odit explicabo laudantium perferendis sit.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(458, 1, 'Nike Enim.', '-', '-', '-', 4453244, 4487493, 20, 'Atque eos nam debitis dignissimos dolores aperiam quidem. Adipisci eos in quia aut corrupti voluptatem quis magni. Modi provident dolore quo rerum aspernatur quidem eos rerum. Facere dolores aut consequatur aspernatur aut minima.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(459, 1, 'Nike Vel.', '-', '-', '-', 3311403, 1715947, 30, 'Rerum et delectus suscipit quas repudiandae et illo. Eveniet qui doloribus alias numquam ut. Ducimus incidunt numquam velit sunt ratione.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(460, 3, 'Ortuseight Culpa et.', '-', '-', '-', 3577028, 2035550, 11, 'Mollitia placeat accusamus velit aut. Consequatur mollitia consectetur molestiae quasi tempora commodi maxime. Quae nostrum consequatur nobis velit itaque. Quis aut neque cupiditate nam minus qui dolor.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(461, 4, 'Converse Dolorem.', '-', '-', '-', 3946417, 3768963, 15, 'Consectetur doloremque veritatis ducimus qui eaque. Alias nihil ab voluptatum ipsam. Veniam doloremque magnam est qui qui. Tempore atque enim in asperiores voluptatibus doloremque tempore.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(462, 2, 'Adidas Quo et.', '-', '-', '-', 4000170, 2616718, 6, 'Eius aliquid aut blanditiis qui. Enim culpa accusamus accusamus ipsam aut suscipit et. Molestiae sed in quos accusamus et et vel. Quod reprehenderit iste odio velit est.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(463, 1, 'Nike Eius placeat.', '-', '-', '-', 3075405, 2951830, 18, 'Totam animi aut deleniti porro ut. Et laboriosam et eum praesentium atque voluptas nam quas. Voluptas saepe aspernatur expedita aperiam qui. Eaque corporis explicabo et quod ad exercitationem.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(464, 2, 'Adidas Ipsa.', '-', '-', '-', 1930597, 3911760, 7, 'Adipisci autem ea dicta velit. Libero dolor minus voluptatibus dolorum sed. Accusamus aspernatur iusto facere quos. Occaecati quod qui temporibus minima animi ea occaecati.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(465, 1, 'Nike Provident.', '-', '-', '-', 3171584, 2659212, 28, 'Dolorem et illo provident quam sed. Corrupti velit ex minus quia laborum. Nesciunt optio ex tenetur eum magnam.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(466, 2, 'Adidas Quae.', '-', '-', '-', 4377260, 3160960, 18, 'Sit eos quam autem ipsum ullam officia ut. Vitae et consequatur dolorum est repellendus voluptas laudantium. Quas dolores quis ut.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(467, 1, 'Nike Labore.', '-', '-', '-', 4344421, 4140176, 10, 'Dolores ut aut corporis veritatis quis assumenda. Voluptas quisquam animi animi. Eos qui officia velit dolores laudantium. Adipisci quaerat maxime amet in.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(468, 2, 'Adidas Repellat nihil.', '-', '-', '-', 4536149, 1518710, 25, 'Nemo velit id quos. Amet aut voluptatem ut tempora voluptate vel ut. Qui aliquam perspiciatis autem corporis eveniet harum ducimus non.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(469, 2, 'Adidas Ullam nam.', '-', '-', '-', 4054771, 2626168, 26, 'Quidem ducimus ea nihil ipsam placeat. Quas unde corporis facere consequatur. Cum provident iure consectetur pariatur.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(470, 1, 'Nike Corporis nostrum.', '-', '-', '-', 2289736, 4455563, 5, 'Occaecati dignissimos soluta laborum quae nihil. Iusto unde et quidem explicabo repellendus sit. Totam est magni veritatis ut.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(471, 2, 'Adidas A cum.', '-', '-', '-', 2692051, 4416080, 12, 'Aliquid qui nihil deserunt corrupti. Et nulla maiores sed fugiat. Ipsum fuga excepturi veniam pariatur dolores. Sed aut in ducimus dolore aut molestias est.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(472, 2, 'Adidas Esse.', '-', '-', '-', 2048263, 3986694, 25, 'Quas iste sequi est est. Non autem ex dolores ullam. Eos et sapiente dolores suscipit delectus voluptatum. Totam ipsam odit explicabo blanditiis.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(473, 3, 'Ortuseight Ea sed.', '-', '-', '-', 4845956, 1964751, 30, 'Dolorum debitis beatae iusto magnam. Quae voluptates nulla quos voluptatum odio sed dolores.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(474, 3, 'Ortuseight Omnis tempore.', '-', '-', '-', 2647456, 4497245, 20, 'Et ut consectetur quidem sed sed non. Laboriosam qui reprehenderit aut eum. Inventore et voluptas vel quasi et. Et velit eveniet nisi maxime aut tenetur architecto. Blanditiis ea sequi quasi ipsa nihil sed.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(475, 3, 'Ortuseight Amet doloremque.', '-', '-', '-', 3912619, 3250484, 20, 'Ut sit est eum inventore corrupti. Earum omnis et quia et maiores. Cupiditate eum et et quia veritatis. Maxime et itaque quasi et enim dolore saepe illo.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(476, 3, 'Ortuseight Nihil aspernatur.', '-', '-', '-', 4578366, 1641202, 21, 'Aspernatur quis natus necessitatibus pariatur. Vitae adipisci a veniam et inventore soluta non velit. Ipsam et expedita iure similique fugiat.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(477, 2, 'Adidas Quis temporibus.', '-', '-', '-', 2421356, 2838337, 11, 'Recusandae similique eius expedita ut adipisci. Ea sunt at non molestiae asperiores. Suscipit dolorem voluptate officia dolorem dolore minima.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(478, 2, 'Adidas Ullam.', '-', '-', '-', 2564119, 4110579, 5, 'Sed doloribus assumenda recusandae odio repudiandae voluptatem neque aspernatur. Adipisci aut odio minus sed aut. Maiores rem eius et rerum aliquam beatae sapiente. Porro est dolorem neque quia at voluptate eos debitis.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(479, 1, 'Nike Totam sunt.', '-', '-', '-', 4910340, 1533273, 14, 'Aut quidem eligendi provident quod eum ut. Recusandae odio nihil minima. Similique libero nemo sed consectetur et sit voluptatem maxime. Vero non perferendis qui tempore et consequuntur.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(480, 5, 'Mills Sapiente.', '-', '-', '-', 4140624, 3029997, 13, 'Quibusdam neque enim omnis repellendus est dolores. Non sint in qui architecto voluptas beatae. Magni et pariatur provident possimus.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(481, 2, 'Adidas Iste optio.', '-', '-', '-', 1839556, 3269418, 10, 'Tempora facilis incidunt ab perspiciatis. Qui sed placeat odit modi dolores ea illo. Vel est et laboriosam nam porro. Veniam asperiores saepe voluptas perspiciatis suscipit.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(482, 4, 'Converse Dolorum.', '-', '-', '-', 4485306, 3675421, 11, 'Quam reprehenderit vel voluptatibus consequatur. Officia non voluptates quo possimus rerum non sit nulla. Assumenda eaque eius at hic non cumque autem. Velit vitae adipisci ipsum impedit dicta ut voluptas.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(483, 1, 'Nike Veniam.', '-', '-', '-', 2163741, 3700355, 27, 'Quae aut in assumenda id. Esse laborum natus magni molestiae.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(484, 1, 'Nike Et.', '-', '-', '-', 3146563, 1725759, 18, 'Eum quae corrupti optio quia. Ut nam provident mollitia quo neque atque unde. Culpa dolorum officia ut aliquam itaque consequatur sunt. Ad voluptatem quo sint ut harum. Voluptas tempora aut maxime fugit sunt.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(485, 4, 'Converse Velit.', '-', '-', '-', 2357186, 2417676, 26, 'Qui officiis qui repudiandae aliquid qui. Debitis autem quo non laborum omnis molestiae eligendi dolore. Sed sit nemo qui aliquid vero. Dolor hic eligendi rem corporis.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(486, 2, 'Adidas Ut.', '-', '-', '-', 2136702, 1557144, 12, 'Veniam ipsa asperiores et veniam rerum. Deserunt voluptatem quia dolorem inventore. Eaque omnis enim expedita a ut asperiores ipsum.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(487, 1, 'Nike Sint.', '-', '-', '-', 3256895, 3414650, 9, 'Id distinctio sit voluptate deleniti distinctio. Est aperiam dolor quo esse est nihil. Ut suscipit dolor eaque.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(488, 2, 'Adidas Soluta.', '-', '-', '-', 1840680, 3474099, 27, 'Et et beatae aut ipsum sed. Qui odit a nemo repudiandae et sapiente modi provident. Ipsam magni placeat corrupti sed dolores est.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(489, 1, 'Nike Nihil.', '-', '-', '-', 4825635, 1578588, 11, 'Ut ex culpa qui ut animi enim. Amet consequuntur accusamus fugiat eligendi. Maxime quasi et quam voluptatem maiores.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(490, 3, 'Ortuseight Ex.', '-', '-', '-', 4094945, 3311504, 24, 'Delectus accusamus molestiae corrupti mollitia eveniet est. Veniam et facilis rerum est. Error non distinctio quam officia exercitationem rerum ab. Omnis unde veritatis culpa.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(491, 5, 'Mills Eveniet et.', '-', '-', '-', 4149212, 4827840, 27, 'Neque quia explicabo iure sed sed sed ducimus. Est cum consequatur ut. Impedit et earum tempore et. Et voluptatem ad enim quas autem.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(492, 5, 'Mills Delectus porro.', '-', '-', '-', 3994374, 4270765, 27, 'Eos ipsam et ipsum. Deleniti explicabo nihil facere quod. Velit consequuntur praesentium quos molestiae sit est dolorum. Minima quos aut aut quis. Et fugiat blanditiis neque debitis et fuga alias nemo.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(493, 3, 'Ortuseight Eos.', '-', '-', '-', 4594800, 4308572, 8, 'Est quam iusto et velit esse fuga. Voluptatum qui modi ratione quis rerum. Consequatur earum dolore sint provident debitis nulla. Suscipit consectetur qui illum officia voluptates debitis temporibus nisi.', 41, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(494, 3, 'Ortuseight Recusandae.', '-', '-', '-', 4672131, 2991034, 27, 'Perspiciatis et sequi dolore quia fugit sed. Quaerat amet distinctio dolor dignissimos consequuntur odit voluptates sunt. Qui porro omnis ab aut ut asperiores dolores quasi. Beatae consequatur exercitationem ab nihil qui. Voluptas eaque est magni placeat sed sed.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(495, 3, 'Ortuseight Est ipsam.', '-', '-', '-', 2981624, 1742039, 18, 'Quaerat nostrum quod facilis similique ut. Eos quo qui quia qui ex. Qui mollitia aliquam assumenda quia aspernatur quia ea.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(496, 2, 'Adidas Asperiores pariatur.', '-', '-', '-', 3404052, 2968407, 11, 'Quo qui veritatis impedit dolorum occaecati a accusamus. Est maxime id deserunt culpa. Quas placeat maxime earum et quaerat in.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(497, 3, 'Ortuseight Quis.', '-', '-', '-', 1750416, 3762524, 21, 'Fugit excepturi cupiditate asperiores vero ad minus hic laborum. Aliquam aut qui vel sed vitae.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(498, 3, 'Ortuseight Sunt repudiandae.', '-', '-', '-', 4213216, 4482286, 25, 'Quia harum sit perferendis earum rerum amet rerum. Et at aut autem alias vel. Deserunt nihil omnis magnam sequi id magnam. Tempore sequi rerum quae ipsum.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(499, 3, 'Ortuseight Voluptatibus ipsam.', '-', '-', '-', 3567428, 2350949, 14, 'Iste magni quo omnis est. Aliquid pariatur cupiditate ab eos rerum corrupti.', 42, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(500, 2, 'Adidas Minus.', '-', '-', '-', 2140082, 1940540, 11, 'Quasi provident iusto dicta tempore non. Consectetur dignissimos quia omnis modi est itaque blanditiis beatae.', 44, '2024-07-15 01:31:38', '2024-07-15 01:31:38');

--
-- Triggers `shoes`
--
DELIMITER $$
CREATE TRIGGER `before_update_shoes` BEFORE UPDATE ON `shoes` FOR EACH ROW BEGIN
  IF NEW.sale_cost < OLD.sale_cost THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'harga lebih kecil dari harga asli, silahkan ganti!!';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `shoes_with_category`
-- (See below for the actual view)
--
CREATE TABLE `shoes_with_category` (
`category_name` varchar(255)
,`id_shoes` bigint unsigned
,`sale_cost` int
,`shoe_name` varchar(255)
,`stock` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `shoes_with_category_check_view`
-- (See below for the actual view)
--
CREATE TABLE `shoes_with_category_check_view` (
`category_name` varchar(255)
,`id_shoes` bigint unsigned
,`shoe_name` varchar(255)
,`stock` int
);

-- --------------------------------------------------------

--
-- Table structure for table `specifications`
--

CREATE TABLE `specifications` (
  `id_specification` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_shoes` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `specifications`
--

INSERT INTO `specifications` (`id_specification`, `name`, `id_shoes`, `created_at`, `updated_at`) VALUES
(1, 'Veritatis quo blanditiis laboriosam aut. Fuga molestias voluptatem labore. Iusto voluptatibus quaerat tenetur ea quaerat quae qui. Voluptas saepe rerum alias reiciendis placeat.', 317, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(2, 'Nulla odit esse et perferendis autem cumque iste. Autem sit beatae autem maiores eos quis ipsam. Dicta totam culpa vel. Harum deserunt aut vel vero velit nihil.', 131, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(3, 'Doloremque aut quam animi provident quaerat provident numquam quos. Magnam et architecto aut quia. Nihil quia cupiditate aut quo beatae error quia repudiandae.', 88, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(4, 'Aperiam omnis vitae non non. Vel iure repudiandae ad reiciendis iusto ea. Qui dicta quaerat voluptatem. Ut occaecati eos quia ut sint.', 209, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(5, 'Qui odio voluptates sint porro libero qui. Ipsam enim quos et ex. Velit non enim et quia non ex aut.', 249, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(6, 'Facere ut et quo minus nam sed doloribus. Nihil repellat voluptatum omnis consequatur accusamus qui omnis. Quia officia velit ad in.', 294, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(7, 'Consequatur sint commodi nemo et aliquam nihil nam sunt. Eius et dolores adipisci ab et. Fuga voluptatibus non velit libero sapiente tempore sint. Cumque quia animi qui et.', 43, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(8, 'Suscipit totam ducimus eum nihil non debitis enim. Qui et quisquam ducimus iure rerum. Sit reprehenderit provident illo occaecati et omnis.', 57, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(9, 'Officiis quaerat aut dolore autem ut quas. Maiores corporis quisquam quo consectetur ut voluptatem. Voluptatibus perferendis assumenda libero.', 377, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(10, 'Et reprehenderit dignissimos tempora dolor. Magnam praesentium blanditiis deleniti qui optio in officiis. Voluptatem et animi temporibus. Quod et a aut ea consectetur nihil.', 456, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(11, 'Nesciunt voluptatum laboriosam sint quia rem beatae doloribus. Tempora dolorem accusantium inventore. Et numquam eos id.', 52, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(12, 'Perferendis consequatur saepe recusandae iste fuga soluta. Dolores velit et fuga aut. Necessitatibus voluptatum excepturi veritatis minima.', 169, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(13, 'In mollitia deleniti porro nobis quae qui et. Provident eum occaecati voluptate. Fuga hic rerum voluptatem.', 245, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(14, 'Non est quia error consequatur. Sequi expedita quia sit consequatur. Illo aut quaerat consequatur dolorem explicabo tenetur qui.', 185, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(15, 'Porro consequatur a maxime saepe autem vel rem aperiam. Dolores est corrupti reprehenderit.', 137, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(16, 'Voluptate reprehenderit libero et incidunt. Similique quisquam similique sit tenetur aut quisquam facilis. Voluptate facilis impedit enim neque placeat ipsa aliquid.', 119, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(17, 'Voluptatem autem animi velit exercitationem ut voluptatem. Sunt dignissimos laudantium beatae et vel ut. Omnis deserunt impedit dignissimos et ducimus. Delectus temporibus asperiores est officiis.', 299, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(18, 'Nihil corrupti repudiandae blanditiis qui. Velit libero exercitationem quidem molestiae culpa. Autem facilis adipisci incidunt quibusdam asperiores velit sit quaerat.', 451, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(19, 'Sed illo quia ea modi. Aut fugiat facere labore odit. Et magnam et quos officiis qui dolorum tenetur. Qui delectus sed illum et voluptatum quibusdam.', 200, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(20, 'Deserunt vel et aut et. Molestiae deleniti omnis et neque. Quibusdam quas reiciendis voluptas.', 361, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(21, 'Dolorem itaque sunt ea. Repellendus sed explicabo itaque laborum dolorem incidunt iste ratione. Laboriosam rerum sed commodi voluptatem illum voluptas.', 368, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(22, 'Rerum et qui reprehenderit velit. Consequatur corrupti rerum voluptatem tempore est iste.', 89, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(23, 'Deserunt voluptatibus consequatur et itaque dolor dolorem. Corporis officiis et eveniet perspiciatis aut saepe. Quas enim magnam qui et reiciendis vel et nam. Ullam nam animi reiciendis quo doloremque nobis fuga. Nesciunt facilis quidem alias delectus quis dolores.', 112, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(24, 'Nam dolorum distinctio laudantium quos itaque. Dignissimos commodi rerum fuga repellat. Veniam sit voluptatibus quia fugit enim nemo. Vel porro voluptas sit error quas rerum error.', 398, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(25, 'Id molestiae dolore beatae illo ipsam voluptatibus nihil itaque. Omnis nihil sint est ea aut dicta et. Optio doloribus odit officia ea.', 299, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(26, 'Tenetur porro molestias magnam nostrum et omnis provident. Accusantium impedit tenetur quidem debitis ab. Impedit occaecati illo praesentium distinctio dolor et non.', 170, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(27, 'Aut voluptatem voluptas at. Ratione rerum maxime explicabo iusto dolor. Est culpa facilis occaecati veritatis qui. Consequatur quis exercitationem nihil neque.', 68, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(28, 'Dolores minus illum quaerat porro. Maxime commodi at vel. Expedita iusto quia aut molestias. Eum odio perferendis est assumenda.', 201, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(29, 'Consequatur natus voluptates quibusdam voluptatibus est. Consequatur voluptas non dolores libero. Ad ut saepe distinctio qui fugiat voluptas.', 496, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(30, 'Consequuntur a est est tempore consectetur voluptas. Nihil magni ipsa voluptas voluptas sit quo. Voluptatem aperiam sit excepturi id.', 322, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(31, 'Et non sunt dolorum consequatur unde sit. Voluptatum distinctio dolor sit dolores. Aut sit voluptas dolorem.', 384, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(32, 'Accusantium reprehenderit quod magnam quia labore. Magnam voluptas dolorem dolores ut quidem soluta. Rerum distinctio ut laboriosam.', 193, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(33, 'In et earum ullam enim eum aliquam labore. Sunt non non ut nam libero qui sit. Laboriosam mollitia libero quis rerum vitae ducimus qui.', 122, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(34, 'Illum sit magni eveniet molestiae iste voluptatem. Alias quas voluptatem error sit accusantium rem. Facilis fugiat omnis et aliquam modi omnis.', 297, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(35, 'Et non quo reprehenderit doloremque et sed possimus. Delectus earum earum porro. Quis voluptate doloribus commodi.', 18, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(36, 'Id omnis nemo hic occaecati qui quia. Modi et officiis enim fuga voluptatum quia. Quasi exercitationem velit excepturi explicabo qui id sit.', 116, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(37, 'Beatae eaque illo veniam qui fuga sunt. Et officiis possimus quaerat enim repellat hic.', 496, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(38, 'Voluptas esse minus quisquam illum mollitia ipsam. Et a ut sunt. Harum iusto voluptatem quidem maiores qui illo.', 51, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(39, 'Inventore mollitia repudiandae distinctio corporis ea et illum. Dolore vel a rerum asperiores. Mollitia cupiditate quidem voluptate impedit aperiam. Adipisci eos sapiente ullam rerum sequi cupiditate maxime corrupti.', 337, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(40, 'Hic quae neque nihil sint. Est magnam ut quia dicta sapiente. Eos qui rerum placeat rerum voluptas molestiae ut.', 250, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(41, 'Voluptates excepturi et praesentium qui ullam. Laboriosam fugiat harum quae consequatur repudiandae. Ut vel voluptate qui aut repellendus.', 491, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(42, 'A odio adipisci occaecati qui rerum autem facere accusamus. Repellat placeat vel inventore pariatur atque dolore odit culpa. Omnis atque et aliquam et.', 276, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(43, 'Occaecati corporis molestiae dolor qui ex earum ratione. Eaque asperiores nam quibusdam magni doloremque nostrum porro. Aperiam iste asperiores facere excepturi.', 82, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(44, 'Eos reprehenderit nemo aut fugit nulla. Rerum dolorum est aut earum sit voluptates. Dolor quia omnis et non vero. Consectetur beatae eum et nisi dolorem.', 183, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(45, 'Rerum enim ex alias incidunt quam quas laboriosam. Sit nostrum voluptate nemo at dolores sed. Pariatur cumque numquam est esse inventore nemo et.', 302, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(46, 'Quia dolores soluta nisi quis voluptas quidem. Qui repudiandae ut inventore. Omnis temporibus non ipsa qui magnam doloremque itaque. Quis optio quia quos.', 40, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(47, 'Et dolor eius et enim non molestiae omnis et. Distinctio dolorem ex et eos. Distinctio ad aliquam nisi eaque quis rerum. Similique quae repellat facilis voluptatem eos rem voluptatem reprehenderit.', 401, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(48, 'Magni est ipsa et corrupti vitae aut. Omnis voluptatum quia nesciunt nulla reprehenderit et sit. Beatae deserunt voluptatem in rerum voluptatem. Iste hic sunt ea rerum.', 103, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(49, 'Et porro ab iure aliquid. Consequatur laudantium accusamus pariatur rerum sed dicta et voluptas. Voluptatem alias et quibusdam eligendi vero accusantium voluptas. Hic totam corrupti ipsa minus.', 418, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(50, 'Neque adipisci omnis a laborum. Possimus veniam recusandae sit explicabo corrupti nostrum ut. A non distinctio quidem veniam. Quia modi omnis deserunt reiciendis blanditiis itaque id.', 355, '2024-07-15 01:31:38', '2024-07-15 01:31:38');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id_transaction` bigint UNSIGNED NOT NULL,
  `id_user` bigint UNSIGNED NOT NULL,
  `id_shoes` bigint UNSIGNED NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purchase_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gross_amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pdf_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id_transaction`, `id_user`, `id_shoes`, `status`, `purchase_amount`, `gross_amount`, `pdf_url`, `created_at`, `updated_at`) VALUES
(3, 3, 309, 'pending', '2', '8064449', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(4, 2, 88, 'rate it', '1', '9327155', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(10, 1, 453, 'Send', '5', '2118816', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(11, 2, 255, 'rate it', '5', '4553994', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(13, 1, 414, 'Success', '1', '5564414', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(15, 3, 226, 'Send', '1', '2784174', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(17, 3, 78, 'rate it', '3', '6705197', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(18, 1, 344, 'Success', '4', '9730909', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(20, 3, 245, 'Send', '5', '3570778', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(21, 3, 121, 'Send', '1', '5186667', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(23, 3, 29, 'pending', '1', '3179673', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(25, 3, 175, 'pending', '1', '9029345', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(26, 1, 359, 'Send', '4', '5222371', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(34, 3, 196, 'Success', '1', '8371783', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(37, 3, 179, 'pending', '5', '2994807', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(41, 3, 109, 'pending', '2', '9454342', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(43, 1, 25, 'pending', '4', '2328616', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(44, 3, 347, 'pending', '3', '8106449', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(45, 3, 257, 'Success', '5', '3973249', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(46, 3, 122, 'rate it', '3', '9084163', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(47, 3, 215, 'rate it', '5', '1829196', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(48, 2, 78, 'rate it', '1', '1790336', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(50, 1, 374, 'pending', '3', '5612382', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(90, 3, 260, 'pending', '4', '9237557', '-', '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(94, 3, 60, 'Success', '3', '2428102', '-', '2024-07-14 05:00:00', '2024-07-14 05:00:00');

--
-- Triggers `transactions`
--
DELIMITER $$
CREATE TRIGGER `after_insert_transactions` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
  UPDATE shoes
  SET stock = stock - NEW.purchase_amount
  WHERE id_shoes = NEW.id_shoes;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_transaction_delete` BEFORE DELETE ON `transactions` FOR EACH ROW BEGIN
    INSERT INTO log_transactions(id_transaction, id_shoes, status, purchase_amount, gross_amount, pdf_url, created_at, updated_at)
    VALUES(OLD.id_transaction, OLD.id_shoes, OLD.status, OLD.purchase_amount, OLD.gross_amount, OLD.pdf_url, OLD.created_at, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `transaction_details_status`
-- (See below for the actual view)
--
CREATE TABLE `transaction_details_status` (
`created_at` timestamp
,`gross_amount` varchar(255)
,`id_shoes` bigint unsigned
,`id_transaction` bigint unsigned
,`id_user` bigint unsigned
,`pdf_url` varchar(255)
,`purchase_amount` varchar(255)
,`status` varchar(255)
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `name`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Samuel', 'samuel@gmail.com', '$2y$12$uVmp/ZylSljhwhghUmNj7OYi09Sdi73Pdnakbk2H7c0h52k8NqPv2', 'admin', '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(2, 'Azrul', 'azrul@gmail.com', '$2y$12$zskSshV1cLQbe7lZ8i85jeYA1yTmgP13NJc6oq0VTmUK5EUfAnYcO', 'admin', '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(3, 'Abi', 'abi@gmail.com', '$2y$12$YTZ6J/gZXbMCdYfIrMJUE.rjQP42u58fwr57CnIo0b9xtwEpNBUSK', 'admin', '2024-07-15 01:31:37', '2024-07-15 01:31:37');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `after_delete_users` AFTER DELETE ON `users` FOR EACH ROW BEGIN
  DELETE FROM transactions WHERE id_user = OLD.id_user;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_users` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
  IF EXISTS (SELECT 1 FROM users WHERE email = NEW.email) 
  THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'email sudah terdaftar, silahkan gunakan email lain!';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_profiles`
--

CREATE TABLE `user_profiles` (
  `id_user_profile` bigint UNSIGNED NOT NULL,
  `id_user` bigint UNSIGNED NOT NULL,
  `addres` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_profiles`
--

INSERT INTO `user_profiles` (`id_user_profile`, `id_user`, `addres`, `phone_number`, `gender`, `created_at`, `updated_at`) VALUES
(1, 1, 'Yogyakarta', '081236126316', 'Male', '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(2, 2, 'Bogor', '012738612381', 'Male', '2024-07-15 01:31:37', '2024-07-15 01:31:37'),
(3, 3, 'Bekasi', '08127362176', 'Male', '2024-07-15 01:31:37', '2024-07-15 01:31:37');

-- --------------------------------------------------------

--
-- Stand-in structure for view `user_shoe_info`
-- (See below for the actual view)
--
CREATE TABLE `user_shoe_info` (
`email` varchar(255)
,`id_shoes` bigint unsigned
,`id_user` bigint unsigned
,`name` varchar(255)
,`role` varchar(255)
,`shoe_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id_wishlist` bigint UNSIGNED NOT NULL,
  `id_user` bigint UNSIGNED NOT NULL,
  `id_shoes` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wishlists`
--

INSERT INTO `wishlists` (`id_wishlist`, `id_user`, `id_shoes`, `created_at`, `updated_at`) VALUES
(2, 1, 297, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(3, 2, 418, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(5, 3, 213, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(6, 2, 275, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(8, 3, 286, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(11, 3, 288, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(12, 2, 277, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(13, 2, 410, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(15, 2, 436, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(16, 1, 374, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(18, 1, 300, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(19, 2, 109, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(20, 1, 270, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(21, 2, 251, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(22, 2, 405, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(23, 1, 120, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(25, 3, 205, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(26, 3, 463, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(28, 3, 410, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(30, 2, 332, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(32, 2, 242, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(33, 3, 360, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(34, 2, 91, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(36, 2, 243, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(40, 2, 476, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(41, 2, 474, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(42, 1, 35, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(47, 1, 376, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(48, 2, 11, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(49, 3, 475, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(50, 2, 5, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(52, 3, 104, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(53, 2, 446, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(54, 2, 102, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(56, 3, 31, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(57, 3, 250, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(60, 2, 213, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(61, 1, 57, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(64, 2, 416, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(67, 1, 47, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(68, 1, 204, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(72, 3, 301, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(74, 3, 36, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(75, 2, 400, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(76, 3, 445, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(78, 2, 328, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(79, 3, 261, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(80, 2, 489, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(81, 2, 285, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(82, 2, 402, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(84, 3, 154, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(85, 1, 333, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(86, 3, 346, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(87, 1, 486, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(88, 3, 191, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(90, 1, 324, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(92, 1, 435, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(96, 2, 201, '2024-07-15 01:31:38', '2024-07-15 01:31:38'),
(99, 2, 248, '2024-07-15 01:31:38', '2024-07-15 01:31:38');

-- --------------------------------------------------------

--
-- Structure for view `shoes_with_category`
--
DROP TABLE IF EXISTS `shoes_with_category`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `shoes_with_category`  AS SELECT `s`.`id_shoes` AS `id_shoes`, `s`.`shoe_name` AS `shoe_name`, `s`.`stock` AS `stock`, `s`.`sale_cost` AS `sale_cost`, `c`.`name` AS `category_name` FROM (`shoes` `s` join `categories` `c` on((`s`.`id_category` = `c`.`id_category`)))  ;

-- --------------------------------------------------------

--
-- Structure for view `shoes_with_category_check_view`
--
DROP TABLE IF EXISTS `shoes_with_category_check_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `shoes_with_category_check_view`  AS SELECT `shoes_with_category`.`id_shoes` AS `id_shoes`, `shoes_with_category`.`shoe_name` AS `shoe_name`, `shoes_with_category`.`stock` AS `stock`, `shoes_with_category`.`category_name` AS `category_name` FROM `shoes_with_category` WHERE (`shoes_with_category`.`stock` <= 5) WITH LOCAL CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `transaction_details_status`
--
DROP TABLE IF EXISTS `transaction_details_status`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `transaction_details_status`  AS SELECT `transactions`.`id_transaction` AS `id_transaction`, `transactions`.`id_user` AS `id_user`, `transactions`.`id_shoes` AS `id_shoes`, `transactions`.`status` AS `status`, `transactions`.`purchase_amount` AS `purchase_amount`, `transactions`.`gross_amount` AS `gross_amount`, `transactions`.`pdf_url` AS `pdf_url`, `transactions`.`created_at` AS `created_at`, `transactions`.`updated_at` AS `updated_at` FROM `transactions` WHERE (`transactions`.`status` = 'pending')  ;

-- --------------------------------------------------------

--
-- Structure for view `user_shoe_info`
--
DROP TABLE IF EXISTS `user_shoe_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user_shoe_info`  AS SELECT `u`.`id_user` AS `id_user`, `u`.`role` AS `role`, `u`.`name` AS `name`, `u`.`email` AS `email`, `s`.`id_shoes` AS `id_shoes`, `s`.`shoe_name` AS `shoe_name` FROM ((`users` `u` join `wishlists` `w` on((`u`.`id_user` = `w`.`id_user`))) join `shoes` `s` on((`w`.`id_shoes` = `s`.`id_shoes`)))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `before_update_category`
--
ALTER TABLE `before_update_category`
  ADD PRIMARY KEY (`id_before_update_category`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id_cart`),
  ADD KEY `carts_id_shoes_foreign` (`id_shoes`),
  ADD KEY `carts_id_user_foreign` (`id_user`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id_category`);

--
-- Indexes for table `log_transactions`
--
ALTER TABLE `log_transactions`
  ADD PRIMARY KEY (`id_log_transaction`),
  ADD KEY `idx_transaction` (`id_transaction`,`gross_amount`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id_review`),
  ADD KEY `reviews_id_user_foreign` (`id_user`),
  ADD KEY `reviews_id_transaction_foreign` (`id_transaction`),
  ADD KEY `reviews_id_shoes_foreign` (`id_shoes`);

--
-- Indexes for table `shoes`
--
ALTER TABLE `shoes`
  ADD PRIMARY KEY (`id_shoes`),
  ADD KEY `shoes_id_category_foreign` (`id_category`),
  ADD KEY `idx_shoes` (`id_shoes`,`sale_cost`);

--
-- Indexes for table `specifications`
--
ALTER TABLE `specifications`
  ADD PRIMARY KEY (`id_specification`),
  ADD KEY `specifications_id_shoes_foreign` (`id_shoes`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id_transaction`),
  ADD KEY `transactions_id_user_foreign` (`id_user`),
  ADD KEY `transactions_id_shoes_foreign` (`id_shoes`),
  ADD KEY `idx_transaction` (`id_transaction`,`status`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD PRIMARY KEY (`id_user_profile`),
  ADD KEY `user_profiles_id_user_foreign` (`id_user`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id_wishlist`),
  ADD KEY `wishlists_id_user_foreign` (`id_user`),
  ADD KEY `wishlists_id_shoes_foreign` (`id_shoes`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `before_update_category`
--
ALTER TABLE `before_update_category`
  MODIFY `id_before_update_category` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id_cart` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id_category` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `log_transactions`
--
ALTER TABLE `log_transactions`
  MODIFY `id_log_transaction` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id_review` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `shoes`
--
ALTER TABLE `shoes`
  MODIFY `id_shoes` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=501;

--
-- AUTO_INCREMENT for table `specifications`
--
ALTER TABLE `specifications`
  MODIFY `id_specification` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id_transaction` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_profiles`
--
ALTER TABLE `user_profiles`
  MODIFY `id_user_profile` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id_wishlist` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_id_shoes_foreign` FOREIGN KEY (`id_shoes`) REFERENCES `shoes` (`id_shoes`) ON DELETE CASCADE,
  ADD CONSTRAINT `carts_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_id_shoes_foreign` FOREIGN KEY (`id_shoes`) REFERENCES `shoes` (`id_shoes`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_id_transaction_foreign` FOREIGN KEY (`id_transaction`) REFERENCES `transactions` (`id_transaction`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `shoes`
--
ALTER TABLE `shoes`
  ADD CONSTRAINT `shoes_id_category_foreign` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id_category`) ON DELETE CASCADE;

--
-- Constraints for table `specifications`
--
ALTER TABLE `specifications`
  ADD CONSTRAINT `specifications_id_shoes_foreign` FOREIGN KEY (`id_shoes`) REFERENCES `shoes` (`id_shoes`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_id_shoes_foreign` FOREIGN KEY (`id_shoes`) REFERENCES `shoes` (`id_shoes`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `user_profiles`
--
ALTER TABLE `user_profiles`
  ADD CONSTRAINT `user_profiles_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `wishlists_id_shoes_foreign` FOREIGN KEY (`id_shoes`) REFERENCES `shoes` (`id_shoes`) ON DELETE CASCADE,
  ADD CONSTRAINT `wishlists_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
