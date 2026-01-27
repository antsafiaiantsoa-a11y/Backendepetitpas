-- phpMyAdmin SQL Dump
-- version 4.0.2
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Mar 27 Janvier 2026 à 16:50
-- Version du serveur: 5.6.11-log
-- Version de PHP: 5.3.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `epetitpas`
--
CREATE DATABASE IF NOT EXISTS `epetitpas` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `epetitpas`;

-- --------------------------------------------------------

--
-- Structure de la table `formations`
--

CREATE TABLE IF NOT EXISTS `formations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `duree` varchar(50) DEFAULT NULL,
  `note` decimal(2,1) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `formations`
--

INSERT INTO `formations` (`id`, `titre`, `description`, `type`, `duree`, `note`, `image`, `slug`) VALUES
(1, 'Anglais professionnel, bureautique & IA', 'Compétences linguistiques et numériques', 'Distanciel', '187h', '5.0', 'aprendre.jpg', 'anglais-ia'),
(2, 'Développeur Web & Web Mobile', 'Titre RNCP – Front & Back-end', 'Diplômant', '7–10 mois', '5.0', 'dww.jpg', 'dwwm'),
(3, 'Bureautique professionnelle', 'Word, Excel, PowerPoint', 'Distanciel', '120h', '4.9', 'bp.jpg', 'bureautique'),
(4, 'Cybersécurité & Réseaux', 'Protection des systèmes informatiques', 'Certifiant', '6 mois', '5.0', 'cr.jpg', 'cybersecurite'),
(5, 'Web Design & UI/UX', 'Interfaces modernes et intuitives', 'Créatif', '3 mois', '4.8', 'ux.jpg', 'uiux'),
(6, 'Gestion de projet digital', 'Agile, Scrum & outils collaboratifs', 'Management', '4 mois', '4.9', 'gd.jpg', 'gestion-projet'),
(7, 'Marketing digital', 'SEO & réseaux sociaux', 'Business', '2 mois', '4.7', 'Md.jpg', 'marketing'),
(8, 'Data & Intelligence Artificielle', 'Bases de la data et de l’IA', 'Data', '3 mois', '5.0', 'ia.jpg', 'data-ia');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `accepted_terms` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password_hash`, `accepted_terms`, `created_at`) VALUES
(1, 'Antsa ', 'antsa@example.com', 'test123', 1, '2026-01-21 10:21:39'),
(2, 'Antsa', 'antsa@gmail.com', '$2b$10$I5xCbK3JJHkK3gnNVuox4u4MBb39f4a2.44VXhE.NmIEvPyV9YNYq', 1, '2026-01-21 12:42:36'),
(3, 'Ayo', 'ayo@gamail.com', '$2b$10$QXPnMuL3I2llxiToSR42uuLrr0Cfm.gD8rYFVpiUV4dKNBHZWqOIa', 1, '2026-01-21 12:52:00'),
(4, 'Ezamy', 'ezamy@gmail.com', '$2b$10$Pr5XSXBOpKjL.ta.QjpQqusifNQHoaNGGuf0osc8o55FjAXoeVpQa', 1, '2026-01-21 16:24:22'),
(5, 'Aina', 'antsafiaiantsoa@gmail.com', '$2b$10$3EwSLoHXHYT1JjotXt/CdezV134TTRm8gUFFw.ZHhqQ/Eew01uCrC', 1, '2026-01-27 12:31:49');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
