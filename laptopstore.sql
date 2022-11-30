create schema laptop_store;

--
-- Cấu trúc bảng cho bảng `account`
--
CREATE TABLE `users` (
  `id` int auto_increment,
  `username` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `full_name` varchar(250),
  `address` varchar(250),
  `email` varchar(250),
  `phone` varchar(250),
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


create table `orders`(
	`id` int NOT NULL AUTO_INCREMENT,
    `product_id` int,
    `user_id` int,
    `quantity` int,
    `order_date` varchar(200),
    primary key (id)
);

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `products` (
  `id` int NOT NULL auto_increment,
  `name` varchar(250) NOT NULL,
  `price` double,
  `description` varchar(250),
  `details` varchar(250),
  `status` int,
  `category` varchar(250),
  `image` mediumblob,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `category` (
  `id` int NOT NULL auto_increment,
  `name` varchar(250) NOT NULL,
  primary key (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert into users (`username`, `password`) value('admin', '123');
