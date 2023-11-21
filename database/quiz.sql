-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2023 at 03:53 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `player_id` int(11) NOT NULL,
  `first` varchar(255) NOT NULL,
  `last` varchar(255) NOT NULL,
  `code` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`player_id`, `first`, `last`, `code`) VALUES
(1, 'test', 'tester', 'G023NY'),
(2, 'test1', 'tester2', '0515C6'),
(3, 'test2', 'tester3', '15B318'),
(4, 'test4', 'tester4', '1K5EKU'),
(5, 'test5', 'tester5', '25SG7Z'),
(6, 'player1', 'player1', 'K8NHDB'),
(7, 'player2', 'player2', '18K63R'),
(8, 'player3', 'player3', '5UM9KA'),
(9, 'player5', 'player5', '35FA35'),
(10, 'player6', 'player6', 'E361JQ');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `a` varchar(255) NOT NULL,
  `b` varchar(255) NOT NULL,
  `c` varchar(255) NOT NULL,
  `d` varchar(255) NOT NULL,
  `answer` varchar(15) NOT NULL,
  `category` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `content`, `a`, `b`, `c`, `d`, `answer`, `category`) VALUES
(1, 'Qui est le fondateur de la ville de Rabat ? ', 'Moulay Ismaïl ', 'Abd al-Mumin ', 'Idriss Ier', 'Moulay Hassan', 'c', 'a'),
(2, 'Dans quel pays se trouve la ville de Machu Picchu ? ', 'Pérou', 'Brésil ', 'Argentine ', 'Mexique', 'a', 'a'),
(3, 'Dans quelle ville se trouve le siège de l\'Organisation des Nations Unies (ONU) ? ', 'Genève ', 'New York ', 'Paris ', 'Londres ', 'b', 'a'),
(4, 'Quelle est la plus grande ville des États-Unis d\'Amérique ? ', 'Los Angeles ', 'Chicago ', 'New York ', 'Houston', 'c', 'a'),
(5, 'Combien de planètes comporte le système solaire ?', '6', '8', '10', '12', 'b', 'a'),
(6, 'Quel est l’élément naturel qui existe le plus dans l’univers ?', 'l\'hydrogène', 'l\'oxygène', 'l\'azote', 'le méthane', 'a', 'a'),
(7, 'Dans quelle université est née \"Facebook\" ?', 'Harvard', 'HEC Paris', 'MIT', 'Oxford', 'a', 'a'),
(8, 'Le Flooding est :', 'Une attaque qui sature le réseau', 'La mise en place d\'un sniffeur', 'Une faille de sécurité du sendmail', 'Une usurpation d\'adresse IP interne', 'a', 'a'),
(9, 'Java est un langage :', 'Compilé', 'Interprété', 'Compilé et interprété ', 'Ni compilé ni interprété', 'c', 'a'),
(10, 'Lequel des langages informatiques suivants est utilisé pour l’intelligence artificielle?', 'PYTHON', 'COBOL', 'FORTRAN', 'PROLOG', 'd', 'a'),
(11, ' La forme complète de OSI est:', 'Operating System interface', 'Optical System interconnection', 'Operating System Internet', 'Open system interconnection', 'd', 'a'),
(12, 'Que signifie MAC ?', 'Media Access Carriage', 'Media Access Control  ', 'Media Access Collision', 'Media Access Cable', 'b', 'a'),
(13, 'L’adresse IP de « classe A » comprend ?', '16 millions d’adresses', '65.000 adresses', '256 adresses', '254 adresses', 'a', 'a'),
(14, 'Comment appelle-t-on l’application des méthodes de Machine Learning à une grande base de données?', 'Big data', 'Data mining', 'Intelligence artificielle', 'Internet des objets', 'b', 'a'),
(15, 'Les terres ne couvrent qu\'une modeste partie de la surface de notre planète comparées à celle des mers et océans. Quel pourcentage représentent-ils ?', 'Environ 30%', 'Environ 70%', 'Environ 50%', 'Environ 5%', 'a', 'a'),
(16, 'Quel est le plus grand pays de l\'Union européenne en termes de superficie ? ', 'La France ', 'L\'Espagne ', 'L\'Allemagne ', 'La Suède', 'c', 'b'),
(17, 'Quelle célèbre équation est associée à Albert Einstein ?', 'M=EC²', 'E²=MC', 'E=MC²', 'EMC=2', 'c', 'b'),
(18, 'Quelle est la vitesse de la lumière ?', '300 km/s', '3000 km/s', '30.000 km/s.', '300 000 km/s', 'd', 'b'),
(19, 'Comment se nomme un angle compris entre 90° et 180° ?', 'Un angle droit', 'Un angle aigü', 'Un angle obtus', 'un angle gauche', 'c', 'b'),
(20, 'Quelle est l\'unité de mesure de l\'énergie ?', 'Kilo', 'Watt', 'Tonne', 'Joule', 'd', 'b'),
(21, 'Quelle est la valeur maximale que peut prendre le champs TTL ?', '128', '255', '256', 'Une valeur infinie', 'b', 'b'),
(22, ' Le client DNS s’appelle ?', 'DNS updater', 'DNS resolver', 'DNS handler', 'Aucune de ces réponses n’est vraie.', 'b', 'b'),
(23, 'Quel code de réponse HTTP 1.0 est faux ?', '200 : la requête s’est déroulée correctement', '400 : erreur de syntaxe dans la requête envoyé par le client', '500 : requête acceptée, traitement en cours', '404 : la ressource demandée n’existe pas', 'c', 'b'),
(24, 'Lequel de ces langages n’est pas couramment utilisé pour l’IA ?', 'PROLOG', 'LISP', 'Python', 'Perl', 'd', 'b'),
(25, 'Lequel des éléments suivants n’est pas un package d’application?', 'Open Office', 'Adobe Pagemaker', 'Red Hat Linux', 'Microsoft Office', 'c', 'b'),
(26, 'Dans Liunx, le mot de passe crypté d’un utilisateur est stocké dans ?', '/etc/shadow ', '/etc/enpasswwd', '/etc/.passwd', '/etc/passwd', 'a', 'b'),
(27, 'Le Machine Learning est un sous-ensemble de:', 'Big data', 'Data mining', 'Deep Learning', 'Intelligence artificielle', 'd', 'b'),
(28, 'Qui a créé la première carte géographique de l\'Europe ? ', 'Les Romains ', 'Les Grecs ', 'Les Vikings ', 'Les Celtes', 'b', 'b'),
(29, 'La discipline créée par Sigmund Freud est :', 'La sociologie', 'La psychanalyse', 'La psychologie', 'L\'épidemiologie', 'c', 'b'),
(30, 'Spring est un framework ?', 'gratuit', 'open source', 'sous une licence', 'propriétaire', 'b', 'b'),
(31, 'Que contiennent les globules rouges ?', ' de la chlorophylle', 'de l\'hémoglobine', 'de la bile', 'un noyau', 'b', 'c'),
(32, 'Quel est le symbole chimique de l\'Or?', 'Or', 'A', 'B', 'Au', 'd', 'c'),
(33, 'Qui a mis au point la pénicilline ?', 'Necker', 'Louis Pasteur', 'Alexander Flemming', 'Severo Ochoa', 'c', 'c'),
(34, 'Quelle est la plus grande planète dans notre système solaire ?', 'Mars', 'Pluton ', 'Jupiter', 'La Terre', 'c', 'c'),
(35, 'Les types de Big Data sont :', ' Données non structurées', 'Données structurées', 'Données semi-structurées', 'Toutes les réponses sont vraies ', 'd', 'c'),
(36, 'Qui possède le plus grand cluster Hadoop du monde?', 'Google', 'LinkedIn', 'Facebook', 'IBM', 'c', 'c'),
(37, ' Laquelle des mémoires suivantes doit être rafraîchie plusieurs fois par seconde ?', 'SRAM ', ' DRAM ', 'EPROM', 'ROM', 'b', 'c'),
(38, 'Quels sont les V du Big Data ?', 'Véracité, Visualisation, et Valeur', 'Variété, variabilité', 'Volume, vélocité', 'Toutes les réponses sont vraies', 'd', 'c'),
(39, 'Lequel des éléments suivants peut être identifié en tant que Cloud ?', 'Applications Web', 'Intranet', 'Hadoop', 'Tout les réponses sont vrais', 'b', 'c'),
(40, 'Dans une stratégie de veille stratégique (Business Intelligence), lequel de ces éléments est indispensable ? ', 'Intelligence artificielle', 'Gestion de la relation client (CRM)', 'Entrepôt de données', 'Systèmes de gestion de la qualité ', 'c', 'c'),
(41, 'Que signifie la méthodologie SMART ?', 'Sécurité, Monitoring, Approche, Ressource, Transmissible', 'Spécifique, Mesurable, Acceptable, Réaliste, Temporellement défini', 'Spécialiste, Mensuel, Améliorable, Réfutable, Tempéré', 'Software, Matrice, Agile, Raccourci, Transfert', 'b', 'c'),
(42, 'Dans quel pays a été construite la première ligne de chemin de fer ?', 'Angleterre', 'Espagne', 'France', 'Allemagne', 'a', 'c'),
(43, 'Combien y a-t-il d\'étoiles dans le ciel ?', '2, le soleil et l\'étoile du berger', '100 millions', '500 000 millions', 'Proche de l\'infini', 'd', 'c'),
(44, 'Quel est le nom de l\'organisation européenne créée pour garantir la sécurité et la défense de l\'Europe ? ', 'L\'Union européenne ', 'L\'OTAN ', 'L\'OSCE ', 'L\'UEO', 'b', 'c'),
(45, 'En quel langage Hadoop a-t-il été écrit ?', 'Python', ' Java', 'Perl', 'C++', 'b', 'c'),
(46, 'Où se trouve le siège de l\'Union européenne ? ', 'Bruxelles, Belgique ', 'Berlin, Allemagne ', 'Paris, France ', 'Madrid, Espagne', 'a', 'd'),
(47, 'Quel est le nom de l\'accord qui a supprimé les frontières entre les pays de l\'Union européenne ?  ', 'Le Traité de Maastricht', 'Le Traité d\'Amsterdam', 'Le Traité de Schengen', 'Le Traité de Lisbonne', 'b', 'd'),
(48, 'Les donneurs O peuvent donner aux receveurs:', 'B et AB', 'AB', 'O, A, B et AB', 'A et AB ', 'c', 'd'),
(49, 'Parmi les éléments suivants, lesquels ne sont pas des technologies de Big Data ?', 'Apache Hadoop', 'Apache Spark', 'Apache Kafka', 'Apache Pytarch', 'd', 'd'),
(50, 'Quel a été le premier message ARPANET  (premier réseau conçu aux États-Unis) ?', '« hello world »', ' « lo »', '« Welcome to ARPANET »', ' « Bonjour je suis ARPANET »', 'b', 'd'),
(51, 'Lequel des éléments suivants n’est pas une base de données NoSQL ?', 'CASSANDRA', 'MONGODB', 'Microsoft SQL Server', 'Aucune de ces réponses', 'c', 'd'),
(52, 'Quelle société a développé Apache Kafka ?', 'Microsoft', 'Amazon', 'LinkedIn', 'Google', 'c', 'd'),
(53, 'Qui est l’inventeur de l’intelligence artificielle ?', 'John McCarthy', 'Linus Benedict Torvalds', 'Rasmus Lerdorf', 'James Gosling', 'a', 'd'),
(54, 'Quel algorithme de recherche nécessite le moins de mémoire ?', 'Recherche optimale', 'Recherche en profondeur', 'Recherche linéaire', 'Aucune de ces réponses', 'b', 'd'),
(55, 'Sous quelle licence Android se trouve-t-il ?', 'Sourceforge', 'Apache/MIT', 'OSS', 'Aucune des catégories ci-dessus', 'b', 'd'),
(56, 'Qui est responsable de la mesure de la performance du projet ?', 'Le Scrum Master', 'Responsable de la livraison', 'Product Owner', 'L’équipe de développement', 'c', 'd'),
(57, 'Angular Js est basé sur :', 'Architecture MVC', 'Architecture MVVM ', 'Pattern Decorator', 'Pattern Observer', 'b', 'd'),
(58, 'Quel est le plus petit os du corps humain ?', 'Le cubitus', 'Le tibia', 'L\'étrier', 'l\'omoplate', 'c', 'd'),
(59, 'Quel est le numéro de port pour HTTPS (HTTP Secure)?', '43', '443', '445', '444', 'b', 'd'),
(60, 'Quelle technique d’IA permet aux ordinateurs de comprendre les associations et les relations entre les objets et les événements ?', 'Traitement heuristique', 'Science cognitive', 'Symbolisme relatif', 'Pattern Matching', 'd', 'd');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `a` varchar(255) NOT NULL,
  `b` varchar(255) NOT NULL,
  `c` varchar(255) NOT NULL,
  `d` varchar(255) NOT NULL,
  `answer` varchar(15) NOT NULL,
  `category` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`id`, `content`, `a`, `b`, `c`, `d`, `answer`, `category`) VALUES
(1, 'Que signifie  INDH  ?', 'Initiative Nationale pour le Développement Humain', 'Initiative Nominale contre les Déchets et lHumidité ', 'Informatisation Nominative et Directive de LHémicycle', 'Initiative Nationale pour le Développement de lHumanité', 'a', 'a'),
(2, 'Que signifie la dévaluation ?', 'Une perte de valeur de la monnaie ', 'Une perte de pouvoir d’achat de la monnaie', 'Une baisse des prix ', 'Une baisse des impôts', 'a', 'a'),
(3, 'Quel est le rôle de la caisse de compensation ?', 'Subventionner certains produits de grande consommation', 'Investir en milieu rural', 'Financer l’alphabétisation', 'Couvrir les dépenses de santé', 'a', 'a'),
(4, 'L’épargne est :', 'Une partie du salaire investie', 'Une partie du revenu non consommée ', 'Une partie du revenu prêtée', 'Une partie du revenu consommée', 'b', 'a'),
(5, 'Que signifie  INDH  ?', 'Initiative Nationale pour le Développement Humain', 'Initiative Nominale contre les Déchets et lHumidité ', 'Informatisation Nominative et Directive de LHémicycle', 'Initiative Nationale pour le Développement de lHumanité', 'a', 'a'),
(6, 'Que signifie la dévaluation ?', 'Une perte de valeur de la monnaie ', 'Une perte de pouvoir d’achat de la monnaie', 'Une baisse des prix ', 'Une baisse des impôts', 'a', 'a'),
(7, 'Quel est le rôle de la caisse de compensation ?', 'Subventionner certains produits de grande consommation', 'Investir en milieu rural', 'Financer l’alphabétisation', 'Couvrir les dépenses de santé', 'a', 'a'),
(8, 'L’épargne est :', 'Une partie du salaire investie', 'Une partie du revenu non consommée ', 'Une partie du revenu prêtée', 'Une partie du revenu consommée', 'b', 'a'),
(9, 'Les agents économiques sont au Maroc au nombre de :', '5', '6', '7', '8', 'a', 'a'),
(10, 'Le RAMED est :', 'Un régime médical ', 'Un plan de développement de la méditerranée', 'Une politique d’association avec des pays méditerranéens', 'Un régime d’assistance aux personnes en difficulté mentale', 'a', 'a'),
(11, 'La principale exportation du Maroc est :', 'Le phosphate', 'Les véhicules ', 'Les agrumes', 'Le textile', 'b', 'a'),
(12, 'Le SMIG est :', 'Un revenu minimum ', 'Un revenu moyen', 'Un revenu maximal', 'Un revenu du marché', 'a', 'a'),
(13, 'Le Maroc détient la 1ère réserve mondiale des Phosphates ; lequel des pays ci-après ne constitue pas un concurrent du Maroc pour la production des Phosphates et Acides Phosphoriques sur le plan international ?', 'Inde', 'Arabie saoudite\n\n', 'Chine', 'Etats Unis', 'a', 'a'),
(14, 'Lequel des pays africains ci-après est considéré comme étant producteur et exportateur du pétrole ?', 'Gabon', 'République centrafricaine', 'Mali', 'Niger', 'a', 'a'),
(15, 'Lequel des pays ci-après est considéré comme étant le premier producteur de céréales au Monde ?', 'Chine', 'Etats Unis', 'Inde', 'Russie', 'a', 'a'),
(16, 'Le capitalisme est le système économique où?', 'Ce sont les individus et non l’Etat qui détiennent le capital', 'L’Etat est inexistant ', 'Le partage des richesses est équilibré entre les différentes composantes de la société', 'L’Etat qui fixe les prix et les taux d’intérêts', 'a', 'a'),
(17, 'La mondialisation correspond ?', 'A la libéralisation des échanges internationaux et laccès de nouveaux acteurs à ce marché, modifiant les rapports de force traditionnels', 'A lutilisation généralisée du dollar dans les échanges internationaux', 'A la multiplication des forums internationaux, chaque pays voulant accueillir le sien', 'A L’ouverture des frontières entre les différents pays', 'a', 'a'),
(18, 'Que représente la compétitivité ?', 'Laptitude dune entreprise à faire face à la concurrence et à satisfaire ses clients', 'Une très grande capacité de production de l’entreprise', 'La notoriété d’une entreprise sur les marchés internationaux', 'Une mesure de rentabilité financière d’une entreprise', 'a', 'a'),
(19, 'En temps de crise économique, On peut affirmer que ?', 'Les ménages reportent leurs achats ', 'Les ménages augmentent leurs achats', 'Les ménages consacrent plus de budget pour les voyages et loisirs ', 'Les ménages investissent plus en bourse en raison de la baisse supposée des cours des actions', 'a', 'a'),
(20, 'En économie, le problème central est :', 'La rareté', 'lallocation des ressources', 'la consommation', 'la monnaie', 'a', 'a'),
(21, 'Indiquez ci-dessous ce qui nest PAS un facteur de production :', 'le capital', 'le prêt bancaire', 'la terre', 'le travail', 'b', 'a'),
(22, 'La macroéconomie traite :', 'des activités des entités individuelles', 'des agrégats économiques', 'du comportement des entreprises', 'du comportement de lindustrie électronique', 'b', 'a'),
(23, 'Létude de linflation fait partie de:', 'Léconomie descriptive', 'La macroéconomie', 'L’économie normative', 'La microéconomie', 'b', 'a'),
(24, 'Une récession est :', 'une période durant laquelle le produit agrégé diminue', 'une période durant laquelle les prix baissent', 'une période durant laquelle les prix baissent de manière très rapide', 'une période durant laquelle le chômage baisse', 'a', 'a'),
(25, 'Le chômage signifie que :', 'il y a un excès de demande sur le marché du travail', 'des gens ne souhaitent pas travailler au taux de salaire du marché ', 'au taux de salaire du marché il y a des gens qui veulent travailler mais qui ne trouvent pas demploi', 'des gens ne pourront pas travailler au taux de salaire du marché', 'c', 'a'),
(26, 'Dans une économie planifiée, toutes les décisions économiques sont prises par', 'les électeurs', 'les travailleurs', 'les consommateurs', 'lÉtat', 'd', 'a'),
(27, 'Les flux entre les entreprises et les institutions financières sont principalement', 'Des flux matériels', 'Des flux réels', 'Des flux matériels et financiers', 'Des flux financiers', 'd', 'a'),
(28, 'La balance commerciale enregistre ', 'les échanges de marchandises avec le reste du monde', 'Les échanges de capitaux avec le reste du monde', 'Les échanges de service avec le reste du monde', 'les échanges de revenus avec le reste du monde', 'a', 'a'),
(29, 'Sur un marché, le monopole correspond à la situation suivante …', 'Quelques vendeurs et un acheteur unique', 'Quelques acheteurs et beaucoup de vendeurs', 'Quelques vendeurs et beaucoup dacheteurs', 'Un grand nombre dacheteurs et un seul vendeur', 'd', 'a'),
(30, 'Que signifie OCDE ?', 'Organisation de Coopération et de Développement Economiques', 'Organisation des Clubs Des Eleveurs ', 'Organisation des Centres pour le Développement de lEntreprise', 'Organisation des Centres de Distribution Electrique', 'a', 'a'),
(31, 'Que signifie le G8 ?', 'Groupement de pays ayant la bombe nucléaire', 'Groupement de pays parmi les 15 membres du Conseil de sécurité de l’ONU', 'Regroupement des 8 pays les plus puissants économiquement au monde', 'Groupement de pays producteurs de pétrole', 'c', 'a'),
(32, 'Que signifie TTC ?', 'Toute Taxe Compétitif', 'Toute Taxe Capitalisé', 'Toute Taxe Comprise ', 'Ne veut rien dire', 'c', 'a'),
(33, 'De quoi se compose le budget de lEtat ?', 'Recettes publiques', 'Dépenses publiques', 'Recettes et dépenses publiques', 'Déficit public', 'c', 'a'),
(34, 'Quest ce que le FMI ?', 'Fonds Monétaire International', 'Fonds Mondial d’Investissement', 'Fédération Marocaine des Internautes', 'Fédération Mondiale des Internautes', 'a', 'a'),
(35, 'En Athlétisme combien dépreuves comprend lheptathlon ?', '5', '6', '7', '8', 'c', 'b'),
(36, ' Le CHAN 2018 est organisé par:', 'Algérie', 'Ethiopie', 'Kenya', 'Le Maroc', 'd', 'b'),
(37, ' Quelle est la longueur exacte d’une piscine olympique ?', '25m', '50m', '80m', '100m', 'b', 'b'),
(38, ' Lors des jeux Olympiques d’Eté célébrés à Rio de Janeiro en 2016, la Chine a été classée dans le tableau des médailles :', '3', '4', '5', '6', 'a', 'b'),
(39, '  Quel est le nom officiel du Terrain de Tennis ?', '     Le Playground', ' La Pelouse', ' Le terrain de Tennis', '   Le Court', 'd', 'b'),
(40, 'Le Mondial de HandBall 2019 sera organié dans lun des pays suivants:', '   Allemagne', 'Danemark', '    Allemagne-Danemark', '     France- Belgique', 'c', 'b'),
(41, '  Au judo, quel est le grade le plus élevé parmi ces ceintures ?', 'Bleue', 'Blanche-Rouge', '     Noir', '   Large-Blanche', 'd', 'b'),
(42, 'A quel sport doit-on jouer pendant 2 mi-temps de 40 minutes ?', 'Volley Ball', '    Handball', '     Rugby', '    Basket Ball', 'c', 'b'),
(43, 'Quelle est la largeur dun but de football ?', '7,32 m', '       9 m', '6, 50 m', '      9, 30 m', 'a', 'b'),
(44, '  Quelle est la distance officielle dun marathon?', '36,870 kilomètres', '    40,625 kilomètres', '     42,195 kilomètres', ' 45,610 kilomètres', 'c', 'b'),
(45, 'En cyclisme, quelle est la couleur du maillot du leader du Tour de France ?', 'Blanc', 'Jaune', 'Rouge', 'Noir', 'b', 'b'),
(46, 'Dans quel sport sest illustré Said Aouita?', 'La boxe', 'Le Foot Ball', 'Le cyclisme ', 'L’Athlétisme', 'd', 'b'),
(47, 'Comment sappelle le sport où lon danse et où lon effectue des figures sur la glace ?', 'Le patinage artistique', 'La danse sur glace', 'La glisse artistique', 'Le patinage en salle', 'a', 'b'),
(48, 'Combien de joueurs forment une équipe de Handball?', '7', '9', '11', '13', 'a', 'b'),
(49, 'Combien de joueurs forment une équipe de RUGBY ?', '13', '14', '15', '16', 'c', 'b'),
(50, 'Les jeux olympiques dété de 2020 se dérouleront à :', 'Paris', 'Amsterdam', 'Tokyo', 'Rome', 'c', 'b'),
(51, 'Quel sport consiste à escalader des montagnes ?', 'Spéléologie', 'Alpinisme', 'Rafting', 'Surf', 'b', 'b'),
(52, 'Les Jeux olympiques (été ou hiver) sont organisés :', 'tous les ans', 'tous les deux ans', 'tous les quatre ans', 'tous les cinq ans', 'c', 'b'),
(53, 'Quel marocain a été triple champion du monde en cross country ?', 'S. Hissou', 'Kh. Sekkah', 'B. Boutaïb', 'S. Aouita', 'b', 'b'),
(54, 'Dans quel sport peut-on toucher le ballon avec nimporte quelle partie du corps ?', 'Basket-ball', 'Foot-ball', 'Volley-ball', 'Hand-ball', 'c', 'b'),
(55, 'Que désigne-t-on usuellement par « C.A.F » ?', 'Championnat Africain Féminin', 'Coupe Africaine de Frisbee', 'Confédération Africaine de Football', 'Championnat dAthlétisme Africain', 'c', 'b'),
(56, 'Comment s’appelle le sélectionneur actuel de l’équipe marocaine de Football ? ', 'Badou Zaki', 'Rachid Taoussi', 'Hervé Renard', 'Philippe Troussier', 'c', 'b'),
(57, 'Où aura lieu la prochaine coupe du monde de football 2018 ? ', 'Russie ', 'Australie', 'Japon', ' Qatar', 'a', 'b'),
(58, 'Lequel de ces 4 sports ne se déroule pas dans leau ?', 'Waterpolo', 'Kayak', 'Aviron', 'Cross', 'd', 'b'),
(59, 'Qu’est-ce que le Water-Polo ?', 'Sport collectif aquatique  ', 'Sport individuel aquatique ', 'Sport où il faut nécessairement porter un polo ', 'Vêtement waterproof, qui résiste à l’eau ', 'a', 'b'),
(60, 'En karaté, de quelle couleur est la ceinture la plus gradée ?', 'Jaune ', 'Verte', 'Marron ', 'Noire', 'd', 'b'),
(61, 'Mehdi Bennani est un champion marocain de : ', 'Jeu d’échec ', 'Tennis', 'Course automobile ', 'Natation ', 'c', 'b'),
(62, '     Qui est l’athlète marocain qui a obtenu une médaille d’or aux Jeux Olympiques de 1984 ?', 'Hicham El Guerrouj', '  Said Aouita', '   Khalid Sekkah', '    Brahim Boulami', 'b', 'b'),
(63, ' les deux Clubs de football qui sont qualifiés pour jouer le match final  de la coupe du trône pour la saison sportive 2016-2017 sont le Club RCA et le Club DHJ. Combien de fois ces deux Club  se sont rencontrés pour la même occasion?', '   1- 2 fois', '   2- 3 fois', '    3- 4 fois', '   4- 5 fois', 'b', 'b'),
(64, '        Le tour de France de cyclisme juillet 2017 est remporté par le cycliste', 'WARREN   BARGUIL', '  SIMON   YATES', '  CHRISTOPHER   FROOME', '   MICHAEL  MATTHEWS', 'c', 'b'),
(65, 'En 2011, à la suite de quel événement a eu lieu l’accident nucléaire de Fukushima ?', '   Un séisme et un tsunami', '   Une attaque terroriste', ' Une erreur des ingénieurs', '  Son mauvais état', 'a', 'c'),
(66, 'La première ligne de TGV au Maroc relie', 'Tanger à Casablanca', 'Casablanca à Marrakech', 'Casablanca à Agadir', 'Tanger à Fès', 'a', 'c'),
(67, 'COP veut dire :', 'Conférence officielle des Planificateurs', 'Conference of the Parties ', 'Centre d’organisation populaire', 'Conseil d’organisation Palestinienne', 'b', 'c'),
(68, 'La région qui a opté pour son indépendance de l’Espagne est :', '. L’Andalousie', 'Le pays Basque', 'La catalogne ', 'Aragon', 'c', 'c'),
(69, 'Combien y a-t-il de régions au Maroc ?', '10', '14', '12', '11', 'c', 'c'),
(70, 'Le chef du gouvernement Marocain appartient au Parti :', 'Istiqlal', 'PAM', 'RNI', 'PJD ', 'd', 'c'),
(71, 'La guerre en Syrie dure depuis :', '10 ans', '6 ans ', '4 ans', '8 ans', 'b', 'c'),
(72, 'Quel pays asiatique est actuellement dirigé par un dictateur et objet de tensions autour de l’arme nucléaire ?', 'Japon ', 'Corée du Nord', 'Corée du Sud', 'Singapour ', 'b', 'c'),
(73, 'Quel pays n’a pas été touché par le Printemps arabe ? ', 'Tunisie', 'Egypte ', 'Lybie', 'Qatar', 'd', 'c'),
(74, 'Le chef de la résistance palestinienne après 1959 était : ', 'Muammar Kadhafi ', 'Moshe Dayan', 'Yasser Arafat', 'Le Roi Hussein ', 'c', 'c'),
(75, 'Quel parti a remporté les dernières élections législatives au Maroc ? ', 'Le RNI', 'L’USFP', 'Le PAM', 'Le PJD  ', 'd', 'c'),
(76, 'La Journée Mondiale de la Femme est célébrée chaque année le :', '14 août  ', '11 janvier', '29 mars', '8 mars ', 'd', 'c'),
(77, 'Entre 1912 et 1956, le Maroc est officiellement occupé par :', 'La France et l’Italie', 'La France et l’Allemagne', 'La France et l’Espagne ', 'La France et l’Angleterre', 'c', 'c'),
(78, 'Quel costume de bain a créé la polémique cet été en France ? ', 'Le bikini', 'Le burkini', 'La burqa', 'Le short', 'b', 'c'),
(79, 'Un pays laïque est un pays dont le régime : ', 'Est totalitaire', 'Est libertaire', 'Sépare la religion de la politique', 'Applique la Charia ', 'c', 'c'),
(80, 'Quel pays vient de quitter l’accord international sur l’environnement appelé « Accord de Paris » ?', 'Chine  ', 'Brésil ', 'Etats-Unis ', 'Arabie Saoudite', 'c', 'c'),
(81, 'En Janvier 2015, des terroristes ont attaqué un journal français. Lequel ? ', 'Le Monde', 'Charlie Hebdo', 'Le Figaro ', 'La Vie Eco ', 'b', 'c'),
(82, '« Le Maroc vu du ciel » est :', 'Une émission télévisée qui montre la beauté du Maroc ', 'Un jeu sur le Maroc', 'Un journal de la presse électronique marocaine', 'Une radio marocaine ', 'a', 'c'),
(83, 'Le Roi Abdullah II et la Reine Rania sont les monarques de quels pays ?', 'Emirats arabes Unis ', 'Qatar', 'Koweit', 'Jordanie ', 'd', 'c'),
(84, 'Les candidats à la présidentielle américaine 2016 étaient :   ', 'Bill Clinton contre Donald Trump ', 'Gary Johnson contre Hilary Clinton ', 'Hilary Clinton contre Donald Trump', 'Barack Obama contre Donald Trump', 'c', 'c'),
(85, 'Comment s’appelle l’ancienne Ministre marocaine de l’Environnement ? ', 'Hakima EL HAITE', 'Bassima HAKKAOUI', 'Charafat AFAILAL', 'Nabila MOUNIB', 'a', 'c'),
(86, 'Comment s’appelle l’actuelle chef d’Etat de l’Allemagne ?', 'Christine Lagarde', 'Angela Merkel ', 'Monika Herrmann', 'Clara Siebert', 'b', 'c'),
(87, 'Hosni Moubarak était le Président de quel pays ?', 'Egypte ', 'Tunisie', 'Syrie', 'Liban ', 'a', 'c'),
(88, 'Le Maroc était récemment sur le devant de la scène pour un fait marquant d’archéologie. Quel est-il ? ', 'On a retrouvé des restes d’homo sapiens datant de 300 000 ans', 'On a retrouvé des restes de dinosaures datant de plusieurs millions d’années   ', 'On a créé un nouvel institut d’archéologie  ', 'On a fait des découvertes dans la montagne d’Igîlîz située dans l’Anti-Atlas', 'a', 'c'),
(89, 'A quoi fait référence le « BREXIT » ? ', 'La sortie du Qatar de la Ligue Arabe ', 'La sortie du Royaume Uni de l’Union Européenne ', 'La sortie des Etats –Unis de l’OTAN', 'L’entrée de la Chine dans les pays du BRICS', 'b', 'c'),
(90, 'Les initiales du parti politique « PJD » signifient ? ', 'Parti de la Jeunesse et du Divertissement ', 'Parti des Jeunes Démocrates ', 'Parti de la Justice et du Développement ', 'Parti de la Justice et de la Démocratie ', 'c', 'c'),
(91, 'Le « brexit»  concerne quel pays ? ', 'Portugal', 'Royaume Uni', 'Iran', 'Italie ', 'b', 'c'),
(92, 'Comment s’appelle la femme candidate aux dernières élections présidentielles américaines ? ', 'Michelle Obama', 'Hilary Clinton ', 'Condoleeza Rice', 'Jennifer Gardener', 'b', 'c'),
(93, 'Quelle est la capitale de la Pologne ?', 'Prages', 'Budapest', 'Split', 'Varsovie', 'd', 'c'),
(94, 'Quelle est la devise de la République Française ?', 'Liberté, Egalité Fraternité', 'Liberté, Disparité, Fraternité', 'Volonté, Egalité, Fraternité', 'Fraternité, Equité, Liberté', 'a', 'c'),
(95, 'De quoi est composée la molécule d’eau ? ', '2 atomes d’oxygène et 1 atome d’hydrogène', '1 atome d’oxygène et 2 atomes d’hydrogène', '1 atome d’oxygène et 1 atome d’hydrogène', '2 atomes d’oxygène et 1 atome de carbone ', 'b', 'd'),
(96, 'Quel est le principal constituant de certains dissolvants utilisés pour retirer le vernis à ongles ?', 'Eau oxygénée', 'Méthanol', 'Acétone ', 'Plomb', 'c', 'd'),
(97, 'Qu’est-ce qu’un Spam ?', 'Un site web ', 'Un programme ', 'Un message indésirable ', 'Un virus très dangereux ', 'c', 'd'),
(98, 'On mesure la fréquence dun Microprocesseur en :', ' MHz', '  GHz', '   Décibels', '     Ko', 'a', 'd'),
(99, 'De combien de touches dispose un clavier standard :', '    103', '105', '110', '      120', 'b', 'd'),
(100, 'Que signifie lacronyme DNS?', '     Domain Name System', '      Domain Nama Server', '    Data Name Server', '     Data Name System', 'a', 'd'),
(101, 'A quoi sert ARP?', '  A trouver ladresse MAC dune station dont on connaît ladresse IP', '  A trouver ladresse IP dune station dont on connaît ladresse MAC', ' A trouver ladresse MAC dune station dont on connaît le nom de HOST', '     A trouver ladresse IP dune station dont on connaît le nom de HOST', 'a', 'd'),
(102, 'Un WebFTP permet :', ' De se connecter à Internet', ' Denvoyer et de recevoir les fichiers via le protocole http', '      De se passer dun navigateur Internet pour surfer', '  Décrire des programmes sur le Web', 'b', 'd'),
(103, 'Un browser est un ', '  Logiciel de programmation', '    Navigateur du Web', '  Logiciel dexploitation', '  Site Internet', 'b', 'd'),
(104, 'La base Hexadécimale utilise :', '      Les chiffres', '     Les lettres', '      Les chiffres et les lettres de A à F', '    Les chiffres et les lettres ', 'd', 'd'),
(105, 'Quels sont les organes qui agissent sur la synthèse de glucose ?', 'Les reins, l’estomac et le tube digestif', 'Les doigts de pieds, les mains et la tête', ' Le foie, les muscles et le tissu adipeux', 'Le cœur, le cerveau et le pancréas', 'd', 'd'),
(106, 'Quels types de rayons solaires sont dangereux pour la peau ?', 'Ultraviolets', 'Infrarouges', 'Infraviolets', 'Laser', 'a', 'd'),
(107, 'Le théorème de Pythagore est un théorème de : ', 'Géométrie ', 'Algèbre', 'Géologie', 'Chimie', 'a', 'd'),
(108, 'Le chinois Jack Ma est le fondateur de :', 'Alibaba', ' Facebook', 'Amazone ', 'Snapchat', 'a', 'd'),
(109, 'La baleine est :  ', 'Un reptile ', 'Un mammifère  ', 'Un ovipare', 'Un batracien ', 'b', 'd'),
(110, 'Qu’est-ce qu’un avion supersonique ?', 'Un avion imaginaire ', 'Un avion qui peut voler plus vite que la vitesse de la lumière', 'Un avion qui peut voler plus vite que la vitesse du son ', 'Un drone sans pilote', 'c', 'd'),
(111, 'Un cookie sur internet est :  ', 'Un virus  ', 'Une caméra  ', 'Une information conservée sur votre ordinateur par un site web que vous visitez afin de mieux vous identifier plus tard.', 'Un livret de recettes de desserts', 'c', 'd'),
(112, 'Quelle anomalie de la vision fait confondre le plus souvent le rouge et le vert ? ', 'Dichromate  ', 'Daltonisme', 'Cataracte', 'Presbytie ', 'b', 'd'),
(113, 'Archimède était : ', 'Un médecin', 'Un politologue', 'Un économiste    ', 'Un mathématicien', 'd', 'd'),
(114, 'Un routeur est : ', 'Une machine permettant la construction de routes ', 'Une personne travaillant sur les chantiers autoroutiers', 'Un équipement informatique permettant le transit de blocs de données d’une interface à une autre', 'Une station pour astronautes ', 'c', 'd'),
(115, 'La maladie de Parkinson touche : ', 'Les os  ', 'Les reins', 'Le cerveau', 'Le cœur ', 'c', 'd'),
(116, 'Quelle science a pour objet la recherche des liens de parenté entre les personnes ? ', 'Le génétisme', 'La généalogie', 'L’anthropologie  ', 'La parotosie', 'b', 'd'),
(117, 'Quel réseau social Microsoft a-t-il récemment racheté ?', 'Pinterest', 'Tumblr', 'Instagram', 'LinkedIn ', 'd', 'd'),
(118, 'Combien existe-t-il d’océans ?', '3', '4', '5', '6', 'c', 'd'),
(119, 'Quel gaz pollue beaucoup l’atmosphère ?', 'Le Dioxyde de Carbone ', 'L’acétylène ', 'Le butane ', 'Le gaz de schiste ', 'a', 'd'),
(120, 'Où trouve-t-on la centrale solaire « NOOR » ?', 'Marrakech ', 'Ouarzazate', 'Merzouga', 'Chefchaouen', 'b', 'd'),
(121, 'En téléphonie, qu’appelle-t-on un MMS ? ', 'Un signal électrique  ', 'Un message multimédia', 'Le code de verrouillage du téléphone ', 'Un message codé', 'b', 'd'),
(122, 'Comment s’appelle le gaz responsable du réchauffement climatique ?', 'Gaz à effet de serre ', 'Gaz blanc', 'Gaz combustible', 'Gazoduc ', 'a', 'd'),
(123, 'Combien de litres de sang contient le corps humain ? ', '1', '5', '10', '12', 'b', 'd'),
(124, 'Quel est le médecin qui endort un patient avant une opération ?', 'Un hypnotiseur ', 'Un endormeur ', 'Un anesthésiste ', 'Un oncologue ', 'c', 'd');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`player_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `player_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
