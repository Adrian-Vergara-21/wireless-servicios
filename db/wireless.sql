-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-11-2025 a las 16:29:51
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `wireless`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bancos`
--

CREATE TABLE `bancos` (
  `id_banco` int(11) NOT NULL,
  `nombre_banco` varchar(255) NOT NULL,
  `numero_cuenta` varchar(255) NOT NULL,
  `cedula_propietario` varchar(20) NOT NULL,
  `nombre_propietario` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bancos`
--

INSERT INTO `bancos` (`id_banco`, `nombre_banco`, `numero_cuenta`, `cedula_propietario`, `nombre_propietario`) VALUES
(4, 'banca amiga', '0102-0000-0000-0000-0000', 'v12722373', 'galanet solutions,c.a');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobros_manuales_historial`
--

CREATE TABLE `cobros_manuales_historial` (
  `id` int(11) NOT NULL,
  `id_cobro_cxc` int(11) NOT NULL,
  `id_contrato` int(11) NOT NULL,
  `autorizado_por` varchar(100) NOT NULL,
  `justificacion` text NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `monto_cargado` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunidad`
--

CREATE TABLE `comunidad` (
  `id_comunidad` int(11) NOT NULL,
  `nombre_comunidad` varchar(150) NOT NULL,
  `id_parroquia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comunidad`
--

INSERT INTO `comunidad` (`id_comunidad`, `nombre_comunidad`, `id_parroquia`) VALUES
(1, 'betijoque', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratos`
--

CREATE TABLE `contratos` (
  `id` int(11) NOT NULL,
  `ip` varchar(20) NOT NULL COMMENT 'Dirección IP asignada al cliente (IPv4)',
  `cedula` varchar(20) NOT NULL COMMENT 'Cédula o ID del cliente',
  `nombre_completo` varchar(150) NOT NULL COMMENT 'Nombre completo del titular del contrato',
  `id_municipio` int(11) NOT NULL COMMENT 'FK de la tabla municipio',
  `id_parroquia` int(11) NOT NULL COMMENT 'FK de la tabla parroquia',
  `id_comunidad` int(11) NOT NULL,
  `id_plan` int(11) NOT NULL COMMENT 'FK de la tabla planes',
  `id_vendedor` int(11) NOT NULL COMMENT 'FK de la tabla vendedores',
  `direccion` varchar(150) NOT NULL COMMENT 'Dirección detallada de instalación',
  `telefono` varchar(50) NOT NULL COMMENT 'Número de teléfono de contacto',
  `correo` varchar(100) DEFAULT NULL COMMENT 'Correo electrónico de contacto (Opcional)',
  `fecha_instalacion` date NOT NULL DEFAULT '2025-10-01',
  `ident_caja_nap` varchar(50) NOT NULL COMMENT 'Identificador físico de la Caja NAP/Splitter',
  `puerto_nap` varchar(10) NOT NULL COMMENT 'Puerto utilizado en la Caja NAP',
  `num_presinto_odn` varchar(50) NOT NULL COMMENT 'Número del Hilo de Fibra o Presinto ODN',
  `id_olt` int(11) NOT NULL,
  `id_pon` int(11) NOT NULL COMMENT 'Identificador Serial PON del equipo del cliente (ONT/Router)',
  `estado` varchar(20) NOT NULL DEFAULT 'ACTIVO' COMMENT 'Estado actual del contrato: ACTIVO, INACTIVO, SUSPENDIDO, etc.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contratos`
--

INSERT INTO `contratos` (`id`, `ip`, `cedula`, `nombre_completo`, `id_municipio`, `id_parroquia`, `id_comunidad`, `id_plan`, `id_vendedor`, `direccion`, `telefono`, `correo`, `fecha_instalacion`, `ident_caja_nap`, `puerto_nap`, `num_presinto_odn`, `id_olt`, `id_pon`, `estado`) VALUES
(1, '192.168', '3283141', 'as', 1, 1, 0, 1, 2, 'asd', '0426-4689848', 'asd@', '2025-10-01', '1', '', '', 3, 0, 'INACTIVO'),
(2, '192.168.10.100', 'V12721951', 'Carmen Aide Ramirez ', 1, 2, 0, 3, 2, 'Sector Piedras Blancas, Casa S-N, Frente A La Caja ', '4147148013', 'ESBUS2018@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(3, '192.168.10.101', 'V10398076', 'Darwin Bastidas', 1, 5, 0, 3, 2, 'Sector La Mata, Calle Principal, Casa #50', '4147425198', 'DARKS29@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(4, '192.168.10.103', 'V13462956', 'Omar Vergara ', 1, 5, 0, 3, 2, 'Quevedo, Via Principal, Casa S-N ', '4247419627', 'OMARVERGARAB@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(5, '192.168.10.104', 'V10262751', 'Dalia Quintero', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania Calle 5', '4263713136; 41470778', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(6, '192.168.10.105', 'V4657696', 'Morela Nuñez', 1, 5, 0, 3, 2, 'Calle Santa Rita, Cerca De La Plaza, La Mata ', '4246265666', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(7, '192.168.10.106', 'V12466273', 'Yusmelis Gomez', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Casa #27, Calle 1', '4163080932; 41276404', 'ROSMELISSEGOVIA@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(8, '192.168.10.107', 'V21064445', 'Raquel Briceño\r\n', 1, 5, 0, 3, 2, 'Sector Cruz De La Mision \r\n', '4247129062; 41670171', 'RAQUELBRICEÑOAÑEZ@GMAIL.COM\r\n', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(9, '192.168.10.108', 'V15043297', 'Anderxon Angulo Castellano', 1, 5, 0, 5, 2, 'Sector El Terreno La Mata', '4247417027', 'anderxonangulo306@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(10, '192.168.10.109', 'V20708756', 'Yosmer Viloria ', 1, 5, 0, 3, 2, 'Sector Las Dalias, Santa Rita, La Mata ', '4247275020', 'LUCIANOJOSEVASQUEZ@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(11, '192.168.10.111', 'V25604039', 'Zulinda Amada Sulbaran Montilla (Materna)', 1, 5, 0, 3, 2, 'Sector La Mata Calle Las Dalias Via A Quevedo', '4247005402', 'zuli2301@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(12, '192.168.10.112', 'V16377234', 'Cesar Cancilleri ', 1, 5, 0, 3, 2, 'Sector Jaruma, Calle 2 Casa #10 Eje Colinas De Carmania ', '4160868620; 42477223', 'CESARDEJESUSCANCILLERI@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(13, '192.168.10.113', 'V27497250', 'Ricardo Pernia', 1, 5, 0, 3, 2, 'Calle El Molino', '4261016870', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(14, '192.168.10.114', 'V23762822', 'Adrian Divita', 1, 5, 0, 3, 2, 'Granja Encuvadora Quevedo', '4246005242', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(15, '192.168.10.115', 'V9326834', 'Argenis Pirela ', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Calle 3 Casa 56', '4264216218', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(16, '192.168.10.116', 'V32621418', 'Luisany Aguilar ', 1, 4, 0, 3, 2, 'Quevedo Parte Alta, Casa S-N, Mas Arriba De La Escuela ', '4164071542; 42636739', 'OLMOSSARAY7@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(17, '192.168.10.117', 'V26784148', 'Jose Garcia ', 1, 5, 0, 3, 2, 'Sector Hugo Chavez, Casa #103, Eje Colinas De Carmania ', '4267651772', 'WUILDERMIUZCATEGUI@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(18, '192.168.10.118', 'V20429056', 'Daylhu Veruska Cegarra Guerrero', 1, 2, 0, 3, 2, 'Urb  Vista Hermosa', '4147291068/ 41452953', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(19, '192.168.10.119', 'V', 'Sala De Gobierno La Mata', 1, 5, 0, 8, 2, 'La Mata', ' ', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(20, '192.168.10.12', 'V27676333', 'Fidel Briceño\r\n', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania, Calle 4, Casa #83, Parrq.Santa Rita, Mun.Escuque	\r\n', '04264403846', 'Fidelbricen@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(21, '192.168.10.120', 'V15293767', 'Ue Luis Beltran Prieto Figueroa', 1, 4, 0, 8, 2, 'Sector La Quinta, Pq La Union, Mun Escuque ', '4126693201', 'LUISBELTRANPRIETO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(22, '192.168.10.121', 'V17830584', 'Soleany Cardozo', 1, 2, 0, 3, 2, 'Calle Barrio Lindo, Con Calle Pueblo Nuevo Casa S-N ', '4126693201', 'SOLIANY84SC@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(23, '192.168.10.122', 'V20789494', 'Rafael Valera', 1, 4, 0, 3, 2, 'Las Rurales Del Alto De Escuque Casa S-N ', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(24, '192.168.10.123', 'V16377423', 'Andreina Del Carmen Hernandez Pacheco', 1, 4, 0, 3, 2, 'Sector Las Rurales Del Alto De Escuque, Via Principal, Cerca Del Estadio', '4168704116', 'trujillo.sbe@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(25, '192.168.10.124', 'V16995687', 'Elizabeth Carolina Briceño Anton', 1, 4, 0, 3, 2, 'Av. Principal La Quinta, Despues De La Escuela Casa S-N ', '4247251160', 'elizabethcarolinab@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(26, '192.168.10.125', 'V4660923', 'Jose Luis Medina', 1, 4, 0, 3, 2, 'Via Las Antenas, Sector La Laguneta', '4148243777; 42472518', 'CAMPUSORGANICO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(27, '192.168.10.126', 'V9397187', 'Tibisay Briceño ', 1, 2, 0, 3, 2, 'Calle Barrio Lindo Con Calle Bolivar', '4264578919', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(28, '192.168.10.127', 'V9316409', 'Eudomario Jose Arandia ', 1, 4, 0, 3, 2, 'Sector La Laguneta, Calle Via Las Antenas, Pq La Union, Mun Escuque ', '4247665527', 'MANUELARANDIA353@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(29, '192.168.10.13', 'V27497951', 'Johangli Araujo', 1, 5, 0, 3, 2, 'Urb.Ezequiel Zamora, Eje Colinas De Carmania,Terraza 3, Casa #16, Parrq.Santa Rita, Mun.Escuque', '4162662329; 41677706', 'johangliaraujo865@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(30, '192.168.10.130', 'V25919799', 'Alberto Dominguez', 1, 4, 0, 3, 2, 'Sector Quevedo, Pq La Union, Mun Escuque ', '4166708160', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(31, '192.168.10.131', 'V 13896752', 'Sonia Maldonado ', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, Segunda Etapa, Pq Sabana Libre, Mun Escuque ', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(32, '192.168.10.132', 'V12542378', 'Leida Gonzalez ', 1, 4, 0, 3, 2, 'Calle Principal Divino Niño, El Alto De Escuque Casa S-N', '4161759773; 41609149', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(33, '192.168.10.133', 'V17095357', 'Yusmary Peñaloza ', 1, 5, 0, 3, 2, 'Sector La Cruz De La Mision, La Mata Pq Santa Rita, Mun Escuque ', '4247535749', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(34, '192.168.10.134', 'V9164492', 'Leobardo Rivas ', 1, 1, 0, 3, 2, 'Sector Juan Diaz, Calle Principal, Callejon Los Pinos', '4247375968; 42603318', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(35, '192.168.10.135', 'V20428974', 'Jesus Alfredo Briceño', 1, 4, 0, 3, 2, 'Sector La Quinta', '4147391027; 42471895', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(36, '192.168.10.136', 'V20657574', 'Erika Leal', 1, 5, 0, 3, 2, 'La Mata Via Quevedo', '4143743479', 'erikaleal6349@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(37, '192.168.10.137', 'V25006969', 'Damaris Carrillo', 1, 5, 0, 3, 2, 'Sector Hugo Chavez, Pq Santa Rita, Mun Escuque', '4247084612', 'DAMARISCARRILLO098@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(38, '192.168.10.138', 'V18095375', 'Sugeidy Alarcon', 1, 5, 0, 3, 2, 'Sector El Terreno, La Mata Casa S-N, Pq Santa Rita, Mun Escuque ', '4247543824; 41265176', 'MOLINAKLAURISMAR@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(39, '192.168.10.139', 'V15584752', 'Eduardo Mendez', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania, Calle 3 Casa 61', '4247780553', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(40, '192.168.10.140', 'V16066742', 'Luis Alberto Briceño Villarreal', 1, 5, 0, 3, 2, 'La Mata Calle La Milagrosa Casa S/N ', '4265532046', 'luisbriceno532@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(41, '192.168.10.141', 'V30474367', 'Jesus Salas ', 1, 4, 0, 3, 2, 'La Rurales Del Alto Av Principal', '4161790138', 'ENRIQUE27JESUS@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(42, '192.168.10.142', 'V20039116', 'Zurisadai Vetencourt ', 1, 5, 0, 3, 2, 'Colinas De Carmania, Calle Hugo Chavez ', '4247208589', 'ZURISADAIESTHERVEN@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(43, '192.168.10.143', 'V7772651', 'Maria Hayde Rivero De Moreno', 1, 4, 0, 3, 2, 'El Pao Casa S-N Av Principal ', '4265747084', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(44, '192.168.10.144', 'V20076757', 'Maria Sierralta ', 1, 4, 0, 3, 2, 'El Pao Casa S-N Av Principal ', '4264553050; 41258074', 'DARYANNISBELLA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(45, '192.168.10.145', 'V19644310', 'Titady Araujo', 1, 4, 0, 3, 2, 'Sector La Laguneta, Via El Alto De Escuque, Casa #21 ', '4125836973', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(46, '192.168.10.146', 'V25171586', 'Esther Bastidas ', 1, 2, 0, 3, 2, 'Sector El Corocito De Sabana Libre, Los Terrenos ', '4147051419', 'RAMOBARRIOS@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(47, '192.168.10.147', 'V14329662', 'Hector Segovia ', 1, 4, 0, 3, 2, 'La Bomba, A Una Casa De Villa, Pq La Union, Mun Escuque ', '4247350363', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(48, '192.168.10.148', 'V11875522', 'Rosmary Perez ', 1, 4, 0, 3, 2, 'El Alto De Escuque, Calle Santa Rosalia Casa #7', '4145925644', 'ROSMAPEREZ304@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(49, '192.168.10.149', 'V16209389', 'Yetzenia Delgado', 1, 4, 0, 3, 2, 'El Pao, Casa Sa/N Sector La Quinta', '4169766610', 'DELGADO.YETZENIA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(50, '192.168.10.15', 'V16267050', 'Maria Gabriela Aguilar', 1, 5, 0, 3, 2, 'Eje Colinas De Carmania, Via Principal, Mas Arriba Del Cri', '4247182767; 41474667', 'Gabriela_aguilar1981@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(51, '192.168.10.150', 'V5762998', 'Justina Viloria ', 1, 4, 0, 3, 2, 'Sector El Pao Calle Principal Casa S/N', '4267716929', 'JUSTINAVV2588@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(52, '192.168.10.151', 'V17095745', 'Carmen Teresa Hernandez Sardi', 1, 4, 0, 3, 2, 'Sector El Pao Calle Principal Casa S/N', '4147417231', 'yeanpiero2015@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(53, '192.168.10.152', 'V15953229', 'Yean Piero Perez ', 1, 4, 0, 3, 2, 'Callejon Santa Barbara, Boqueron', '4247299382', 'yeanpiero2015@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(54, '192.168.10.153', 'V21064809', 'Maria Hernandez ', 1, 4, 0, 3, 2, 'Sector Santa Barbara, El Boqueroin, Pq La Union, Mun Escuque ', '4261634586', 'ADRIANA809UZCATEGUI@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(55, '192.168.10.154', 'V15953545', 'Hector Alonzo Parra', 1, 4, 0, 3, 2, 'Sector El Boqueron Calle Principal Arriba De La Cruz De La Mision ', '4260634895', 'hec_1921@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(56, '192.168.10.155', 'V10454251', 'Jose Gregorio Parra', 1, 4, 0, 3, 2, 'El Boqueron Av Principal Casa S-N, Inv Emmanuel ', '4267014363; 41608166', 'KLARAINESPARRA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(57, '192.168.10.156', 'V9705841', 'Mario Luzardo', 1, 4, 0, 3, 2, 'Residencias Las Piedras, Casa S/N, Sector El Quinquinillo, ', '4121280960', 'MARIO1.LUZARDO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(58, '192.168.10.157', 'V5762982', 'Jose Marquez Parra Viloria (Vladimir)', 1, 4, 0, 3, 2, 'El Boqueron Sector El Quinquinillo', '4263739776', 'pedrobladimirpm87@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(59, '192.168.10.158', 'V18984403', 'Edy Rene Moreno', 1, 5, 0, 3, 2, 'Calle Principal, Via Los Conucos, Sector La Mata, Casa #67', '4247297923; 41472047', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(60, '192.168.10.159', 'V17094685', 'Maira Rondon De Moreno ', 1, 5, 0, 3, 2, 'Colinas De Carmania, Urb Jaruma, Calle #3 Casa #55', '4263279991; 41497843', 'MAIRARONDON35@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(61, '192.168.10.16', 'V10038020', 'Maighet Peralta', 1, 5, 0, 3, 2, 'Urb.Ezequiel Zamora, Terraza 5 Casa Numero 28, Parrq.Santa Rita, Mun.Escuque', '4247426554', 'maighetdimar@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(62, '192.168.10.160', 'V22624009', 'Mayra Cabrera ', 1, 2, 0, 3, 2, '', '4149773985', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(63, '192.168.10.161', 'V15294655', 'Henry Santos ', 1, 5, 0, 8, 2, 'Quevedo Via La Mata ', '', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(64, '192.168.10.163', 'V16534556', 'Maria Teresa Moreno Viloria', 1, 4, 0, 3, 2, 'El Pao, Via Principal (Frente Marisabel Marquez)', '4261408420', 'PENDIENTE', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(65, '192.168.10.164', 'V4663015', 'Maria Isabel Marquez Araujo ', 1, 4, 0, 3, 2, 'El Pao Parte Alta Via El Filo', '4246596395/416277894', 'abreunelson082@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(66, '192.168.10.165', 'V19813402', 'Jose Manuel Torres ', 1, 4, 0, 3, 2, 'El Pao Parte Alta, Pq La Union, Mun Escuque ', '4247293007', 'CHRISTSONCHRITSON@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(67, '192.168.10.166', 'V16881353', 'Yoselyn Gonzalez', 1, 4, 0, 3, 2, 'El Boqueron Sector El Quinquinillo', '4121739806', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(68, '192.168.10.167', 'V 20790197', 'Ricardo Villamizar', 1, 4, 0, 3, 2, 'Sector El Quinquinillo, Pq La Union, Mun Escuque ', '4261045447', 'JORGERANGEL53@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(69, '192.168.10.168', 'V5762975', 'Jorge Rangel ', 1, 4, 0, 3, 2, 'Boqueron, Sector Sabanaeta, Pq La Union, Mun Escuque ', '4261045747', 'JORGERANGEL53@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(70, '192.168.10.169', 'V1409865', 'Maria Enriqueta Viloria De Viloria', 1, 4, 0, 3, 2, 'El Boqueron Sector La Abejita Casa S/N', '4266287267', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(71, '192.168.10.17', 'V3461641', 'Omar Jesus Viloria Diaz', 1, 5, 0, 3, 2, 'Urbanizacion Ezequiel Zamora Casa #17', '4247353931', 'omarjesusvoloriadiaz@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(72, '192.168.10.170', 'V18456928', 'Luisana Moreno ', 1, 4, 0, 3, 2, 'Sector Sabaneta, El Boqueron', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(73, '192.168.10.171', 'V15827969', 'Carly Perez', 1, 1, 0, 3, 2, 'Edificio Eskukey, P1A Juan Diaz Escuque ', '4264431161', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(74, '192.168.10.172', 'V10035155', 'Digna Rosa Duarte Andara ', 1, 2, 0, 3, 2, 'Sabana Libre Calle Bolivar, Frente A La Plaza', '4264271822', 'ALEJANDRA_2493@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(75, '192.168.10.173', 'V4664850', 'Jose Antonio Leon', 1, 1, 0, 3, 2, 'Edificio Eskukey, Juan Diaz Escuque ', '4122108050', 'CARLYPEREZCASTRO@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(76, '192.168.10.174', 'V23777885', 'Moises David Viloria ', 1, 1, 0, 3, 2, 'Juan Diaz Calle Principal Cubita, Frente A Eskukey', '4142625264', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(77, '192.168.10.175', 'V17864976', 'Elizabeth Briceño ', 1, 5, 0, 3, 2, 'Urb San Jose, Casa #13 Sector La Plaza', '4161180910; 42603421', 'DIDIER1983.03@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(78, '192.168.10.176', 'V16740516', 'Evelyn Rondon ', 1, 4, 0, 3, 2, 'El Boqueron, Sector Sabaneta, Casa S/N', '4267200726', 'VENEZUELA', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(79, '192.168.10.177', 'V19285124', 'Blendis Parra ', 1, 4, 0, 3, 2, 'El Boqueron, Sector El Quinquinillo, Entrada A La Bartola ', '4262267460', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(80, '192.168.10.178', 'V13715079', 'Gerard Torres ', 1, 4, 0, 3, 2, 'El Boqueron ', '4146422644', 'TORRESGE1@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(81, '192.168.10.18', 'V15307105', 'Juan Freitez', 1, 5, 0, 3, 2, 'Urb.Ezequiel Zamora, Terraza 3, Casa#20 Eje Colinas De Carmania, Parrq.Santa Rita, Mun.Escuque', '4247319770; 41209890', 'ajsr0927@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(82, '192.168.10.180', 'V9176968', 'Celsa Romero ', 1, 4, 0, 3, 2, 'Sector El Quinquinillo, Casa #A66, La Romareña, El Boqueron', '4147552909', 'CELSA.ROMERO24@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(83, '192.168.10.181', 'V3739949', 'Ismael De Jesus Abreu Mendez', 1, 4, 0, 3, 2, 'Sector Quinquinillo. Via Al Boqueron Casa S/N', '414731100', 'mai0248@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(84, '192.168.10.182', 'V7740010', 'Jose Garcia ', 1, 4, 0, 3, 2, 'El Tiro, Sector La Quinta ', '4160762959', 'CHEOGARCIA.180261@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(85, '192.168.10.183', 'V11322225', 'Alberto Alzate Arbelaez', 1, 4, 0, 3, 2, 'Las Malvinas, Granja', '4147299097; 42474184', 'ALBERTOALZATE_51@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(86, '192.168.10.184', 'V16329864', 'Luzmar Magdaly Alexander De Valera', 1, 4, 0, 3, 2, 'Sector El Pao', '4169749355', ' cavmarin@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(87, '192.168.10.185', 'V20656107', 'Pedro Perez', 1, 2, 0, 3, 2, 'San Benito Sector Los Pinos, 150 Mts Entrada Del Cementerio  ', '4247057155', 'PEDROPEREZCHEPELCA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(88, '192.168.10.186', 'V', 'Cira Carrasquero', 1, 2, 0, 3, 2, 'Calle La Estancia, Casa A40 Vista Hermosa ', '4262170387', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(89, '192.168.10.187', 'V17265621', 'Isaid Piña ', 1, 1, 0, 3, 2, 'Sector Juan Diaz, Urb Inces Casa #03', '4247541308', ' KANNAXCHAPARRO@GMAIL.COM ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(90, '192.168.10.188', 'V9310832', 'Atilio Parra ', 1, 4, 0, 3, 2, 'Sector Divino Niño, Cerca De San Benito', '4141755308', 'ATILIOPARRAPROCOL@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(91, '192.168.10.189', 'V18348209', 'Levis Pichardo ', 1, 2, 0, 3, 2, 'El Corocito Frente A La Piscina, Sabana Libre ', '4247505233', 'LEVIS.PICHARDO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(92, '192.168.10.19', 'V11320228', 'Lesbia Del Carmen Briceño Araujo', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania, Calle 2 Casa #41, Parrq.Santa Rita, Mun.Escuque.', '4167730674; 41470099', 'cr72005mago@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(93, '192.168.10.190', 'V11614126', 'Luis Duarte', 1, 5, 0, 3, 2, 'Calle Principal, Frente A La Cancha ', '4266592143', 'OSKARLYDUARTE1@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(94, '192.168.10.191', 'V9317082', 'Carmen Zambrano', 1, 2, 0, 3, 2, 'Calle Barrio Lindo, Diagonal A Raquel Arepas', '4141763165', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(95, '192.168.10.192', 'V19898099', 'Virxabid Bael Vazquez Bastidas ', 1, 2, 0, 3, 2, 'Sabana Libre, Calle El Jardin, Casa 01', '4267023987; 41268116', 'VIRXABIDVAZQUEZ289@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(96, '192.168.10.193', 'V19287285', 'Aldrin Collins Rafael Segovia Quintero', 1, 4, 0, 3, 2, 'Via Principal, Detras Del Hotel Villavivencio', '4265703765', 'YUGLE1107@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(97, '192.168.10.194', 'V12458559', 'Johnadal Montilla', 1, 4, 0, 3, 2, 'Sector El Pao Cerca De Luzmar', '4167267830', ' JOHNADALM02@GMAIL.COM ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(98, '192.168.10.195', 'V27245788', 'Angeline Hernandez', 1, 4, 0, 3, 2, 'Calle Principal Boqueron Casa A52', '416341340', ' NORELKISDELVALLEMAMA@GMAIL.COM ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(99, '192.168.10.196', 'V7836669', 'Losbeida Bencomo ', 1, 4, 0, 3, 2, 'El Boqueron, Mas Abajo De La Cruz ', '4263269508', 'LOSBEIDAB269@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(100, '192.168.10.197', 'V14459417', 'Aura Rosa Montilla ', 1, 4, 0, 3, 2, 'El Pao Via Principal, A 100M De La Trilladora ', '4169869975; 42656573', 'VILORIADAVID797@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(101, '192.168.10.198', 'V10039553', 'Deyanira Cinfuentes', 1, 4, 0, 3, 2, 'El Pao, Primera Callejuela Casa S/N', '4123554865', 'DEYANIRACIFUENTES@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(102, '192.168.10.199', 'V26962586', 'Mariana Alvarado', 1, 4, 0, 3, 2, 'Sector El Corocito, Casa #19 Frente A La Plaza Bolivar ', '4121714880', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(103, '192.168.10.20', 'V9325569', 'Jose Miguel Paredes Sanchez', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania, Calle 6 Casa 150, Parrq.Santa Rita, Mun.Escuque', '4147105147', 'miguelparedes1967@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(104, '192.168.10.201', 'V17604654', 'Marisela Provenzali', 1, 5, 0, 3, 2, 'Quevedo, Sector Cano', '4247144573', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(105, '192.168.10.202', 'V19794443', 'Johanna Volcanes ', 1, 1, 0, 3, 2, 'Sector Juan Diaz ', '4260389959', 'VOLCANESLINDA7@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(106, '192.168.10.203', 'V9175797', 'Alvaro Rangel Nava ', 1, 5, 0, 3, 2, 'La Mata, Via La Antena ', '4147054315', 'ALVARORANGELNAVA@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(107, '192.168.10.204', 'V9175797', 'Alvaro Rangel Nava (2)', 1, 5, 0, 3, 2, 'La Mata, Via La Antena ', '4147054315', 'ALVARORANGELNAVA@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(108, '192.168.10.205', 'V20040801', 'Veronica Perez ', 1, 4, 0, 3, 2, 'Sector Divino Niño, Av Principal Al Lado De La Bodega ', '4161954766', 'VEROYANTO4@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(109, '192.168.10.206', 'V18097365', 'Julio Peña ', 1, 1, 0, 3, 2, 'Urb La Escondida Sector Juan Diaz Numero 03', '4247644603; 42477999', 'Multiserviciossurgical@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(110, '192.168.10.207', 'V26784342', 'Permarys Valero', 1, 5, 0, 3, 2, 'Quevedo Calle Ppal Casa Azul Al Lado De La Cruz De La Mision', '4247033856', 'permarysvalero@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(111, '192.168.10.208', 'V4063730', 'Milagro De Jesus Perez De Delgado', 1, 4, 0, 3, 2, 'El Alto Calle Bolivar #10', '4147305846', ' perezmila199@yahoo.com.ve ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(112, '192.168.10.209', 'V20429597', 'Jackson Rivas', 1, 4, 0, 3, 2, 'El Alto Casa Psuv', '4160919116; 41673618', ' Jacsonrivas159@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(113, '192.168.10.21', 'V9362257', 'Gabriel Arturo Espinoza', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania, Calle 2, Casa #46, Parrq.Santa Rita, Mun.Escuque', '4247473337; 42474925', 'Inv.bis.mary@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(114, '192.168.10.210', 'V22892023', 'Darwin Alexander Balza Gonzalez', 1, 4, 0, 3, 2, 'Sector La Bomba, Detras De La Vinotinto, Alto De Escuque', '4262731455', ' bricenodariandreni@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(115, '192.168.10.211', 'V19832243', 'Darvelis Leal ', 1, 5, 0, 3, 2, 'Sector Siruma Casa S/N', '4147379382', ' Vleal0203@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(116, '192.168.10.212', 'V11315190', 'Edgardo Nuñez', 1, 5, 0, 3, 2, 'Sector La Mata, Calle Las Dalias, Chalet ', '4147113201', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(117, '192.168.10.213', 'V24618223', 'Suneky Troconis', 1, 4, 0, 3, 2, 'Sector La Laguneta Via Las Antenas ', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(118, '192.168.10.214', 'V9891786', 'Edgar Augusto Mujica Zerpa ', 1, 1, 0, 3, 2, 'Juan Diaz Calle El Rincon De Las Pizzas', '4146182858', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(119, '192.168.10.215', 'V4317301', 'Francisco Jose Portillo Barroso', 1, 4, 0, 3, 2, 'El Boqueron Via Principal S/N', '4140829753', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(120, '192.168.10.216', 'V12043940', 'Glendys Salas', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania ', '4247129319', 'sanchezlinaresyomarantonio@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(121, '192.168.10.217', 'V13260823', 'Ana Diaz', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Primera Etapa Casa A22, Sabana Libre ', '4161301921; 42472825', ' anadiazarraez19@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(122, '192.168.10.218', 'V18097849', 'Danyer Garcia', 1, 2, 0, 3, 2, 'Sector Brisas De San Benito, Parte Alta, Calle Miranda(Pavimentada) Sabana Libre', '4169376819; 41670553', ' shantellgarcia406@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(123, '192.168.10.219', 'V18985128', 'Yesenia Ojeda', 1, 4, 0, 3, 2, 'Sector La Quinta, Via El Boqueron', '4247089879', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(124, '192.168.10.22', 'V4324487', 'Maria La Paz Ramirez Blanco', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania, Calle 2 Casa #45', '4247697714', 'maripazramirezblanco@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(125, '192.168.10.221', 'V15294848', 'Yohana Contreras', 1, 2, 0, 3, 2, 'Sector Brisas De San Benito, Casa S/N Calle Sucre', '4261194932', ' Skarlyvillarreal5@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(126, '192.168.10.222', 'V4657944', 'Henial Del Carmen Provenzali Molina', 1, 5, 0, 3, 2, 'Sector Quevedo Calle Principal Casa S/N', '4247752952', 'albornozc668@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(127, '192.168.10.223', 'V3907267', 'Luis Felipe Toro Estrada', 1, 4, 0, 3, 2, 'Boqueron Calle Principal, Casa Numero A47, Mas Abajo De La Iglesia', '4269878148', 'Luisftoroes@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(128, '192.168.10.224', 'V9170711', 'Deixi Josefina Valero Godoy', 1, 4, 0, 3, 2, 'Boqueron Calle Principal Al Lado Bodega Chelique, Alcantarilla', '4267126429', 'albarrancarla6@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(129, '192.168.10.225', 'V21206841', 'Alexandra Karina Araujo Perez', 1, 4, 0, 3, 2, 'Sector El Boqueron Cerca De Donde Duval Giudicci', '51917758764', 'Ale.araujope@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(130, '192.168.10.227', 'V27245813', 'Leydimar Ruiz', 1, 4, 0, 3, 2, 'Boqueron, Via La Candelaria, Casa S/N ', '4264774848', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(131, '192.168.10.228', 'V9319683', 'Francisco Javier Hernandez Sarabia', 1, 4, 0, 3, 2, 'El Boqueron Calle Principal Frente A La Caseta Policia', '4266935586', 'Franciscozarabia63@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(132, '192.168.10.229', 'V6284044', 'Myriam Rodriguez Nieto', 1, 4, 0, 3, 2, 'Los Sauces Casa S/N, Carretera Sabana Libre-Alto De Escuque', '4265757009/424753182', 'myrodriguezn@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(133, '192.168.10.23', 'V16533944', 'Yerly Leon', 1, 5, 0, 3, 2, 'Urb.Ezequiel Zamora Terraza Numero 1 Casa Numero 4', '4169678877; 41696588', 'leonyerly2@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(134, '192.168.10.230', 'V27677175', 'Michael Rojas', 1, 4, 0, 3, 2, 'La Laguneta Via Principal Frente Ala Manga De Ftth', '4121734806', 'michiangelesisma@@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(135, '192.168.10.231', 'V10039752', 'Gustavo Salcedo', 1, 2, 0, 3, 2, 'Cale Pardillo Casa L48', '4169732752', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(136, '192.168.10.232', 'V25913176', 'Iria Del Carmen Peña Utrilla ', 1, 4, 0, 3, 2, 'Alto De Escuque Sector Divino Niño Calle Hugo Chavez Casa Sin Numero ', '4268435521', 'utrillairia@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(137, '192.168.10.233', 'V10401354', 'Ana Leonor Diaz', 1, 5, 0, 3, 2, 'Urbanizacion Ezequiel Zamora  Terraza 5 Casa 34', '4164148677; 42475660', 'Analeod@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(138, '192.168.10.234', 'V9000684', 'Irma Bastidas', 1, 5, 0, 3, 2, 'Sector Hugo Chavez Por Detras De La Casa De Yoel Albarran ', '4269872164; 42670072', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(139, '192.168.10.237', 'V16883828', 'Daniel Vergara', 1, 1, 0, 3, 2, 'Ariba De La Alcantarilla, La Garita ', '04147506115; 0416672', 'dv23072011@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(140, '192.168.10.238', 'V19643118', 'Luis Briceño', 1, 1, 0, 3, 2, 'La Garita Via Principal Bodega Hermanos Burger ', '04120701190; 0412511', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(141, '192.168.10.239', 'V12940965', 'Michaelk Marquez', 1, 1, 0, 3, 2, 'Puerto Escondido Por La Principal Arriba De La Alcantarilla Casa 59', '4160497375; 42657834', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(142, '192.168.10.240', 'V9322646', 'Duber Jose Uzcategui Pirela', 1, 1, 0, 3, 2, 'Sector La Garita', '4165132324', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(143, '192.168.10.242', 'V16534642', 'Beatriz Gonzalez ', 1, 1, 0, 3, 2, 'La Garita, Calle Principal Con Calle Los Samanes ', '4247465410', 'Pendiente', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(144, '192.168.10.243', 'V10035984', 'Alexis De Jesus Contreras', 1, 1, 0, 3, 2, 'Calle Principal La Garita Casa S/N Las Rurales Casa Del Zapatero', '4121407515', 'jesuscontrerasviloria@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(145, '192.168.10.245', 'V14800978', 'Maridel Evelyn Bello', 1, 1, 0, 3, 2, 'Sector La Garita, Calle La Misericordia, Casa #26', '4143955192; 41628902', 'evelinter14@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(146, '192.168.10.246', 'V12540477', 'Carmen Gonzalez', 1, 1, 0, 3, 2, 'Sector Puerto Escondido Parte Alta, Casa #77', '4264576377; 41275142', 'Javierpj@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(147, '192.168.10.247', 'V28495739', 'Claudia Billanburg', 1, 4, 0, 3, 2, 'El Tiro Cerca De Johan', '4260860001; 41640413', 'Villanbourdaniela@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(148, '192.168.10.248', 'V14459433', 'Maria Serrada', 1, 2, 0, 3, 2, 'Sector Los Pinos, Casa #5 Sabana Libre', '4247669621; 42473334', 'serradamaria2@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(149, '192.168.10.249', '', 'Nelson Mendoza', 1, 2, 0, 8, 2, 'Calle Eduardo Viloria, Antes De La Entrada A La Ciudadela', '4147313378', 'abogadonelzonmendoza@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(150, '192.168.10.250', 'V13461915', 'Wuendi Briceño		', 1, 1, 0, 3, 2, 'Fray Hicnacio Alvares 2 Calles Arriba De La Cancha', '04265405608', 'bzwendy0104@gmail.com\r\n', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(151, '192.168.10.251', 'V24618369', 'Irene Perez', 1, 4, 0, 3, 2, 'Sector Alto De Escuque, Casa #2 Entrada Calle Paez', '4164047630; 41220429', 'olivarirene93@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(152, '192.168.10.252', 'V14328802', 'Dessire Molina', 1, 4, 0, 3, 2, 'La Quinta Via Boqueron Diagonal Al Monasterio', '4269629748', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(153, '192.168.10.27', '12542972', 'Luis Manuel Simancas Gonzalez', 1, 5, 0, 3, 2, ' Urb. Colinas De Carmania Calle Principal Casa Nro 33', '4147595013', 'Luis_simancas@yahoo.es', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(154, '192.168.10.28', 'V17605224', 'Yizza Suarez', 1, 5, 0, 3, 2, 'Urb.Ezequiel Zamora, Terraza 7 Casa45, Parrq.Santa Rita, Mun.Escuque', '4247301971; 41259835', 'yizza147.ys@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(155, '192.168.10.29', 'V13764296', 'Francisco Daboin', 1, 5, 0, 3, 2, 'Urb.Ezequiel Zamora, Terraza 7 Casa #48 , Parq.Santa Rita, Mun.Escuque', '4247647028; 41479380', 'franciscodaboinventas@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(156, '192.168.10.31', 'V17094393', 'Oswaldo Nava', 1, 5, 0, 3, 2, 'Urb.Ezequiel Zamora, Terraza #2 Casa#11', '4147040996; 41212350', 'oswaldonava0209@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(157, '192.168.10.32', 'V19898750', 'Jonathan Jesus Debies Pacheco', 1, 5, 0, 3, 2, 'Sector Jaruma, Calle#1 Casa 42, Parrq.Santa Rita, Mun.Escuque', '4167125920', 'Jonathandebies28@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(158, '192.168.10.33', 'V23837398', 'Idaly Hernandez', 1, 5, 0, 3, 2, 'Brisas De Colinas, 1Ra Calle, Casa #2, Parrq.Santa Rita, Mun.Escuque', '4247424733; 41647728', 'cgraterol884@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(159, '192.168.10.34', 'V12046400', 'Yamibeth Morillo', 1, 5, 0, 3, 2, 'Sexta Calle Colinas De Carmania Casa 176 (Referencia Coco)', '4120605169', 'MORILLOYAMIBETH2020@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(160, '192.168.10.35', 'V5348359', 'Jose Natividad Romero Barrio', 1, 5, 0, 3, 2, 'Casa 4 Calle 116, Colinas De Carmania Parte Alta', '', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(161, '192.168.10.36', 'V12797402', 'Colbert Vergara', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania Calle 1,  Avenida 2, Casa#16', '4166608671; 41470158', 'colbertkako@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(162, '192.168.10.37', 'V9003205', 'Arnoldo Mendoza', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania, Calle2 Casa#47,', '4247415815; 41657624', 'arnoldomendoza62@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(163, '192.168.10.38', 'V26413874', 'Bibiano Amado Castro Hernandez', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania Calle 5 Casa#143', '4143762341; 41472714', 'Bibianocastro4@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(164, '192.168.10.39', 'V13523338', 'Carol Gallardo ', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Calle 5 Casa 130 ', '4247002644', 'JOSE.BENCO1@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(165, '192.168.10.41', 'V10911434', 'Julio Cesar Perdomo Romero', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania , Primera Calle Frente A Alvaro', '4265741800', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(166, '192.168.10.42', 'V12042030', 'Yaneris Lisobeida Romero Peña			\r\n', 1, 5, 0, 3, 2, 'Urb. Colinas De Carmania Primera Calle Casa Nro 11', '4247171027', 'yaneris24romero@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(168, '192.168.10.45', 'V25913137', 'Pedro Daniel Laguna Quintero', 1, 5, 0, 3, 2, 'Urb Jaruma Calle 2 Casa 08', '4168896631', 'lagunapedro513@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(169, '192.168.10.46', 'V27415960', 'Angel Odin Pacheco Alburgue', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Bodega Pin Hijo De Odin, Santa Rita, Escuque ', '4242401942', 'Castillohemerlys@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(170, '192.168.10.47', '29814164', 'Alejandro Josue Valero Laguna', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Jaruma Calle 3 Casa Nro 66', '4147114954', ' alejosue.valagu@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(171, '192.168.10.48', 'V13896646', 'Elizabeth Santos Cardoza ', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Sexta Calle Casa #52', '', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(172, '192.168.10.49', 'V10037317', 'Jose Paredes ', 1, 5, 0, 3, 2, 'Calle 2 Cas 18 Jaruma Colinas De Carmania P/B', '4126543830', 'mariangelaraujo2912@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(173, '192.168.10.5', 'V30223795', 'Marcelo Mejias', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmnia, Calle 6, Casa#178, Santa Rita, Escuque ', '4121381135; 42471801', 'danielafabiana0056@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(174, '192.168.10.50', 'V6369038', 'Jose Asuaje', 1, 5, 0, 3, 2, 'Colinas Se Carmania, Sector Renacer De Terrazas', '4143756796; 42638922', 'Jasuaje3@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(175, '192.168.10.52', 'V14799521', 'Yusmary Santos', 1, 5, 0, 3, 2, 'Sector Jaruma, Calle Principal, Casa#36, Eje Colinas De Carmania', '4247168137; 42471705', 'Yusmarisantos198@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(176, '192.168.10.53', 'V27497429', 'Keila Espinoza', 1, 5, 0, 3, 2, 'Invasion La Paca ', '4247509497, 41217260', 'KEILAESPINOZA236@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(177, '192.168.10.54', 'V4324489', 'Jose Francisco Ramirez Blanco ', 1, 5, 0, 3, 2, 'Urb.Colinas De Carmania, Calle 1 Con Av Principal, Casa #28(Escquina) ', '4163780607; 41474226', 'josefranciscoramirez489@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(178, '192.168.10.56', 'V13996642', 'Gabriel Torres', 1, 5, 0, 3, 2, 'Quevedo Via Principal Mas Arriba De La Escuela De Quevedo', '4165925795, 42637143', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(179, '192.168.10.57', 'V10037101', 'Judith Salas Molina', 1, 5, 0, 3, 2, 'Colinas De Carmania Calle 4 Casa 139', '4247585718', 'JUDITH10@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(180, '192.168.10.58', 'V28206093', 'Yorgelis Araujo', 1, 5, 0, 3, 2, 'Sector Jaruma Casa 30 Colinas De Carmania', '4126464181', 'YORGEVITORIA2002@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(181, '192.168.10.59', 'V17391336', 'Jose Rodrigo Sulbaran Viloria', 1, 5, 0, 3, 2, 'La Mat A Via Conucos La Paz', '4247239146', 'JOSERSULBARAN01@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(182, '192.168.10.60', 'V18348510', 'Emily Nataly Briceño', 1, 5, 0, 3, 2, 'Colinas De Carmania Av Principal Casa 97', '4147050521', 'EMMILYBRI38@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(183, '192.168.10.61', 'V27070310', 'Mariangelly Dayana Peñaloza Urbina', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania Calle 3, Santa Rita ', '4120644302', ' mariangellydpu5@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(184, '192.168.10.62', 'V19794617', 'Ingrid Cancilleri', 1, 5, 0, 3, 2, 'Av Principal Hugo Chavez Casa S/N', '4247425838, 42640518', 'S/2801982@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(185, '192.168.10.63', 'V4323574', 'Ramon Moreno', 1, 5, 0, 3, 2, 'La Mata Parte Alta Via Quevedo', '4247442128', 'RAMMORENOLAMATA@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(186, '192.168.10.64', 'V16597633', 'Yelitza Vazquez', 1, 5, 0, 3, 2, 'Sector Jaruma 1Ra Calle Casa Nñ 29', '4247441420', 'BARRIOSRUBEY9@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(187, '192.168.10.65', 'V20038318', 'Roybel Andrea Vieras Paredes', 1, 5, 0, 3, 2, 'La Mata Av Principal Frente Al Parque', '4247677105, 42479236', ' andrea.royvieras@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(188, '192.168.10.66', 'V11897089', 'Edilberto Oviedo', 1, 5, 0, 3, 2, 'Sector Quevedo La Escondida', '4247587303', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(189, '192.168.10.68', 'V19899716', 'Karina Gonzalez', 1, 5, 0, 3, 2, 'Sector Hugo Chavez Vereda A5', '4269907105', 'KARINPARA.28@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(190, '192.168.10.69', 'V23594365', 'Aliesmar Moreno', 1, 5, 0, 3, 2, 'Urbanizacion Colinas De Carmania Sector Jaruma Casa Nñ28', '4247347423, 42475637', 'ALIESMARMORENO92@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(191, '192.168.10.70', 'V9174138', 'Diomedes Salvador Barrios Ortega', 1, 5, 0, 3, 2, 'Urb Ezequiel Zamora Casa 22 Terra 4', '4140793530', ' diomedessalvador@hotmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(192, '192.168.10.71', 'V18493758', 'Nahudth Zared Pombilio Baez', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Parte Alta, Calle 5 Casa 131(Al Lado Dela Escuela)', '04247375740 - 042473', 'Zarpombilio@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(193, '192.168.10.72', 'V9324111', 'Eleazar Segundo Vasquez Salas(Chalo La Mata) ', 1, 5, 0, 3, 2, 'Av Principal La Mata Frente A Arturo', '4147013952', 'CHALO0205@HOTMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(194, '192.168.10.74', 'V23781347', 'Maria Teresa Provenali', 1, 5, 0, 3, 2, 'Via Principal Quevedo Casa S/N', '4262687404', 'TERESAPROVENZALIGMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(195, '192.168.10.75', 'V28206310', 'David Puche ', 1, 5, 0, 3, 2, 'Urb. Colinas De Carmania Calle Principal Casa A 4 Sector Terrazas De Colinas', '4247517928, 42626894', 'PUCHEDAVIDALEJANDRO@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(196, '192.168.10.77', 'V29739367', 'Daniela Hernandez', 1, 5, 0, 3, 2, 'La Mata Calle Zuruma Casa Sin Numero ', '4141772569, 42473355', 'HERNDJHV@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(197, '192.168.10.78', 'V25919673', 'Carmen Araujo', 1, 5, 0, 3, 2, 'Quevedo Parte Alta Los Pinos', '4147432148', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(198, '192.168.10.79', 'V5755165', 'Maria Romero', 1, 4, 0, 3, 2, 'Final Del Sector Las Rurales Del Alto', '4269895392', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(199, '192.168.10.80', 'V17585378', 'Karina Martinez', 1, 5, 0, 3, 2, 'Urb Las Dalias, Casa #8 La Mata, Pq Santa Rita, Mun Escuque ', '4263745564', 'jeremiasyjerenith@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(200, '192.168.10.81', 'V26036448', 'Yeliana Uzcategui ', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania Calle 5 Casa S-N, Pq Santa Rita, Mun Escuque ', '426201210', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(201, '192.168.10.83', 'V11324828', 'Hilda Paredes', 1, 5, 0, 3, 2, 'Sector La Mata, Calle Las Dalias Casa#177 Parrq.Santa Rita, Mun.Escuque', '4167216291; 42474358', 'airportkc@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(202, '192.168.10.84', 'V11324182', 'Julio Abreu (Centro Educativo Antonio Perez Carmona) ', 1, 5, 0, 8, 2, 'Av. Principal Sector Colinas Se Carmania, Santa Rita, Escuque', '4264343929', 'ESCUELAANTONIOPEREZCARMONA2015@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(203, '192.168.10.85', 'V11318147', 'Ana Victoria Peña Pirela', 1, 5, 0, 3, 2, 'Urb. Colinas De Carmania Calle 2 Casa Nro 37', '4260601768/424757344', 'penaana04.73@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(204, '192.168.10.86', 'V17391281', 'Jose Clemente Viloria ', 1, 5, 0, 3, 2, 'ñ', '4149709123; 42470155', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(205, '192.168.10.87', 'V18349837', 'Diana Carolina Briceño', 1, 5, 0, 3, 2, 'Quevedo Mas Arriba De La Escuela, Via Principal, Pq Santa Rita, Mun Escuque', '4247210962; 4247585502', NULL, '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(206, '192.168.10.88', 'V11652810', 'Jorge Salas ', 1, 5, 0, 3, 2, 'La Mata Casa #17, Calle Principal, Mun Escuque, Pq Santa Rita ', '4267567005', 'JLSG-PIOLIN1972@HOTMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(207, '192.168.10.89', 'V16533979', 'Rosangela Abreu ', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Casa S-N, 3Era Calle, Pq Santa Rita, Mun Escuque ', '412655086; 426486862', 'ABREUROSANGELA07@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(208, '192.168.10.90', 'V17393439', 'Maryuri Valero ', 1, 5, 0, 3, 2, 'Urb Hugo Chavez, Pq Santa Rita, Mun Escuque ', '4247302829', 'MARYURIVALERO8@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(209, '192.168.10.91', 'V16377736', 'Cesar Augusto Soler ', 1, 5, 0, 3, 2, 'Quevedo, Finca La Esperanza Pq Santa Rita, Mun Escuque ', '4247141847', 'CESAR128333@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(210, '192.168.10.92', 'V26311727', 'Maria Virginia Carrizo Monsalve ', 1, 5, 0, 3, 2, 'Eje Colinas De Carmania, Indio Jaruma, Calle 3 Casa #70', '4267202391; 41627234', 'MARIAVCARRIZO48@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(211, '192.168.10.94', 'V', 'Orlando Briceño ', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Calle 4 Casa #86', '4260601768', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(212, '192.168.10.95', 'V26123383', 'Andres Valero ', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Calle 1 Casa #04 ', '4147529007', 'VALEROANDRES1996@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(213, '192.168.10.96', 'V11615905', 'Ana Julia Fernandez Osuna', 1, 5, 0, 3, 2, 'Calle Principal Casa Numero 25', '4147030974/416472838', 'Anaf29144@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(214, '192.168.10.97', 'V13765729', 'Katherine De Blanco', 1, 5, 0, 3, 2, 'La Mata  Al Lado De La Prefectura Casa #112', '4247167591; 41657530', 'BETVI.16@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(215, '192.168.10.99', 'V18801200', 'Dubraska Garcia ', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania 5Ta Calle, Casa #138', '4147425198', 'DUBRASKAGARCIABASTIDAS@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(216, '192.168.100.10', 'V12541706', 'Feliz Viloria', 1, 1, 0, 3, 2, 'Sector La Garita, Calle San Jose', '4247108327; 41680462', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(217, '192.168.100.100', 'V28261448', 'Franyelis Alejandra Gonzales Mendes', 1, 1, 0, 3, 2, 'La Garita Via Principal ', '4124756609', 'gonzalezfrasnye18@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(218, '192.168.100.102', 'V9168887', 'Eunices Vielma', 1, 5, 0, 3, 2, 'La Mata Sector El Terreno', '4165776598', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(219, '192.168.100.103', 'V17265714', 'Maria Alejandra Duarte', 1, 2, 0, 3, 2, 'Callejon Cruz De La Mision', '4247037035', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(220, '192.168.100.104', 'V19643296', 'Maryuri Alejandra Nuñez Araujo', 1, 2, 0, 3, 2, 'Urb Vista Hermosa Segunda Etapa, Casa M41', '4247303543', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(221, '192.168.100.105', 'V27415575', 'Rainibeth Oreyana', 1, 2, 0, 3, 2, 'Sector San Benito Frente A La Casa Comunal ', '4267530591', 'pinguilos90@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(222, '192.168.100.106', 'V16534734', 'Neyra Perez', 1, 2, 0, 3, 2, 'Calle Bolivar  Los Canaletes Arriba Del Palon', '4247623917', 'lidjamitzaperezrivera@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(223, '192.168.100.108', 'V14982467', 'Nakary Gonzalez ', 1, 1, 0, 3, 2, 'Sector La Garita, Via Principal Casa S/N 1Cuadra Mas Abajo De La Escuela', '4129301342', 'gonzaleznakary84@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(224, '192.168.100.11', 'V27497086', 'Nelson Abraham Viloria Tejera', 1, 5, 0, 3, 2, 'La Mata Sector Las Dalias', '4247248879', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(225, '192.168.100.110', 'V27512231', 'Ronald Mendoza', 1, 1, 0, 3, 2, 'Sector Valle Alto Segunda Calle  Casa 061', '4147525219', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(226, '192.168.100.111', 'V15825130', 'Yusmary Araujo', 1, 4, 0, 3, 2, 'Via Principal Las Casitas  Sector El Alto De Escuque', '4261223685', 'araujoyusmary411@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(227, '192.168.100.112', 'V25374130', 'Luzmary Coromoto Carrillo Montilla ', 1, 4, 0, 3, 2, 'Sector Divino Niño El Alto De Escuque ', '4267653210', 'OLEGARIO12047@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(228, '192.168.100.113', 'V9167820', 'Zenic Rangel', 1, 4, 0, 3, 2, 'Sector La Bomba ', '4247184164', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(229, '192.168.100.114', 'V16377625', 'Norma Balza', 1, 4, 0, 3, 2, 'El Alto Frente Ala Panaderia Casa N3', '4167136531', 'Fermindesantiago30@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(230, '192.168.100.115', 'V30976428', 'Enrique Lamus', 1, 1, 0, 3, 2, 'La Garita Parte Alta  Antes Del Tanque', '4247238468', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(231, '192.168.100.116', 'V7976782', 'Victor Naranjo', 1, 4, 0, 3, 2, 'El Alto Via  Principal  Antes De La Cruz', '4168667860', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(232, '192.168.100.117', 'V200329112', 'Linda Lorena Abreu Salas ', 1, 4, 0, 3, 2, 'Calle Principal El Boqueron, Despues De La Alcantarilla ', '4147304023', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(233, '192.168.100.118', 'V11897877', 'Mary Guerrero', 1, 5, 0, 3, 2, 'Quevedo Cerca Del Centro Turistico Abandonado ', '4264016236', 'pilarguerrero2018@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(234, '192.168.100.119', 'V19285117', 'Jesus Alberto Albarran Daboin', 1, 4, 0, 3, 2, 'Boqueron, Calle Principal Casa Nro A-21', '4263263954', 'Jesusalbarran7@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(235, '192.168.100.12', '', 'Yonathan Miranda Corro Castro', 1, 4, 0, 3, 2, 'Sector La Quinta, Diagonal A Skarly', '4121244029', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(236, '192.168.100.120', 'V9166489', 'Marisol Villegas De Diaz', 1, 4, 0, 3, 2, 'Sector El Boqueron Via Al Taladro', '4149724192', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(237, '192.168.100.121', 'V12044416', 'Jose Guedez', 1, 2, 0, 3, 2, 'Sector El Coroso Via Principal Al Lado Del Doctor', '4167144698', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(238, '192.168.100.122', 'V9320976', 'Mary Palomares', 1, 2, 0, 3, 2, 'El Corosito Al Lado De La Cruz', '4242391170', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(239, '192.168.100.123', 'V5762970', 'Amilcar Ramon Abreu Viloria', 1, 4, 0, 3, 2, 'El Boqueron Via Principal Donde La Sra Flora Viloria', '4143711280', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(240, '192.168.100.124', 'V18349255', 'Marianela Rosa Briceño Gonzalez', 1, 4, 0, 3, 2, 'El Boqueron Av Principal Quinquinillo', '4167710601', 'laconchitadeoro@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(241, '192.168.100.125', 'V20039112', 'Daniel Hernandez ', 1, 4, 0, 3, 2, 'Av Principal El Boqueron, Antes De La Alcantarilla', '4147304023', 'Lindalorena_415@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(242, '192.168.100.127', 'V9010493', 'Nestor Guillen', 1, 4, 0, 3, 2, 'Sector  Campo Rico Via El Alto Abajo De El Hotel Villa Vicencio', '4247246108', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(243, '192.168.100.128', 'V4657738', 'Dora Alicia Matos ', 1, 4, 0, 3, 2, 'La Laguneta Av. Principal Frente Hotel Villa Vicencio', '4147244038', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(244, '192.168.100.129', 'V25173024', 'Anakarina Gonzalez', 1, 1, 0, 3, 2, 'Calle Minerva Sector La Garita Casa S/N Escuque', '4125768278', 'anakarinadelvallecrespo@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(245, '192.168.100.13', 'V21634902', 'Soraida Matheus', 1, 1, 0, 3, 2, 'Sector Valle Alto, Casa #75, Escuque', '4127566773', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(246, '192.168.100.130', 'V25006958', 'Yahaira Torres', 1, 1, 0, 3, 2, 'La Garita Parte Alta', '4161615538', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(247, '192.168.100.131', 'V17865186', 'Jhonny David Andrade', 1, 1, 0, 3, 2, 'La Garita Parte Alta Calle Los Apostoles Casa Sn', '4267746004', 'nakaribarrios@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(248, '192.168.100.132', 'V13825137', 'Pedro Briceño			\r\n', 1, 4, 0, 3, 2, 'El Alto A Media Cuadra De La Casa Del Partido Psuv', '04263800737', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO');
INSERT INTO `contratos` (`id`, `ip`, `cedula`, `nombre_completo`, `id_municipio`, `id_parroquia`, `id_comunidad`, `id_plan`, `id_vendedor`, `direccion`, `telefono`, `correo`, `fecha_instalacion`, `ident_caja_nap`, `puerto_nap`, `num_presinto_odn`, `id_olt`, `id_pon`, `estado`) VALUES
(249, '192.168.100.133', 'V19101946', 'Elsy Marino', 1, 1, 0, 3, 2, 'Ambulatorio La Mata', '4247764194', 'elsymarino64@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(250, '192.168.100.134', 'V220040598', 'Engelts Francisco Garcia', 1, 4, 0, 3, 2, 'El Alto Sector La Laguneta Finca Canelon', '4129699258', 'Garciaenyer@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(251, '192.168.100.135', 'V8053048', 'Pedro Palencia', 1, 5, 0, 3, 2, 'Colinas De Carmania Finan De La Tercera Calle Casa N80', '4263796062', 'pedroramon5824@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(252, '192.168.100.136', 'V15709637', 'Ruben Valera', 1, 1, 0, 3, 2, 'Puerto Escondido Parte Alta Sector El Chalet  ', '4121758262', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(253, '192.168.100.137', 'V12046373', 'Jesus Alberto  Mendoza Montilla ', 1, 1, 0, 3, 2, 'Sector La Garita Parte Baja Calle Venezuela', '4247033663', 'mendosajesusalberto89@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(254, '192.168.100.139', 'V10813933', 'Margarita Salazar', 1, 2, 0, 3, 2, 'Sabana Libre Final Calle San Agustin', '4247195453', 'margaritasalazar30@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(255, '192.168.100.14', 'V16739791', 'Yohan Jose Andara Briceño			\r\n', 1, 1, 0, 3, 2, 'Sector Puerto Escondido, Vereda Niño Jesus', '4160499448', 'andaraj2566@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(256, '192.168.100.140', 'V26036268', 'Mayerlin Araujo', 1, 1, 0, 3, 2, 'Calle Principal La Garita Parte Alta  Abajo De La Cancha', '4247323529', 'mayerlynaraujo20@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(257, '192.168.100.141', 'V15825389', 'Carolina Cardozo', 1, 1, 0, 3, 2, 'La Garita Calle Minerval', '4121759743', 'eesjc1981@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(258, '192.168.100.142', 'V26036485', 'Maria Luisa Plaza Valecillos', 1, 4, 0, 3, 2, 'Boqueron Mas Abajo De Marianela', '4164592839', 'boqueron2323@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(259, '192.168.100.143', 'E84602146', 'Jeronimo Aparicio Comellas', 1, 4, 0, 3, 2, 'El Boqueron Sector El Taladro', '4128995777', 'JACC_054@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(260, '192.168.100.144', 'V12042424', 'Wendy Olivar', 1, 4, 0, 3, 2, 'Sector San Benito, Casa #27 Alto De Escuque', '4261227278', 'Guerreroluciany07@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(261, '192.168.100.145', 'V11392407', 'Wendi Coromoto Ramirez', 1, 1, 0, 3, 2, 'Sector La Garita Casa S/N Diagonal Al Sr Dilimo', '4121240058', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(262, '192.168.100.146', 'V5496261', 'Jose Usechas', 1, 4, 0, 3, 2, 'Alto De Escuque Sector La Bomba', '4147175550', 'joseusechasleal22@gamil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(263, '192.168.100.147', 'V10427925', 'Andres Guillermo Alizo Valero', 1, 4, 0, 3, 2, 'Casa Blanca Frente Al Ambulatorio Sector El Boqueron', '4141670077', 'andresalizo@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(264, '192.168.100.148', ' V10397086', 'Luis Duran', 1, 4, 0, 3, 2, 'El Alto Calle Santa Rosalia', '4163419617', 'gativilla2525@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(265, '192.168.100.149', 'V23838279', 'Eliezer Pineda', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Calle #2 Casa #35', '4247386603', 'ELPINEDA23A@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(266, '192.168.100.15', 'V14825553', 'Maricela Otrilla', 1, 1, 0, 3, 2, 'Sector Puerto Escondido, Casa #27', '4246034080; 42621211', 'paulimarihernandez@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(267, '192.168.100.150', 'V13049948', 'Lisbeth Valero', 1, 4, 0, 3, 2, 'Sector Las Rurales Del Alto, Casa N32-50', '4247030702', 'LISBETVALERO30@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(268, '192.168.100.151', 'V4326575', 'Maruja De Escalante', 1, 4, 0, 3, 2, 'El Alto Frente A La Plaza Casa 11', '4165298346', 'rafaelescant@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(269, '192.168.100.152', 'V7470134', 'Mercedes Medina', 1, 1, 0, 3, 2, 'Puerto Escondido Por Los Chalet', '4123559901', 'luis545466@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(270, '192.168.100.153', 'V9313011', 'Jose Miguel Mendoza Vazquez', 1, 2, 0, 3, 2, 'Calle Pueblo Nuevo, Sabana Libre', '4247819252', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(271, '192.168.100.154', 'V9169287', 'Fany Suarez', 1, 2, 0, 3, 2, 'Calle Pueblo Nuevo Mas Abajo Del Hotel La Nona', '4162969096', 'patriciaveronica532@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(272, '192.168.100.155', 'V25473102', 'Jose Gregorio Leon Vargas', 1, 4, 0, 3, 2, 'La Laguneta Frente Al Cementerio', '4164124762', 'josegregorioleonvargas@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(273, '192.168.100.156', 'V15953468', 'Liliana Carolina Pacheco Valero (Restaurant. Manamanas Rellenas)', 1, 4, 0, 3, 2, 'Calle Principal El Boqueron Las Famosas Manamanas Sector La Candelaria', '4247146325', 'pachecovalerolilianacarolina2@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(274, '192.168.100.157', 'V24881180', 'Dimauri Robles', 1, 5, 0, 3, 2, 'Jaruma Calle1 Casa Sn', '4147385181', 'roblesdimauris79@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(275, '192.168.100.158', 'V20798958', 'Luisandis Beatriz Brett Viloria', 1, 4, 0, 3, 2, 'El Boqueron Sector La Candelaria Casa S//N', '4269582468', 'Pendiente', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(276, '192.168.100.159', 'V10395931', 'Nilsy Briceño ', 2, 3, 0, 3, 2, 'San Juan De Isnotu, Y Sector Las Rurales, Casa S/N, Una Cuadra Mas Abajo De La Via Principal, Casa Esquina Color Blanco', '4247473002', 'nilsicoromoto@hotmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(277, '192.168.100.16', 'V30379848', 'Digmaris Garcia', 1, 1, 0, 3, 2, 'Sector Puerto Escondido, Casa S/N ', '4247479674', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(278, '192.168.100.160', 'V21365817', 'Emigdio Alfonso Marquez Añez', 1, 1, 0, 3, 2, 'Sector El Pepo Frente De Anderson Angulo', '4265434341', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(279, '192.168.100.161', 'V23593603', 'Luis Miguel Villarreal Peña', 2, 3, 0, 3, 2, 'Las Rurales Viejas San Juan Cerca De Juan Méndez', '4247753812	', 'Luismvp2902@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(280, '192.168.100.162', 'V9318041', 'Aura Filomena Viloria De Colmenares', 2, 3, 0, 3, 2, 'San Juan De Isnotu Casa S/N Al Lado De La Plaza', '4147319987', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(281, '192.168.100.164', 'V 11316959-8', 'Yecenia Coromoto Mendez Castro', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Proncipal A Una Casa De La Casilla Principal ', '4147156793', 'Yeseniamendez11316959@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(282, '192.168.100.165', 'V 21592191-1', 'Marcos Enrique Peña Perez', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Principal', '4247581336', 'Paolecol@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(283, '192.168.100.166', 'V 9007646-5', 'Nima Nava De Castro', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Proncipal 5 Casas De La Escuela', '4147522097', 'Toroluispedevaltrujillo@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(284, '192.168.100.167', 'V17864569-9', 'Andrea Coromoto Castro Briceño', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Los Faroles Deagonal Ala Loteria De Animalitos ', '04147303760', 'Andrea.29CB@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(285, '192.168.100.168', 'V 25832365', 'Samuel Jose Gonzalez Mejia', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Los Faroles Casa Sin Numero Loto Kamus Loteria', '4247073467', 'SJGMSAMUEL@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(286, '192.168.100.169', 'V21367598', 'Ana Bencomo', 1, 1, 0, 3, 2, 'Sector Valle Alto Vereda 2 Al Final', '4147201167', 'bencomo_anai@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(287, '192.168.100.17', 'V13048237', 'Jose Raul Gonzalez', 1, 1, 0, 3, 2, 'Sector La Garita, Calle Principal Casa S/N', '4266753428; 41222899', 'Raul77kamila07@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(288, '192.168.100.170', 'V9166605', 'Nolly Araujo', 1, 2, 0, 3, 2, 'Final Calle Comercio Diagonal Grupo Escolar', '4149777239', 'nollyalzate4@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(289, '192.168.100.171', 'V21365251', 'Marbelys Palomares (Ambulatorio Sabana Libre)', 1, 2, 0, 4, 2, 'Calle Grupo Escolar Al Frente Del Parque Ambulatorio Sabana Libre', '4267717721', 'estebanbastidas7@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(290, '192.168.100.172', 'V9176626', 'Jose Ernesto Rojas Pavon', 1, 2, 0, 3, 2, 'Vista Hermosa Casa A19', '04140811213; 0412095', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(291, '192.168.100.173', 'V9495424', 'Maria Gregoria Rangel', 1, 1, 0, 3, 2, 'Juan Diaz Via Principal  Asia El Alto', '4247468816', 'marigre651@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(292, '192.168.100.174', 'V13996308', 'Lucila Olivar', 1, 4, 0, 3, 2, 'Sector Las Casitas Via El Alto Frente Ala Señora Mary Pajaro', '4263750550', 'Lucilaolivar56@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(293, '192.168.100.175', 'V15294229', 'Lucila Olivar', 1, 4, 0, 3, 2, 'El Alto De Escuque Final Calle Santa Rosalia ', '4261713152', 'maricarorojas@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(294, '192.168.100.176', 'V19832773', 'Daysi Andara', 1, 1, 0, 3, 2, 'La Garita Parte Alta  Diagonal A Duber ', '4127137503', 'reyesgrachi01@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(295, '192.168.100.177', 'V3467835', 'Evalu Morales De Garcia', 1, 4, 0, 3, 2, 'Residencias Don Poncho Los Townhouse Sector La Quinta', '4120714095', 'evalunamorales3@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(296, '192.168.100.178', 'V14598062', 'Emily Cano ', 1, 1, 0, 3, 2, 'Sector La Garita, Casa Dos Piedras', '4247696835', 'EMILYTACANO@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(297, '192.168.100.179', 'V5763120', 'Soralba Fernandez', 1, 4, 0, 3, 2, 'El Alto Calle Independencia Casa #9', '4261709320', 'nelvitafernandez@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(298, '192.168.100.18', 'V9170221', 'Eder Cardozo', 1, 1, 0, 3, 2, 'Sector La Garita Parte Baja, Callejon San Jose, Casa S/N', '4247592035', 'Edder1996eli@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(299, '192.168.100.180', 'V16405811', 'Johanna Celis', 1, 1, 0, 3, 2, 'Sector La Constituyente, Calle Primero De Mayo, Kiosko Rojo Casa S-N', '4243130242', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(300, '192.168.100.181', 'V25173047', 'David Garcia ', 1, 1, 0, 3, 2, 'Sector La Constituyente Final De Calle Principal Casa S/N ', '4267115595', 'Regalitovenezuela@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(301, '192.168.100.182', 'V9397187', 'Tibisay Briceño (Servicios Publicos Sabana Libre)', 1, 2, 0, 8, 2, 'Servicios Publicos Sabana Libre, Frente A La Policia ', '4264578919', 'tibilabrujita1@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(302, '192.168.100.183', 'V20038409', 'Cesar Briceño', 1, 1, 0, 3, 2, 'Sector La Garita Parte Alta, Masa Abajo De La Escuela, Casa S-N', '4160569182', 'PSUVESCUQUE@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(303, '192.168.100.184', 'V5791533', 'Yolanda Cesilia Mendez', 1, 4, 0, 3, 2, 'El Alto Via Boqueron  En La Bodega Diagonal A Escarli', '4247119321', 'ceciliamenyalismarsgl3@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(304, '192.168.100.185', 'V17028928', 'Danilo Guerra', 1, 5, 0, 3, 2, 'Urbanizacion Jaruma Calle 1', '4121302334', 'guerra0288@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(305, '192.168.100.186', 'V19103596', 'Daniel Moreno', 1, 4, 0, 3, 2, 'Boqueron, Sector El Quiquinillo', '04264521947; 0416156', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(306, '192.168.100.187', 'V16740663', 'Miguel Brillembourg', 1, 4, 0, 3, 2, 'El Alto Via Sabana Libre Sector La Laguneta Calle La Capilla', '4247592950', 'migue.brillem@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(307, '192.168.100.188', 'V27512381', 'Jonny Javier Sanches Martinez', 1, 1, 0, 3, 2, 'Sector La Garita 2Casas Mas Arriba De La Escula Andres Bello', '4161395669', 'jonny2019martinez@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(308, '192.168.100.189', 'V13765376', 'Adela Montilla ', 1, 1, 0, 3, 2, 'Tierra De Nubes Vereda 2 Casa #30', '4262551558', 'enrriquejose@petalmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(309, '192.168.100.19', 'V14928118', 'Arlenys Abreu', 1, 4, 0, 3, 2, 'Sector Alto De Escuque Final Calle Paez', '4122036749', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(310, '192.168.100.190', 'V14150825', 'Maria Dalia Linares Olivar', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania, Calle 5 Casa 129', '04166748798/04247167', 'dalialinares114@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(311, '192.168.100.191', 'V13633085', 'Marisela Montilla', 1, 1, 0, 3, 2, 'Juan Diaz Via Principal, Despues De Puente Cabrita ', '4247153971', 'leomary102210@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(312, '192.168.100.192', 'V22624556', 'Estefany Parra ', 1, 4, 0, 3, 2, 'El Alto Sector La Bomba ', '4264628249', 'estefaaany1992@gmail.con', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(313, '192.168.100.193', 'V4016104', 'Alfredo Leon', 1, 4, 0, 3, 2, 'El Alto Sector La Laguneta Frente A La Entrada De Las Monjitas', '4146146059', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(314, '192.168.100.194', 'V15320848', 'Jose Gregorio Salinas Fernandez', 1, 2, 0, 3, 2, 'Calle San Agustin Con Calle Grupo Escolar, Casa #3', '4120206495', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(315, '192.168.100.195', 'V17094164', 'Maria Cardozo ', 1, 1, 0, 3, 2, 'Bcm', '4247595817', 'JOSMARYSANCHEZ22@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(316, '192.168.100.196', 'V4665755', 'Cristobal Molina', 1, 5, 0, 3, 2, 'La Mata, Calle Las Dalias, Taller De Alfredo ', '4161769042', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(317, '192.168.100.197', 'V30116042', 'Andres Bravo', 1, 4, 0, 3, 2, 'El Boqueron Frente Al Doctor Alizo', '4160722471', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(318, '192.168.100.198', 'V18456139', 'Alfonso Hernandez', 1, 4, 0, 3, 2, 'Sector La Candelaria, El Boqueron, Casa S/N', '4165617831; 41660416', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(319, '192.168.100.199', 'V10032702', 'Gladis Gonzalez', 1, 1, 0, 3, 2, 'Juan Diaz, Antes De Puente Cabrita ', '4247621223', 'gonzalezkatherin946@mail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(320, '192.168.100.20', 'V29994245', 'Aurelis Uzcategui', 1, 1, 0, 3, 2, 'Calle Principal De La Garita, Casa S/N', '4147353911; 42472746', 'ayulyef123@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(321, '192.168.100.200', 'V30048283', 'Daniel Araujo', 1, 1, 0, 3, 2, 'Puerto Escondido Escuque', '4261569575', 'Da2706177@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(322, '192.168.100.201', 'V19285369', 'Pedro Hernandez', 1, 1, 0, 3, 2, 'Sector Puerto Escondido Frente A Milito', '4247212823', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(323, '192.168.100.202', 'V15825658', 'Karelis Valera', 1, 5, 0, 3, 2, 'La Mata Calle Santa Rita A Dos Casas Del Parque', '4247139201', 'karelisvalera027@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(324, '192.168.100.203', 'V17391920', 'Leonardo Abreu', 1, 2, 0, 3, 2, 'Sector Corocito Via Baño De Motatan', '4124738432', 'marisoliparra05@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(325, '192.168.100.204', 'V4741679', 'Jorge Teran ', 1, 4, 0, 3, 2, 'Sector Alto De Escuque, Calle Santa Rosalia', '4146407188', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(326, '192.168.100.205', 'V13461576', 'Noris Villegas', 1, 4, 0, 3, 2, 'El Boqueron Sector Santa Barbara', '4262251154', '-', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(327, '192.168.100.206', 'V13897108', 'Lisbeth Bracamonte', 1, 2, 0, 3, 2, 'Sector Los Pinos Parte Alta', '4164027059', 'bracamontelisbeth689@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(328, '192.168.100.207', 'V22892332', 'Nakary Gabriela Olivar Briceño(Luisana Segovia)', 1, 5, 0, 3, 2, 'Sector Los Conucos De La Paz Parte Alta', '4247122661', 'luisanasegovia929@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(329, '192.168.100.208', 'V21365482', 'Engelber Bastidas', 1, 5, 0, 3, 2, 'Conucos De La Paz   En La Curva De La Cruz', '4149727912', 'dayibethalbarran7@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(330, '192.168.100.209', 'V27497229', 'Maury Jimenez', 1, 5, 0, 3, 2, 'Calle Araguaney Final De Calle ', '4120670072', 'maurisjimenez19@gmai.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(331, '192.168.100.21', 'V15589303', 'Lismary Justo', 1, 1, 0, 3, 2, 'Sector La Garita, Casa S/N Via Principal Diagonal Proteccion Civil', '4121428877', 'Jlismary7@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(332, '192.168.100.210', 'V27268026', 'Joanny Alfredo Suarez', 1, 5, 0, 3, 2, 'Bcm', '4149726813', 'alfredogato720@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(333, '192.168.100.211', 'V18095196', 'Gabriela Carolina Segovia Gutierrez', 1, 5, 0, 3, 2, 'Conucos De La Paz Sector Araguaney', '4140367173', 'gsgliz25@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(334, '192.168.100.212', 'V12046787', 'Maria Josefina Torrealba Viloria ', 1, 4, 0, 3, 2, 'El Boqueron', '4269645505', 'TORREALBAV.MJ787@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(335, '192.168.100.213', 'V19644175', 'Dairin Rosa Santiago', 1, 1, 0, 3, 2, 'Conucos De La Paz Detras De La Capilla', '4262202384', 'dairinsantiago@gmai.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(336, '192.168.100.214', 'V32616347', 'Marcos Enrrique Fernandez', 1, 5, 0, 3, 2, ' Calle San Cipriano Al Final  ', '4247719968', 'Simancas.audimoran79@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(337, '192.168.100.215', 'V10399644', 'Nay Muchacho', 1, 5, 0, 3, 2, 'Conucos, Sector Valle Alto, Via La Mata, En Frente De La Sra Marcelina', '4147526890; 42477411', 'nay68muchacho@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(338, '192.168.100.216', 'V11322402', 'Maria Marcelina Barrios ', 1, 5, 0, 3, 2, 'Conucos De La Paz Casa S-N Al Lado Del Tanque', '4246962841', 'BARRIOSMARCELINA@GMAIL.COM ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(339, '192.168.100.217', 'V20134113', 'Yoselin Carrillo', 1, 5, 0, 3, 2, 'Conucos De La Paz, Parte Alta, Segundo Tanque, Taller De Motos ', '4247225704; 42475704', 'CARILLOYOSELIN215@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(340, '192.168.100.218', 'V21367597', 'Jose Alexander Abreu Materan', 1, 5, 0, 3, 2, 'La Mata Calle Las Dalias Casa 169 Via Quevedo', '4120314989', 'josesocial18@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(341, '192.168.100.219', 'V9329558', 'Maria Luisa Vargas De Barrios', 1, 5, 0, 3, 2, 'Conucos Parte Alta', '4266643741', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(342, '192.168.100.22', 'V27415961', 'Emir Abreu', 1, 5, 0, 3, 2, 'Sector El Terreno, Casa S/N Diagonal A Pulpo', '4267763045', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(343, '192.168.100.220', 'V14800991', 'Nelly Patricia Vivas', 1, 5, 0, 3, 2, 'Conucos De La Paz Parte Alta', '4143757180', 'nellynestor2012@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(344, '192.168.100.221', 'V4657363', 'Jose Martin', 1, 5, 0, 3, 2, 'Conucos Parte Alta', '4143181537', 'rrdani79@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(345, '192.168.100.222', 'V10912736', 'Maribel Mendez', 1, 1, 0, 3, 2, 'Valle Alto Casa14', '4266027072', 'maribelmendez_16@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(346, '192.168.100.223', 'V12797833', 'Susy Cardozo', 1, 5, 0, 3, 2, 'Conucos De La Paz Calle Simon Rodriguez Frente A Casa De Piedra', '4120643875', 'Susycardozo29@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(347, '192.168.100.224', 'V27022005', 'Yonatan Paredes', 1, 5, 0, 3, 2, ' Conucos De La Paz  Calle  Serca Del Cafecero', '4247173305', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(348, '192.168.100.225', 'V27628513', 'Alberto Diaz', 1, 5, 0, 3, 2, 'Conucos Parte Alta', '4247180891', 'adanelysdiaz2024@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(349, '192.168.100.226', 'V16882168', 'Jose Verde', 1, 5, 0, 3, 2, 'Conucos Parte Alta Calle Esquivel Zamora', '4262900110', 'joseverde016@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(350, '192.168.100.227', 'V30671314', 'Yorgeny Paul Barrueta', 1, 5, 0, 3, 2, ' Conucos Parte Alta Calle  Cipriano', '4247101851', 'vieraselizabeth454@gmailcom', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(351, '192.168.100.228', 'V28096115', 'Leonel Barrios', 1, 5, 0, 3, 2, 'Conucos De La Paz Parte Alta Abajo Taller De Motos', '4127889275', '26leonel.barr@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(352, '192.168.100.229', 'V25173405', 'Pedro Briceño', 1, 2, 0, 3, 2, 'Calle Comercio  Local Delicias Al Horno Al Lado De La Farmacia', '04143763243', 'idibismariahe@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(353, '192.168.100.23', 'V6229664', 'Yamily Graterol', 1, 5, 0, 3, 2, 'Calle Principal Callejon San Benito, Casa S/N', '4247645495', 'Yamilygraterol0@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(354, '192.168.100.230', 'V17392075', 'Maira Rivas', 1, 1, 0, 3, 2, 'La Garita', '4120114653', 'rivasmaire212@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(355, '192.168.100.231', 'V14928625', 'Belkis Gonzalez', 1, 4, 0, 3, 2, 'Alto De Escuque Via Quevedo Las Rurales Del Alto', '4247022685', 'galindezalejandra650@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(356, '192.168.100.232', 'V13070948', 'Yenny Leidy Gutierrez Crespo', 1, 2, 0, 3, 2, 'Sabana Libre Vista  Calle Principal 2 Etapa Casa K12', '4262110117', 'yennygutierrez451', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(357, '192.168.100.233', 'V25485059', 'Eriana Coronado', 1, 2, 0, 3, 2, ' Sabana Libre Calle  Calle Grupo Escolar Frente Ala Clinica', '4247242536', 'erianacoronado@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(358, '192.168.100.234', 'V12044898', 'William Jose Hernandez ', 1, 5, 0, 3, 2, ' Conucos Parte Halta  Porton Amarillo Cerca De La Cancha', '4247472923', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(359, '192.168.100.235', 'V30475199', 'Noiralip Del Valle Peña Villamizar', 1, 2, 0, 3, 2, ' El Corosito  Al Lado Del Tanque Frente Años Terrenos', '4247664892', 'alan26.je@ail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(360, '192.168.100.236', 'V16376846', 'Jhonny Antonio Uzcategui Villegas', 1, 4, 0, 3, 2, 'Via  Boqueron Via Principal Al Frente De La Entrada De La Bartola  Al Lado De Maria Juna', '4262620413', 'jhonnyuzcategui46@', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(361, '192.168.100.237', 'V4059433', 'Maria Auxiliadora Parra', 1, 2, 0, 3, 2, 'Calle Bolivar Al Lado De La Cancha', '4143711174', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(362, '192.168.100.238', 'V27268026', 'Johnny Alfredo Suarez', 1, 5, 0, 3, 2, ' Abajo De La Parada 79', '4149726813', 'alfredogato720@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(363, '192.168.100.239', 'V21365721', 'Maria Carolina Rodriguez Briceño ', 1, 1, 0, 3, 2, 'Juan Diaz Frente Al Taller Maximiliano', '4163717292', 'carolinarodriguezbriceño@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(364, '192.168.100.24', 'V14799414', 'Yaritza Albornoz', 1, 5, 0, 3, 2, 'Eje Colinas De Carmania, Calle Principal Al Lado Del Cri', '4129845793', 'yaryalbornoz2102@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(365, '192.168.100.240', 'V16065550', 'Yeannely Valero ', 1, 2, 0, 3, 2, 'Sabana Libre Calle Ppalbrisas De San Benito Sn', '4168739283', 'Yeannely-valle80@gimail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(366, '192.168.100.241', 'V31319852', 'Yehan Rivero', 1, 5, 0, 3, 2, 'Eje Colinas De Carmania, Sector Hugo Chavez, A 150Mtrs De La Calle Principal', '4247394780', 'riveroyehan@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(367, '192.168.100.242', 'V14328636-6', 'Valero De Matheus Angelina Del Carmen', 1, 5, 0, 3, 2, 'Conucos De La Paz Parte Alta Mas A Bajo De La Capilla San Benito', '4149760870', 'angelinavalero448@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(368, '192.168.100.243', 'V 12513352-1', 'Clara Luisa Sanchez Rangel', 1, 4, 0, 3, 2, 'Sector Los Barbechos Calle El Fortin Casa Sin Numero', '4160616634', 'JOSEDARGUELLO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(369, '192.168.100.244', 'V 29932900', 'Isabel Torres', 1, 4, 0, 3, 2, 'Divino Niño Al Lado De La Casa Del Jefe De Calle', '4247083761', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(370, '192.168.100.245', 'V 15187481-', 'Aidalys Linares (Cei Rosa Graciela Viloria De Salas)', 1, 2, 0, 8, 2, 'Calle Mi Jardin La Escuela Nectari', '4268281044', 'Angelesdemijardin@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(371, '192.168.100.246', 'V 9318312', 'Nelson Ramires', 1, 2, 0, 3, 2, 'Avenida Bolivar Frente Al Yavari Nelson Burge', '4140780495', 'rmireznelson2019@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(372, '192.168.100.247', 'V-621679-5', 'Yudi Beatriz Chirinos', 1, 4, 0, 3, 2, 'El Boqueron Sector La Calendaria Casa Numero 20', '4169643209', 'Rosachirinos.20121@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(373, '192.168.100.248', 'V 18396198-8', 'Johana Del Carmen Chirinos Salazar', 1, 4, 0, 3, 2, 'Sector El Quinquinillo Partr Alata', '4262231494', 'Johaanchirino658@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(374, '192.168.100.249', 'V-21063650', 'Daniel Alejando Hernandez Gonzales', 1, 8, 0, 3, 2, 'Entrada Los Rosales Cubita Alado Del Señor Benacion', '4123795814', 'alandanielhg1993@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(375, '192.168.100.25', 'V11898795', 'Rosa Zerpa', 1, 5, 0, 3, 2, 'Sector Quevedo, Casa Chalet De Ladrillo ', '4128669721', 'Romazeto13@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(376, '192.168.100.250', 'V 9179434', 'Mirla Marleni Oviedo Segovia', 1, 2, 0, 3, 2, 'Sabana Libre Sector Barrio Lindo Primera Entrada', '4167716151', 'mirlaoviedo54@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(377, '192.168.100.251', 'V 12798899', 'Maria Milagro Coronado Ramirez', 1, 2, 0, 3, 2, 'Sabanalibre Calle Ferrer A Dos Casas De Los Yogur', '4147276442', 'coronadomilagro0105@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(378, '192.168.100.252', 'V 18984902', 'Mileidy Diaz Villareal', 1, 5, 0, 3, 2, 'Terrazas De Colinas De Carmanea Calle 7 Casa 65', '4160770741', 'Araujofreddy533@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(379, '192.168.100.253', 'V26553607', 'Javier Fernandez', 1, 1, 0, 3, 2, 'Brisas Del Golondrino Vereda 1 Frente A Los Champiñones ', '4129190785', 'Javieryaya15@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(380, '192.168.100.254', 'V18348253', 'Diego Sanchez', 1, 5, 0, 3, 2, 'La Mata Frente Al Ambulatorio', '4247401242', 'gabrielg6348@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(381, '192.168.100.26', 'V14459856', 'Marbelis Briceño			\r\n', 1, 4, 0, 3, 2, 'Sector Las Rurales Del Alto, Casa S/N Casitas Del Terreno', '04165659761', 'Bricenomarbelis41@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(382, '192.168.100.27', 'V12041454', 'Nilia Rangel ', 1, 1, 0, 3, 2, 'Sector La Garita Parte Alta, Casa S/N Calle Los Apostoles ', '4247313328', 'Rangelnilia@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(383, '192.168.100.28', 'V27415984', 'Karla Maldonado', 1, 1, 0, 3, 2, 'Calle Minerval Casa S/N La Garita', '4263744528', 'Karlapaolamaldonado9@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(384, '192.168.100.29', 'V20679711', 'Wilmen Alvarado', 1, 5, 0, 3, 2, 'Eje Colinas De Carmania, Entrada De La Paca, Casa #1', '4269181237', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(385, '192.168.100.30', 'V30975897', 'Jose Miguel Suarez', 1, 2, 0, 3, 2, 'Sector San Benito, Calle Paez', '4247588506', 'suarezjosemiguel90@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(386, '192.168.100.31', 'J-412735764', 'Comercializadora Valle Esperanza C.A ', 1, 2, 0, 3, 2, 'Calle Ferrer  Sabana Libre Abajo De La Gallera', '4246650938', 'ESPERANZAVALEY@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(387, '192.168.100.32', 'V18985083', 'Lucy Alarcon', 1, 5, 0, 3, 2, 'Urb. San Jose, Casa #22 Fondo Plaza Bolivar De La Mata E Iglesia, Sector La Mata', '4149778844', 'lucyalarcon338@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(388, '192.168.100.33', 'V16883214', 'Virginia Jackelin Louze', 1, 5, 0, 3, 2, 'Calle Las Dalias Parte Baja, Dos Casa Mas Abajo De La Alcantarilla, Via La Antena, Sector La Mata, Mun. Escuque', '4242543027; 41683184', 'virginialouza400@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(389, '192.168.100.34', 'V28096350', 'Daniuska Villasmil', 1, 2, 0, 3, 2, 'Urb Ciudadela, Calle 2 Casa #55', '4247592824', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(390, '192.168.100.35', 'V4013056', 'Chanci Halim', 1, 1, 0, 3, 2, 'Urb Juan Diaz Diagonal A La Vaquera, Primera Entrada Al Final Casa S-N', '4243582196', 'CHANCIHALIM@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(391, '192.168.100.36', 'V12906012', 'Eyilda Molina', 1, 1, 0, 3, 2, 'Entrada De La Garita, Callejon San Jose, Tercera Casa, Final. ', '4247598865', 'profeyildajmm@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(392, '192.168.100.37', 'V9167847', 'Elias Zambrano Perdomo', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, Primera Etapa, Casa Sta Anita A33', '4164294056', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(393, '192.168.100.38', 'V5498870', 'Bcm', 1, 2, 0, 3, 2, 'Calle Bolivar Sector Los Canaletes, Casa S/N Sabana Libre, Una Cuadra Mas Arriba De Ferreteria', '4147264583; 42436210', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(394, '192.168.100.39', 'V13523736', 'Carlos Luis Villareal', 1, 5, 0, 3, 2, 'Via Principal Con Calle La Zuruma, Sector La Mata.', '4247303179', 'herminiaenmanuel@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(395, '192.168.100.40', 'V11316248', 'Oswaldo Campos Arandia', 1, 1, 0, 3, 2, 'Sector La Garita, Calle Alberto Godoy, ultima Casa', '04149715570; 0426379', 'zenaidaespinoza323@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(396, '192.168.100.41', 'V17604219', 'Yesenia Leal', 1, 4, 0, 3, 2, 'Sector La Bomba, Via El Alto, Detras De La Vinotinto', '4128635304', 'maikelbriceno08@gmai.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(397, '192.168.100.42', 'V12541192', 'Maigualida Coromoto Delgado Diaz', 1, 5, 0, 3, 2, 'Sector La Mata, Calle Las Dalias Via Quevedo, Diagonal A Entrada Via Los Terrenos', '4145322288', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(398, '192.168.100.43', 'V11391601', 'Neida Semprun', 1, 2, 0, 3, 2, 'Sector Campo Rico, Via Hotel Villavicencio Laguneta, Sabana Libre', '4147248237', 'neidasempruntorres@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(399, '192.168.100.44', 'V14800807', 'Nabely Camacho', 1, 1, 0, 3, 2, 'La Garita Calle Alberto Godoy, Diagonal Al Tanque De Agua ', '4147346701', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(400, '192.168.100.45', 'V20429122', 'Karla Nuñez', 1, 1, 0, 3, 2, 'Sector Puerto Escondido, Calle Principal, 150M De Proteccion Civil', '4125374067', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(401, '192.168.100.46', 'V9310020', 'Dionicio Uzcategui', 1, 1, 0, 3, 2, 'Puerto Escondido Via Principal \"Casa Uruguaya\"', '4166712629', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(402, '192.168.100.47', 'V10174499', 'Roman Lakhovski Cardoza Leon', 1, 4, 0, 3, 2, 'Sector La Bomba, Casa #7', '4162759703', 'rromancardoza@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(403, '192.168.100.48', 'V4658669', 'Victor Manuel Godoy Peña', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Sector I Calle Principal Casa D20', '4120556919 / 4121686610', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(404, '192.168.100.49', 'V26413636', 'Kelvin Santos', 1, 1, 0, 3, 2, 'Sector Puerto Escondido Cerca De La Alcantarilla ', '4162773661; 42687657', 'Kelvinsantoshernandez97@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(405, '192.168.100.50', 'V4666035', 'Aida Del Carmen Barrios De Avila', 1, 1, 0, 3, 2, ' Juan Diaz Residencia Corpoelec Casa  10', '4147043364; 41470318', 'zualyjose14@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(406, '192.168.100.51', 'V1570990', 'Hugo Serrano', 1, 4, 0, 3, 2, 'Calle Ambulatorio, El Alto De Escuque Casa 4', '4140070949', 'herasimport@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(407, '192.168.100.52', 'V18985082', 'Rosana Alarcon ', 1, 4, 0, 3, 2, 'El Alto De Escuque, Esquina Calle Paez ', '4247409154; +5195721', 'rosanaalarcon18@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(408, '192.168.100.53', 'V18985082', 'Rosana Alarcon (2)', 1, 5, 0, 3, 2, 'Urbanizacion San Jose, Casa #28 La Mata ', '4247409154; +5195721', 'rosanaalarcon18@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(409, '192.168.100.54', 'V10034629', 'Yamila Juarez', 1, 1, 0, 3, 2, 'Sector Puerto Escondido Calle Principal Donde Milito', '4140744311', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(410, '192.168.100.55', 'V30975715', 'Jesus Uzcategui', 1, 1, 0, 3, 2, 'Urbanizacion Fray Ignacio Alvarez Calle Miraflores Casa 3368', '04162732570; ', 'jesusuzcategui2004@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(411, '192.168.100.57', 'V4711818', 'Elida Del Carmen Prieto', 1, 2, 0, 3, 2, 'El Coroso, Urbanizacion Buenos Aires Casa 3', '4245535245', 'Elidadelcarmenprieto@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(412, '192.168.100.58', 'V28457914', 'Yender Rios', 1, 2, 0, 3, 2, 'El Coroso, Urbanizacion  Buenos Aires Casa 06', '4247787711', 'yenderprieto88@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(413, '192.168.100.59', 'V30491984', 'Thailana Moreno', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania ', '4247194366', 'THAILANAMORENO38@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(414, '192.168.100.60', 'V13996720', 'Victor Abreu', 1, 5, 0, 3, 2, 'Calle Principal Parte Baja Sector San Benito', '4247197185', 'victorjar1979@ail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(415, '192.168.100.61', 'V23594546', 'Mayra Alejandra Hernandez De Crespo', 1, 4, 0, 3, 2, 'El Boqueron Sector La Bartola, Casa/S/N', '04246057784 - 042631', 'La.gata17@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(416, '192.168.100.62', 'V11320525', 'Maria Juana Mendez Ruiz', 1, 4, 0, 3, 2, 'Sector Quinquinillo El Boqueron Casa Num 37', '4247040057', 'maryjmendez@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(417, '192.168.100.63', 'V9494519', 'Maria Mercedes Mendez Ruiz', 1, 4, 0, 3, 2, 'Sector El Boqueron Calle Principal Centro Turistico Mendez', '4247425475', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(418, '192.168.100.64', '10401889', 'Maria Isabel Parra Viloria', 1, 4, 0, 3, 2, 'Boqueron, Calle La Bartola ', '4263273784', 'isabelparra2865@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(419, '192.168.100.65', 'V19898540', 'Antonio Briceño', 1, 5, 0, 3, 2, 'Sector Hugo Chavez Casa 07', '04247496498; 04267740372', 'antoniojbriceno19898@gmsil.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(420, '192.168.100.66', 'V14309427', 'Wendy Hernandez ', 1, 1, 0, 3, 2, 'Via Principal Juan Diaz Abajo De La Trilladora De Ricardo', '4147539135', 'wendyline27@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(421, '192.168.100.67', 'V17606792', 'Alejandrina Osechas', 1, 2, 0, 3, 2, 'Sabana  Libre Sector San Benito Primera Calle Subiendo ', '4121598068', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(422, '192.168.100.68', 'V24786729', 'Jose Briceño\r\n', 1, 2, 0, 3, 2, 'Calle El Cementerio Sector Los Pinos 	', '4268262013; 4267161198', '9520jose@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(423, '192.168.100.69', 'V5103533', 'Ricardo Añez', 1, 5, 0, 3, 2, 'Sector La Antena   Por Las Granjas Vecino Marcos Solarte', '4121673566; ', 'Ricardoanez@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(424, '192.168.100.70', 'V16739113', 'Mayra Alejandra Gil Leon', 1, 5, 0, 3, 2, 'La Mata Calle Las Dalias Via Quevedo', '4147281042', 'gilleonmayraalejandra@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(425, '192.168.100.71', 'V23781332', 'Maira Guerrero', 1, 4, 0, 3, 2, 'Calle Independencia Sector La Huerta, El Alto De Escuque ', '4146039034', 'mairachanelguerrerobriceno@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(426, '192.168.100.72', 'V29814951', 'Cladiusca Contreras', 1, 1, 0, 3, 2, 'La Garita Callejon La Misericordia ', '4247150627', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(427, '192.168.100.74', '25006408', 'Alberto Camilo Celadon Teran ', 1, 1, 0, 3, 2, 'Sector La Garita, Urb Los Chalets Casa S-N ', '4247200886', 'CAMILOCELADON@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(428, '192.168.100.75', 'V15431951', 'Romelys Colls', 1, 2, 0, 3, 2, 'Urb Vista Hermosa Sabana Libre ', '4120700404', 'romelys.colls@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(429, '192.168.100.76', '', 'Carlos Avallone', 1, 4, 0, 3, 2, 'La Bartola Parte Alta', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(430, '192.168.100.77', 'V5497353', 'Maritza Josefina Duran Rivero ', 1, 4, 0, 3, 2, 'Boqueron, Calle Principal, Sector El Quinquinillo', '4126554010', 'MARTIN14AGUILAR@GMAIL.COM ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(431, '192.168.100.78', 'V5763118', 'Aliz Maribel Viloria', 1, 4, 0, 3, 2, 'Via Principal Las Rurales Del Alto, Al Lado Del Chalet De Madera ', '4247705722', 'alizmaribelviloria@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(432, '192.168.100.79', 'V10395681', 'Yaditza Betancourt', 1, 4, 0, 3, 2, 'Las Rurales Del Alto, Frente A La Capilla', '4262797466', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(433, '192.168.100.80', 'V18349655', 'Mayerlen Cabrera', 1, 2, 0, 3, 2, 'Calle San Agustin Con Calle La Union Casa Sin Numero', '4269327203', 'maryelencabrera@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(434, '192.168.100.81', 'V12457344', 'Maria Alejandra Simancas De Venegas ', 1, 2, 0, 3, 2, 'Urb Vista Hermosa Casa #F05', '4143718115', 'rocnervenegas@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(435, '192.168.100.82', 'V18095263', 'Betiuska Gallinat', 1, 2, 0, 3, 2, 'Urb Vista Hermosa Casa K 26', '4141066517', 'berugallinat@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(436, '192.168.100.84', 'V14599771', 'Alemania Castaldi', 1, 5, 0, 3, 2, 'Sector Cotiza Casa 6 ', '4147142726', 'Alemania.dva@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(437, '192.168.100.85', 'V13050167', 'Senovia Segovia', 1, 1, 0, 3, 2, 'Av Principal Juan Diaz ', '4161869261', 'Segoviass5588@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(438, '192.168.100.86', 'V12905764', 'Alejandro Toro', 1, 1, 0, 3, 2, 'Sertor Juan Diaz Al Lado De Edificio Escuquey', '4267529281', 'alejandrotoro352@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(439, '192.168.100.87', 'V11606613', 'Nina Struve ', 1, 4, 0, 3, 2, 'Sector La Bomba, Cerca De La Pluma De Agua ', '4261707840', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(440, '192.168.100.88', 'V1389301', 'Ricardo Perez', 1, 1, 0, 3, 2, 'Sector Juan Diaz Casa 3, Detras De La Senora De Ferrer ', '4241306300', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(441, '192.168.100.89', 'V27245772', 'Clara Parra ', 1, 4, 0, 3, 2, 'El Boqueron, Pq La Union, Mun Escuque ', '4160816659', 'KLARAINESPARRA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(442, '192.168.100.90', 'V22622003', 'Imer Barrueta', 1, 4, 0, 3, 2, 'Sector Divino Niño;4266747028', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(443, '192.168.100.91', 'V30671154', 'Krismar Arandia', 1, 4, 0, 3, 2, 'Sector Divino Niño;', '4261928466', 'Kris.arandia2005@gma', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(444, '192.168.100.92', 'V27466071', 'Ariana Katiusca Abreu Martinez', 1, 2, 0, 3, 2, 'Calle El Cementerio Setor Los Pinos', '4247048712', 'arianaabreumartines@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(445, '192.168.100.93', 'V23837299', 'Yulie Torres Medina', 1, 5, 0, 3, 2, 'Urb Colinas De Carmania Primera Calle ', '5,8416E+11', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(446, '192.168.100.94', 'V23781274', 'Maria Leal', 1, 4, 0, 3, 2, 'Sector La Bomba, Frente A Cornelio', '4129084879', 'mariacarolinalealbrillemborurg@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(447, '192.168.100.95', 'V25919512', 'Edwin Mendoza', 1, 5, 0, 3, 2, 'La Mata Calle Principal', '4147154571', 'mendozacardozo20@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(448, '192.168.100.96', 'V16881892', 'Monica Nuñez', 1, 5, 0, 3, 2, 'La Mata Calle Principal, Frente Hosmary', '4247278464', 'bricenoromeroedgaralexander@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(449, '192.168.100.97', 'V9716907', 'Oswaldo Molano', 1, 4, 0, 3, 2, 'El Boqueron Via Principal, Al Lado De Portillo , Pq La Union, Mun Escuque ', '4140627203', 'oemolano@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(450, '192.168.100.98', 'V17904821', 'Cintia Rivas', 1, 4, 0, 3, 2, 'Sector La Bomba ', '4247192077', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(451, '192.168.100.99', 'V83622324', 'Luis Cordero', 1, 1, 0, 3, 2, 'Juan Diaz Sector Cubita Casa 51', '4264273810; 41437382', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(452, '192.168.110.10', 'V14148564', 'Augusto Antonio Castro Nava', 2, 3, 0, 3, 2, 'Sector Arturo Cardozo, San Juan De Isnotu, Parroquia Jgh, Rafael Rangel', '4147264813; 42475447', 'castroaugusto212@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(453, '192.168.110.100', 'V20657541', 'Maria Alejandra Abreu', 1, 2, 0, 3, 2, 'Vista Hermosa Sector K Casa K10', '4269260291', 'mariaalejandraabreuduran@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(454, '192.168.110.101', 'V14929019-9', 'Yudith Marileth Ojeda Peña', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Principal Alado Del Modulo Policial', '04247685879; 04263131673', 'Prof.yudithojeda.unefa@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(455, '192.168.110.102', 'V 11322080', 'Yusmari Del Pilar Viloria Agilar', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector La Abeja Bajando La Medicatura', '04147312272; 0424751', 'yusmaryviloria11@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(456, '192.168.110.103', 'V12443466', 'Jose Gregorio Gonzalez Reverol', 2, 3, 0, 3, 2, 'Sector La Abeja San Juan De Isnotu Casa S/N', '4247186958', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(457, '192.168.110.104', 'V16535166', 'Noheli Del Carmen Gonzalez Rojas', 1, 4, 0, 3, 2, 'Las Cruces De La Unicon Calle Principal A 20M De La Caja De Agua ', '04247673009; ', 'Noeligonzalez037@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(458, '192.168.110.105', 'V20039761', 'Luisana Fatima Viloria Araujo', 1, 4, 0, 3, 2, 'Las Cruces De San Juan, Cerca De La Iglesia., ', '04143718756 / 042472', 'PENDIENTE ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(459, '192.168.110.106', 'V18802819', 'Yesika Gudelia Peña Duran', 1, 4, 0, 3, 2, 'Sector La Laja Parte Baja, Calle Principal Casa S/N', '4247806983', 'Yesijohana607@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(460, '192.168.110.107', 'V9327193', 'Juan Godoy ', 1, 4, 0, 3, 2, 'El Boqueron', '4247355875', 'juangacham@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(461, '192.168.110.108', 'V13523512', 'Neyda Albarran', 1, 4, 0, 3, 2, 'El Boqueron', '', 'maryikarely.19@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(462, '192.168.110.109', 'V16377755', 'Andreina Gregoria Colmenares Viloria', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector Las Rurales Nuevas Al Fondo 3  Casa Antrando Por El Estadio', '04147205022; 0424756', 'Andreinacolmenaresvilo@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(463, '192.168.110.11', 'V10037271', 'Thais Hernandez', 1, 2, 0, 3, 2, 'A Un Lado De La Iglesia', '4146182873', 'herntha@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(464, '192.168.110.110', 'V20135498', 'Lorna Josefina Materan De Manzanilla ', 2, 3, 0, 3, 2, 'Sector La Laja, Parte Baja, Johan Mecanico ', '4247796855', 'LORNAMATEFLO1988@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(465, '192.168.110.111', 'V20428282', 'Erick Alexander Nava Araujo', 1, 4, 0, 3, 2, 'La Laja Parte Baja Casa #8 Via Isnotu', '0414 7441901', 'Erocknava523@gmail. Com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(466, '192.168.110.112', 'V7710981', 'Jeanly Montiel', 1, 4, 0, 3, 2, 'La Laguneta Frente Al Cementerio', '4146738224', 'jeanlymontiel@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(467, '192.168.110.113', 'V10398420', 'Doris Consuelo Rojo', 1, 4, 0, 3, 2, 'La Laja Parte Baja Calle Virgen Del Rosario Numero De Casa B03', '04266141715; 0416718', 'santiagoboy2018@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(468, '192.168.110.114', 'V8723849', 'Carmen Valera Villegas', 1, 4, 0, 3, 2, 'Sector La Laja, Parte Baja Casa Numero 22', '4269869912', 'Carmenaidevalerabillegas@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(469, '192.168.110.115', 'V9046083', 'Aura Del Carmen Teran De Mendoza ', 1, 4, 0, 3, 2, 'La Laja Parte Baja Tercera Casa Casa Sn Via Principal', '4120140626', 'At5714073@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(470, '192.168.110.116', 'V12796153', 'Veronica Del Valle Teran Viloria', 1, 4, 0, 3, 2, 'La Laja Parte Baja 300Mt De La Entrada Casa Sin Numero', '4169325486', 'Veronicateran1976@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(471, '192.168.110.117', 'V 19899972-2', 'Mayerlin Karina Viloria Materan', 1, 4, 0, 3, 2, 'La Laja Parte Baja Calle Principla A 20M De La Señora Yesica', '04147592305; 0412043', 'Joseandrestorresrivero@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(472, '192.168.110.118', 'V 17604461-2', 'Monica Manzanilla ', 1, 5, 0, 3, 2, 'La Mata Calle Principal Alado Del Ambulatorio', '04247412580; 0416854', 'Monicamanzanilla5@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(473, '192.168.110.119', 'V 10401345', 'Noli Josefina Araujo Suares', 1, 4, 0, 3, 2, 'Las Cruces De La Union Parte Baja Calle Principal Numero De Casa 0119', '04247670471; 0424745', 'Nolyaraujo29@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(474, '192.168.110.12', 'V 21061840', 'Francisco Javier Supelano', 2, 3, 0, 3, 2, 'San Juan Alado De La Cancha Sector El Prado', '4147356410', 'franciscosupelano21@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(475, '192.168.110.120', 'V14053070', 'Luis Alberto Matos Briceño', 1, 4, 0, 3, 2, 'La Laja Parte Baja Calle Principal Alado Del Taller Royo El Chalet', '4147404937	', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(476, '192.168.110.121', 'V20040453', 'Maite Peña (Casa)', 2, 3, 0, 3, 2, 'San Ajustin Calle Proncipal Subiendo La Cruz De La Mision Casa Sn', '04126415797; 0412125', 'derwinramirez75@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(477, '192.168.110.122', 'V25171120', 'Valeria Alejandra Materan Flores', 1, 4, 0, 3, 2, 'Via Principal, Sector La Laja P/B, Antes De La Piscina Los Viloria', '4247314953', 'valeriamateran25@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(478, '192.168.110.123', 'V20705758', 'Jakeline Aguilar', 1, 4, 0, 3, 2, 'Las Cruces De La Union Av Principal Sector San Isidro ', '4247383319', 'Jakelineaguilr156@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(479, '192.168.110.124', 'V16740210', 'Jover Antonio Araujo Manzanilla', 2, 3, 0, 3, 2, 'Sector Las Cruces San Isidro, Detras De La Cancha ', '4247155023', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(480, '192.168.110.125', 'V 9602658-0', 'Winston Ramon Ramos Rojas', 1, 4, 0, 3, 2, 'La Laja Parte Baja Avenida Principal A 200 Subiendo Del Restaurante Del Encanto', '4166782371', 'Wistinramos123@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(481, '192.168.110.126', 'V4315586', 'Nelly Viloria De Cabrera', 1, 5, 0, 3, 2, 'La Mata Sector Las Antenas Frente Donde Wanda', '4149158747', 'nellycviloria@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(482, '192.168.110.127', 'V30380081', 'Javier Pirela', 1, 4, 0, 3, 2, 'Las Cruces De La Union, Diagonal A La Iglesia Casa S/N', '4242694109; 42426941', 'Pirelaandres21@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(483, '192.168.110.128', 'V4704655', 'Isabel Briceño De Mendoza', 1, 4, 0, 3, 2, 'Las Cruces De La Union Casa S/N', '4247262702', 'Pendiente', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(484, '192.168.110.129', 'V10038550', 'Gladis Materan', 2, 3, 0, 3, 2, 'La Laja Parte Baja, Calle Santa Eduviges', '4249719104', 'EMILYANTHONELAGARCIA@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(485, '192.168.110.13', 'V 13336522-2', 'Juan Carlos Piña Fernandez ', 1, 5, 0, 3, 2, 'Sector Puerta De Golpe Via La Antenas Diagonal Radio Sinpatia ', '4247386624', 'Juan Carlos.piafernadez@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(486, '192.168.110.130', 'V10908978', 'Miterio Mendoza', 1, 4, 0, 3, 2, 'Quinquinillo Residencia Las Piedras', '4161938203', 'miteriomendoza@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(487, '192.168.110.131', 'V17393814', 'Noris Vergara', 1, 4, 0, 3, 2, 'Las Malvinas', '4167797922', 'vergaravalesillos@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(488, '192.168.110.132', 'V24139425', 'Carlos Antonio Briceño Balza ', 1, 4, 0, 3, 2, 'Las Malvinas', '4162949277', 'bricenobalzacarlosantonio@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(489, '192.168.110.133', 'V26046178', 'Leandro Materan', 1, 4, 0, 3, 2, 'Sector San Isidro, Via Las Cruces De La Union, Parq.La Union, Mun.Escuque', '4247181431; 42453745', 'materanleandro70@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO');
INSERT INTO `contratos` (`id`, `ip`, `cedula`, `nombre_completo`, `id_municipio`, `id_parroquia`, `id_comunidad`, `id_plan`, `id_vendedor`, `direccion`, `telefono`, `correo`, `fecha_instalacion`, `ident_caja_nap`, `puerto_nap`, `num_presinto_odn`, `id_olt`, `id_pon`, `estado`) VALUES
(490, '192.168.110.134', 'V10396722', 'Yamile Vargas', 1, 2, 0, 3, 2, 'Pueblo Nuevo', '4260558081', 'fabianuber995@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(491, '192.168.110.135', 'V12041536', 'Omaira Betancourt ', 1, 4, 0, 3, 2, 'La Laja Parte Baja', '4247092900', 'SOSA_THAIS@YAHOO.ES ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(492, '192.168.110.136', 'V19338104', 'Marbellis Teran', 1, 5, 0, 3, 2, 'Conucos De La Paz', '4247390694', 'marbellisc.t.b@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(493, '192.168.110.137', 'V30563367', 'Ronaldo Montilla', 1, 2, 0, 3, 2, 'Calle Barrio Lindo', '4147223234', 'montillateranronaldo@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(494, '192.168.110.138', 'V31095489', 'Maria Gabriela Araujo ', 1, 4, 0, 3, 2, 'El Alto ', '4160570561', 'marigabri2601@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(495, '192.168.110.139', 'V29539933', 'Moises Gualda ', 1, 1, 0, 3, 2, 'Sector Valle Alto, Casa S-N Cerca De La Escuela Vicente De La Torre ', '4247306527; 42472869', 'GUALDAMOISES37@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(496, '192.168.110.14', 'V13261084', 'Carla Nuñez (Unidad Educativa Vicente De La Torre)', 1, 1, 0, 8, 2, 'Sector Valle Alto Calle Principal Al Frente De La Base De Misiones', '4125374067', 'KARLACAROL90@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(497, '192.168.110.140', 'V 17831220', 'Rudy Aujenio Perez Verios', 1, 5, 0, 3, 2, 'Quevedo Sector La Esperanza Parte Baja Casa Sin Numero', '424448553', 'rudyeugenioperez@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(498, '192.168.110.141', 'V 4012721', 'Carlos Antonio Osuna', 1, 1, 0, 3, 2, 'Puerto Escondido Calle Proncipal Numero De Casa 72', '04261676926; 0412265', 'Jenny.osuna@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(499, '192.168.110.142', 'V9174652', 'Gania Flores', 1, 4, 0, 3, 2, 'Las Cruces De La Union', '4247473792', 'josefinafloresme...63@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(500, '192.168.110.143', 'V12796952', 'Jose Teran', 1, 4, 0, 3, 2, 'La Laja Parte Baja', '4263727591', 'joseteranv@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(501, '192.168.110.144', 'V20789224', 'Vanessa Perdomo', 2, 3, 0, 3, 2, 'Sector La Abeja Parte Baja', '4247174462', 'vanessanuevo2@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(502, '192.168.110.145', 'V21366857', 'Angel Chinchilla', 1, 4, 0, 3, 2, 'San Juan Esquina De La Iglesia Bajando', '4141766500', 'chinchilla.angel.18@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(503, '192.168.110.146', 'V11319056', 'Carla Aldana', 1, 2, 0, 3, 2, 'Segunda Entrada Del Cementerio', '4247371208', 'carlacenteno079@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(504, '192.168.110.147', 'V9168496', 'Manuel Blanco', 1, 2, 0, 3, 2, 'Vista Hermosa Sector 1 Casa A 40', '4121746392', 'manuelblanco147@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(505, '192.168.110.148', 'V10400854', 'Belen Bravo', 1, 2, 0, 3, 2, 'Calle La Democracia', '4262832868', 'belenzaid08@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(506, '192.168.110.149', 'V9375346', 'Jesus Quintero (El Padre)', 1, 2, 0, 3, 2, 'A Un Lado De La Iglesia', '4165737066', 'chuyquinteromorillo17@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(507, '192.168.110.15', 'V21372815-2', 'Yuleisy Benita Millano De Corona', 1, 1, 0, 3, 2, 'Juan Dias Avenida Principal Casa Sin Numero Entrada Los Rosales Cuarta Casa', '4247635999', 'Yuleisybenitamillano@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(508, '192.168.110.150', 'V12042452', 'Taired Briceño', 1, 2, 0, 3, 2, 'Calle San Agustin', '04127691519', 'taydbri@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(509, '192.168.110.151', 'V19794239', 'Dennis Sardi', 1, 4, 0, 3, 2, 'Sector El Pao', '4247836174', 'dennissardi2008@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(510, '192.168.110.152', 'V12541047', 'Jesus Vergara', 1, 4, 0, 3, 2, 'Sector Quevedo Parte Alta', '4162910721', 'jesus25ve@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(511, '192.168.110.153', 'V13260257', 'Walter Linares', 1, 2, 0, 3, 2, 'Pueblo Nuevo Frente A La Señora De La Masa De Maiz', '4247326032', 'walterslinares1978@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(512, '192.168.110.154', 'V31884149', 'Raul Alberto Blanco Struve', 1, 4, 0, 3, 2, 'Sector La Bomba Calle Proncipal Via El Alto', '4269871770', 'Raualberto15.04@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(513, '192.168.110.155', 'V10910286-0', 'Maigualida Abreu Colmenares', 1, 4, 0, 3, 2, 'La Laguneta Alado De La Soñara Dora Matos Casa De 2 Plantas ', '4143214395', 'mabreu71@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(514, '192.168.110.156', 'V 14329439', 'Yoliant Claret Flores Torres ', 1, 4, 0, 3, 2, 'Las Cruces De La Union Numero De Casa 0101 Restaurante El Encanto ', '04264242027; 0414625', 'Claret2209@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(515, '192.168.110.157', 'V12804010', 'Juan Carlos Moreno', 1, 4, 0, 3, 2, 'El Alto Via Quevedo Chalet Verde', '4126922642', 'jcmoreno0776@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(516, '192.168.110.158', 'V15188927', 'Rosmery Linares', 1, 5, 0, 3, 2, 'Sector Las Antenas', '4247004243', 'rlinaresvillarreal@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(517, '192.168.110.159', 'V4700161', 'Benita Morales', 1, 4, 0, 3, 2, 'Sector La Laguneta Entrada A Las Antenas', '4126426906', 'benitamorales18@gmaul.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(518, '192.168.110.16', 'V3464906', 'Guido Ramon Mancini Godoy', 2, 3, 0, 3, 2, 'San Juan De Isnotu, Al Lado De Laboratorio Dental', '4265718410', 'guidoramon.09mancini@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(519, '192.168.110.160', 'V 7613149', 'Carmen Luisa Zambrano', 1, 4, 0, 3, 2, 'El Alto De Escuque Sector Sambenito Casa Sin Numero ', '4246229911', 'carmen201507@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(520, '192.168.110.161', 'V10402386', 'Claribel Josefina Flores Mendoza', 1, 4, 0, 3, 2, 'La Laja Parte Baja', '4147477945/414704869', 'andreamatos2110@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(521, '192.168.110.162', 'V18802951', 'Lilia Coromoto Linares Artigas ', 2, 3, 0, 3, 2, 'San De Isnotu Calle Principal Subiendo A 20M De La Tiendita De Migel Peña ', '4241389647', 'lilianalinares550@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(522, '192.168.110.163', 'V26123324', 'Valeria Montilla', 1, 5, 0, 3, 2, 'La Mata Final De La Av Ppal', '4160638520', 'valeriaems0503@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(523, '192.168.110.164', 'V26616474', 'Susana Victoria Carrillo Castro ', 2, 3, 0, 3, 2, 'San Pedro Calle Principal Numero De Casa Sin Numero Referencia A 200 Metros Del Puente Subiendo ', '4141760479', 'Yarisnelstefaniacarrilocastro@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(524, '192.168.110.165', 'V21106203', 'Milagros Del Valle Valderrama Garcia', 2, 3, 0, 3, 2, 'San Pedro Calle Principal Primer Puente Casa Sin Numero', '4247007642', 'Valderramagarciasm257@gamil.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(525, '192.168.110.166', 'V9321338', 'Jose Gregorio Villarreal ', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector Chacoi Pitisai Numero De Casa 140', '4245264804', 'Villarraljosegregorio884@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(526, '192.168.110.167', 'V11315481', 'Ricardo Perez', 1, 4, 0, 3, 2, 'El Boqueron Sector La Candelaria', '4168279579', 'gatoperez202@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(527, '192.168.110.168', 'V28096241', 'Reina Nebraska Perez Gonzales ', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector La Abeja Parte Baja Alado De La Señora Macrin Casa Con Frente De Piedras ', '4247594998', 'Rainy02perez@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(528, '192.168.110.169', 'V9014985', 'Benicia Aguilar', 2, 3, 0, 3, 2, 'San Pedro De Isnotu Av Principal Casa N1-7', '4269150484', 'Marbviloria1@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(529, '192.168.110.17', 'V21366299', 'Ramon Barreto', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Sector Punta Brava', '4122282001', 'bmmari540@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(530, '192.168.110.170', 'V15583127', 'Rosalba Briceño', 1, 4, 0, 3, 2, 'Entrada De Las Cruces En Frente Del Tanque ', '04247334896; 04247568684', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(531, '192.168.110.171', 'V9718090', 'Freddy Gonzalez', 1, 4, 0, 3, 2, 'Sector Las Cruces Mas Abajo Del Tanque', '4147224318', 'freddyramon2865@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(532, '192.168.110.172', 'V14149352', 'Mariela Villegas', 2, 3, 0, 3, 2, 'Sector La Abeja Parte Baja', '4246989008', 'villegasjavier583@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(533, '192.168.110.173', 'V26046698', 'Nelyari Carrillo', 2, 3, 0, 3, 2, 'Sara Linda', '4126008183', 'yarisnelstefaniacarrillocastro@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(534, '192.168.110.174', 'V27070980', 'Anderlyng Quintero', 1, 2, 0, 3, 2, 'Calle La Rivera', '4247630082', 'anderlingquintero@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(535, '192.168.110.175', 'V10031660', 'Victor Peña', 1, 4, 0, 3, 2, 'La Laja Parte Baja', '04143745722', 'nestormanuelgonzalezpena@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(536, '192.168.110.176', 'V11677143', 'Rosa Blanco', 1, 2, 0, 3, 2, 'Vista Hermosa Segunda Etapa 0-16', '4247213600', 'armidarosablanco@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(537, '192.168.110.178', 'V24605711', 'Yalimar Lopez', 1, 2, 0, 3, 2, 'Diagonal Al Cementerio', '4161419485', 'lopezrobertisyalimarcarolina94@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(538, '192.168.110.179', 'V20655810', 'Adriana Ramirez', 1, 4, 0, 3, 2, 'Las Malvinas Frente. A La Laguna', '4142856800', 'adrianaramirezmatheus@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(539, '192.168.110.18', 'V19285450', 'Neivys Paredes', 1, 2, 0, 3, 2, 'Calle El Paraiso Casa D09', '4160740931', 'neivys.paredes@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(540, '192.168.110.180', 'V23777068', 'Genesis Peña', 2, 3, 0, 3, 2, 'San Agustin A 100Mtrs De La Cancha', '04145310559', '23777068gene@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(541, '192.168.110.181', 'V29994798', 'Jose Leonardo Telles', 1, 1, 0, 3, 2, 'Los Conucos De La Paz Parte Alta', '4149778671', 'leonardoyel31@gamil.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(542, '192.168.110.182', 'V5101420', 'Elena Gomez', 1, 5, 0, 3, 2, 'Colinas De Carmania', '4165745386', 'egomezsimancas@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(543, '192.168.110.183', 'V16560595', 'Ana Boscan', 1, 1, 0, 3, 2, 'La Constituyente', '4168430489', 'aboscan948@gamil.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(544, '192.168.110.184', 'V27466061', 'Jesus Perez', 2, 3, 0, 3, 2, 'San Juan A Un Lado De La Iglesia', '4247163892', 'perezriverojesusmanuel@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(545, '192.168.110.185', 'V14459327', 'Marielba Araujo', 2, 3, 0, 3, 2, 'San Pedro De Isnotu, Calle Principal Casa 1-3 Al Lado De Ferreteria Rangel Aguilar ', '4269135383', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(546, '192.168.110.186', 'V27896848', 'Angel Vargas', 1, 4, 0, 3, 2, 'El Tiro Av Principal', '4248725268', 'angelvargas27896@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(547, '192.168.110.187', 'V 30047723-9', 'Yarwin Jose Blanco Berrios', 1, 5, 0, 3, 2, 'Escuque Colinas De Carmana, Urbanizacion Jaruma Calle Numero 2 Casa Numero 1', '04160879645; 0416377', 'Yarwinb02@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(548, '192.168.110.188', 'V10913469', 'Vianey Perez', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Casa F-20', '4247734010', 'vianeyperez0209p@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(549, '192.168.110.189', 'V32177022', 'Naybeth Aranguibel', 2, 3, 0, 3, 2, 'Sara Linda Mas Abajo Del Ambulatorio', '4168398938', 'naybethmoreno17@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(550, '192.168.110.19', 'V13897413', 'Karina Rivero', 1, 2, 0, 3, 2, 'Vista Hermosa Calle Paraiso', '4264219004', 'karinarivera1979@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(551, '192.168.110.190', 'V17830071', 'Yugledis Cabrera', 1, 5, 0, 3, 2, 'Colinas De Carmania Vereda 2', '4247698724', 'sanchezveronica3071@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(552, '192.168.110.191', 'V24565348', 'Nilethsy Nohely Hernandez Torres', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Casa S/N Mas Abajo De La Iglesia Catolica', '4160536703', 'nilethsy2021@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(553, '192.168.110.192', 'V27804727', 'Grecia Briceño', 2, 3, 0, 3, 2, 'Sara Linda De Isnotu, Parte Baja, Casa Sin Número, Detras De La Bloquera', '4162790540, 4263252011', 'greciabriceno43@gmail.com\r\n', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(554, '192.168.110.193', 'V9495422', 'Jorge Luis Paredes Teran', 2, 3, 0, 3, 2, 'Av. Principal Sector Sara Linda  Parte Baja Casa Nro 01', '4247097833', 'PIROREPUESTOS_10@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(555, '192.168.110.194', 'V29585965', 'Yohanderson Rodriguez', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja', '4267104759', 'yohanderson27200@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(556, '192.168.110.195', 'V24565549', 'Ana Belen Castellano', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja', '4264614746', 'anabelencastellano@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(557, '192.168.110.196', 'V26123370', 'Emily Hernandez', 1, 4, 0, 3, 2, 'El Boqueron Mas Abajo De La Iglesia', '4217377218', 'emilypatriciahm26@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(558, '192.168.110.197', 'V8759898', 'Leidy De Pichardo', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja', '4161712851', 'pichado458@gamil.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(559, '192.168.110.198', 'V18801439', 'Luis Nava', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja ', '4247539344', 'lgnava2017@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(560, '192.168.110.199', 'V12458987', 'Luzmar Nava ', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja, Sector Punta Brava', '4165194178', 'LUZMARNAVA15@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(561, '192.168.110.20', 'V 5105566-3', 'Manuel Alfonso Castro', 2, 3, 0, 3, 2, 'San Juan De Isnotu A 3 Casas Bajando Por La Escuela', '4247509875', 'Manueltotocastro@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(562, '192.168.110.200', 'V 18802443-9', 'Javier Jose Viloria Castro', 2, 3, 0, 3, 2, 'Sara Linda Calle Principal Chicharo Era Viloria Becerra', '4120975572', 'Viloriajavierjose373@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(563, '192.168.110.201', 'V19286363', 'Yohselyn Vanesa Carrillo', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja', '4265753770', 'vanesacarrillo530@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(564, '192.168.110.202', 'V14875284', 'Dayana Rivero', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja, Via San Pedro Viejo,Casa #7 Parrq.Jgh, Mun.Rafael Rangel', '4263636268; 42657241', 'riverodayanamaria0@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(565, '192.168.110.203', 'V27029356', 'Mery Peña', 2, 3, 0, 3, 2, 'Sara Linda Av. Ppal', '04247508981	', 'meeypena2018@gmqil.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(566, '192.168.110.204', 'V20040453', 'Maite Peña (Negocio)', 2, 3, 0, 3, 2, 'Av Principal Sara Linda, Chicharronera Maite ', '4121256389', 'maitecpdaraujo@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(567, '192.168.110.205', 'V9323464	', 'Lisbeth Briceño', 2, 3, 0, 3, 2, 'Sara Linda Av Principal, Restaurante Posada Del Turista', '4147389975	', 'todolimpiolisbt@gmail.com\r\n', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(568, '192.168.110.206', 'V10435856', 'Alfredo Rincon', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja', '4268763926', 'valjorina728@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(569, '192.168.110.207', 'V28079218', 'Angelo Villa', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta, 400Mt Mas Arriba Del Gimnasio', '4163082478; 41653148', 'angelovilla1303@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(570, '192.168.110.208', 'V19510590', 'Deinys Jesus Simancas Colmenares (Chicharronera Simancas)', 2, 3, 0, 3, 2, 'Sara Linda Avenida Principal Cicharronera Siman', '4266039941', 'Invsimanca027@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(571, '192.168.110.209', 'V18802819	', 'Yesika Peña', 2, 3, 0, 3, 2, 'Sara Linda Avenida Principal Chicharronera La Chiva', '04247806983	', 'Yesijohana607@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(572, '192.168.110.21', 'V 5503845-3', 'Jose Luis Parra Leon', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Principal Casa Sin Nunero Diagonal Ala Casa De La Cultura ', '4247295767', 'dianoracolmenares5@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(573, '192.168.110.210', 'V 20084337', 'Jose Alberto Ruza', 2, 3, 0, 3, 2, 'Sara Linda Aector La Carmelitas Panaderia El Niño ', '4268471451', 'Josealbertoruza209@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(574, '192.168.110.211', 'V26046646', 'Yulexi Andrea Montilla Aguilar', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta, Coloradito Casa Sin Numero ', '4247662059', 'Yulexi_yr@hotmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(575, '192.168.110.212', 'V10031660', 'Victor Manuel Peña Barreto', 2, 3, 0, 3, 2, 'Sara Linda Av Principal', '4143745722', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(576, '192.168.110.213', 'V15409683', 'Juan Jose Pedrozo Ojeda', 2, 3, 0, 3, 2, 'Sara Linda De Isnotu Sector Los Coloraditos Casa S/N', '4143746516', 'juanpedrozo27@hotmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(577, '192.168.110.214', 'V18349882', 'Jose Mendez ', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Sector Los Coloraditos', '4247400908', 'jmendezq1986', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(578, '192.168.110.215', 'V28261853	', 'Carlos Eduardo Ramirez Piña', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Calle Los Coloraditos', '4160843237', 'ramirescarlos550@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(579, '192.168.110.216', 'V13461717', 'Anyerly Valera', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta', '4262674094', 'idanyeridalgo@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(580, '192.168.110.217', 'V30548935', 'Yovana Perez', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta', '4262676446', 'perezyovana2022@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(581, '192.168.110.218', 'V16739671', 'Yusmina Carolina Saez Quintero', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Casa S/N', '4164728418', 'oendienre@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(582, '192.168.110.219', 'V27889582', 'Paola Mogollon', 1, 5, 0, 3, 2, 'La Mata Via A Las Antenas', '4120257379', 'paolamogo123@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(583, '192.168.110.22', 'V16534150', 'Ricardo Manzanilla', 2, 3, 0, 3, 2, 'San Agustin Parte Baja', '4247413304', 'johnkeiver503@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(584, '192.168.110.220', 'V13262575', 'Sonia Montilla ', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta, Via Principal', '4147451402', 'montillasonia94@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(585, '192.168.110.221', 'V31665982', 'Maria Viloria', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja ', '4169812297', 'mariaviloriapena@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(586, '192.168.110.222', 'V 9176738', 'Sonia Margarita Quintero Gutierrez', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja ', '4264076740', 'Sonia.64quin@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(587, '192.168.110.223', 'V28323367', 'Oscar Matheus ', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta ', '4147391328', 'oscarkenery.21@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(588, '192.168.110.225', 'V10401732', 'Alexander Simancas', 2, 3, 0, 3, 2, 'Sara Linda A Un Lado De La Chicharronera Chivas', '4147265682', 'BCM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(589, '192.168.110.226', 'V30737685', 'Rainer Briceño', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta', '04127058033	', 'rainernuhlen@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(590, '192.168.110.227', 'V20789385', 'Egle Villarreal', 2, 3, 0, 3, 2, 'San Juan Cerca De La Iglesia', '4217322339', 'egleevilla36@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(591, '192.168.110.228', 'V9496569', 'Gladys Rivas', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Casa N21', '4124609398', 'rivasgladysj@gmaul.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(592, '192.168.110.229', 'V9239707', 'Katina Espronceda', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Casa B22', '4143799861', 'katinatrinidadesprinceda@gamil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(593, '192.168.110.23', 'V12038554', 'Noiralyn Simancas ', 2, 3, 0, 3, 2, 'San Agustin Parte Baja', '4247075419', 'eliannispaolasimancaslinares@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(594, '192.168.110.230', 'V12046637', 'Manuel Quintero', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '4143799861', 'manuelquintero212@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(595, '192.168.110.231', 'V10034218', 'Aura Barrios', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '4149727040', 'aura.rosaap@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(596, '192.168.110.232', 'V12691605', 'Douglas Morillo', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '4246341976', 'asistentedm682@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(597, '192.168.110.233', 'V9322737	', 'Lenis Briceño		\r\n', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '04147337480	', 'lembri20@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(598, '192.168.110.234', 'V7866687', 'Edmer Gonzalez', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '4146026948', 'edmergonzalez4@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(599, '192.168.110.235', 'V17093973', 'Marvelys Teran', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '4247524381', 'marvelysteranpitela@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(600, '192.168.110.236', 'V9169819', 'Digna Pirela', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '4143794932', 'dayanateran734@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(601, '192.168.110.237', 'V7802633', 'Gilberto Peña	', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '04147275278	', 'gilberto41020@gmail.com\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(602, '192.168.110.238', 'V24881260', 'Gania Josefina Materan Flores ', 1, 4, 0, 3, 2, 'La Laja Parte Baja Frente Del Señor Wiston Ramos', '04121229318; 0416070', 'jovasram20@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(603, '192.168.110.239', 'V10911044', 'Jose Leal', 1, 4, 0, 3, 2, 'La Laja Parte Alta ', '4161751302', 'p.59leal@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(604, '192.168.110.24', 'V13048780', 'Morelis Del Valle  Morillo Quintero ', 2, 3, 0, 3, 2, 'San Juan Las Rurales Frente A La Sra Carol', '4247127443', 'Morelismorillo7@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(605, '192.168.110.240', 'V10910213', 'Gerardo Perdomo', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '4121375606', 'gerardoperdomo2967@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(606, '192.168.110.241', 'V7756314', 'Angel Osorio', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '4147300187', 'arobosch@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(607, '192.168.110.242', 'V25822924', 'Roldany Prieto', 2, 3, 0, 3, 2, 'La Laja Parte Alta', '4124394787', 'prietoroldany@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(608, '192.168.110.243', 'V25733490', 'Diego Aguilar', 2, 3, 0, 3, 2, 'San Pedro', '4126242968', 'barriosgabriela922@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(609, '192.168.110.244', 'V15825128', 'Nancy Sanchez', 1, 4, 0, 3, 2, 'Sara Linda Sector Las Carmelitas', '4264263897', 'sancheznncy7@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(610, '192.168.110.245', 'V13897055', 'Kleiber Aguilar', 1, 4, 0, 3, 2, 'Sara Linda Parte Baja', '4247210654', 'kaguilar.unermb@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(611, '192.168.110.246', 'V5629234', 'Egna Morela Carrillo', 1, 4, 0, 3, 2, 'La Laja Parte Alta', '4267707358', 'morelacarrillo450@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(612, '192.168.110.247', 'V11798284', 'Ana Carolina Viloria', 1, 4, 0, 3, 2, 'La  Laja ', '4247423435', 'viloriagud@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(613, '192.168.110.248', 'V11318026', 'Atilio Rivas ', 1, 4, 0, 3, 2, 'Sara Linda Parte Alta', '4264060667', 'rivasatilio371@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(614, '192.168.110.249', 'V17893583	', 'Teila Briceño', 1, 4, 0, 3, 2, 'Sara Linda Parte Baja', '04147124521	', 'bricenoteila@gmail.com\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(615, '192.168.110.25', 'V20040635-0', 'Yamileth Ramirez', 2, 3, 0, 3, 2, 'San Juan De Isnotu, Via La Abeja, La A 100 Mtros Del Ambulatorio. Al Lado De Casa De La Cultura', '4147406892', 'yamilethrr45@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(616, '192.168.110.250', 'V10402033	', 'Lucya Briceño', 1, 4, 0, 3, 2, 'Sara Linda Parte Baja', '04263032527	', 'bricenolucy123@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(617, '192.168.110.251', 'V10400923', 'Alberto Dasilva', 1, 2, 0, 3, 2, 'La Laguneta Via Sabana Libre', '4147299648', 'portugues40_@outlook.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(618, '192.168.110.252', 'V 20430703', 'Eliana Marbelis Araujo Blanco', 1, 1, 0, 3, 2, 'Juan Diaz Calle Principal Diagonal Alas Malvina', '04247352957; 0424741', 'E20430703@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(619, '192.168.110.253', 'V23594320	', 'Nathaly Briceño', 1, 2, 0, 3, 2, 'Sabana Libre Diagonal Al Palon', '04247063440	', 'nathalyviviana29@gmAil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(620, '192.168.110.254', 'V31814974', 'Moises Alvarez', 1, 4, 0, 3, 2, 'San Agustin Diagonal A La Cancha', '4149795821', 'alvarezmoises1e@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(621, '192.168.110.26', 'V17266063', 'Daniel Manzanilla', 2, 3, 0, 3, 2, 'San Agustin Parte Baja', '4147359867', 'angelmanzanilla93@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(622, '192.168.110.27', 'V17094584', 'Christopher Jose Osorio Peña ', 2, 3, 0, 3, 2, 'San Juan Sector La Union, Callejon Luego De La Alcantarilla Ref: Casa De Rejas Blancas Y Barda De Ciclon ', '4145525363', '83christoosorio@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(623, '192.168.110.28', 'V29683208', 'Javier Salazar', 2, 3, 0, 3, 2, 'San Agustin Rafael Rangel', '4247401731', 'PENDIENTE', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(624, '192.168.110.29', 'V5495907', 'Mireya Josefina Caldera Valero (Padre Johan)', 2, 3, 0, 3, 2, 'Sector San Agustin Parte Baja Via Isnotu Casa S/N', '4141751762', 'frayjohancaldera@gmal.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(625, '192.168.110.30', 'V25302986', 'Rafael Enrique Castellanos Otero', 2, 3, 0, 3, 2, 'San Juan Via Principal A 3 Calles De La Escuela', '4247653029', 'Pendiente', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(626, '192.168.110.31', 'V12797228', 'Thais Carolina Leon', 2, 3, 0, 3, 2, 'San Juan Las Rurales Casa S/N', '4268503710', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(627, '192.168.110.32', 'V8758388', 'Norla Beatriz Espinoza Viloria', 2, 3, 0, 3, 2, 'San Juan De Isnotu Las Rurales Casa 159', '4241945720', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(628, '192.168.110.33', 'V4657567', 'Carlos Adelmo Rosales Leon', 2, 3, 0, 3, 2, 'San Agustin, Mas Abajo De Taller Ricardo Manzanilla ', '4247759728', 'PENDIENTE ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(629, '192.168.110.34', 'V 26616550-8', 'Yuliana Espinoza Viloria ', 2, 3, 0, 3, 2, 'Calle Las Rurales A 6 Casas De La Doctora ', '4127989644', 'Y.ESPINOZA1310@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(630, '192.168.110.35', 'V14718970', 'Ender Matos', 2, 3, 0, 3, 2, 'San Agustin Parte Baja', '4147149230', 'matosepdval@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(631, '192.168.110.36', 'V12040903', 'Odalis Coromoto Morillo Quintero', 2, 3, 0, 3, 2, 'San Juan Cerca De La Casa De La Sra Yune Esposa De Juan', '4247208601', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(632, '192.168.110.37', 'V10104060', 'Doris Delgado', 2, 3, 0, 3, 2, 'San Agutin Parte Baja, Mas Abajo De La Cancha, Quinta Francisco Sn', '4147369379', 'PATRICIACARRILLO19.PC@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(633, '192.168.110.38', 'V19101364-', 'Ruben Osorio', 2, 3, 0, 3, 2, 'Sector Las Rurales, Via Principal San Juan De Isnotu. ', '4165646312', 'rubenmiguelosorio@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(634, '192.168.110.39', 'V 18350459', 'Angela Maria Peña Gonzalez', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector Las Rural Viejas Segunda Casa Aano Derecha', '4247446412', 'emiriangela1987@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(635, '192.168.110.40', 'V 9167108', 'Jose Gregorio Mendez Castro', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Las Rural Viejas Ante Penuntima Casa', '4247226791', 'Maryuriaponte32@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(636, '192.168.110.41', 'V 20656237', 'Jessica Carolina Moreno Rosales', 1, 2, 0, 3, 2, 'Calle El Gardin De Agonal Al Prescolar Casa Sin Numero ', '4149747789', 'Jessicacmr1992@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(637, '192.168.110.42', 'V 15953116-0', 'Alba Herrera Balasa', 1, 4, 0, 3, 2, 'Alto De Escuque Secorr Rurales Sector Las Travesias Casa Sin Numero', '4162509521', 'Herrerarosa1983@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(638, '192.168.110.43', 'V 27029169', 'Eliasibeth Daliana Rivero Vetencourt', 1, 1, 0, 3, 2, 'Escuque Valle Alto Una Cuadra Mas Arriba Del Colegio Primera Entrada A Mano De Recha Ultima Casa', '4249087885', 'ELIZAVETENCOURT9@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(639, '192.168.110.45', 'V 9000031', 'Alys Margarita Mendez Rivero', 2, 3, 0, 3, 2, 'San Juan De Isnotu Frete Al Colegio ', '4147459695', 'ALYSMMR@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(640, '192.168.110.46', 'V 15430537-4', 'Yoahana Rosaly Colmenares', 2, 3, 0, 3, 2, 'San Juan De Isnotu Urbanizacion Arturo Cardoso 0015', '4247095984', 'Yohacol@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(641, '192.168.110.47', 'V11316054-', 'Orlando Oscar Sosa Becerra', 2, 3, 0, 3, 2, 'Sector Los Faroles San Juan De Isnotu, A 100 Mtr De La Plaza', '4165367035', 'trujisosa2017@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(642, '192.168.110.49', 'V 16738345-5', 'Jose Alfredo Matos Matos', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Principal Casa Sin Numero A 100M De La Escuela Mano Derecha', '4149743325', 'JOSMAT.HERBAL@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(643, '192.168.110.50', 'V 11323792-5', 'Henry Alberto Diaz Rasse', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sectore La Abeja Alado De Casa Alta', '4147114744', 'henryalbertodiaz9246@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(644, '192.168.110.51', 'V 28445400', 'Javier Alejandro Montenegro Quintero ', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector Las Rurales Calle Principal Saliando Por El Estadio ', '4123642087', 'Javier.montenegroq@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(645, '192.168.110.52', 'V27251352', 'Desire Barrios', 2, 3, 0, 3, 2, 'Sector Las Rurales De San Juan, San Juan De Isnotu', '4147352274', 'desirevb0699@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(646, '192.168.110.53', 'V7819669', 'Chacomina Vñetrano', 2, 3, 0, 3, 2, 'San Juan De Isnotu Las Rurales Chao Pitisai Bajando Ala Iglesia Numero De Casa 15157', '4247234814', 'Chacovetrano20@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(647, '192.168.110.54	', 'V27245908-8', 'Auriliana Briceño', 2, 3, 0, 3, 2, 'San Jun De Isnotu Urbanización Arturo Cardoso', '04162039339	', 'Aurilianab@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(648, '192.168.110.55', 'V 11798531', 'Meri Del Socorro Paredes Leon', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector La Abajea A 200M Del Ambulatorio', '4247431348', 'mass200104@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(649, '192.168.110.56', 'V5497872-0', 'Lilia Margarita Viloria De Castro', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Los Faroles A Una Casa De La Tiendita Los Faroles', '4247638881', 'Liliamargaritaviloriadecastro@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(650, '192.168.110.57', 'V 18377672', 'Yarelis Del Valle Viloria ', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Chacoipitizai Ultima Casa Al Fondo ', '4247262568', 'Viloriayarelis4@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(651, '192.168.110.58', 'V 5764052', 'Antonio Ramon Carrillo Vielma ', 2, 3, 0, 3, 2, 'San De Isnotu Frete Al Estadio', '4247604763', 'Xoniaaraujo.9143@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(652, '192.168.110.59', 'V26616480', 'Katherinne Viloria', 2, 3, 0, 3, 2, 'San Juan De Isnotu, Sector Las Rurales, Diagonal Al Liceo Frente Al Estadio', '4247355691', 'katherinneviloria5@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(653, '192.168.110.60', 'V 2145852-6', 'Manuel Antonio Rosales Bastidas ', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle El Ramal Subiendo Al 200M Del Colegio', '4149276501', 'Manuelrosalesbastidas43@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(654, '192.168.110.61', 'V 25454557', 'Maira Alajandra Carmona Avila', 2, 3, 0, 3, 2, 'San Agustin Parte Baja Alado De La Cancha ', '4247344281', 'mayracarmona740@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(655, '192.168.110.62', 'V 9179813', 'Rosa Alba Miranda Laguado', 1, 2, 0, 3, 2, 'Sabana Libre Urbanizacion Vista Hermosa Secto M (Nñ30) Segunda Etapa ', '4149627354', 'rosita1964miranda@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(656, '192.168.110.63', 'V 27415631', 'Maibelyn Carolina Moreno Vieras', 1, 2, 0, 3, 2, 'Sabana Libre Urbanizacion Vista Hermosa Sector Los Pardillos', '4126530206', 'Maibelyncarolina0206@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(657, '192.168.110.64', 'V 24786290', 'Aliris Eliza  Cañizales Ciervo', 1, 2, 0, 3, 2, 'Sabana Libre Urbanizacion Vista Hermosa Sector O  Frete Al Parque ', '4147538549', 'canizalezaliris3@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(658, '192.168.110.65', 'V 30434728', 'Yetzali Daschiell Aldana Nuñez', 1, 2, 0, 3, 2, 'Sabana Libre Urbanizacion Vista Hermosa La Primera Entrada Subiendo Ala Izquierda Casa D 8', '4247053344', 'YALDANA004@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(659, '192.168.110.66', 'V 16354587', 'Daniel Alcides Tomey Millan ', 1, 2, 0, 3, 2, 'Sabana Libre Urbanizacion Vista Hermosa Sector A Numero De Casa A36', '4120449910', 'danieltomey2011@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(660, '192.168.110.67', 'V 12044124', 'Carlos Luis Rivas Rivas', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector La Abeja Parte Baja Las Poncho Ultima Casa', '4147233499', '12044124moi@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(661, '192.168.110.68', 'V18457657', 'Ismael Araujo', 1, 2, 0, 3, 2, 'Piscina Los Bohios', '4166740697', 'lcdo.ismaelaraujo@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(662, '192.168.110.69', 'V 12040555', 'Fredy Alberto Leon Perez', 2, 3, 0, 3, 2, 'San Juen De Isnotu Sector La Abeja Casa Bodega La Abaje', '4147536325', 'Leofredi213@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(663, '192.168.110.70', 'V 20655019', 'Milanyela Katerine Rivas Ramirez ', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector La Abeja Calle Proncipla Parte Alta Frete Ala Cruz ', '4247080469', 'aranzhami@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(664, '192.168.110.71', 'V 29539026', 'Andres David Villarreal Castro', 2, 3, 0, 3, 2, 'San Juan De Isnotu Urbanizacion Arturo Cardos Segunda Casa A Mano Izquierda ', '4260477783', 'andresdavidvillarrealcas@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(665, '192.168.110.72', 'V12456366', 'Dulce Viloria', 1, 2, 0, 3, 2, 'Sector Los Canaletes', '4164721092', 'dulceparra463@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(666, '192.168.110.73', 'V2146446', 'Ramon Marin', 1, 7, 0, 3, 2, 'El Alto Calle Santa Rosalia', '4247561413', 'ltm201510@gmaul.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(667, '192.168.110.74', 'V 23782383', 'Rosa Hortensia Ordoñez C', 2, 3, 0, 3, 2, 'San Agustin Carretera Vieja Via A Isnotu A Una Casa De La Cancha', '4247331410', 'rosaordones772@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(668, '192.168.110.75', 'V 10914992', 'Milagros Del Carmen Vielma Mendez', 2, 3, 0, 3, 2, 'Sanjuan De Isnotu Urbanizacion Arturo Cardoso Segunda Calle La Tersera Casa A Mano Derecha', '4245617261', 'MilagrosV1971@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(669, '192.168.110.76', 'V 32621373', 'Marianny Victoria Nava Silva ', 2, 3, 0, 3, 2, 'San Juan De Isnotu Urbanizacion Arturo Cardoso Primera Calle Al Fondo Por El Callejon  Bajando Las Escaleras Casa Sin Numero', '4147540610', 'navasilvamariannyvictoriann@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(670, '192.168.110.77	', 'V', 'Luis David Duran Briceño', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Leonardo Ruiz Pineda  En Le Taller Mecánico', '04247690410	', 'dd7077891@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(671, '192.168.110.78', 'V16267459', 'Gladis Paredes', 1, 4, 0, 3, 2, 'Sector Quinquinillo Casa 70', '4140823376', 'gladisparedes286@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(672, '192.168.110.79', 'V 4665056', 'Olga Marina Nava Leon', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector Las Rurales Viejas Frente Ala Señora Angela', '4145194496', 'Olgamarinanava20@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(673, '192.168.110.80	', 'V10035597	', 'Ingrid Teresa Briceño', 1, 2, 0, 3, 2, 'Vista Hermosa2 Calle La Paz Casa M18', '+34613764899', 'ingridbriceno10@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(674, '192.168.110.81', 'V 19898626', 'Anyi Nakari Leon', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector La Abeja Entre La Division Parta Alta Y Baja Casa Del Medio ', '4247584441', 'anyinakari0508@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(675, '192.168.110.82', 'V15411910', 'Jorge Silva', 1, 2, 0, 3, 2, 'A Un Lado Del Liceo Casa Invasion', '4122069492', 'gonzaleztiofilo275@ Gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(676, '192.168.110.83', 'V 13261265', 'Macrim Pilar Sosa', 2, 3, 0, 3, 2, 'San Juan De Isnotu Sector La Abeja Parte Baja Quinta Casa A Mano Izquierda ', '4247465155', 'macrimsosa9@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(677, '192.168.110.84', 'V13064613', 'Erly Jose Peña Toro', 2, 3, 0, 3, 2, 'San Agustin Parte Baja A 200M Del Puente Casa Sin Numero Alado Isquierdo Subiendo ', '4247128427', 'erlypena8@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(678, '192.168.110.85', 'V 21366526', 'Diego Jose Leon Viloria ', 2, 3, 0, 3, 2, 'San Juan De Isnotu Clle Principal Alado De La Iglesia', '4247325829', 'matosmariarojasjose@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(679, '192.168.110.86', 'V20706819', 'Julio Kisis', 1, 2, 0, 3, 2, 'Vista Hermosa Segunda Etapa Calle N Penultima Casa', '4162611675', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(680, '192.168.110.87', 'V 15584644', 'Belkis Del Carmen Soler Azuaje', 2, 3, 0, 3, 2, 'San Juan De Isnotu Las Rurales Casa 15B1', '4247380113', 'Esteban35qc@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(681, '192.168.110.88', 'V 9318312', 'Nelson Jose Ramirez Torres', 2, 3, 0, 3, 2, 'San Juan De Isnotu Urbanizacion Arturo Cardoso Numero De Casa 15', '4140780485', 'diosmarr41@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(682, '192.168.110.89', 'V13262773', 'Gledys Manzanilla', 1, 5, 0, 3, 2, 'Sector Las Antenas', '4147264320', 'gledysmanzanilla22@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(683, '192.168.110.90', 'V 9176916-2', 'Elvis Jose Vielma Mendez', 2, 3, 0, 3, 2, 'San Agustin Parte Baja Alado Del Señor Carlos Gonzalez Leon', '4247192238', 'yaniscast70@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(684, '192.168.110.91', 'V4063906', 'Magaly Rojas', 1, 4, 0, 3, 2, 'Sector La Bomba Frente Al Potrero', '4164098863', 'tobiasmontiel4@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(685, '192.168.110.92', 'V 17266190-0', 'Endy Javier Viloria Ramirez', 2, 3, 0, 3, 2, 'San Juan De Isnotu Calle Principal Alado De La Casa De Sr Mario Valera', '4247584129', 'endyviloria@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(686, '192.168.110.93', 'V11323262', 'Aura Hernandez', 1, 4, 0, 3, 2, 'Las Malvinas', '4167967114', 'auradhernandez@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(687, '192.168.110.94', 'V19812552', 'Juan Diego Delgado', 1, 1, 0, 3, 2, 'Valle Alto Mas Abajo De La Escuela', '4147567596', 'juandelgado3619@gmqil.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(688, '192.168.110.95', 'V 16535063', 'Maria Mercedes Duarte De Briceño( Escuela Batalla De Ponemesa)', 1, 4, 0, 8, 2, 'Las Cruces De La Union Calle Principal Escuela Batalla De Ponemesa', '04247383662; 0424780', 'alonso23maria@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(689, '192.168.110.96', 'V19794880	', 'Maria Teresa Peña', 1, 5, 0, 3, 2, 'La Mata Sector Las Antenas Casa 199	', '04160690580	', 'mariatpl90@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(692, '192.168.110.99', 'V10395085', 'Maria Rivas', 1, 2, 0, 3, 2, 'Vista Hermosa Sector E Casa E7', '4147241184', 'privasmaria@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(693, '192.168.120.100', 'V19102456', 'Alexandra Garcia', 1, 2, 0, 3, 2, 'Urb La Ciudadela Calle 1 Casa 4', '4247299903', 'alexandragarciar65@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(694, '192.168.120.101', 'V21612489', 'Keila Castro', 1, 4, 0, 3, 2, 'Sector Quevedo Parte Alta 2', '4247289641', 'keilaacastro66@gamil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(695, '192.168.120.102', 'V14150028', 'John Sanchez', 1, 2, 0, 3, 2, 'Urb La Ciudadela Calle 1 Casa 5', '4247518544', 'sanchezjohn.0602@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(696, '192.168.120.103', 'V16607572', 'Arnaldo Paez', 1, 4, 0, 3, 2, 'El Alto De Escuque Las Rurares De Tras Del Estadio Primera Wntrada Mano Isquierda Un Chalet Con Picina ', '4246833175', 'Arnaldop05@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(697, '192.168.120.104', 'V13632146', 'Yoleida Ramirez', 1, 2, 0, 3, 2, 'Sector Santa Maria', '4124967312', 'yoleram2020@gmail.con', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(698, '192.168.120.105', 'V18802896', 'Angel Bracho', 1, 1, 0, 3, 2, 'Sector Conucos De La Paz Via A La Mata', '4247480926', 'angelalbertobra85@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(699, '192.168.120.106', 'V30867516', 'Mariana Ramirez', 1, 5, 0, 3, 2, 'Quevedo Sector Cano', '4129215373', 'mg5944788@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(700, '192.168.120.107', 'V5178354', 'Jorge Luis Negrette Cardozo', 1, 5, 0, 3, 2, 'Sector Quevedo Casa S/N', '4121650047/426981343', 'jlnegrette@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(701, '192.168.120.11', 'V28002563', 'Astrid Herrera', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Casa E-15', '4247440231', 'Astridherrera1130@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(702, '192.168.120.110', 'V12039751', 'Sonia Quintero', 1, 4, 0, 3, 2, 'La Laja Parte Alta Frente A La Iglesia', '04247370521; 0426767', 'quinterosonia809@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(703, '192.168.120.112', 'V29691329', 'Roberto Mavarez', 2, 3, 0, 3, 2, 'Sara Linda Sector Las Carmelitas Calle 2', '4264608105', 'robertomavarez327@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(704, '192.168.120.113', 'V13765180', 'Yohan Perez', 1, 2, 0, 3, 2, 'Mas Abajo De La Gallera Calle Ferrer', '4248647758', 'yohanpv@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(705, '192.168.120.114', 'V28445733', 'Andres Parra', 1, 2, 0, 3, 2, 'Subiendo Por Mi Delirio Cuarta Casa De Dos Pisos De Color Blanco', '4247270190', 'andresparra1507@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(706, '192.168.120.115', 'V30600862', 'Pier Pineda', 2, 3, 0, 3, 2, 'San Juan A Una Cuadra Despues De La Escuela Casa 10', '4247272740', 'pierpineda25@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(707, '192.168.120.116', 'V25485676', 'Wilson Montilla', 1, 2, 0, 3, 2, 'La Laja Parte Alta', '4245343512', 'w25485676@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(708, '192.168.120.117', 'V13404716', 'Marleny Blanco', 2, 3, 0, 3, 2, 'La Abeja Parte Alta Casa De Muro De Piedra', '4247742915', 'marleny13404@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(709, '192.168.120.118', 'V9312047', 'Aracelis Delgado', 1, 2, 0, 3, 2, 'Calle San Agustin Final De La Calle Ciega', '4123704977', 'aracelisdelgado50@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(710, '192.168.120.119', 'V13049416', 'Josefina Valero', 1, 2, 0, 3, 2, 'Calle Ferrer Ultima Casa', '4260551336', 'josefinatarazona1@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(711, '192.168.120.12', 'V12038076', 'Jeanneth Rosa Gonzalez De Estevanez', 2, 3, 0, 3, 2, 'Altos De Sara Linda Finca La W', '4167066747/426062196', 'sebastianestebanezgonzalez@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(712, '192.168.120.120', 'V18984596', 'Normaryuri Montilla', 1, 5, 0, 3, 2, 'La Mata Urb San Jose', '424796452', 'vallenormamontilla@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(713, '192.168.120.121', 'V26962324', 'Daniel Valero ', 1, 4, 0, 3, 2, 'Sector Juan Diaz Detras De La Escuela ', '(+56 958077487)', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(714, '192.168.120.122', 'V14328988', 'Gustavo Vasquez', 1, 2, 0, 3, 2, 'Sector Santa Maria Caserio , Parte Baja, Local S/N Rincon De Toño;', '4261736703', 'gustavo12papi@gmail', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(715, '192.168.120.123', 'V11898358', 'Dayana Perez', 1, 2, 0, 3, 2, 'Mas Abajo De La Escuela Neptali', '4247189386', 'sadiani210603@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(716, '192.168.120.124', 'V17391829', 'Maquelin Atencio', 1, 2, 0, 3, 2, 'Calle Las Flores Con 24 De Julio', '4141762760', 'atenciomaquelin@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(717, '192.168.120.125', 'v15583653', 'Yelitza Briceño', 1, 2, 0, 3, 2, 'Calle Barrio Lindo', '04147085394	', 'yelit.brice@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(718, '192.168.120.126', 'V15825365', 'Menyer Viloria', 1, 1, 0, 3, 2, 'Mas Arriba Del Palon', '4247570150', 'menyervil@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(719, '192.168.120.127', 'V28323213', 'Daniela Suarez', 1, 2, 0, 3, 2, 'Calle La Democracia Bajando De La Bodega Kikiriki Casa Fucsia Rejas Marron', '4269026168', 'danielasuarezolmos@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(720, '192.168.120.128', 'V11897682', 'Maryoli Uzcategui', 1, 2, 0, 3, 2, 'Una Cuadra Antes Del Cementerio', '4247619446', 'maryoliuzcategui24@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(721, '192.168.120.129', 'V6371085', 'Lilian Delgado', 2, 3, 0, 3, 2, 'San Pedro Finca El Pedregalito', '4147263725', 'liliandelgado06@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(722, '192.168.120.13', 'V 7543115', 'Yelitza Del Pilar Rodriguez ', 1, 1, 0, 3, 2, 'Sector El Pepo Barrio Niño Jesus Casa Numero 8 ', '4147013459', 'YELITZARodriguez305@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(723, '192.168.120.130', 'V17605237', 'Agnny Molina', 1, 2, 0, 3, 2, 'Calle Barrio Lindo', '4163783214', 'agnnymolina109@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(724, '192.168.120.131', 'V18250808', 'Darlys Granda', 1, 2, 0, 3, 2, 'Calle San Agustin', '4246007611', 'catalinacañizalez71@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(725, '192.168.120.132', 'V25604027	', 'Carolina Peña', 1, 4, 0, 3, 2, 'El Alto Sector Divino Niño', '04165521744	', 'launionlasruralesmsv0@gmail.com\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(726, '192.168.120.133', 'V12796429', 'Isabel Rojo', 1, 1, 0, 3, 2, 'Sector El Pepo Calle Niño Jesus', '4266038860', 'isabelteresarojoaraujo@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(727, '192.168.120.134', 'V11250505', 'Luis Antonio Duque', 1, 4, 0, 3, 2, 'Sector La Quinta Chalet Marron De Dos Pisos A Un La Do De La Escuela Luis Beltran', '4140677578', 'claudiapdfster@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(728, '192.168.120.135', 'V30600365', 'Veronica Parra', 1, 2, 0, 3, 2, 'A Una Cuadra De La Plaza Bolivar Subiendo Por La Principal', '4164787788', 'verofpp0908@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(729, '192.168.120.136', 'V29638391', 'Oscar Arellano', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa', '4247133792', 'arellanooscar725@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(730, '192.168.120.138', 'V16738751', 'Ender Jose Perez Romero', 2, 3, 0, 3, 2, 'Sector La Abeja, Via San Pedro', '04147546603; 0424743', 'yorgenispacheco2004@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(731, '192.168.120.139', 'V24341196', 'Yessenia Rondon', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja, Via Principal, Sector San Pedro Viejo', '4262348401', 'RONDONYESSENIA311@GMAIL.COM ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(732, '192.168.120.14', 'V14718785', 'Carla Rosales', 2, 3, 0, 3, 2, 'Sara Linda Chicharronera El Saman', '4247733867', 'carlita-rosco@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(733, '192.168.120.140', 'V23777885', 'Moises Viloria', 1, 2, 0, 3, 2, 'Mas Arriba Del Hotel Mi Delirio', '4247729987', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO');
INSERT INTO `contratos` (`id`, `ip`, `cedula`, `nombre_completo`, `id_municipio`, `id_parroquia`, `id_comunidad`, `id_plan`, `id_vendedor`, `direccion`, `telefono`, `correo`, `fecha_instalacion`, `ident_caja_nap`, `puerto_nap`, `num_presinto_odn`, `id_olt`, `id_pon`, `estado`) VALUES
(734, '192.168.120.141', 'V15824924', 'Pablo Cabrera', 1, 2, 0, 3, 2, 'Calle Comercio El Cyber', '4263260458', 'pablojcabrerav@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(735, '192.168.120.142', 'V15824924', 'Betania Paredes', 1, 2, 0, 3, 2, 'La Ciudadela Tercera Calle Casa 72', '4263260458', 'betaniap21@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(736, '192.168.120.143', 'V10319129', 'Zenaida Perdomo', 1, 2, 0, 3, 2, 'La Ciudadela Primera Calle Casa 6', '4167706946', 'zenaidaperdomo7@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(737, '192.168.120.144', 'V10038868', 'Jorge Perdomo', 1, 2, 0, 3, 2, 'Antes Del Palon Negocio De Henrry', '4267718381', 'jorgeperdomo300168@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(738, '192.168.120.145', 'V20488858', 'Estefani Lobo', 1, 5, 0, 3, 2, 'La Mata Esquina De La Cancha', '4121148842', 'estefanilobo01@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(739, '192.168.120.146', 'V9003462', 'Cleofe Matheus', 1, 1, 0, 3, 2, 'Las Calas 2,(Porton Marron) Via Juan Diaz.', '04247335866 / 041298', 'Pendiente', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(740, '192.168.120.147', 'V10914072', 'Nelson Araujo', 1, 4, 0, 3, 2, 'El Alto Calle Santa Rosalia', '4247433230', 'adrianyovanny2002@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(741, '192.168.120.148', 'V15043438', 'Luis Suarez', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Casa A11', '4120147671', 'luismaui1980@icloud.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(742, '192.168.120.149', 'V24139534', 'Yormary Ramos', 2, 3, 0, 3, 2, 'San Agustin Subiendo El Puente Diagonal A La Iglesia', '4247188289', 'ramosmontillay@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(743, '192.168.120.15', 'V 17682708', 'Jesus Alberto Pacheco Prada ', 1, 1, 0, 3, 2, 'El Pepo Barrio Niño Jesus Numero De Casa 8', '4121478225', 'jp4741173@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(744, '192.168.120.150', 'V25919570', 'Isamar Elizabeth Mendoza Becerra', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja, Casa S/N Al Lado De La Iglesia Catolica', '4261545461', 'isamarm387@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(745, '192.168.120.151', 'V12040709', 'Alexander Enrique Cabrita Montilla', 1, 4, 0, 3, 2, 'Sector El Pao Casa S/N', '4123603346', 'alexandercabrita12@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(746, '192.168.120.152', 'V16534556', 'Maria Teresa Moreno Viloria (Bodega)', 1, 4, 0, 3, 2, 'Sector La Quinta Via Principal ', '4261408420', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(747, '192.168.120.153', 'V11895409', 'Ramon Manzanilla', 1, 5, 0, 3, 2, 'La Mata Calle Las Dalias Parte Alta', '4160107705', 'ramonmanzanilla23@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(748, '192.168.120.154', 'V16017161', 'Carlos Enrique Rondon Avila', 1, 4, 0, 3, 2, 'El Pao, Parte Alta Calle Tapon', '4126719880', 'rondoncarlos@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(749, '192.168.120.155', 'V10398052', 'Mariela Guerrero', 1, 2, 0, 3, 2, 'Calle 5 De Julio', '4147297033', 'mariela-guerrero1@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(750, '192.168.120.156', 'V29994630', 'Yanelyn Garcia', 1, 5, 0, 3, 2, 'Quevedo Sector La Esperanza', '4164118245', 'garciayanely3@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(751, '192.168.120.158', 'V20040577', 'Gustavo Ruiz', 1, 5, 0, 3, 2, 'La Mata Sector Zaruma', '4267749788', 'rosiemendoza2811@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(752, '192.168.120.159', 'V29539239', 'Eduar Urbina', 1, 2, 0, 3, 2, 'Sabana Libre Antes Del Palon', '4166763310', 'eduarsimancas@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(753, '192.168.120.16', 'V9158318', 'Yasenia Forfara', 1, 4, 0, 3, 2, 'La Laja Parte Alta Mas Abajo De La Iglesia', '4124259958', 'yaseniaforfara@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(754, '192.168.120.160', 'V17392850', 'Ivan Viloria', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Por La Alcantarilla Casa A Mano Derecha ', '4146758948', 'delgadobrayannis@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(755, '192.168.120.161', 'V11798848	', 'Evelyn Briceño', 1, 2, 0, 3, 2, 'La Laja Parte Baja', '04247274996	', 'evelynbriceno38@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(756, '192.168.120.162', 'V4523974', 'Maritza Moreno', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Casa B-18', '4122099080', 'maritmoreno48@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(757, '192.168.120.163', 'V18097365	', 'Julio Peña', 1, 2, 0, 3, 2, 'La Farmacia Esquina De La Oficina Galanet', '04247644603	', 'multiserviciossulgicar@gmail.com\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(758, '192.168.120.164', 'V16881806', 'Humberto Suarez', 1, 5, 0, 3, 2, 'La Mata Via A Los Conucos De La Paz', '04162106588; 0424706', 'matoslilibeth338@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(759, '192.168.120.165', 'V9171533', 'Maria Erlida Hernandez', 1, 1, 0, 3, 2, 'Juan Diaz Callejon Los Pinos', '4165650898', 'mariaerlindaheenandez@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(760, '192.168.120.166', 'V18097080', 'Yudith Valero', 1, 1, 0, 3, 2, 'Colinas De Carmania Frente A La Escuela', '4167049515', 'yadiracova23@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(761, '192.168.120.167', 'V10399133', 'Alexander Matos', 2, 3, 0, 3, 2, 'La Abeja Parte Baja Al Lado Del Trapiche Los Matos', '4267871629', 'matosclaret@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(762, '192.168.120.168', 'V18376342', 'Evelyn Hernandez', 2, 3, 0, 3, 2, 'San Juan Frente A La Casa De La Cultura', '4247203628', 'evelynvhm@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(763, '192.168.120.169', 'V15425960', 'Marielena Graterol', 1, 2, 0, 3, 2, 'Mas Abajo De La Plaza Donde Venden La Empanadas', '4247401126', 'marielenagraterol98@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(764, '192.168.120.17', 'V 16376281', 'Joel Francisco Abreu Duarte', 1, 2, 0, 3, 2, 'El Corosito De Sabana Libre Calle Principal Numero De Casa 27', '4265780240', 'Jhoea2006@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(765, '192.168.120.170', 'V30737999', 'Viviana Sanchez', 1, 2, 0, 3, 2, 'Despues Del Liceo Via A La Gallera Primera Casa', '4247278767', 'vivianasanchezopsu@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(766, '192.168.120.171', 'V19644098', 'Jose Hernandez', 1, 4, 0, 3, 2, 'El Boqueron Frente A La Casa Dende Venden Colombio', '4121737999', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(767, '192.168.120.172', 'V27497141', 'Roseilis Carrillo ', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja', '4268007305', 'roseiliscarrillos@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(768, '192.168.120.173', '', 'Victor Rodriguez', 1, 2, 0, 3, 2, 'Calle 24 De Julio Qta Mariana Coromoto', '04265720212; 0426240', 'totesauttvit1632@gamil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(769, '192.168.120.174', 'J-294038280', 'Inversiones Avicola C.A', 1, 5, 0, 3, 2, 'Quevedo Mas Abajo De La Escuela', '4146778151', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(770, '192.168.120.175', 'V10596245', 'Carlos Montiel', 1, 2, 0, 3, 2, 'El Corocitoantes De La Caja De Agua', '4264572708', 'Carlosmontielb2024@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(771, '192.168.120.176', 'V30976460', 'Andrea Rangel', 1, 4, 0, 3, 2, 'El Boqueron Frente A Manigueta', '4247332395', 'yoecoco18@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(772, '192.168.120.177', 'V3462077', 'Reyes De Jesus Rondon Gallardo', 1, 2, 0, 3, 2, 'Urb.  Vista Hermosa 2 M-22', '4245586642', 'mariannysr14@gmail.com/ Reyesrondon20@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(773, '192.168.120.178', 'V11894357', 'Jose Benito Angel Berrios', 1, 4, 0, 3, 2, 'Lalaja Parte Baja Sector Las Cruces', '0416 4682071', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(774, '192.168.120.179', 'V3838120', 'Eudocia Araujo', 1, 2, 0, 3, 2, 'Calle La Rivera Mas Abajo De La Fabrica De Urnas', '4143033309', 'Eudo787@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(775, '192.168.120.18', 'V 26877870', 'Luis Javier Valecillos Abreu ', 1, 1, 0, 3, 2, 'Corosito Sabana Libre Calle Principal Cerca De La Placita A 10M', '4141756811', 'Valecillosl400@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(776, '192.168.120.180', 'V27415575', 'Rainibeth Orellana', 1, 2, 0, 3, 2, 'Local Frente A La Plaza Bolivar', '4262212756', 'rainibethorellana8@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(777, '192.168.120.182', 'V15735098', 'Lisbeth Perez', 1, 1, 0, 3, 2, 'Valle Alto Mas Arriba De La Escuela Callejon El Sanjon', '4122622253', 'perezlisbeth15735098@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(778, '192.168.120.183', 'V21364975', 'Cristabel Gonzalez', 1, 5, 0, 3, 2, 'La Mata Sector Las Dalias Parte Alta Via A Quevedo', '4247135817', 'cristabelunesr@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(779, '192.168.120.184', 'V19147690	', 'Ronald Briceño', 1, 2, 0, 3, 2, 'La Ciudadela Tercera Entrada Casa 81', '04247610392	', 'ronalbriceño64@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(780, '192.168.120.185', 'V26046585', 'Enyely Aguilar', 1, 1, 0, 3, 2, 'Conucos De La Paz Esquina De La Cancha Final De La Calle De Tierra', '4247393926', 'enyelyaguilar123@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(781, '192.168.120.186', 'V13897129', 'Yetzenia Rosales', 1, 1, 0, 3, 2, 'La Constituyente Donde Esta El Tanque De Agua Casa Blanca Al Final De La Calle De Tierra', '4126557229', 'yererosal@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(782, '192.168.120.187', 'V7765187', 'Zoraida Medero De Espinoza', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Calle Las Flores Casa A-41', '4245441248', 'espinozaeli20dd@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(783, '192.168.120.188', 'V10035031', 'Wuilian Valbuena', 1, 2, 0, 3, 2, 'Casa Frente Al Negocio De Bladimir Esquina Para Cruzar Via El Cementerio', '4247125210', 'andreinapineda43@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(784, '192.168.120.189', '', 'Gustavo Morillo ', 1, 1, 0, 3, 2, 'Juan Diaz Detras Del Parque Eskukey', '4147962988', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(785, '192.168.120.19', 'V25006957', 'Mildred Matheus', 1, 1, 0, 3, 2, 'Puerto Escondido Mas Abajo De Los Chalet', '4125688112', 'mildredmatheus768@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(786, '192.168.120.190', 'V', 'Yesika Cardozo', 1, 2, 0, 3, 2, 'Calle Barrio Lindo A Un Lado De La Capilla De San Benito', '4147962988', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(787, '192.168.120.191', 'V26094120', 'Vanesa Duarte', 1, 2, 0, 3, 2, '', '4247640012', 'Maldonadovanesa33@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(788, '192.168.120.192', 'V14544173', 'Antonio Bermudez', 1, 4, 0, 3, 2, 'Sector Quinquinillo Resid. Las Piedras Ultima Casa Via Al Boqueron', '4265701646', 'tonymp4@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(789, '192.168.120.193', 'V30866802	', 'Manuel Briceño	', 1, 2, 0, 3, 2, 'Brisas De San Benito Tercera Entrada A Mano Derecha Casa 2', '04247775931	', 'Manuel.briceno.2004@gmail.com\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(790, '192.168.120.194', 'V14148823', 'Ruben Gonzalez', 1, 1, 0, 3, 2, 'La Constituyente Por Detras Del Tanque', '4247675346', 'yonkleiberalejandro2009@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(791, '192.168.120.195', 'V13764282', 'Marilu Garcia', 1, 1, 0, 3, 2, 'Valle Alto Mas Arriba De La Escuela Por El Lado Del Sanjon', '4263778732', 'pp0364369@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(792, '192.168.120.196', 'V-83622882', 'Rainer Yrala', 2, 3, 0, 3, 2, 'San Juan Sector La Abeja Parte Baja Cerca Del Negocio De Gea', '4215918728', 'fabianayrala1@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(793, '192.168.120.197', 'V15751597', 'Nairobi Rivero', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Sector Las Carmelitas Detras Del Ginnacio', '4161943945', 'valentineuzcategui750@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(794, '192.168.120.198', 'V29694835', 'Andrea Villarreal', 2, 3, 0, 3, 2, '', '4247342016', 'villarreallealandreapaola@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(795, '192.168.120.199', 'V20428836', 'Hugo Pereira', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Detras De La Bodega Benedicto Montilla', '4162243867', 'pereirahugofernando@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(796, '192.168.120.20', 'V26046633', 'Geraldin Nava', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja', '4247763763', 'navageraniedelcarmen@gmqil.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(797, '192.168.120.200', 'V33465128', 'Paola Castellanos', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Despues De La Alcantarilla Casa En La Popa', '4262099148', 'castellanospaola95@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(798, '192.168.120.201', 'V30036356', 'Angel Briceño', 1, 2, 0, 3, 2, 'Vista Hermosa Segunda Etapa Casa M-4', '04120139571', 'imbriic20@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(799, '192.168.120.202', 'V12045289', 'Rosario Suarez', 1, 2, 0, 3, 2, 'Via Al Alto La Casa Queda Frenta Al Tanque De Agua De Color Rojo', '4249548673', 'rusielpena@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(800, '192.168.120.203', 'V10318504', 'Leonet Rosales Quintero', 1, 4, 0, 3, 2, 'La Quinta Al Lado De La Tienda Del Señor Normes Casa Blanca De 2 Pisos', '04147415598; 0424776', 'Metqrosales@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(801, '192.168.120.204', 'V7607806', 'Omaira Villasmil', 1, 4, 0, 3, 2, 'Detras Del Estadio Del Alto En Toda La Esquina Casa Azul', '4146839991', 'villasmilomaira06@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(802, '192.168.120.205', 'V9172926', 'Xiomara Vielma', 2, 3, 0, 3, 2, 'San Juan Urb Arturo Cardozo Casa 4', '4247288147', 'xiomarvielma63@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(803, '192.168.120.206', 'V19427358', 'Micheel Noe Araujo Mendoza', 1, 4, 0, 3, 2, 'Sector La Popa Las Cruces De La Union ', '4266040332', 'michael_noe@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(804, '192.168.120.207', 'V11894331', 'Manuel Zambrano', 1, 2, 0, 3, 2, 'Los Pinos Parte Alta Detras Del Cementerio', '4247743734', 'zulayaraujo@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(805, '192.168.120.208', 'V32374038', 'Miguel Montilla', 1, 1, 0, 3, 2, 'Valle Alto Mas Arriba De La Escuela Frente A Donde Chande', '4121694993', 'dgfxvhx5@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(806, '192.168.120.209', 'V20098139', 'Yonexy Pulido', 1, 2, 0, 3, 2, 'Brisas De San Benito Subiendo El Paron Carretera De Tierra Segunda Entrada A Mano Derecha Segunda Casa', '1217465372', 'yonexypulido33@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(807, '192.168.120.21', 'V 28096329', 'Yugueixy Agilar ', 1, 4, 0, 3, 2, 'La Laja Parte Alta El Reten Sin Numero De Casa Frente Ala Caja N ', '4167113117', 'Abranmigueloquendoagilar@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(808, '192.168.120.210', 'V13001771', 'Gustavo Reyes', 1, 4, 0, 1, 2, 'Via Ppal De Quevedo Sector Las Rurales Despues Del Cuales De Madera ', '4146173719', 'reygusrey@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(809, '192.168.120.211', 'V24881547', 'Niobes Garcia', 1, 4, 0, 3, 2, 'Las Cruces De La Union Final De La Escuela A Mano Derecha Segunda Casa', '4147223349', 'niobesgarcia1745@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(810, '192.168.120.212', 'V20708842', 'Milay Uzcategui', 1, 5, 0, 3, 2, 'Las Rurales Del Alto Atras Del Estadio Bajando Las Escaleras Primera Casa', '4162086371', 'milayuzcategui5@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(811, '192.168.120.213', 'V10399501', 'Iria Teran', 1, 2, 0, 3, 2, 'La Laja Parte Alta Frente A La Iglesia ', '4147448204', 'iriateran8@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(812, '192.168.120.214', 'V5495369', 'Gladys Viloria', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Casa A-43', '4260385364', 'gladysviloria72@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(813, '192.168.120.215', 'V4058792', 'Alexis Olmos', 1, 2, 0, 3, 2, 'Mas Arriba Del Palo A Cuadra Y Media Subiendo A Mano Derecha Casa De Dos Pisos De Laja Roja', '4147355680', 'lic.alexis.7@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(814, '192.168.120.216', 'V29633783', 'Victor Vergara', 1, 4, 0, 3, 2, 'El Boqueron Sector El Taladro Mas Abajo De La Alcantarilla Casa A Un Lado Del Español', '4169227812', 'veitza2013@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(815, '192.168.120.217', 'V10913428', 'Gilberto Matheus', 1, 1, 0, 3, 2, 'Juan Diaz Mas Abajo De La Tostadora Frente A La Fruteria', '4247792678', 'gmatheussilva@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(816, '192.168.120.218', 'V25454482', 'Jorge Guerrero', 1, 2, 0, 3, 2, 'Av 5 De Julio Casa Blanca A Un Lado- Terreno Donde Estan Construyendo Varias Casas', '4147013849', 'jg141045780@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(817, '192.168.120.219', 'V4324229', 'Ricardo Jose Briceño Nava ', 1, 2, 0, 3, 2, 'Calle San Rafael Casa S/N ', '4247671291', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(818, '192.168.120.22', 'V13727983', 'Maria Toro', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja', '4247626088', 'mariatoro443@gmqil.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(819, '192.168.120.220', 'V11619865', 'Liseth Del Valle Valera Quevedo', 1, 5, 0, 3, 2, 'Ezequiel Zamora A Mano Derecha De La Tiendita Verde Casa Al Fondo', '04247139086; 0416715', 'Lisettvalera1@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(820, '192.168.120.221', 'V27628564', 'Jorge Francisco Silva', 1, 2, 0, 3, 2, 'Calle En Cementerio Sector Los Pinos Casa El La Esquina Para Bajar Por La Calle Del Ambulatorio Casa Sin Numero ', '4147543527', 'Camilavsilva309@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(821, '192.168.120.222', 'V 25374352-9', 'Miguel Alejandro Rojas Montilla', 2, 3, 0, 3, 2, 'San Pedro Avenida Principal Inverciones Migmat', '04267804670; 0414349', 'miguearm93@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(822, '192.168.120.223', 'V18458823', 'Robert Jose Villegas Rosario', 2, 3, 0, 3, 2, 'San Predo Parte Baja Sector Aguas Clara Frente Ala Cancha ', '04247343828; ', 'Rojoviro@hotmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(823, '192.168.120.224', 'V 6871612-4', 'Berta Elena Montilla Contreras', 2, 3, 0, 3, 2, 'Sara Linda Panamericana Chicharron El Bohio', '4163216699', 'Monberta2022@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(824, '192.168.120.225', 'V27497249', 'Francis Yessel Leon Briceño', 1, 5, 0, 3, 2, 'La Mata Sector El Terreno Entrada Al Estadio Frente De Los Baños Del Estadio', '04247064318; 04247327986', 'Francisleon.3006@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(825, '192.168.120.226', 'V 28206456', 'Keli Yohana Montilla Castro', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Sector Los Picapiedras La Entrada Antes Del Trapiche El General', '04160119595; 0412173', 'Yohanamon30@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(826, '192.168.120.227', 'V12044097-3', 'Dolis Del Carmen Briceño Molina ', 2, 3, 0, 3, 2, 'San Agustin Bajando Por La Cancha Cayejon Numero Uno Mano Izquierda', '4161806878', 'Dolisbriceno@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(827, '192.168.120.228', 'V25733577-8', 'Jose Gregorio Leon Uscategi', 1, 4, 0, 3, 2, 'El Alto De Escuque Avenida Principal Por El Callejon Del Ambulatorio Casa En La Esquina ', '4247070088', 'j_leon_15@hotmail.es', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(828, '192.168.120.229', 'V 12038064', 'Levis Olnedo Lineres Teran', 1, 5, 0, 3, 2, 'Urbanismo San Jose Casa 5', '04126404342; 0424775', 'levisolmedolcdo@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(829, '192.168.120.23', 'V 10912977-0', 'Carlos Antonio Orellana Rubio', 1, 2, 0, 3, 2, 'Los Canaletes Calle La Rivera Casa Sin Numero A 150M De La Casa De La Fabricacion De Hurnas ', '4269628417', 'eliandroorellanar@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(830, '192.168.120.230', 'V 9323490', 'Yoleida Jisefina Bastidas De Alvarez', 1, 2, 0, 3, 2, 'Vista Hermosa Segunda Etapa Avenida Los Pardillos L15', '4123143638', 'Yoleidabastidas47@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(831, '192.168.120.231', 'V 24566088', 'David Alexander Perez Abreu', 1, 5, 0, 3, 2, 'Calinas De Carmania 4T Calle Casa Numero 105', '04262405820; 0412934', 'Davidperez00abreu@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(832, '192.168.120.232', 'V 9325367-8', 'Avilio Jose Fria Agilar', 1, 2, 0, 3, 2, 'Calle Media Rosca 2 Casas Bajando A La Señora De Las Masas ', '041201898165; 041673', 'ffria38@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(833, '192.168.120.233', 'V 23594554', 'Daniel Alexander Rangel Molina', 1, 5, 0, 3, 2, 'La Mata Via Principal Bajando Los Conucos Casa Numero 66 Segundo Piso ', '+57 3023183725', 'Danielrangelmolina1@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(834, '192.168.120.234', 'V 11125785', 'Lucrecia Yakelin Araujo Abreu', 1, 2, 0, 3, 2, 'Calle La Union Casa Sin Numero A 2 Casas De La Bodega De Andres ', '04264723788; 0412793', 'bricenocanela0@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(835, '192.168.120.235', 'V15043519	', 'Yoly Margarita Chinchilla Peña', 2, 3, 0, 3, 2, 'San Juan De Isnotu Las Rurales Bajando El Liceo Una Entrada Casa Al Fondo Mano Derecha', '04247574336; 04147591523', 'YOLYCHINCHILLA@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(836, '192.168.120.236', 'V 21062959-1', 'Yenimar De Mejia Gonzalez', 1, 5, 0, 3, 2, 'La Mata Via Quevedo Urbanizacion Las Dalias 2 Casa Mano Derecha ññññ', '04247274002; 0412749', 'Carrizoye456@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(837, '192.168.120.238', 'V 12457852', 'Victor Manuel Simanca', 1, 2, 0, 3, 2, 'Sabana Libre Calle Las Flores Con Calle Pueblo Nuevo Casa La Muchacera', '4161675358', 'Simancasv95@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(838, '192.168.120.239', 'V 31603471-0', 'Andres Jose Suarez Rangel', 1, 1, 0, 3, 2, 'Juan Dias Calle Principal Una Entrada Mas Abajo De Ka Piladora De Cafe', '04160227089; 0424760', 'as7411883@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(839, '192.168.120.24', 'V17095064', 'Lisbeth Cardozo', 1, 4, 0, 3, 2, 'Las Malvinas Frente Al Lago', '04247232948; 0424701', 'martinalisbethc@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(840, '192.168.120.240', 'V 18988347', 'Damarys Johana Rodriguez Paez', 1, 5, 0, 3, 2, 'La Mata Calle Principal Numero De Casa 60', '04247702014; 0424655', 'Damarysjohana28@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(841, '192.168.120.241', 'V 5348238', 'Zulay Paez Olmos', 1, 2, 0, 3, 2, 'Sabana Libre Ciudadela Numero De Casa 74 Calle 3 ', '04124278147; 0416073', 'Rpaez6@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(842, '192.168.120.242', 'V28096173', 'Manuel Garcia', 1, 2, 0, 3, 2, 'Atras Del Estadio Calle Ferrer', '4123243990', 'jandromngment@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(843, '192.168.120.243', 'V13688001', 'Yahir Matheus', 1, 5, 0, 3, 2, 'La Mata, Via Quevedo , Carretera Principal Casa S/N Porton Negro ', '4147467920', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(844, '192.168.120.244', 'V25604039', 'Zulinda Amada Sulbaran Montilla ', 1, 5, 0, 3, 2, 'La Mata Calle Las Dalias Parte Alta ', '4247005402', 'zuli2301@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(845, '192.168.120.245', 'V17831930', 'Nohemi Peña ', 1, 5, 0, 3, 2, 'Sector Conucos De La Paz Parte Alta', '4147401158', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(846, '192.168.120.246', 'V12458310', 'Olga Zambrano', 1, 2, 0, 3, 2, 'Vista Hermosa Segunda Etapa Casaj-39', '4147400593', 'okgazambrano2601@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(847, '192.168.120.247', 'V28190395', 'Reismary Morillo', 1, 2, 0, 3, 2, 'La Ciudadela ultima Calle Casa 97', '4120228592', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(848, '192.168.120.248', 'V28190395', 'Petra Carrizo', 1, 2, 0, 3, 2, 'El Trapichito Entrada Del Porton Amarillo', '4160510914', 'carrizopetra2025@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(849, '192.168.120.249', 'V26616549', 'Oscar Oviedo', 2, 3, 0, 3, 2, 'Sector La Abeja Parte Alta A Una Cuadra Despues Del Ambulatorio', '4147278670', 'oscarenriqueoviedoparra@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(850, '192.168.120.25', 'V3523228', 'Luci Margarita Paez Silva', 1, 4, 0, 3, 2, 'La Laja Parte Baja, Al Lado Del Doctor Abreu', '4164528168', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(851, '192.168.120.250', 'V10403789', 'Goleat Abreu Deonicio Jose', 1, 4, 0, 3, 2, 'Sector La Popa, Carretera Vieja Valera Betijoque, Via Celebe Via Principal ', '4167779640', 'Diorelisgoleat@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(852, '192.168.120.251', 'V32158859', 'Karla Franco', 1, 5, 0, 3, 2, 'Conicos De La Paz Donde Esta La Cruz A Dos Casa Subiendo', '4247596918', 'karlavaleriafranco2@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(853, '192.168.120.252', 'V27497245', 'Yovanna Patricia Vasquez Valecillos', 1, 5, 0, 3, 2, 'La Mata. Sector Puerta De Golpe, Via Antena Radio Simpatia, Casa S/N', '4247275020', 'Valecillospatricia@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(854, '192.168.120.253', 'V25832333', 'Elio Castellanos', 1, 1, 0, 3, 2, 'Colinas De Carranza Calle 5 Casa 19', '4147524602', 'ig9541872@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(855, '192.168.120.254', 'V 6134005', 'Eduardo Martins', 1, 5, 0, 3, 2, 'Colinas De Carmania Calle Numero 3 Casa Numero 73', '04127310937; 0412993', 'Eduardomartinsgerrero@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(856, '192.168.120.26', 'V5350285', 'Ramona Del Carmen Saez', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Sexta Casa Casa S-N', '4241667669', 'JUNIORVEGA2602@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(857, '192.168.120.27', 'V18348424', 'Franklin Plaza', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta, Altos De Sara Linda Vereda #2 Casa#3', '4268702280; 41647690', 'Gabrielalamus4@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(858, '192.168.120.28', 'V 21062757', 'Dayana Suarez Garcia ', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta, Dos Casas Mas Arriba Del Gimnasio', '4143763431', 'hdsgdayanasuarez@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(859, '192.168.120.29', 'V 30302014', 'Jose Antonio Quintero', 1, 2, 0, 3, 2, 'Sabana Libre  Sector San Rafael Parte Baja Casa Sin Numero Frente A Un Almacen Una Cuadra Mas Arriba  Bajando Por El Estadio ', '4163899469', 'quinterosegoviaj303@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(860, '192.168.120.30', 'V 21062495', 'Rosbelis Luques Barrios ', 1, 4, 0, 3, 2, 'El Alto De Escuque Sector La Bomba Los Useches ', '4163370474', 'rosbelilaque2@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(861, '192.168.120.31', 'V 19285450', 'Neivys Elena  Paredes Roman', 1, 2, 0, 3, 2, 'Sabana Libre Valle La Democracia Casa Sin Numero Referencia Capilla De San Benito', '4160740971', 'Neivys.paredes@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(862, '192.168.120.32', 'V9362257', 'Gabriel Arturo Espinoza (Mama)', 1, 1, 0, 3, 2, 'Colinas Parte Alta Ultima Calle ', '4247473337; 42474925', 'Inv.bis.mary@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(863, '192.168.120.33', 'V 20038310', 'Manuel Antonio Pacheco', 2, 3, 0, 3, 2, 'San Pedro Callejon Los Andares Frente A La Iglesia Cristiana ', '4165657412', 'pachemnel@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(864, '192.168.120.34', 'V21026307', 'Ismael Abreu Mendez', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Via Principal A 50Metro Del Gignacio Subiendo Por El Alado Derecho ', '4162152101', 'rojnela12311@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(865, '192.168.120.35', 'V7614981', 'Gerardo Antonio Bastidas Labrador', 1, 4, 0, 3, 2, 'La Laja Parte Alta Calle Principal Sector El Reten Ultima Casa Mano Derecha', '4147359442', 'Gerardobastidas14@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(866, '192.168.120.36', 'V 19898192', 'Naileth Nataly Aldara Valero', 1, 2, 0, 3, 2, 'Sabana Libre Calle Las Rivera 2 Alado Del Laboratorio De Abono ', '4247203271', 'naileth.andara@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(867, '192.168.120.37', 'V26046628', 'Dioscar Salas', 2, 3, 0, 3, 2, 'Sector Punta Brava, Sara Linda Parte Baja, Casa #0-7, Parrq.Jgh', '4261565018; 41642266', 'dioscarsalas@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(868, '192.168.120.38', 'V 14148297', 'Leila Patricia Rivera Valero', 1, 2, 0, 3, 2, 'Sabana Libre Sector Los Pinos A 2 Calle Del Cementerio Casa De 2 Pisos Con Laminas Azules ', '4247795641', 'Leirivera270578@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(869, '192.168.120.39', 'V 18802439', 'Yamileth Katiuska Olmos Gonzalez', 1, 2, 0, 3, 2, 'Sabana Libre Calle Los Pinos Numero De Casa Numero 20', '4247161086', 'Olmosyamileth639@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(870, '192.168.120.40', 'V13633326', 'Jose Alexander Briceño		\r\n', 1, 2, 0, 3, 2, 'Sabana Libre Calle Principal Mas Arriba De Los Pasteles Local Naranja Opaco', '04147196952', 'alebricenodavila@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(871, '192.168.120.41', 'V 23837335', 'Jaiber Daniel Abreu Ojeda', 1, 5, 0, 3, 2, 'La Mata Urbanismo Las Dalias Ultima Casa Al Fondo Mano Izquierda ', '4247537179', 'Yorgelissdiaz.20@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(872, '192.168.120.42', 'V 15752602', 'Yoconda Katiuska Viloria Uzcategui', 1, 2, 0, 3, 2, 'Sabana Libre Calle 24 De Julio Casa Sin Numero A 30 Metro De La Bodega Licoreria La Fortuna ', '4263221010', 'yocondavilo@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(873, '192.168.120.43', 'V 16533665-4', 'Omar Daniel Blanco Quevedo', 1, 2, 0, 3, 2, 'Sabana Libre Vista Hermosa Segunda Etapa Casa Numero J-16', '4127638205', 'omardanielquevedo@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(874, '192.168.120.44', 'V12797201', 'Humberto Jose Viloria Gudiño (Churuata Los Viloria)', 1, 4, 0, 3, 2, 'Sector La Laja Via Isnotu ', '4247423456/042471422', 'dianaviloria796@gmail.com/ churuatalosviloria@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(875, '192.168.120.45	', 'v1733397', 'Franklin Javier Gudiño', 1, 4, 0, 3, 2, 'La Laja Parte Baja Sector Mukimus Ma Abajo De La Picina Los Viloria A 2 Casa Bajando', '', 'Fg1733397@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(876, '192.168.120.46', 'V 25459131', 'Greti Maile Hernandez Moreno', 1, 4, 0, 3, 2, 'La Parte Baja Sector Mikimu A 100 Metros De La Piscina Los Viloria', '4140821336', 'greti162012ñGmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(877, '192.168.120.47', 'V20834262', 'Alexis Ramon Paz Perez ', 1, 2, 0, 3, 2, 'Sector La Laja, Casa La Cabelliza, Via Sara Linda', '14047811314', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(878, '192.168.120.48', 'V4540620', ' Jose Francisco Abreu Albornoz', 2, 3, 0, 3, 2, 'La Laja Sector Las Cruces Al Lado De La Caballeriza', '4147310912', 'neumojoseabreualbornoz@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(879, '192.168.120.49', 'V 4320703', 'Marlene Del Carmen Torres Del Briceño ', 1, 4, 0, 3, 2, 'La Laja Parte Alta Al Lado De La Tiendita Un Chalet Para Dentro', '4141435922', 'bbriceno@febeca.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(880, '192.168.120.50', 'V7964113', 'Elizabeth Del Valle Montilla ', 1, 4, 0, 3, 2, 'El Boqueron Calle Principal Al Lado Del Señor Marquez', '416666557', 'montillaelizabethdelvalle@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(881, '192.168.120.51', 'V 12541946', 'Irma Rosa Aguilar Rodriguez ', 1, 2, 0, 3, 2, 'Sabana Libre Sector Los Canaletes 3 Entrada Casa Al Fondo', '414751768', 'Montillayrmaaguilardemontilla@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(882, '192.168.120.52', 'V13462423', 'Gloria Cartagena', 1, 5, 0, 3, 2, 'Colinas De Carmania Serctor Las Brisas', '4262680903', 'abreugavidial@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(883, '192.168.120.53', 'V14757831', 'Blanca Bencomo', 1, 1, 0, 3, 2, 'Colinas De Carmania Calle Jaruma A Un Lado Del Kiosko De Odin', '4161620307', 'bencomoblaca50@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(884, '192.168.120.54', 'V5493656', 'Teresa Quintero', 1, 2, 0, 3, 2, 'Sector Los Canaletes Calle Rivera 2', '4262123297', 'qteresita808@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(885, '192.168.120.55', 'V9310245', 'Augusto Leon', 2, 3, 0, 3, 2, 'San Juan Sector La Abeja Parte Baja', '4147302817', 'augustoleon01@gmqil.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(886, '192.168.120.56', 'V9168103', 'Aura Josefina Hernandez', 1, 2, 0, 3, 2, 'Sector Los Pinos 1 Por Las Invasiones Mas Arriba Del Palon', '4147412410', 'aura62hernandez@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(887, '192.168.120.57', 'V15042279', 'Yesenia Molina (Escuela Neptali Valera Hurtado)', 1, 2, 0, 3, 2, 'Sabana Libre Abajo De La Oficina De Galanet', '4264561726', 'ebnvhurtado4@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(888, '192.168.120.58', 'V18801298', 'Yulimar Delgado', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Sector Punta Brava', '4264049901', 'delgadotulimar390@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(889, '192.168.120.59', 'V3989708', 'Isidro Agular', 1, 2, 0, 3, 2, 'Frente A La Tasca Mi Delirio', '4144073014', 'ijab54@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(890, '192.168.120.60', 'V14148399', 'Benito Aguilar', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Por El Taller Mecanico', '4167476321', 'benito33delgado@gamil.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(891, '192.168.120.61', 'V26488378', 'Niorka Quijada', 1, 2, 0, 3, 2, 'Sabana Libre Por El Cementerio', '4247376392', 'quijadaniorka925@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(892, '192.168.120.62', 'V10908456', 'Magaly Garcia', 1, 4, 0, 3, 2, 'El Boqueron Frente A La Escuela', '4128543502', 'maggyvil@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(893, '192.168.120.63', 'V11322496', 'Carmen Paredes', 1, 2, 0, 3, 2, 'Frente A La Escuela Neptali', '4247027083', 'carmenparedes547@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(894, '192.168.120.64', 'V9328718', 'Jesus Viloria', 1, 2, 0, 3, 2, 'Vista Hermosa Casa B-7', '4249384457', 'jesusalbertoviloria2@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(895, '192.168.120.65', 'V16535958', 'Sahiduvi Jerez', 1, 2, 0, 3, 2, 'Mas Arriba De La Posada La Nona', '4262473119', 'scjerez16@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(896, '192.168.120.66', 'V18349703	', 'Yusneidy Briceño', 2, 3, 0, 3, 2, 'Las Cruces De La Union Frente Al Ambulatorio	', '04247769124	', 'martanunez847@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(897, '192.168.120.67', 'V11798584', 'Sonia Hidalgo (Escuela Sabana Libre)', 1, 4, 0, 8, 2, 'El Boqueron Al Lado De La Iglesia ', '4160929782', 'soniamargaritahidalgo@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(898, '192.168.120.68', 'V7834348', 'Rafael Ortega', 1, 4, 0, 3, 2, 'El Boqueron Sector La Candelaria Mas Arriba Del Gato', '4127977795', 'gatoperez202@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(899, '192.168.120.69', 'V11134393', 'Nelida Rosa Fernandez Chirinos', 1, 5, 0, 3, 2, 'Colinas De Carmania Calle 3 Con Frnte De Flores', '4263216162', 'Danemar30@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(900, '192.168.120.70', 'V16266204', 'Jean Carlos Alarcon', 1, 4, 0, 3, 2, 'El Boqueron Sector La Bartola', '4247371832', 'jehanalarcon1982@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(901, '192.168.120.71', 'V18348495', 'Rafael Torres', 1, 5, 0, 3, 2, 'La Mata A Media Cuadra De La Iglesia', '4247371832', 'rtorres1202@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(902, '192.168.120.72', 'V13897977', 'Sorelis Del Rosario Melendez Etanislao', 1, 2, 0, 3, 2, 'Urb Vista Hermosa Sector B Casa B26', '4166748660', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(903, '192.168.120.73', 'V18457992', 'Geraldine Niriana Araujo Vielma', 1, 2, 0, 3, 2, 'Vista Hermosa Etapa 2 Casa M28', '4120752100', 'niri.naza.gene@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(904, '192.168.120.75', 'V5263779', 'Elsa De Escalona', 2, 3, 0, 3, 2, 'San Pedro A Un Lado De La Medicatura', '4268662181', 'elsalacruz162@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(905, '192.168.120.76', 'V28501861', 'Katerine Sanchez', 2, 3, 0, 3, 2, 'Sector La Popa', '4247344322', 'katerinsanchez2202@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(906, '192.168.120.77', 'V15043248	', 'Melitza Briceño', 1, 2, 0, 3, 2, 'Primera Etapa De Vista Hermosa Casa F-32', '04264056609	', 'melitzabriceno1981@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(907, '192.168.120.78', 'V13641112', 'Carmen Gonzalez', 1, 2, 0, 3, 2, '5 Casas Mas Abajo De La Posada La Nona', '4146304331', 'carmengonzalez121398@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(908, '192.168.120.79', 'V26759052', 'Caterina Petralia', 1, 2, 0, 3, 2, 'Sabana Libre A Tres Casas Mas Arriba De La Señora Que Hace La Harina', '4125222377', 'pimbo124@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(909, '192.168.120.80', 'V9170454', 'Fabricio Briceño', 2, 3, 0, 3, 2, 'Sector La Popa ', '04261118932', 'fabriciovalera80@gmail.com\r\n', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(910, '192.168.120.81', 'V165330508', 'Granja El Tormento (Daniel Benitez)', 2, 3, 0, 3, 2, 'Sector La Popa', '4261198872', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(911, '192.168.120.82', 'V27889441', 'Adriana Carolina Salcedo Hernandez', 1, 4, 0, 3, 2, 'Final De Calle Sector La Popa, La Union, Escuque ', '4161994905; 04121643', 'Manzogo43@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(912, '192.168.120.83	', 'V5501548	', 'Ivone Briceño', 2, 3, 0, 3, 2, 'Sector La Popa', '04117504807	', 'bricenoivone5@gmail.com\r\n', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(913, '192.168.120.84', 'V30738465', 'Riczabeth Paredes', 1, 2, 0, 3, 2, 'Calle Mi Jardin Por El Preescolar', '4143715342', 'riczabethparedes@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(914, '192.168.120.85', 'V18841757', 'Andrea Gamboa', 1, 1, 0, 3, 2, 'Sector Puerto Escondido Via Los Chalet', '4125794016', 'mgamboavillegas@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(915, '192.168.120.86', 'V9311158', 'Benito Nuñez', 1, 5, 0, 3, 2, 'Cuatro Casa Detras De La Iglesia', '4147554456', 'segundoapicultor@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(916, '192.168.120.87', 'V15825286', 'Rosalba Rivas', 1, 1, 0, 3, 2, 'Sector Puerto Escondido Via A Los Chalet', '4124952404', 'rivasrosarivas031@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(917, '192.168.120.88', 'V25913326', 'Maria Gabriela Manzaneda', 1, 2, 0, 3, 2, 'Sector Santa Maria ', '4121253676', 'manzanedavasquezm@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(918, '192.168.120.89', 'V15584832', 'Alexandra Ramirez', 1, 2, 0, 3, 2, 'Sector Santa Maria', '4129572829', 'aleori45@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(919, '192.168.120.90', 'V5497355', 'Evelyn Parra', 2, 3, 0, 3, 2, 'San Agustin Mas Abajo De La Cancha', '4143711287', 'laekim59@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(920, '192.168.120.91', 'V18378186', 'Bermari Moreno', 1, 2, 0, 3, 2, 'Sector Santa Maria', '4147368318', 'bermari.moreno27@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(921, '192.168.120.92', 'V31095030', 'Maryelin Jovito', 1, 2, 0, 3, 2, 'Sector Santa Maria', '4129543125', 'maryelinjovito26@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(922, '192.168.120.93', '', 'Gerson Bastidas', 1, 2, 0, 3, 2, 'Vista Hermosa Segunda Etapa Sector O Frente A Jorge Romero ', '4247475819', 'Veronica.bastidas.d.villa@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(923, '192.168.120.94', 'V11319505', 'Luz Marina Balza', 1, 2, 0, 3, 2, 'Diagonal A La Licoreria De Edwin Una Cuadra Mas Abajo De La Plaza', '4262001290', 'luzmarinabalza486@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(924, '192.168.120.95', 'V27022666', 'Jose Bastidas', 1, 2, 0, 3, 2, 'Calle El Cementerio Sector Los Pinos Parte Alta', '4247282962', 'estebanbastidas321@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(925, '192.168.120.96', 'V17392708', 'Luis Bogarin', 1, 1, 0, 3, 2, 'Sector La Garita Cerca De La Casa De Duber El Que Trabaja En El Cdi', '4247241734', 'terevalesphi@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(926, '192.168.120.97', 'V15752989', 'Luis Alfonso Guerrero', 1, 2, 0, 3, 2, 'Sector Los Canaletes La Casa Queda A Un Lado De La Fabrica De Urnas', '4247706412', 'bnirbelis@gamil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(927, '192.168.120.98', 'V17265839', 'Rafael Ortega', 1, 5, 0, 3, 2, 'Sector Quevedo Tres Casas Mas Abajo De La Plaza', '4247607186', 'yoraimacaste24@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(928, '192.168.120.99', 'V19670689', 'Alexis Escobar', 1, 4, 0, 3, 2, 'Sector La Quinta Mas Arriba De La Monjas', '4264004917', 'alexisjoseescobareacalona@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(929, '192.168.130.10', 'V18349067', 'Geraldine Uzcategui', 1, 1, 0, 3, 2, 'Colinas De Carmania Calle 1 Casa 14', '4269779482', 'geraluzcategui.88@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(930, '192.168.130.100', 'falta@gmail.com', 'Maria Fernanda Gonzalez', 1, 2, 0, 3, 2, 'Sector Brisas De San Benito Tercera Entrada Al Final De La Calle', '4247502426', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(931, '192.168.130.101', 'V8096652', 'Rosario Sandoval', 1, 4, 0, 3, 2, 'La Laguneta Mas Arriba De Andreina Galanet', '4264270205', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(932, '192.168.130.102', 'V31428051', 'Fernando Galavis', 1, 4, 0, 3, 2, 'La Laguneta Mas Arriva De La Casa De Andreina Galanet', '4146149885', 'fernandojaviergalavis@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(933, '192.168.130.103', 'V00000', 'Gladys Velasquez', 1, 1, 0, 3, 2, 'Colinas De Carmania Casa Detras Del Negocio De Maison Por La Carretera De Tierra', '04122156835; 0426373', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(934, '192.168.130.104', 'V17832913', 'Daniel Parra', 1, 1, 0, 3, 2, 'Colinas De Carmania Detras De La Panaderia Calle De Tierra', '04162622853; 0412104', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(935, '192.168.130.105', 'V32374270', 'Mauro Hernandez', 1, 1, 0, 3, 2, 'Colinas De Carmania Casa Al Lado Del Negocio De Maison Donde Empieza La Carretera De Tierra', '04162584702; 0426412', 'hernandezmauro.pc@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(936, '192.168.130.106', 'V20039495', 'Amanda Montilla ', 1, 1, 0, 3, 2, 'Colinas De Carmania Quinta Calle Al Final', '4247142843', 'Amanda.montilla19@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(937, '192.168.130.107', 'V15674246', 'Yurbelys Valera', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Despues De La Alcantarilla Tercera Entrada De Tierra', '4266037923', 'valerayurbelys@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(938, '192.168.130.108', 'V9327354', 'Nelly Balza', 1, 2, 0, 3, 2, 'Sabana Libre Mas Arriba Del Hotel Mi Delirio Cara Blanca Con Amarillo', '4166644036', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(939, '192.168.130.109	', 'V000000	', 'Yubana Briceño\r\n', 1, 5, 0, 3, 2, 'La Mata Diagonal A La Cancha Casa De Dos Pisos', '04247064318', 'yubana_25@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(940, '192.168.130.11', 'V14599918', 'Nelson Osuna', 1, 2, 0, 3, 2, 'Calle Barrio Lindo Casa Al Fondo De Una Que Esta En Construccion', '4247775508', 'nelsonosuna2210@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(941, '192.168.130.111', 'V18984323', 'Ricardo Hernandez', 1, 1, 0, 3, 2, 'Juan Diaz Urb El Ince', '4147079158', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(942, '192.168.130.112', 'V19795792', 'Orlando Castellano', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Despues De Ginnasio A Dos Casa', '4262763304', 'orlandocastellanoviloria@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(943, '192.168.130.113', 'V16247118', 'Maria Mota ', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Despues Del Ginnasio La Primera Casa', '4267134180', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(944, '192.168.130.114', 'V26413193', 'Isfre Barrios', 1, 5, 0, 3, 2, 'La Mata Urb San Jose Tercera Casa', '4147165753', 'isfrebarrios104@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(945, '192.168.130.115	', 'V13049923	', 'Rosa Briceño', 1, 2, 0, 3, 2, 'Sabana Libre Brisas De San Benito Cuarta Entrada De Tierra Ultima Casa', '04269884022	', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(946, '192.168.130.116', 'V9311962', 'Maximo Rangel', 1, 4, 0, 3, 2, 'Sector La Laguneta Despues De La Entrada De Las Antenas A Tres Casas Via Ppal', '4247678703', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(947, '192.168.130.117', 'V12047710', 'Maria Cardozo', 1, 1, 0, 3, 2, 'La Garita Casa Frente A La Escuela', '4247838557', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(948, '192.168.130.118', 'V1326109', 'Edixon Quintero', 2, 3, 0, 3, 2, 'San Agustin Frente A La Antigua Radio Andina', '4127647323', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(949, '192.168.130.119', 'V32084452', 'Jose Gregorio Graterol', 2, 3, 0, 3, 1, 'Sara Linda Parte Alta Despues De La Alcantarilla Tercera Entrada De Tierra Casa 3', '4247487269', 'josemendoza4200@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(950, '192.168.130.12	', 'V9162937	', 'Maria Paula Peña	', 2, 3, 0, 3, 1, 'San Agustín Más Adelante De La Cancha Por La Vía Ppal Casa Azul Donde Ahí Una Mata De Coco', '04249735809	', 'mariapaulapenabriceno52@gmail.com\r\n', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(951, '192.168.130.120', 'V18802040', 'Sorsire Uzcategui', 1, 2, 0, 3, 2, 'Sabana Libre Diagonal Al Palon Via A La Fabrica De Urnas ', '4162165286', 'sorsireuzcategui@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(952, '192.168.130.121', 'V18888231', 'Jose Castillo', 1, 4, 0, 3, 2, 'Quevedo A Dos Casa Despues De La Escuela', '4126784922', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(953, '192.168.130.122', 'V5498665', 'Jose Batista', 1, 1, 0, 3, 2, 'Colinas De Carmania Depues Del Cdi Urb Ezequiel Zamora Calle 6 Ultima Casa', '4169771702', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(954, '192.168.130.123', 'V10214002', 'Rafael Raga', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Casa C-27', '5,49298E+12', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(955, '192.168.130.124', 'V 10030021', 'Aly Benito Romero Barrios', 1, 5, 0, 3, 2, 'Colinas De Carmania Primera Calle Casa Numero 08', '4247042192', 'Romeroaly727@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(956, '192.168.130.125', 'V12046945', 'Maritza  Barrios', 1, 1, 0, 3, 2, 'Colinas De Carmania Calle 4 Casa A-91', '4126687306', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(957, '192.168.130.126', 'V10033018', 'Nely Cardozo', 1, 2, 0, 3, 2, 'Sabana Libre A Nueve Casas Mas Abajo De La Nonna', '4262643660', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(958, '192.168.130.127', 'V25619432', 'Iglesia Pentecostal Unidas', 2, 3, 0, 3, 2, 'Via Ppal Sara Linda Galpon Por Las Chicharroneras', '4126829036', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(959, '192.168.130.128', 'V14329156', 'Leosir Araujo', 1, 1, 0, 3, 2, 'Sector La Constituyente Por Donde Esta El Tanque De Agua Casa Morada', '', 'leosir.go@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(960, '192.168.130.129', 'V21061791', 'Kenia Araujo', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Casa Despues De La Bodega De Benedo', '4247018979', 'keniaaraula1991@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(961, '192.168.130.13', 'V30808638', 'Abraham Delgado', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Despues Del Muro Casa Grande Se Color Verde', '4122621812', 'abrahamdelgado@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(962, '192.168.130.130', 'V23776442', 'Jose Montilla', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Calle 1 Casa 5', '4247539344', 'josegregoriomontilla327@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(963, '192.168.130.131', 'V10910784', 'Cecilia Artigas', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Sector Los Gavilanes Via A San Pedro', '4247595695', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(964, '192.168.130.132', 'V20036436', 'Roxana Montilla', 1, 1, 0, 3, 2, 'Juan Diaz Mas Abajo Del Mecanico Maximo', '4247306527', 'montillaroxana416@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(965, '192.168.130.133', 'V11324583', 'Mariela Alarcon', 1, 1, 0, 3, 2, 'Valle Alto Segunda Calle Diagonal Al Ambulatorio Segunda Casa De Color Azul', '4123845994', 'marielaalar8@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(966, '192.168.130.134', 'V10036583', 'Yoleida Baptista', 1, 1, 0, 3, 2, 'Colinas De Carmania Urb Jaruma Casa 51 Por La Entrada De La Bodega De Maison', '4162674677', 'yoleidabaptista6@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(967, '192.168.130.135	', 'V0000000	', 'Carlos Briceño', 1, 4, 0, 3, 2, 'Sector La Bartola Via El Boqueron	', '+17863198560	', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO');
INSERT INTO `contratos` (`id`, `ip`, `cedula`, `nombre_completo`, `id_municipio`, `id_parroquia`, `id_comunidad`, `id_plan`, `id_vendedor`, `direccion`, `telefono`, `correo`, `fecha_instalacion`, `ident_caja_nap`, `puerto_nap`, `num_presinto_odn`, `id_olt`, `id_pon`, `estado`) VALUES
(968, '192.168.130.136', 'V17094476', 'Rossana Valero', 1, 1, 0, 3, 2, 'Colinas De Carmania Sesta Calle Casa De La Esquina', '4249176586', 'rossanavalero1184@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(969, '192.168.130.137	', 'V11897885	', 'Danila Avendaño', 1, 1, 0, 3, 2, 'Conucos De La Paz Frente A La Capilla San Benito Casa De Dos Pisos', '04247191292	', 'danilaavendaño123@gmail.com\r\n', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(971, '192.168.130.139', 'V00000000', 'Yasmin Perdomo', 1, 2, 0, 3, 2, 'Calle Comercio A Un Lado De La Licoreria Kiri', '', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(972, '192.168.130.14', 'V21064470', 'Keivys Finol', 1, 2, 0, 3, 2, 'El Conocido Mas Abajo De La Cancha Casa De Fachada En Gris', '4147291208', 'keivysfinol81@gmqil.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(973, '192.168.130.140', 'V8500708', 'Yoneida Plata ', 1, 2, 0, 3, 2, 'A Una Cuadra Subiendo La Oficina Galanet Casa De Dos Pisos A Mano Derecha', '4168315491', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(974, '192.168.130.141', 'V10401345', 'Noly Araujo', 1, 4, 0, 3, 2, 'Las Cruces De La Union Casa Frente A La Iglesia', '4162100771', 'jesusviloria1289v@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(975, '192.168.130.142', 'V18371747', 'Wilnoris Ramirez', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Al Lado De La Escuela Porton Negro', '4164562336', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(976, '192.168.130.143', 'V16376746', 'Luis Rivas', 1, 2, 0, 3, 2, 'Sector El Trapichito Casa De Dos Pisos De Rejas Negras', '4261558072', 'elgatoluis100@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(977, '192.168.130.144', 'V10401337', 'Larry Vasquez', 1, 1, 0, 3, 2, 'Juan Diaz Urb El Ince', '4166023193', 'larryeskuke69@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(978, '192.168.130.145', 'V23952823', 'Yolexi Sanchez', 1, 1, 0, 3, 2, 'Puerto Escondido Parte Alta Mas Arriba De Los Chalet', '04247445893; 0416135', 'yomirasanchez333@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(979, '192.168.130.146', 'V21063543', 'Ruben Diaz', 1, 5, 0, 3, 2, 'Conucos De La Paz Subiendo Despues De La Cruz A Media Cuadra Casa Morada A Mano Derecha', '4147287240', 'rubendiazjj40@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(980, '192.168.130.147', 'V10907365', 'Ruben De Jesus Diaz', 1, 5, 0, 3, 2, 'Conucos De La Paz Diagonal A La Cruz', '4147097985', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(981, '192.168.130.148', 'V9343594', 'Monasterio Sagrado Corazon De Jesus (Liliana Ramirez)', 1, 4, 0, 3, 2, 'Sector La Quinta', '04162706294; 0414702', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(982, '192.168.130.149', 'V25374384', 'Maria Rojo', 2, 3, 0, 3, 1, 'San Agustin Via Ppal Casa Despues Del Taller Mecanico', '4245397743', 'mariaelenarp.2024@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(983, '192.168.130.15', 'V30867119', 'Luis Mendoza', 1, 2, 0, 3, 1, 'Casa Azul Frente Al Cementerio', '4165417015', 'lm5212947@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(984, '192.168.130.150', 'V14599049', 'Erlin Aguilar', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Casa Al Lado De La Bodega De Benedo', '4147073872', 'montillacamila123@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(985, '192.168.130.151', 'V9705466', 'Naldy Morales', 1, 4, 0, 3, 2, 'La Bartola Subiendo La Capilla Al Final', '4123460011', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(986, '192.168.130.152', 'V16535283', 'Neiry Franco', 2, 3, 0, 3, 2, 'Agua Blanca Bajando La Escuela Al Final Donde Esta El Trapiche', '4161756400', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(987, '192.168.130.153	', 'V16810873	', 'Mariliza Peña', 1, 4, 0, 3, 2, 'Las Cruces De La Union Mas Abajo De La Iglesia', '04217541641	', 'marilizapena@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(988, '192.168.130.154', 'V10036741', 'Evelyn Perez', 1, 5, 0, 3, 2, '\nLa Mata Via A Las Antenas Casa Al Frente De Nap 068', '4247280558', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(989, '192.168.130.155', 'J505679147', 'Piedras Blancas', 1, 4, 0, 3, 2, 'El Boqueron Sector El Taladro', '4247566303', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(990, '192.168.130.156', 'V21365155', 'Karen Ortiz', 2, 3, 0, 3, 2, 'San Pedro Via Ppal Antes De Puente', '4160684855', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(991, '192.168.130.157', 'V14928474', 'Carlos Luis Ortiz', 2, 3, 0, 3, 2, 'San Pedro Via Ppal Antes Del Puente', '4263681627', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(992, '192.168.130.158', 'V18095466', 'Yenny Colmenares', 1, 4, 0, 3, 2, 'Las Cruces De La Union Casa Frente Al Ambulatorio', '4264038192', 'colmenaresyenny4@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(993, '192.168.130.159', 'V4325696', 'Maria Sequera', 1, 2, 0, 3, 2, 'Sector El Trapichito Final Donde Esta El Porton Negro ', '4241157987', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(994, '192.168.130.16', 'V4059749', 'Leonardo Gonzalez', 2, 3, 0, 3, 2, 'Sara Linda Parte Alta Despues De La Alcantarilla', '4247260450', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(995, '192.168.130.160', 'V31319784', 'Oscar Usechas (Hijo)', 1, 4, 0, 3, 2, 'Sector La Bomba Casa Frente A La Vinotinto', '4125684986', 'albicntre2007@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(996, '192.168.130.161', 'V10966207', 'Jose Gregorio Marin', 1, 2, 0, 3, 2, 'Las Cruces De Sabana Libres Mas Abajo De La Entrada Del Trapichito Casa Blanca De Dos Pisos', '4146213149', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(997, '192.168.130.162', 'V26046723', 'Rebeca Materan', 2, 3, 0, 3, 2, 'La Laja Parte Baja Av Ppal', '4129186592', 'babyflores1994@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(998, '192.168.130.163', 'V20656783', 'Crisbeli Bencomo', 1, 1, 0, 3, 2, 'Final De Valle Alto A Mano Derecha A La Quinta Casa', '4246457771', 'bencomocribely@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(999, '192.168.130.164', 'V12038726', 'Adela Perez', 1, 4, 0, 3, 2, 'El Boqueron Sector La Candelaria Por Dinde Vive Alfonso', '4247579820', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1000, '192.168.130.165', 'V18349600', 'Yuneyci Paredes', 1, 1, 0, 3, 2, 'Tierra De Nubes Final De La Carretera De Cemento', '4122765189', 'yuneyciparedes1987@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1001, '192.168.130.166	', 'V7609448	', 'Rolando De La Peña', 1, 4, 0, 3, 2, 'Sector La Quinta Casa De Dos Pisos Entrando A La Bartola ', '04123603346	', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1002, '192.168.130.167', 'V 9001143', 'Zenaida Del Carmen Viloria De Zerpa', 2, 3, 0, 3, 2, 'San Pedro De Isnotu Casa Numero 1 Referencia Frente Al Trapiche Los Mendez', '04147341467; 0414711', 'franyeskicarrizo123@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1003, '192.168.130.168', 'V10033779', 'Yoneida Montilla', 1, 2, 0, 3, 2, 'Vista Hermosa Primera Etapa Casa D-19', '4147034663', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1004, '192.168.130.169', 'V4529912', 'Betty Valbuena', 1, 5, 0, 3, 2, 'Conucos De La Paz Casa Azul Frente A La Cancha', '4141770624', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1005, '192.168.130.17', 'V18801369', 'Luismer Pereyra', 1, 2, 0, 3, 2, 'Frente A La Plaza Bolivar 2 Locales Del Cyber', '4160198349', 'yundorpereyra@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1006, '192.168.130.170', 'V19643912', 'Johanna Perez', 2, 3, 0, 3, 2, 'La Abeja Parte Baja Casa Por El Negocio De Freddy Leon', '4247497371', 'johannaelizabethperezromero@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1007, '192.168.130.171', 'V14237982', 'Leguis Gonzalez', 1, 2, 0, 3, 2, 'Vista Hermosa Segunda Etapa Casa 0-20', '4247638446', 'leguisalfredogonzalez@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1008, '192.168.130.172', 'V9162025', 'Jose Antonio Gonzalez', 1, 2, 0, 3, 2, 'Sector Los Canaletes Mas Arriba Del Palon', '04247577657; 0414739', 'eripagonzalez@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1009, '192.168.130.173', 'V14328223', 'Yoisi Uzcategui', 1, 2, 0, 3, 2, 'Brisas De Sanbenito Segunda Entrada A La Quinta Casa', '4164418025', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1010, '192.168.130.174', 'V4659164', 'Drucila Paredes', 1, 5, 0, 3, 2, 'La Mata Casa En La Esquina De La Iglesia Ventanas Y Puerta De Madera', '4147372613', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1011, '192.168.130.176', 'V 5759269', 'Reina Betty Mijares Santiago', 1, 2, 0, 3, 2, 'Sabana Libre Vista Hermosa Etapa 2 Avenida La Paz Casa Numero J-36 ', '4145320061', 'Reinabettymijares@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1012, '192.168.130.177', 'V 9328155', 'Luis Alberto Caceres Abreu ', 1, 5, 0, 3, 2, 'Colonas De Carmania Parte Alta Primera Calle Numero De Casa 6#', '4264469000', 'Luiscaceres2008@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1013, '192.168.130.178', 'DA38', 'Daniel Herrera', 1, 4, 0, 3, 2, 'Quedo Atras Del Estadio Casa Final De La Calle Ciega', '4247324347', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1014, '192.168.130.179', 'V10039512', 'Amado Quintero', 1, 4, 0, 3, 2, 'Las Cruces De La Union Casa A Una Cuadra Antes De La Iglesia', '4261347419', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1015, '192.168.130.18', 'V25173118', 'Yesika Matheus', 1, 5, 0, 3, 2, 'La Mata Esquina De La Cancha Segunda Casa', '4147151244', 'yesikamailyn@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1016, '192.168.130.180', 'V4657741', 'Libia De Quintero', 1, 4, 0, 3, 2, 'Las Cruces De La Union Casa Azul Frente Al Ambulatorio', '4242829068', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1017, '192.168.130.181', 'V9171543', 'Maritza Abreu', 2, 3, 0, 3, 2, 'San Juan Calle Leonardo Ruiz Casa Por Donde Vive El Gallo', '', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1018, '192.168.130.182', 'V5855380', 'Benilde Montilla', 1, 2, 0, 3, 2, 'Vista Hermosa Segunda Etapa Primera Calle Casa I-17', '4241219407', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1019, '192.168.130.183', 'V30671175', 'Jhoan Mendoza', 1, 5, 0, 3, 2, 'Conucos De La Paz Por La Cruz Hacia Adentro Calle Araguaney', '4217501779', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1020, '192.168.130.184	', 'V5763719	', 'Luceda Briceño', 1, 1, 0, 3, 2, 'Escuque Calle Paez La Mama De Jean Piero	', '04263237708	', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1021, '192.168.130.185', 'V31772031', 'Rubeiyelin Barrios', 1, 1, 0, 3, 2, 'Colinas De Carmania Calle Jaruma Casa Vinotinta Final De La Calle', '4247532243', 'barriosoliannys71@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1022, '192.168.130.186	', 'V10401732	', 'Alexander Simancas Briceño', 2, 3, 0, 3, 2, 'Sector San Agustin, Via Isnotu Casa#8 \r\nSara Linda', '04147265682', 'Alexandersimancas853@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1023, '192.168.130.187', 'V10401336', 'Helen Vasquez', 1, 1, 0, 3, 2, 'Escuque Frente A La Plaza Bolivar Local Esquina De La F', '4247199592', 'Vasquezhelen472@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1024, '192.168.130.188', 'V14719353', 'Brusnelly Cancillery', 1, 1, 0, 3, 2, 'Sector La Victoria Calle Paez ', '4247385683', 'brusnellyc@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1025, '192.168.130.189', 'V11315582', 'Ramon Jose Valero Balza', 1, 4, 0, 3, 2, 'El Alto De Escuque, Calle Sucre Casa #22', '4161980533', 'Ramonvalero985@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1026, '192.168.130.19', 'V5762994', 'Rafael Provenzali', 1, 4, 0, 3, 2, 'Sector Sambenito Detras Del Estadio Donde Esta La Estatua De San Benito Casa Azul', '4244605248', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1027, '192.168.130.190', 'V9316829', 'Jesus Santos', 1, 1, 0, 3, 1, 'El Saman Casa Antiguo Charala', '4127009116', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1028, '192.168.130.20', 'V85001291', 'Yohana Mendez', 1, 2, 0, 3, 1, 'Calle Pueblo Nuevo Mas Abajo Del Hotel La Nona Casa Blanca', '4247015451', 'yirmegatofoca@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1029, '192.168.130.21', 'V30189931', 'Eriuska Linarez', 1, 2, 0, 3, 1, 'Calle El Cementerio Casa Frente Al Taller Mecanico', '4160918456', 'linarezeeiuska18@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1030, '192.168.130.22', 'V19287885', 'Daniel Casas', 1, 2, 0, 3, 2, 'La Gallera', '4126657418', 'danielcasas2016@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1031, '192.168.130.23', 'V9319108', 'Jose Antonio Estrada Vetancourt', 1, 2, 0, 3, 1, 'Sector El Corozo Parte Alta Calle Buenos Aires Casa S/N', '4147279432', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1032, '192.168.130.24', 'V23493939', 'Andreina Rivas', 2, 3, 0, 3, 1, 'Sara Linda A Un Lado De La Chicharronera Los Simancas', '4147475328', 'viloriaandreina4@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1033, '192.168.130.25', 'V9179909', 'Belkis Josefina Jerez', 1, 2, 0, 5, 2, 'Urb Vista Hermosa, Casa F13 Calle Los Azulejos', '4269261335', 'belkisjerez17@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1034, '192.168.130.26', 'V18096783', 'Liliam Coromoto Ayala Hidalgo', 1, 2, 0, 3, 2, 'Sector Vista Hermosa 2Da Etapa Casa Nro 25', '4261059660', 'ayalaliliam39@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1035, '192.168.130.27', 'V17606294', 'Lisbeth Garcia ', 1, 1, 0, 3, 2, 'Sector Puerto Escondido, Mas Arriba De La Granja, Despues De Los Chalets ', '4162762876; 41475573', 'Vivilis1205@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1036, '192.168.130.28', 'V5503218', 'Ramona Castellanos', 1, 1, 0, 3, 2, 'Colinas De Carmania Cuarta Calle Casa Rosada', '04247071671;  042620', 'ramonacastellanos2018@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1037, '192.168.130.29', 'V20790544', 'Lisbeth Mavarez', 2, 3, 0, 3, 2, 'San Juan Diagonal A La Iglesia Calle Arturo Cardozo', '4247012890', 'josecabrerainter@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1038, '192.168.130.30', 'V9176368', 'Dionicia Colmenares', 1, 4, 0, 3, 2, 'Quevedo Mas Abajo De La Escuela', '4268106136', 'colmenaresdionicia51@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1039, '192.168.130.31', 'V4115257', 'Melania Morillo', 1, 4, 0, 3, 1, 'Quevedo Mas Abajo De La Escuela Casa Blanca Con Rejas De Ciclon De Color Verde', '4247289499', 'melaniamorillo415@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1040, '192.168.130.32', 'V16066495', 'Mavelys Salas', 1, 4, 0, 3, 1, 'Las Rurales Del Alto La Granja', '4247345484', 'mave.salas@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1041, '192.168.130.33	', 'V9172628	', 'Jose Gregorio Briceño', 2, 3, 0, 3, 2, 'Sara Linda Parte Baja Restaurante Que Está Frente Al Muro ', '04141762329	', 'briceojose0@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1042, '192.168.130.34', 'V 27363065', 'Karolina Daniela Briceño Riva', 1, 5, 0, 3, 2, 'Colinas De Carmania Calle Numero 6 Casa Sin Numero La 2 Casa Derecha', '04147010094; 0424760', 'Yeisonaraujo2010@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1043, '192.168.130.35', 'V5763980', 'Ubel Abreu', 1, 2, 0, 3, 2, 'El Corocito Mas Abajo De La Cancha', '4161983623', 'abreujesus082@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1044, '192.168.130.36', 'V17095006', 'Yennifer Arguello', 1, 2, 0, 3, 2, 'Vista Hermosa Segunda Etapa Cuarta Calle Casa O-04', '4267531663', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1045, '192.168.130.37', 'V29656400', 'Yolimar Aguilar', 2, 3, 0, 3, 2, '192.168.130.37 (Falta)', '4262993955', 'aguilaryolimar79@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1046, '192.168.130.38', 'V32255546', 'Lerisbeth Quintero', 1, 2, 0, 3, 1, 'El Conocido Cuarta Casa Despues De La Cancha', '4147599106', 'lerisbethq@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1047, '192.168.130.40', 'V10030221', 'Jesus Linares', 2, 3, 0, 3, 1, 'San Agustin Via Ppal Donde Esta El Taller Antes De Las Palmeras', '4247090418', 'cugr17604703@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1048, '192.168.130.41', 'V18456135', 'Carlos Valderrama', 2, 3, 0, 3, 1, 'San Juan Subiendo El Puente Donde Llegan Los Carros Casa Azul Frente Al Nap', '4246881841', 'carlosvalderrama060@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1049, '192.168.130.42', 'V11323710', 'Yajaira Carrillo', 2, 3, 0, 3, 1, 'San Pedro Sector Agua Clara Mas Abajo De La Escuela Primera Entrada', '4162147163', 'yaja-2025@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1050, '192.168.130.43', 'V16883061', 'Katy Moreno', 2, 3, 0, 3, 1, 'San Juan Calle Los Faroles Diagonal A La Iglesia Subiendo', '4247271425', 'katyojedaam09@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1051, '192.168.130.44', 'V10036797', 'Jose Gregorio Mendez', 1, 4, 0, 3, 2, '192.168.130.44 (Falta)', '4161767162', 'tarcybb78@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1052, '192.168.130.45', 'V17391925', 'Norma Del Valle Mendoza Uzcategui', 1, 1, 0, 3, 2, 'Sector La Garita Calle Principal, Casa Sin Numero', '4247134357', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1053, '192.168.130.46', 'V18925223', 'Rosa Castellar ', 1, 1, 0, 3, 2, 'La Garita Mas Arriba De La Escuela', '4162934287', 'rosacastellar989@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1054, '192.168.130.47', 'V26451396', 'La Comandancia De Policia (Ana Maldonado) ', 1, 2, 0, 3, 1, 'Frente A La Plaza Bolivar', '4217736243', 'anateresahidalgo7@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1055, '192.168.130.48', 'V16740254', 'Jose Gregorio Abreu', 2, 3, 0, 3, 1, 'Sara Linda Chicharronera Jgh', '4220035408', 'gregorioabreu659@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1056, '192.168.130.49', 'falta@gmail.com', 'Dennis Simancas', 2, 3, 0, 3, 1, 'Sara Linda Chicharronera Simancas Instalacion En La Casa', '4266039941', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1057, '192.168.130.50	', 'V9498259	', 'Cleotilde Briceño', 2, 3, 0, 3, 1, 'San Juan Calle Arturo Cardoso Segunda Calle Primera Casa', '04269880761	', 'tallerdemotosforsroberro@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1058, '192.168.130.51', 'V12039919', 'Engelberth Perdomo', 1, 2, 0, 3, 1, 'Sabana Libre Calle 24 De Julio Tercera Casa Subiendo', '4269757479', 'enterberperdomo17@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1059, '192.168.130.52', 'V9328060', 'Jose Gregorio Peñaloza', 1, 5, 0, 3, 1, 'La Mata Media Cuadra Ante De La Plaza', '4268435270', 'penalozalydai19@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1060, '192.168.130.53	', 'V27674136	', 'Hery Briceño', 1, 2, 0, 3, 1, 'Sábana Libre Calle San Rafael Diagonal Al Palon Al Lado De La Ferretería', '04247164809', 'herybo67@gmail.com\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1061, '192.168.130.54', 'V24136384', 'Sala Auto Gobierno(Olga Valero) ', 1, 2, 0, 3, 2, 'Escuela Del Corocito', '4265968205', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1062, '192.168.130.55', 'V18095419', 'Maricela Garcia', 1, 1, 0, 3, 2, 'Colinas De Carmania Segunda Calle Casa 2 Donde Esta El Kiosko Blanco', '4160796103', 'garciamaricela154@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1063, '192.168.130.56', 'V30475384', 'Mirianny Perez', 1, 1, 0, 3, 1, 'Colinas De Carmania Calle 2 Casa 4 Por Donde Esta El Kiosko Blanco', '4140363697', 'perezmirianny628@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1064, '192.168.130.58', 'V10395494', 'Alcide De Jesus Linares', 1, 5, 0, 3, 1, 'Renacer De Conucos Callejon Sipriano', '04247427800; 0424372', 'Jesuslinares1039@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1065, '192.168.130.59', 'V 13764994', 'Jose Del Carmen Torres', 1, 5, 0, 3, 1, 'Renacer De Conucos Parte Alta Callejon Sinpiano La Quita Casa ', '4247538517', 'Torresjosedelcarmen18@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1066, '192.168.130.60', 'V 20790546', 'Enderlyn Jimenez', 1, 5, 0, 3, 1, 'Renacer De Conucos Parte Alta Callejon El Araguanei Casa Sin Nimero Frente Ala Caja N 215', '04263759554; 0414735', 'Ederlynjimenez@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1067, '192.168.130.61', 'V3739820', 'Alfredo La Cruz', 1, 5, 0, 3, 2, 'Quevedo A 5 Casas Mas Abajo Del Ambultorio', '4247213524', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1068, '192.168.130.62', 'V18095804', 'Blanca Gonzalez', 1, 4, 0, 3, 2, 'La Quinta Frente Al Monasterio', '4160281968', 'reymrabreu11@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1069, '192.168.130.63', 'V19271729', 'Ovelimar Valero', 1, 1, 0, 3, 2, 'Colinas De Carranza Mas Abajo Del Kiosko El Maracucho', '4147385333', 'ovelimarvleeo663@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1070, '192.168.130.64', 'V2688908', 'Aura Del Carmen Dominguez De Rondon', 1, 2, 0, 3, 1, 'Mas Arriba Del Arco Av Ppal', '4262758946', 'aurarondon266@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1071, '192.168.130.65', 'V10401422', 'Wilfredo Rojo', 2, 3, 0, 3, 1, 'Sara Linda Sector Las Carmelitas Av Ppl Donde Esta La Segunda Entrada Casa De La Esquina', '04165456728; 0412637', 'coromotop630@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1072, '192.168.130.66', 'V27245426', 'Tatina Quintero', 2, 3, 0, 3, 1, 'Sara Linda Sector Las Carmelitas Av Ppl Segunda Entrda Casa Azul', '4262202096', 'quinterotatiana077@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1073, '192.168.130.67', 'V20790544', 'Lisbeth Mavarez', 2, 3, 0, 3, 2, 'Sara Linda Sector Las Carmelitas Segunda Entrada Calle De Al Lado Del Gym Penultima Casa', '4247012890', 'josecabreraintet@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1074, '192.168.130.68', 'V9312736', 'Ramon Rodriguez', 1, 2, 0, 3, 2, 'Casa Frente Al Hotel Villa Vivenzio', '4269209054', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1075, '192.168.130.69', 'V12041003', 'Rafael Viloria', 1, 2, 0, 3, 1, 'Casa Frente Al Hotel Villa Vivenzio', '4247001166', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1076, '192.168.130.70', 'V10404188', 'Marbeny Viloria', 2, 3, 0, 3, 1, 'San Pedro A Cuatro Casas Despues De La Iglesia', '4247617870', 'marbviloria1@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1077, '192.168.130.71', 'V15583139', 'Willy Torres', 2, 3, 0, 3, 1, 'San Pedro Despues De La Iglesia Negocio De Willi', '4163302648', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1078, '192.168.130.72', 'V17095797', 'Zugeidy Carrillo', 1, 1, 0, 3, 2, 'Conicos De La Paz Parte Alta Por Donde Esta La Cruz Hacia Adentro A Cinco Casas', '4267740074', 'valenf.1305@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1079, '192.168.130.73', 'V24881204', 'Maira Vergara', 1, 4, 0, 3, 2, 'La Laja Parte Baja', '04269114331; 0424508', 'mariamanzanilla980@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1080, '192.168.130.74', 'V3491497', 'Jesus Abreu', 1, 4, 0, 3, 2, 'La Laja Parte Alta Mas Abajo De La Iglesia Casa Donde Esta La Mata De Mango Grande', '4147519879', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1081, '192.168.130.76', 'V9174144', 'Lida Del Carmen Delgado (Casa Retiro El Alto)', 1, 4, 0, 5, 2, 'La Laguneta Casa De Retiro Juan Pablo Ii', '4247388581/426658000', 'lidadelcarmen@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1082, '192.168.130.77', 'V19101471', 'Victoria Viloria', 1, 2, 0, 3, 2, 'Sector Los Canaletes Calle Via Pone Mesa', '4143793675', 'cea.reforma@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1083, '192.168.130.78', 'V14928308', 'Tania Carrizo', 2, 3, 0, 3, 1, 'Sara Linda Parte Baja Sector Las Carmelitas Mas Abajo De La Iglesia Evangelica', '4162348132', 'neidacarrizo.nm60@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1084, '192.168.130.79', 'V16557828', 'Luis Gutierez', 2, 3, 0, 3, 1, 'Sara Linda Antes De La Chicharronera Los Simancas Detras De La Peluqueria', '4264868572', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1085, '192.168.130.80', 'V7605019', 'Carlos Bradley', 1, 4, 0, 3, 1, 'El Alto Calle Miraflores Sector Cruz De La Mision Frente A La Posada Las Carolinas', '4246920058', 'carlos.brasley@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1086, '192.168.130.81', 'V20133100', 'Jose Martinez', 1, 4, 0, 3, 1, 'Despues De La Vinotinto A Dos Casas Despues De Las Monjas', '4262237975', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1087, '192.168.130.82', 'V22622499', 'Keila Berrios', 1, 4, 0, 3, 2, 'Quevedo Sectrobla Esperanza ultima Casa Del Sector', '4167214313', 'keilaberrios140@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1088, '192.168.130.83', 'V17265231', 'Franklyn Balza', 1, 4, 0, 3, 1, 'Quevedo Sector Cano', '4247739998', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1089, '192.168.130.84', 'V13759669', 'Yanet Caracas', 1, 4, 0, 3, 1, 'Las Cruces De La Union Casa Frente Al Ambulatorio', '4147381939', 'caracasyanet@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1090, '192.168.130.85', 'V12542455', 'Carolina Leal', 1, 4, 0, 3, 1, 'Las Cruces De La Union Casa Frente A La Iglesia', '4147451786', 'carolinadelvalle1402@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1091, '192.168.130.86', 'V20655916', 'Jesus Araujo', 1, 4, 0, 3, 1, 'Las Cruces De La Union Donde Esta La Cancha De Bolas Criollas', '4163802680', 'jesusaraujotorres13@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1092, '192.168.130.87', 'V11320255', 'Jose Gregorio Araujo', 1, 1, 0, 3, 1, 'La Constituyente Final De La Carretera De Cemento Segunda Casa', '4261738920', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1093, '192.168.130.88', 'V 28495295', 'Orangel Antonio Plaza Guillen', 1, 1, 0, 3, 1, 'Escuque Valle Alto Parte Alta Casa Numero 231', '04246315908; 0414383', 'Orangelplaza15@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1094, '192.168.130.89', 'V31732309', 'Adrian Montilla', 2, 3, 0, 3, 1, 'Sara Linda Parte Alta Despues Del Muro Cuarta Casa', '4263712467', 'am4980652@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1095, '192.168.130.90', 'V24619987', 'Luis Coy', 1, 4, 0, 3, 1, 'Las Cruces De La Union Segunda Casa Bajando La Iglesia', '4140749255', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1096, '192.168.130.91', 'V13404699', 'Elvia Salas', 1, 1, 0, 3, 1, 'Puerto Escondido A Tres Casas Despues De La Alcantarilla Subiendo', '4267731692', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1097, '192.168.130.92', 'V5627368', 'Teobaldo Sanz', 1, 5, 0, 3, 2, 'La Mata Via A Quevedo Antes Del Taller', '4247288621', 'falta@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1098, '192.168.130.93', 'V11798360', 'Maribel Gonzalez', 1, 2, 0, 3, 1, 'Sabana Libre Diagonal Al Cementerio Por El Taller De Motos', '4147389650', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1099, '192.168.130.94', 'V13402578', 'Yuleima Molero', 1, 2, 0, 3, 1, 'Sabana Libre Calle Pueblo Nuevo Cerca De  La Señora De Las Masas', '4247034612', 'yuleimamolero028@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1100, '192.168.130.95', 'V4663061', 'Angel Matos', 2, 3, 0, 3, 1, 'San Juan Sector La Abeja Parte Baja Frente Al Trapiche De Los Matos', '4247239289', 'falta@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1101, '192.168.130.96', 'V 27497188', 'Kenerly Paola Fajardo Villareal', 1, 4, 0, 3, 1, 'Al Esto De Escuque Sector Divino Niño Tercera Calle A Mano Derecha Casa Al Fonfo Blanca', '4160914984', 'Kenerlypaolafajardovillareal@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1102, '192.168.130.98', 'V 32282547', 'Diego Alfonso Jerez Rivero', 1, 2, 0, 3, 2, 'Sabana Libre Vista Hermosa Primera Etapa Casa C-24', '04164093218; 0416156', 'Jerezdiego908@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1103, '192.168.130.99', 'V5502273', 'Jacinto Gonzalez', 1, 4, 0, 3, 2, 'Sector Santa Maria Al Lado De La Casa Comunal', '4165370972', 'falta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1104, '192.168.20.124', 'V15431968', 'Rossie Baptista(Escuela La Cabaña)', 1, 1, 0, 8, 2, 'Sector La Cabaña, Escuela La Cabaña;', '4147363410', 'eb.mercedesdiaz@gmai', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1105, '192.168.20.141	', 'v20134423	', 'Sorangela Andreina Mendez Briceño', 2, 3, 0, 2, 2, 'Produaguacates, Vía Principal Más Abajo De Carlos Martines ( Alejandría)', '04247414183	 ', 'Odontologosorangelamendez@gmail.com ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1106, '192.168.20.143', '5102402', 'Benita Elena Ramos', 1, 1, 0, 2, 2, 'Sector La Candelilla ', '4247183606/416089198', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1107, '192.168.20.144', '15094226', 'Manuel Alejandro Torrellas Gutierrez', 1, 1, 0, 2, 2, 'Sector Candelillas, Granja S/N Parte Alta', '4242459368', ' manueltau@hotmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1108, '192.168.20.155', 'V20749133', 'Neida Del Valle Vasquez Torres ', 2, 3, 0, 2, 2, 'Final De San Pedro Finca De Zenic', '04161511523; 0416255', ' bricenodelgadojosegregorio8@gmaill.com ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1109, '192.168.20.160', '28033297', 'Anderson Jose Peña Perdomo', 1, 1, 0, 2, 2, 'Sector Candelilla Via Principal ', '4263742027', ' andersonpenaajpp@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1110, '192.168.20.17	', 'V 19898151', 'Anthony Briceño', 1, 1, 0, 2, 2, 'Carreterra Vieja Via Escuque Sector La Onda Escalera Numero 6 Casa Blanca', '04147008069; 04247313753', 'Anthony16mathi@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1111, '192.168.20.188', '13896001', 'Janeth Coromoto Leal', 1, 4, 0, 2, 2, 'Via Santa Maria, Las Cruces De San Juan, Via El Celebre', '4264695484', 'jannelyleal@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1112, '192.168.20.194', 'V30066411', 'Abel Castellanos ', 2, 3, 0, 2, 2, 'Sector 1 Produaguacate', '04167112731; 0416579', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1113, '192.168.20.212', 'V18349704', 'Alexander Guerra', 1, 4, 0, 2, 2, 'La Popa Casa S/N La Union, Escuque ', '0414-7139842 ', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1114, '192.168.20.22', 'V9176947', 'Luis Alberto Arnaldi', 1, 1, 0, 2, 2, 'Sector El Tendal, Calle El Calvario Al Final, Al Lado Sr Gonzalo', '4268283808; 41472710', 'luisarnaldi058@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1115, '192.168.20.240', 'V17265590', 'Victor Alfonso Garcia ', 1, 1, 0, 2, 2, 'Av Francisco Ruiz, Segunda Entrada Casa S-N Escuque ', '4247450754', 'VG17265590@GMAIL.COM ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1116, '192.168.20.25', 'V31168301', 'Carliany Salas', 2, 3, 0, 3, 2, 'La Abeja Parte Alta', '4247231286', 'carlianyandreinasalasfranco@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1117, '192.168.20.55', 'V10310032', 'Marcos Garcia', 1, 1, 0, 2, 2, 'Sector Los Potreritos, Carrtera Vieja Valera-Escuque, Casa Sn', '4126849904', 'MARCOSGARCIAGODY469@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1118, '192.168.20.57', '27415620', 'Ada Marquez', 1, 2, 0, 2, 2, 'Pencil Parte Alta, Calle Principal Antes De La Capilla (Bodega)', '4169073136', 'adalucamnicarquez@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1119, '192.168.20.58', 'V12045726', 'Zuleima Delgado', 1, 1, 0, 2, 2, 'Calle Media Luna, Casa 5, Mas Arriba De La Cruz, Escuque ', '4247408350', 'WILMERCAMACHO12@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1120, '192.168.20.61', '10400029', 'Nestor Pirela (Ocasional)', 1, 4, 0, 2, 2, 'Sector El Quinquinillo El Boqueron Casa S/N', '4146746941', 'Pirelan77@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1121, '192.168.20.64', 'V4063135', 'Gladis Josefina Juarez Perez', 1, 1, 0, 2, 2, 'Casa Nro 19 Calle Mismote Frente A La Plaza Bolivar', '4247436445', ' gladisjuarez@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1122, '192.168.20.70', '15042203', 'Maria Nazareth Toro Araujo', 1, 2, 0, 2, 2, 'Pencil Parte Alta , Detras De La Iglesia ', '4149743127', 'airamhterazanT@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1123, '192.168.20.90', 'V34686177', 'Dani David Caldera Navas', 1, 1, 0, 2, 2, 'Sector Media Luna, Callejon San Isidro, Casa S/N', '04162561070; 0424728', ' Calderadani5@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1124, '192.168.20.91', 'V17391084', 'Neida Sanchez', 1, 1, 0, 2, 2, 'Calle Principal, Via La Macarena', '4261191559', ' NEIDADELVALLESANCHEZ@GMAIL.COM ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1125, '192.168.20.96', '7964113', 'Elizabeth Del Valle Montilla', 1, 4, 0, 2, 2, 'El Filo De La Rueda, Sector El Pao', '4166666557', 'Montillaelizabethdelvalle@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1126, '192.168.30.100', 'V14644260', 'Gusmara Lossada', 1, 5, 0, 3, 2, 'Sector La Mata, Calle Ciega El Molino', '4261562402', 'gusmalossada@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1127, '192.168.30.101', 'V9352739', 'Luis Garcia', 1, 5, 0, 3, 2, 'Sector La Mata, Calle La Milagrosa Casa S/N', '4147393398 / 0424763', 'galbertoluisalberto@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1128, '192.168.30.102', 'V7976620', 'Daysi Matheus', 1, 5, 0, 3, 2, 'Sector La Mata, Urb San Jose', '4247718750', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1129, '192.168.30.103', 'V10395718', 'Yackelyn Villarreal', 1, 5, 0, 3, 2, 'La Mata Calle Principal Sector San Benito Casa 69', '4168798871', 'JAIMIFV2003@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1130, '192.168.30.104', 'V20151741', 'Elizabeth Quintero', 1, 5, 0, 3, 2, 'Sector La Mata, Calle Las Dalias Csa 178', '4265775912', 'quinteroelizabeth.rondon@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1131, '192.168.30.105', 'V26795206', 'Jorge David Alvarado Mas Y Rubi', 1, 5, 0, 3, 2, 'Sector La Mata, Urb. San Jose Casa Numero 4', '04147425133 / 041642', 'zexuxttd2002@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1132, '192.168.30.106', 'V15467046', 'Maykelys Mogollon', 1, 2, 0, 3, 2, 'Sector San Benito , Tercera Calle ', '4249079225', 'mogollonmaikelys94@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1133, '192.168.30.109', 'V10141545', 'Enida Yustiz', 1, 5, 0, 3, 2, 'Sector La Mata, Callejon Las Dalias Ultima Casa', '4247762984', 'enida_yutiz@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1134, '192.168.30.11', 'V 11128404', 'Pedro Jose Mijares Santiago', 1, 2, 0, 3, 2, 'Vista Hermosa, 1Ra Etapa,Calle Buena Ventura, Casa B23', '4247100332', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1135, '192.168.30.110', 'V12540921', 'Deysi Ruz', 1, 5, 0, 3, 2, 'Urb.San Jose, Vereda 5 Casa #23', '4147268638', 'deysioromotoruz@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1136, '192.168.30.111', 'V5816330', 'Denis Josefina Hidrobo', 1, 5, 0, 3, 2, 'Sector La Mata Calle Ciega, Callejon El Molino', '4143745398', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1137, '192.168.30.112', 'V9328889', 'Fernando Jose Bolaño Matos', 1, 5, 0, 3, 2, 'Sector El Molino Casa S/N , Frente A La Licoreria', '4247305774', ' FERNANDO.28BOL@GMAIL.COM ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1138, '192.168.30.113', 'V10317073', 'Maria Eugenia Vargas', 1, 5, 0, 3, 2, 'Sector La Mata, La Cruz De La Mision Cerca De La Escuela', '4140791070', 'jefferson_d19@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1139, '192.168.30.114', 'V14305257', 'Yenheili Yuneiski Zambrano Zambrano', 1, 5, 0, 3, 2, 'Urb Las Dalias Casa Nro 2', '4128662058', ' YENHEILIzambrano76@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1140, '192.168.30.115', 'V17093220', 'Rosa Virginia Molina', 1, 5, 0, 3, 2, 'Via Conucos, Callejon El Molino, Santa Rita, Escuque, Conucos De La Paz', '4121256381', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1141, '192.168.30.116', 'V5494393', 'Iris Violeta Abreu Abreu', 1, 5, 0, 3, 2, 'Calle Principal Parte Alta Casa Numero 38', '4140746931', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1142, '192.168.30.117', 'V19287482', 'Yanuary Romelia Abreu', 1, 5, 0, 3, 2, 'Sector El Terreno, Al Lado De La Cancha, Santa Rita, Escuque', '4141753877', ' yanuary2489@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1143, '192.168.30.119	', 'V21062832	', 'Maribel Briceño', 1, 5, 0, 3, 2, 'Sector La Mata, Calle Principal Piscina De Pepe	', '4247707964', 'briceno13maribel@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1144, '192.168.30.12', 'V9178199', 'Consuelo Del Carmen Mendoza Herrera', 1, 2, 0, 3, 2, '1Ra Etapa,Calle Buena Ventura, Casa A29', '424-7052884', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1145, '192.168.30.120', 'V29764146', 'Davidson Sequera', 1, 5, 0, 3, 2, 'La Mata Calle La Milagrosa, Casa N162', '4125139653', 'SEQUERADAVIDSON931@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1146, '192.168.30.121', 'V9328801', 'Carmen Rosa Alarcon', 1, 5, 0, 3, 2, 'La Mata Sector El Molino', '4247554898', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1147, '192.168.30.122', 'V7572857', 'Doris Sanchez', 1, 5, 0, 3, 2, 'Callejon El Molino, ultima Casa Tapon Porton Negro, Sector La Mata', '', 'chiquido226@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1148, '192.168.30.124', 'V17038915', 'Jose Suarez ', 1, 2, 0, 3, 2, 'Vista Hermosa, Calle La Paz, Casa A24, Sabana Libre ', '4261368656', 'JOSESUAMANCHA@HOTMAIL.COM ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1149, '192.168.30.125', 'V19795646', 'Darly Andreina Leguizamo De Viloria', 1, 5, 0, 3, 2, 'La Mata, Santa Rita, Escuque ', '4247234987', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1150, '192.168.30.128', 'V12040323', 'Rosa Silmina Ramirez Gonzalez', 1, 5, 0, 3, 2, 'Calle El Molino, La Mata', '4262856756', ' rosasilminaramirez@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1151, '192.168.30.129', 'V26123345', 'Yorgelis Gabriela Diaz Angulo', 1, 5, 0, 3, 2, 'Calle Principal La Mata, Frente Al Ambulatorio, Casa 9-1', '4247537179', ' yorgelissdiaz.20@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1152, '192.168.30.13', 'V6535068', 'Dora Hernandez Pacheco', 1, 2, 0, 3, 2, '1Ra Etapa Calle La Paz Sector A23', '424-7726589', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1153, '192.168.30.130', 'V16881894', 'Luis Alberto Rangel Molina', 1, 5, 0, 3, 2, 'Calle La Milagrosa La Mata', '4247043287', ' rangelmolinaluisalberto@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1154, '192.168.30.131', 'V4528413', 'Neuro Nerberto Ordoñez Castillo', 1, 5, 0, 3, 2, 'Ector La Antena, Calle Principal Cerca De La Antena De Simpatia', '4247845372', 'neurob413@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1155, '192.168.30.132', 'V16377932', 'Maria Eugenia Briceño Palomares ', 1, 5, 0, 3, 2, 'Sector La Antena, (Puerta El Golpe), Casa S/N, La Mata ', '4161579314', 'BRICENOMARIAEUGENIA2@GMAILCOM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1156, '192.168.30.133', 'V5498534', 'Armando Antonio Gonzalez Teran', 1, 5, 0, 3, 2, 'Frente A La Plaza Bolivar A3 Casa De La Iglesia', '4247633318', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1157, '192.168.30.134', 'V15188402', 'Zugeddy Herrera', 1, 5, 0, 3, 2, 'Sector Los Pinos Uno, Con Calle Cementerio, Casa #8B', '4247010629', 'rozilvanyxsalas33@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1158, '192.168.30.135', 'V10913497', 'Carmen Magaly Monsalve Angulo', 1, 2, 0, 3, 2, 'Calle Grupo Escolar, Urb Saman 1, Casa #3', '4247725284', 'magarilemar23@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1159, '192.168.30.136', 'V27848387', 'Wanda Paola Bracho Rincon', 1, 5, 0, 3, 2, 'Sector La Mata Calle Principal Puerta De Golpe', '4121247083', ' wandabracho5@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1160, '192.168.30.138', 'V11897825	', 'Jackeline Del Valle Salas De Bolaño		 ', 1, 5, 0, 3, 2, 'La Mata Calle Principal A 2 Casas De La Medicatura', '4247098412/4166762323', 'jackelinesalas75@gmail.com \r\n', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1161, '192.168.30.139', 'V18984596', 'Normayuri Del Valle Montilla Matheus', 1, 5, 0, 3, 2, 'La Mata, Santa Rita Calle El Molino', '4247196452', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1162, '192.168.30.14', 'V 11324992', 'Lisbeth Marisol Vargas Peña;1', 2, 3, 0, 2, 1, '', '4147491306', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1163, '192.168.30.140', 'V30302631', 'Jaimileidy Fernandez ', 1, 5, 0, 3, 2, 'La Mata Calle Principal, Casa Numero 52', '4147154571', ' jaimifv2003@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1164, '192.168.30.141', 'V10396430', 'Maribel Villarreal', 1, 5, 0, 3, 2, 'Sector La Mata Calle Principal Casa N45', '4247065719', 'Maribelvillarreal88@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1165, '192.168.30.142', 'V10400939', 'Ender Javier Rangel Villarreal', 1, 5, 0, 3, 2, 'La Mata Calle Sagrada Familia, Sector El Molino', '4168994658', 'eliseo.ender@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1166, '192.168.30.143', 'V15584730', 'Fabian Peñaloza', 1, 5, 0, 3, 2, 'Urb.San Jose, Casa 07, La Mata', '4165675847', 'peñalozaalarconf@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1167, '192.168.30.144', 'V6294117', 'Jose Salas', 1, 5, 0, 3, 2, 'Av. Principal De La Mata, A 120Mt Colegio De La Mata', '4245850950', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1168, '192.168.30.145', 'V12798002', 'Rafael Peña ', 1, 5, 0, 3, 2, 'Avenida Principal, Diagonal A La Escuela De La Mata ', '4166027671', ' Powermax1279@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1169, '192.168.30.146', 'V30867672', 'Leandro David Abreu Torres', 1, 5, 0, 3, 2, 'Sector La Cruz, Ultima Calle Casa Ultima, La Mata ', '4247555204', 'abreuleandro47@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1170, '192.168.30.147	', 'V15752663	', 'Olga Luisa Peñaloza Briceño', 1, 5, 0, 3, 2, 'Calle Principal, Casa #51, Sector La Mata	', '4247769520	', 'olga.lpdm@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1171, '192.168.30.148', 'V11615905', 'Ana Julia Fernandez', 1, 5, 0, 3, 2, 'Sector La Mata, Casa#172D Calle Las Dalias', '4147030974', 'eliascatire22@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1172, '192.168.30.149', 'V16534150', 'Ricardo Manzanilla', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Calle Principal, Segunda Etapa, Casa #I51', '4147348562', 'kcalderont2@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1173, '192.168.30.15', 'V25485063', 'Jesus Enrique Prieto Rosario', 1, 2, 0, 3, 2, '1Ra Etap. Calle Los Azulejos, Casa F14', '4247156287', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1174, '192.168.30.150', 'V26784353', 'Fabiola Antonieta Vasquez Vielma', 1, 5, 0, 3, 2, 'Sector La Mata, Calle Principal, Casa S/N', '4264497644', 'fv0708794@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1175, '192.168.30.151', 'V20430742', 'Exio Rafael Bravo Albornoz', 1, 5, 0, 3, 2, '', '4145327172', 'JINZAYBRAVO2015@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1176, '192.168.30.152', 'V13896222', 'Orlando Jose Peñaloza Matheus', 1, 5, 0, 3, 2, 'Calle El Molino La Mata,', '4147222428', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1177, '192.168.30.153', 'V18350716', 'Ildemari Abreu', 1, 5, 0, 3, 2, 'Sector La Mata, Calle Buen Pastor Casa 141', '4165201619', 'abreuilde07@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1178, '192.168.30.154', 'V5502760', 'Pedro Torres', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Av El Paraiso 1Ra Etapa, Casa D12', '4121731561', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1179, '192.168.30.155', 'V9173321', 'Aura Ramirez Rondon', 1, 5, 0, 3, 2, 'Av Principal Despues Del Parque, Casa #41', '4247241526', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1180, '192.168.30.156', 'V20655602', 'Suleybi Karina Alarcon Vieras', 1, 5, 0, 3, 2, 'Sector El Terreno, Diagonal Al Estadio Casa S/N', '4160212169', 'Sulejose.1107@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1181, '192.168.30.157', 'V30559351', 'Cristabel Andrea Blanco Mendez ', 1, 4, 0, 3, 2, 'Sector Las Rurales Del Alto, Diagonal A La Capilla ', '4147523181', 'cristabel16.blanco@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1182, '192.168.30.158', 'V27512141', 'Sunis Carolina Castro', 1, 5, 0, 3, 2, 'Calle Las Dalias, Via Quevedo, Sector La Mata', '', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1183, '192.168.30.159', 'V14718784', 'Miriam Elena Prada', 1, 5, 0, 3, 2, 'Calle Principal Parte Baja  Casa Sin Numero, La Mata', '04166714185/ 0426473', 'miriamelenaprada@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1184, '192.168.30.16', 'V10312516', 'Raiza Josefina Cabrera Silva', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, 1Ra Etap. Sector I Casa C25', '4140827407', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1185, '192.168.30.160', 'V30047616', 'Hosmary Viviana Soto Villarreal', 1, 5, 0, 3, 2, 'Calle Principal Parte Baja  Casa 056, La Mata', '4247484896', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1186, '192.168.30.161', 'V9178720', 'Nestor Luis Abreu Abreu', 1, 5, 0, 3, 2, ' La Mata Sector El Terreno Frente Al Estadio, Casa Nro. 80', '4246940361', 'Ingnendeabrenest2015@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1187, '192.168.30.162', 'V11127896', 'Numa Javier Briceño Araujo', 1, 5, 0, 3, 2, 'La Mata Calle Estadium Casa Nro 83 ', '4247352559', ' a1supernuma@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1188, '192.168.30.164', 'V16266887', 'Gabriela Delgado', 1, 2, 0, 3, 2, 'Calle Las Flores, Casa 25 Sabana Libre', '4161996708', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1189, '192.168.30.165', 'V17598410', 'Roberto Colina', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa Casa B16', '4162158448 / 4164298', 'rdejesusch86@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1190, '192.168.30.166', 'V19749156', 'Karl Nuhlen', 1, 5, 0, 3, 2, '', '4247221609', 'karl_cfk@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1191, '192.168.30.168', 'V16535531', 'Ever Enrique Viloria ', 1, 5, 0, 3, 2, 'Via Principal Los Conucos Parte Baja Casa Sin Numero', '4261942531', 'viloriae650@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1192, '192.168.30.169', 'V4657698', 'Ramona Ramirez', 1, 5, 0, 3, 2, 'La Mata, Calle La Zuruma, Via Principal, Casa #548, Santa Rita Escuque ', '4145028513', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1193, '192.168.30.17', 'V18457955', 'Dennis Salas ', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, 2Da Etapa Casa #O49', '4149798990/424771166', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1194, '192.168.30.170', 'V13632395', 'Milibeth Del Carmen Villarreal De Diaz', 1, 5, 0, 3, 2, 'La Mata Sector El Molino Al Lado De La Licoreria , Santa Rita, Escuque ', '4265718069', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1195, '192.168.30.171', 'V3736960', 'Rosa De Gonzalez', 1, 5, 0, 3, 2, 'Sector Suruma, Calle Suruma, Via Principal La Mata, Escuque', '424714601', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1196, '192.168.30.173', 'V26962566', 'Kareana Delgado', 1, 5, 0, 3, 2, 'La Mata Via Principal, Cerca Del Parque, Santa Rita, Escuque ', '4147364162', 'KAREANADELGADO88@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1197, '192.168.30.174', 'V27896278', 'Laura Fernandez ', 1, 5, 0, 3, 2, 'La Mata Sector La Antena, Puerta De Golpe Casa #199 , Santa Rita, Escuque ', '4266678459', 'ANYELINAFER30@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1198, '192.168.30.175', 'V14149334', 'Franco Adelso', 1, 5, 0, 3, 2, 'Calle La Zuruma,  Sector La Mata, Parq.Santa Rita, Mun.Escuque', '', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1199, '192.168.30.176', 'V5504746', 'Maria Dolores Rivero', 1, 5, 0, 3, 2, 'Sector Puerta De Golpe, La Antena(Antiguo Radio Simpatia) Casa S/N ', '4166718179', 'degreenegron@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1200, '192.168.30.177', 'V30930806', 'Nestor Andara', 1, 5, 0, 3, 2, 'Calle Principal De La Mata, Casa #34, Sector La Mata Parq.Santa Rita, Mun Escuque', '4267030007', 'nestoraandara@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1201, '192.168.30.178', 'V13522929', 'Juan Garcia', 1, 5, 0, 3, 2, 'Calle La Esperanza, Tercera Casa A Mano Derecha, #03, Sector Quevedo, Parq.Santa Rita, Mun.Escuque', '4247129466, 42470525', 'jesus2008ve@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1202, '192.168.30.179', 'V13522929', 'Juan Garcia', 1, 5, 0, 3, 2, 'Calle La Esperanza, Ultima Casa Tapon, Sector Quevedo, Parq.Santa Rita, Mun.Escuque', '4247129466', 'juanjosegarcia1978@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1203, '192.168.30.18', 'V13997470', 'Jorge Rafael Romero Dorantes', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, 2Da Etapa Casa #O11', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1204, '192.168.30.180', 'V11897403', 'Oscar Enrique Mendoza Maldonado', 1, 5, 0, 3, 2, 'Sector Quevedo Via Principal Casa S/N', '4265147424', 'oscarenmen@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1205, '192.168.30.182', 'V21061605', 'Yhosue Vasquez', 1, 5, 0, 3, 2, 'Sector Cotiza, Casa #6 Av Principal La Mata', '4247655911', 'jhosuevasquez@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1206, '192.168.30.183', 'V6132499', 'Marvelis Gonzalez', 1, 5, 0, 3, 2, 'Via Principal La Mata Quevedo', '4146213095', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO');
INSERT INTO `contratos` (`id`, `ip`, `cedula`, `nombre_completo`, `id_municipio`, `id_parroquia`, `id_comunidad`, `id_plan`, `id_vendedor`, `direccion`, `telefono`, `correo`, `fecha_instalacion`, `ident_caja_nap`, `puerto_nap`, `num_presinto_odn`, `id_olt`, `id_pon`, `estado`) VALUES
(1207, '192.168.30.184', 'V5762991', 'Jose Viloria ', 1, 4, 0, 3, 2, 'Sector Quevedo, Calle Principal, Al Lado De La Escuela', '4147584993', 'VILGARVILORIA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1208, '192.168.30.185', 'V5764342', 'Norma Beatriz Cedeño De Fuenmayor', 1, 5, 0, 3, 2, 'Quevedo Parte Baja Carretera Principal Diagonal A La Cruz De La Mision ', '4147295264', 'normafuenmayor@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1209, '192.168.30.186', 'V27497114', 'Arley Tapia ', 1, 5, 0, 3, 2, 'Quevedo, Sector La Esperanza ', '', 'ARLEYTAPIA104@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1210, '192.168.30.187', 'V15752651', 'Elvia Peñaloza', 1, 4, 0, 5, 2, 'Urb.San Jose, Casa #11, La Mata, Parq.Santa Rita Mun.Escuqie', '4247548228', 'Oneluz2207@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1211, '192.168.30.188', 'V25171490', 'Zara Causado', 1, 4, 0, 3, 2, 'Via Principal Quevedo, Quinta La Embajada.', '4126902836', 'zaracausaso@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1212, '192.168.30.189', 'V9498697', 'Marlene Villarreal', 1, 4, 0, 3, 2, 'Quevedo Parte Baja, Callejon Al Lado De La Quinta La Embajada', '4266717759', 'VILLARREALMARLENE68@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1213, '192.168.30.19', 'V12796764', 'Maria Alejandra Garcia Paniza', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Sector I Casa A35 Buena Ventura', '4247198906', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1214, '192.168.30.190', 'V30189699', 'Esteban Eli Gomez Gonzalez', 1, 5, 0, 3, 2, 'Plaza Bolivar De La Mata, Al Lado De La Iglesia De Santa Rita, Escuque.', '', 'gregoriagv56@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1215, '192.168.30.191', 'V17830197', 'Nathaly Villarreal (David Tapia)', 1, 5, 0, 3, 2, 'Quevedo Parte Alta, S/N (Ref Mas Arriba De La Escuela De Quevedo)', '4247293100', 'Nathalyvilla207@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1216, '192.168.30.192', 'V10399572', 'Gregoriana Del Carmen Gonzalez Gonzalez', 1, 5, 0, 3, 2, 'Quevedo Avenida Principal Casa Sin Numero, Frente A La Iglesia Y Plaza', '04246144789 / 041460', 'PENDIENTE', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1217, '192.168.30.193', 'V16738096', 'Jose Andrade', 1, 5, 0, 3, 2, 'Urb.San Jose, Casa #14, La Mata, Mun.Escuque', '4163772919', 'vale1jose2jean3@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1218, '192.168.30.194', 'V12685891', 'Hector Briceño ', 1, 2, 0, 3, 2, 'Calle San Rafael, Sabana Libre Ferreteria Tarcy', '4247437423, 41697159', 'Hjb1176@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1219, '192.168.30.195', 'V30976022', 'Noriher Leandra Pineda Vielma', 1, 5, 0, 3, 2, 'La Mata, Sector El Terreno Al Lado De La Bodega, Casa S/N', '4146662386', 'FVO708497@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1220, '192.168.30.196', 'V4160997', 'Magaly Margarita Quintero Gil', 1, 5, 0, 3, 2, 'Calle El Buen Pastor ', '', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1221, '192.168.30.197', 'V11944481', 'Carmen Alejandra Barroeta', 1, 5, 0, 3, 2, 'Calle Principal De Quevedo, A Seis Casa De La Capilla, Casa S/N', '4246879913', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1222, '192.168.30.198', 'V17391875', 'Romer Leonardo Briceño Gonzalez', 1, 5, 0, 3, 2, 'Quevedo Calle Principal Diagonal A La Iglesia De Quevedo', '04241422971 / 042414', 'romerleonardo07@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1223, '192.168.30.199', 'V13050625', 'Bernardo Chacon', 1, 5, 0, 3, 2, 'Quevedo, Sector La Peregrina, Al Lado De La Escuela, Ultima Casa', '4162543636', 'bernardojosechaconmoreno@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1224, '192.168.30.200', 'V4061444', 'Laura Uzcategui', 1, 2, 0, 3, 2, 'Calle Bolivar, Al Lado De La Farmacia De Sabana Libre, Escuque', '4164418025', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1225, '192.168.30.201', 'V24618564', 'Jose Daniel Suarez Abreu', 1, 5, 0, 3, 2, 'Sector El Terreno, Frente Al Estadio La Mata, Mun.Escuque', '4247240707, 42475195', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1226, '192.168.30.202', 'V15430397', 'Henrry Araujo', 1, 4, 0, 3, 2, 'Rurales Del Alto, Via Principal Alto De Escuque, Casa 11-48', '4247251572', 'henrryelalto@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1227, '192.168.30.203', 'V13261448', 'Yenny Gutierrez', 1, 2, 0, 3, 2, 'Calle San Agustin, Casa S/N Mun Escuque, Parq.Sabana Libre', '4167039457 , 4167130', 'yennygutierrez24@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1228, '192.168.30.204', 'V26158044', 'Maria Liscano', 1, 2, 0, 3, 2, 'Sector Los Pinos Mas Arriba Del Palon Las Invasiones', '4147351666', 'marializcano.97@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1229, '192.168.30.205', 'V5763100', 'Rosalia Matheus Rivero', 1, 4, 0, 3, 2, 'El Alto De Escuque Calle Independecia ', '4263264392', 'rosaliamatheus0361@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1230, '192.168.30.206', 'V2618607', 'Ramon Dario Leon Matheus', 1, 4, 0, 3, 2, 'Final Calle Miranda,  Casa#4 Alto De Escuque, Prq.La Union', '', 'ramonleon2023@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1231, '192.168.30.207', 'V12042986', 'Maribel Elena Perez Delgado ', 1, 4, 0, 3, 2, 'Sector Divino Niño Via Principal Hacia Quevedo, Sector Alto De Escuque, Mun.Escuque', '4264764613', 'MARIBELELENAPEREZDEL@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1232, '192.168.30.208', 'V17606911', 'Yessa Rangel', 1, 4, 0, 3, 2, 'Alto De Escuque, Sector La Huerta, Calle Prncipal Entrada San Benito, Casa S/N', '4263274491', 'yessa2410@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1233, '192.168.30.209', 'V10312942', 'Sandro Jose Garcia Araujo', 1, 4, 0, 3, 2, 'Calle Paez, Via Principal Casa #14, Casco Del Alto De Escuque, Mun.Escuque', '4261220499', 'titosandro25@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1234, '192.168.30.21', 'V 9314044', 'Luis Antonio Luque Balza', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Sector 2 Calle Los Pardillos Casa L18', '414 7347070', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1235, '192.168.30.210', 'V22996491', 'Jesus Miguel Araujo Moreno', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Calle Los Azulejos, 1Ra Etapa, Casa #F17', '04123514765, 0414752', 'jesus15arauj@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1236, '192.168.30.211', 'V22996491', 'Eder Delgado', 1, 2, 0, 8, 2, 'Urb.Vista Hermosa, 2Da Etapa, Calle Principal Casa#', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1237, '192.168.30.212', 'V23781291', 'Maria Daniela Araque Moreno', 1, 4, 0, 3, 2, 'Alto De Escuque, Calle Independencia Casa #05', '4149661458', 'mada_1124@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1238, '192.168.30.213', 'V18458900', 'Rafael Araque', 1, 4, 0, 3, 2, ' Calle Independencia, Casa #1 Alto De Escuque', ',04247802232 - 04247', 'danin69@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1239, '192.168.30.214', 'V12047182', 'Franklin Valero', 1, 4, 0, 3, 2, 'Sector Las Casitas El Alto De Escuque Via Las Rurales.', '4262400101', 'perezvaleroangeldavid@gmai.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1240, '192.168.30.215', 'V15430182', 'Ramon Jose Bravo', 1, 4, 0, 3, 2, 'Sector Alto De Escuque, Calle Sucre Casa #2, Parq, La Union, Mun.Escuque', '4126936334', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1241, '192.168.30.216', 'V28257980', 'Yoselin Daza', 1, 4, 0, 3, 2, 'Calle Santa Rosalia, Casa Sin Numero, Alto De Escuque, Mun.Escuque', '4261648343', 'liva.vsd3@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1242, '192.168.30.217', 'V9496821', 'Thamara Gonzalez', 1, 2, 0, 3, 2, ' Urb.Vista Hermosa, Sector A Casa A26 Calle El Eden, Primera Etapa, Sabana Libre', '4247085703', 'Gonzaleztamaraynes@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1243, '192.168.30.218', 'V26412676', 'Yenileth Balza', 1, 4, 0, 3, 2, 'Sector Las Casitas Del Alto De Escuque, Calle Don Bosco, Casa S/N, Parrq. La Union, Mun.Escuque', '4121059031', 'yusneirybarrios@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1244, '192.168.30.219', 'V30866847', 'Daniela Abreu', 1, 2, 0, 3, 2, 'Calle 24 De Julio, Subiendo Los Canaletes, Sabana Libre, Mun.Escuque', '4247071937', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1245, '192.168.30.22', 'V 11896368', 'Yaritza Del Valle Ramirez Gonzalez', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Calle O Casa O30, Sector 2 Segunda Etapa', '4147416239', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1246, '192.168.30.221', 'V16679785', 'Lincoln Jose Paez', 1, 2, 0, 3, 2, 'San Benito, (Sector El Terreno) Casa Sin Numero, Sabana Libre, Mun Escuque.', '4247172695', 'lincolnpaez@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1247, '192.168.30.222', 'V9176626', 'Jose Ernesto Rojas Pabon', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Calle Los Azulejos, Sactor E Casa 05, Sabana Libre, Mun.Escuque', '4140811213 041288068', 'fumigacionesenvenezuela@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1248, '192.168.30.225', 'V5506083', 'Marcos Mendoza', 1, 2, 0, 5, 2, ' Calle San Agustin, Casa S/N Parq.Sabana Libre, Mun Escuque', '4144610114', 'mtmh.insta@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1249, '192.168.30.226', 'V23781272', 'Karelys Parra', 1, 4, 0, 3, 2, 'Sector La Rurales , Calle Hugo Chavez(Barrio Chino) Primera Casa A Mano Izquierda', '4146398918', 'efra.mao.rosne.parra@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1250, '192.168.30.227', 'V11319259', 'Edis Gonzalez', 1, 4, 0, 3, 2, 'Sector La Laguneta, Casa #15 , Diagonal A La Entrada De Las Antenas', '4266667952', 'edisjoseunefa@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1251, '192.168.30.228', 'V29694300', 'Sarahi Leon', 1, 4, 0, 3, 2, 'Sector La Laguneta, Via El Alto De Escuque - Sabana Libre, Casa Mi Cafetal', '04126927926 , 042462', 'sarahi.lb01@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1252, '192.168.30.229', 'V27070425', 'Paul Leon', 1, 4, 0, 3, 2, 'Sector La Laguneta, Via El Alto De Escuque - Sabana Libre, Casa Mi Cafetal', '4247511623', 'Paul.vjt68@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1253, '192.168.30.230', 'V14718517', 'Danni Mendez', 1, 4, 0, 3, 2, 'Sector La Laguneta, Via El Cerro Pobipom, Parq La Union. Mun.Escuque', '4145212620', 'yutsymatheus@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1254, '192.168.30.231', 'V12456060', 'Carlos Alberto Briceño Duran', 1, 4, 0, 3, 2, 'Sector La Legua, Via Cerro Pobipom, El Alto De Escuque', '4265780748', 'duran20081@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1255, '192.168.30.232', 'V20430517', 'Anali Maldonado', 1, 4, 0, 3, 2, 'Sector La Laguneta, Via El Cerro Pobipom,Segunda Cuadra A La Izquierda Porton Negro Parq La Union. Mun.Escuque, ', '4145212620', 'maldonadoanaly1@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1256, '192.168.30.233', 'V23777152', 'Clara Flores ', 1, 4, 0, 3, 2, 'Sector La Laguneta, Via El Cerro Pobipom, Casa S/N, Parrq.La Union, Mun.Escuque ', '4263243303', 'mendezlisandro03@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1257, '192.168.30.234', 'V7605014', 'Carlos Bradley', 1, 4, 0, 3, 2, 'Sector La Laguneta, Via El Cerro Pobipom, Casa #3 ñ, Parrq.La Union, Mun.Escuque ', '4246920058', 'carlosr.bradley@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1258, '192.168.30.235', 'V4662363', 'Francisco Palmera', 1, 4, 0, 3, 2, 'Sector San Benito, Alto De Escuque, Avenida Principal', '4165330811', 'ligiapalmera@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1259, '192.168.30.236', 'V 15583654', 'Reinaldo Enrique Briceño Cañizales ', 1, 4, 0, 3, 2, 'Sector La Laguneta, Via El Cerro Pobipom, Callejon A Mano Derecha Ultima Casa, Parrq. La Union, Mun.Escuque', '04147314710; 0414375', 'Rebc2112@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1260, '192.168.30.238', 'V16150044', 'Ligia Elena Palmera', 1, 4, 0, 3, 2, 'Alto De Escuque, Calle Miranda Casa S/N', '4.161.958.567', 'palmeraligia@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1261, '192.168.30.239', 'V16376234', 'Jose Antonio Chacon ', 1, 4, 0, 3, 2, 'Calle Miranda Casa #7, La Union, Escuque ', '4168064291', 'joseantoniocjm@gmaill.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1262, '192.168.30.24', 'V 26412435', 'Francisco Andres Paredes Quevedo', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Segunda Etapa Calle Pardillo Casa L24', '4143755470', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1263, '192.168.30.240', 'V25170956', 'Yanderliz Villarreal', 1, 4, 0, 3, 2, 'Sector Las Rurales, Via Quevedo Abajo Del Estadio Casa S/N, A Union, Escuque ', '4247122590; 04247794', 'jeanmatos0479@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1264, '192.168.30.241', 'V30190020', 'Carlos Alberto Gonzalez Ruiz', 1, 5, 0, 3, 2, 'Final De Calle Santa Rita, Sector El Bucare, Al Lado De La Cancha, La Mata', '4247373414', 'carlosalbertogonzalezruiz2@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1265, '192.168.30.242', 'V4736350', 'Roberto Ramirez Melendez', 1, 4, 0, 3, 2, 'Final Calle Sucre, Sector Mirabel, Primer Chalet Frente A La Cruz De La Mision, Alto De Escuque, Parq.La Union Mun.Escuque', '04147297517; 0414371', 'avgrobertorm@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1266, '192.168.30.243', 'V18984763', 'Francesca Dubraska Tomassi', 1, 5, 0, 3, 2, 'Urb.San Jose, Casa 17, La Mata, Parrq.Santa Rita,Mun. Escuque', '4247344626', 'ftomassi02@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1267, '192.168.30.244', 'V21065792', 'Merly Carolina Viloria Olmos', 1, 2, 0, 3, 2, 'Calle Democracia, Casa S/N Mas Arriba Del Kikiriki, Sabana Libre, Mun.Escuque', '4164076397; 04262439', 'merlycarolinaviloriaolmos@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1268, '192.168.30.245', 'V13523783', 'Juan Jose Maldonado', 1, 4, 0, 3, 2, 'Sector La Laguneta, Calle Principal Casa #22 Via Principal Frente Policia Acostado, Mun.Escuque', '04247190612; 0414079', 'maldonadojuan0502@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1269, '192.168.30.246', 'V 16535968', 'Militza Del Carmen Rondon Sanchez', 1, 2, 0, 3, 2, ' Urb. Vista Hermosa Calle 3 Casa M1', '424 2177532', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1270, '192.168.30.247', 'V15757098', 'Shirley Alejandra Hernandez Aponte', 1, 5, 0, 3, 2, 'Callejon Las Dalias, Con Calle Las Dalias, La Mata, Parrq.Santa Rita Mun.Escuque', '04247038669; 0416511', 'Shirleyhernandez759@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1271, '192.168.30.249', 'V10030164', 'Rosalba Uzcategui', 1, 2, 0, 3, 2, 'Call San Rafael Cruce Con Las Flores Hotel Mi Delirio, Sabana Libre, Mun.Escuque', '04147293949: 0412140', 'CALL SAN RAFAEL CRUCE CON LAS FLORES HOTEL MI DELIRIO, SABANA LIBRE, MUN.ESCUQUE', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1272, '192.168.30.25', 'V 20429748', 'Yeny Maria Pineda Leal', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Etapa 1 Calle Buena Ventura B04', '4140820075', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1273, '192.168.30.250', 'V3463243', 'Jose Maria Viloria Gonzalez', 1, 4, 0, 3, 2, 'Sector La Laguneta El Alto De Escuque', '4162198005', 'joseviloria716@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1274, '192.168.30.251', 'V12047505', 'Jose Gregorio Araujo', 1, 4, 0, 3, 2, 'Las Rurales Del Alto, Alto De Escuque, Parrq La Union, Casa #3263', '4160482305', 'yoguejesusa@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1275, '192.168.30.254', 'V12861354', 'Tobias Andres Montiel Navas', 1, 4, 0, 3, 2, 'El Alto De Escuque Calle Consejo Casa S/N', '4146362808', 'tobiasmontiel44@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1276, '192.168.30.26', 'V3797216', 'Elis Pirela Linares', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Etapa 1 Final Calle La Estancia Casa F06', '4247181727', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1277, '192.168.30.27', 'V17037084', 'Rima Elena El Halabi Perea', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Av La Paz Casa J33 Segunds Etapa', '4264720761', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1278, '192.168.30.28', 'V 13050426', 'Zulay Del Valle Quintero Parra', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Una Cuadra Mas Abajo Del Tanque De Agua Casa J26', '4147354064', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1279, '192.168.30.29', 'V 18097746', 'Rosalba Plata Rivera', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Casa F45 Av Principal Pra Etapa', '426 9500109', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1280, '192.168.30.30', 'V9342708', 'Victor Hugo Barona Rodriguez', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Casa O25 Segunda Etapa', '4147517930', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1281, '192.168.30.31', 'V 13049394', 'Donald Robinson Coronado Araujo', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Estapa 2 Casa #M14 Con Av La Paz', '4143675034', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1282, '192.168.30.32', 'V24398275', 'Jesus Alberto Davila Miranda', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Calle Final Tapon 1Ra Etapa Al Lado Del Parque, Casa Rural', '4245097335', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1283, '192.168.30.33', 'V 15602382', 'Raul Rafael Puche Ramirez', 1, 2, 0, 3, 2, 'Calle Final Tapon 1Ra Etapa Diagonal Al Parque', '4247677919', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1284, '192.168.30.34', 'V 8719951', 'Mariela Rosa Mijares Santiago', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Vista Hermosa 2. Casa M33 Frente Al Parque ', '4122398546', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1285, '192.168.30.35', 'V 17392864', 'Francisco Javier Mendoza Duarte', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Etapa 1 Via Principal Casa G20', '4124059776/424724090', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1286, '192.168.30.36', 'V 16377900', 'Nathaly Josefina Balestrini Toro', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Estapa 2, Calle El Pardillo M2', '0424 7077186 / 0426 ', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1287, '192.168.30.38', 'V 16881211', 'Andreina Del Carmen Pineda De Los Santos', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Calle El Pardillo Casa L19', '4247368308', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1288, '192.168.30.39', 'V 20789818', 'Gerardo Jose Abreu Arandia', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Calle Final Tapon 1Ra Etapa Al Diagonal Al Parque, Al Lado Sr Raeul ', '4262700745/ 41267139', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1289, '192.168.30.40', 'V 11616344', 'Luisa Fernanda Mijares De Fuenmayor', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Casa I12', '4247355251', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1290, '192.168.30.41	', 'V11897238', 'Edgar Alonso Rondon Peña', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Av El Pardillo', '4147309097', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1291, '192.168.30.42', 'V 14599430', 'Ronny Fernando Pombo Perez', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa Av Principal Segunda Etapa', '4141767102', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1292, '192.168.30.43', 'V 18350737', 'Yerson Jose Pineda Leal', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa Av El Pardillo Casa I29', '4126802737', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1293, '192.168.30.44', 'V 9602658', 'Wiston Ramon Ramos Rojas', 1, 2, 0, 3, 2, 'Calle Comercio Pana Deria Con 24 De Julio', '4166782371', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1294, '192.168.30.45', 'V 11319056', 'Carla Coromoto Aldana Centeno', 1, 2, 0, 3, 2, 'Calle Comercio Con Avenida, Kiosko De Loteria Color Verde', '4247371208', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1295, '192.168.30.46', 'V 12796241', 'Francisco Luis Ramirez Valecillos', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa Av El Pardillo Casa M08', '4168795707', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1296, '192.168.30.47', 'V 27070029', 'Dairely Perez', 1, 2, 0, 3, 2, 'Pueblo Nuevo A Media Cuadra De La Posada La Nona', '4147388250', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1297, '192.168.30.48', 'V 19644497', 'Maria Beatriz Valera Medrano', 1, 2, 0, 3, 2, 'Urb Vista Hrmosa Segunda Estapa Calle Principal Casa K28', '04245319158 / 042649', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1298, '192.168.30.49', 'V 15425960', 'Maria Elena Graterol Matheus', 1, 2, 0, 3, 2, 'Sector Brisas De Sanbenito Primera Calle Ultima Casa, Sin Numero', '4247401126 / 0426329', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1299, '192.168.30.52', '21061897', 'Yennifer Maoly Escalona Viloria', 1, 2, 0, 3, 2, 'Brisas De San Benito Casa S/N', '4247488460', 'Armandorodriguez2502@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1300, '192.168.30.54', 'V 12044236', 'Walther Waldemar Araujo Gallardo', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa, 2Da Etapa,Calle La Paz,Casa Nro J-21, Sabana Libre, Escuque', '0416-0540996', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1301, '192.168.30.55', 'V16377634', 'Yerlis Margot Palomares Perez', 1, 2, 0, 3, 2, 'Brisas De San Benito, Calle Negra Matea(3Ra Calle) 2Da Calle Subiendo Casa En Esquina.', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1302, '192.168.30.56', 'V28438803', 'Stefani Gabriela Garcia Garcia', 1, 2, 0, 3, 2, 'Brisas De San Benito, Calle Principal Con Calle 2', '4247268686', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1303, '192.168.30.57', 'V 20656543', 'Norielis Andreina Bencomo Peña', 1, 2, 0, 3, 2, 'Sabana Libre, Calle San Rafael, Diagonal A La Cancha ', '4246160033	', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1304, '192.168.30.58', 'V 19285377', 'Belkis Carolina Diaz Gonzalez', 1, 2, 0, 3, 2, 'Brisas De San Benito, Calle Negro Primero Tultima Calle Casa Final', '4126756791', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1305, '192.168.30.59', 'V 16534841', 'Lucy Crey Uzcategui Pulido', 1, 2, 0, 3, 2, 'Brisas De San Benito, Calle Negro Mateo Con 1Ra Calle Segunda Casa Mano Izquierda ', '4147580346', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1306, '192.168.30.6', 'V18097005', 'Ronald Simancas', 1, 4, 0, 3, 2, 'Av.Principal Via Las Rurales Del Alto, Casa  S/N Al Lado Casa Luis Salcedo', '4160297449; 41204317', 'josebbjose@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1307, '192.168.30.60', 'V24786433', 'Antonieta Pereira ', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa Av Los Pardillos, Con Av Buena Vista Casa I44', '4160719961', 'antonietapereira188@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1308, '192.168.30.61', 'V 16609845', 'Ricardo Jose Araujo Fuenmayor', 1, 2, 0, 3, 2, 'Calle Comercio Local 4 (Bodegon De Adi)', '4247110171', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1309, '192.168.30.62', 'V11318620', 'Ana Cecilia Paredes De Vargas', 1, 2, 0, 3, 2, 'Calle Pueblo Nuevo, Detras De Vista Hermosa', '02712219453/04123518', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1310, '192.168.30.63', 'V10403520', 'Norkis Chirinos De Antonetti', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1311, '192.168.30.64', 'V10316208', 'Marisol Del Carmen Dominguez Teran', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa Primera Estapa Calle Bella Vista, Casa A04', '4166531737', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1312, '192.168.30.65', 'V20038642', 'Jose Heliel Segovia Zerpa', 1, 2, 0, 3, 2, 'Sector Los Canaletes Rivera 1, Frente Terreno', '4247445144', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1313, '192.168.30.66', 'V 19103438', 'Rusarky Vanessa Garcia Salas', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa Av La Paz Casa Numero J22', '4121972370', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1314, '192.168.30.67', 'V 18979261', 'Jhoannery Ramona Palencia', 1, 2, 0, 3, 2, 'Pinos Parte Alta, ', '4247263458', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1315, '192.168.30.68	', 'V 14460299', 'Maria Liliana Nava Briceño', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa 2Da Etapa, Calle Amapate Av La Paz Casa M21', '4149631899	', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1316, '192.168.30.69', 'V 16533743', 'Julio Cesar Pinzon Diaz', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa Sector J Calle La Paz Casa Nro J40', '4121749061', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1317, '192.168.30.70', 'V 17266760', 'Yesenia Rangel', 1, 2, 0, 3, 2, 'Urb. Vista Hermosa Primera Etapa Av Principal, Casa C32', '4247205205', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1318, '192.168.30.71', 'V 19899135', 'Regulo Abreu', 1, 2, 0, 3, 2, 'Av Principal De Sabana Libre, Calle Bajando Tres Casas De Negra Hipolita', '4140768335', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1319, '192.168.30.72', 'V 8724948', 'Sonia Delgado', 1, 2, 0, 3, 2, 'Urb Vista Hermosa Casa Nro C29 Av Principal', '4247587336', ' soniadelgadosilva@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1320, '192.168.30.73', 'V13896694', 'Rona Coromoto Pereira Mendoza', 1, 2, 0, 3, 2, 'Final  De La Calle  San Agustin, Al Lado De La Casa Del Señor Lalo.', '04165326371 04125871', 'MARGARITASALAZAR30@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1321, '192.168.30.74', 'V 5106846', 'Tony Josefina Alizo Manzaneda', 1, 2, 0, 3, 2, 'Av El Grupo Escolar Entrecalle Las Flores Y Aclle Comercio, Casa De Esquina A Una Cuadra De La Oficina', '02712221466 - 042473', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1322, '192.168.30.75', 'V 23593153', 'Luis Alfredo Rico Valecillos', 1, 2, 0, 3, 2, 'Calle Democracia Con Calle Comercio, Mas Debajo De Quiquiriki', '2712219533', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1323, '192.168.30.76', 'V 18734761', 'Eucarys Calderon', 1, 2, 0, 3, 2, 'Segunda Etapa, Sector O Casa Numero 12', '4246419720', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1324, '192.168.30.77', 'V 12039797', 'Lisbeth Rafaela Saavedra', 1, 2, 0, 3, 2, 'Sector Brisas De San Benito, Calle Principal Cerca De La Sra Lery Pulido', '04247162639 / 0424 7', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1325, '192.168.30.78	', 'V27363831	', 'Alaide Andreina Abreu Briceño', 1, 2, 0, 3, 2, 'Urb Vista Hermosa', '4146479096', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1326, '192.168.30.79', 'V 26094073', 'Maria Vanessa Urquiola', 1, 2, 0, 3, 2, 'Sector Bucare, Subiendo Despues Del Arco A Mano Derecha Mas Arriba De Negra Hipolita', '4147406982', 'vanessaurquiola64@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1327, '192.168.30.81', 'V 16533878', 'Grecia Toro', 1, 2, 0, 3, 2, 'Casa 39 Calle Las Flores', '4241527756', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1328, '192.168.30.82', 'V', 'Ronny Valero', 1, 2, 0, 8, 2, 'Vista Hermosa', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1329, '192.168.30.83', 'V 5109987', 'Carmen Teresa Ramos Molina', 1, 2, 0, 3, 2, 'Primra Etapa Casa I26, Al Lado Sr Ronny', '4169931753', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1330, '192.168.30.84', 'V5765972', 'Milagros Del Valle Torres De Gonzalez', 1, 2, 0, 3, 2, 'Urb Brisas De San Benito, Calle Sucre Casa Sin Numero', '4247435723', 'MILAGROSDELVALLE02@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1331, '192.168.30.86', 'V 5761127', 'Juana Arangure', 1, 2, 0, 3, 2, 'Calle Pardillo Casa L16', '4265771564', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1332, '192.168.30.87', 'V 5503308', 'Eloy Viloria', 1, 2, 0, 3, 2, 'Calle El Grupo Escolar, Casa Numero S/N Quinta Trinidad Esquina Via Urb Ciudadela ', '4247566303', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1333, '192.168.30.88', 'V 16882857', 'Yoliker Guerrero', 1, 2, 0, 3, 2, 'Estapa 1, Casa A-40B Final Calle Las Flores', '4247533112', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1334, '192.168.30.89', 'V20656542', 'Yusmari Uzcategui', 1, 2, 0, 3, 2, 'Urb,Vista Hermosa, 1Ra Etapa Calle Las Flores, Casa  A41', '4247679524', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1335, '192.168.30.90', 'V 13378396', 'Alejandra Rojas', 1, 2, 0, 3, 2, 'Primera Etapa Calle Principal, Casa B36', '4168749422', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1336, '192.168.30.91', 'V 27512756', 'Daniel Jose Gonzalez Guerrero', 1, 2, 0, 3, 2, 'Calle Las Flores, Casa A40B', '4246949583', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1337, '192.168.30.92', 'V 16882269', 'Arnaldo Jose Sifuentes Urbina', 1, 2, 0, 3, 2, 'Sector O Casa O23, Segunda Etapa ', '4247041241', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1338, '192.168.30.93', 'V 18096861', 'Diana Maldonado', 1, 2, 0, 3, 2, 'Sector Los Pinos, Parte Alta Casa Sn', '4162716777', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1339, '192.168.30.95', 'V11316245', 'Saira Josefina Silva De Goliat', 1, 2, 0, 3, 2, 'Av. El Paraiso, Casa D11', '4164711841 / 0412392', 'sairajsilva@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1340, '192.168.30.96', 'V11564513', 'Yulimar Del Carmen Vergara Gonzalez', 1, 2, 0, 3, 2, 'Vista Hermosa 2, Casa K20 Via Principal', '4149710931', 'yulimar470@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1341, '192.168.30.97', 'V21364978', 'Maria Alexandra Perez Vazquez', 1, 5, 0, 3, 2, 'Sector La Mata Calle Principal Casa S/N', '4246869060', ' mariaalexandrap23@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1342, '192.168.30.98', 'V13462693', 'Aura Del Carmen Vera Gamarra (Inv. Pitbull)', 1, 5, 0, 3, 2, 'Sector La Mata, Calle La Milagrosa ', '4247690783', ' auravera7@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1343, '192.168.30.99	', 'V9323289	', 'Digna Rosa Matheus Bolaño', 1, 5, 0, 8, 2, 'Sector La Mata, Calles Las Dalias Via Quevedo', '4247378058	', 'paredesvicente2@gmail.com\r\n', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1344, '192.168.40.10', 'V16066743', 'Ligia Elena Rivas Villarreal', 1, 5, 0, 4, 2, 'La Mata Calle Principal Casa S/N Frente A La Quinta Owen ', '4247460340/414971674', ' ligiaelenarivasv@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1345, '192.168.40.108', '15306768', 'Dexi Del Carmen Perdomo Molina', 1, 4, 0, 4, 2, 'El Pao Parte Alta Via El Boqueron', '4264027374', ' dperdomomolina@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1346, '192.168.40.111', 'V31239089', 'Francheska Oropeza', 2, 3, 0, 2, 2, 'Av Principal Sara Linda, Ferreacesorios, ', '4165333699', 'orimaroropeza@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1347, '192.168.40.114', '16881898', 'Jennifer Carolina Lozada Carrizo', 2, 3, 0, 4, 2, 'Calle Principal, Sector Barrio Caracas, Cruz De La Mision Casa S/N ', '4168755865', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1348, '192.168.40.119', '10148324', 'Marco Antonio Rivas Vargas', 2, 6, 0, 8, 2, 'Av Principal De Betijoque', '4247054975', 'RIVSSM779@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1349, '192.168.40.123', '29633117', 'Yisbel Andreina Delgado Araujo', 2, 3, 0, 4, 2, 'Sara Linda Parte Baja Al Lado Del Ambulatorio', '4262606147', ' yisbel440@gmail.com ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1350, '192.168.40.128', 'V26046658', 'Jorge Lamos', 2, 3, 0, 2, 2, 'Sector El Prado Isnotu', '4264509539', 'lamosjorgue107@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1351, '192.168.40.132', '4325356', 'Mercedes Moreno ', 1, 2, 0, 2, 2, 'Corozo Parte Alta Detras De Los Chalets Cas S-N', '4163735714', 'MERCEDESMORENO0301@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1352, '192.168.40.142	', 'V19643526	', 'Jorge Luis Briceño', 1, 1, 0, 2, 2, 'Sector El Corozo, Calle Cipriano Diaz Casa S/N, Mas Arriba De La Gallera ', '4129036952	', 'MOR871@HOTMAIL.ES', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1353, '192.168.40.152', 'V11394018', 'Leoner Ramon Perez Hernandez', 1, 4, 0, 2, 2, 'La Laja Parte Baja Casa S/N Mas Abajo De La Piscina De Los Vilorias', '4129788131', 'PMABELY40@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1354, '192.168.40.155', 'V16015867', 'Maria Araujo De Benitez ', 2, 3, 0, 2, 2, 'Sector Produaguacate 1 Casa Sn', '04161632455; 0416328', 'Mariaaraujo657@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1355, '192.168.40.157', 'V9322826', 'Jaime Alberto Mazzei Gonzalez', 2, 3, 0, 2, 2, 'Sector Villa Blanca Calle Principal, Primera Casa Bajando A Mano Izquierda', '4265367002', 'Mazzeygon2023@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1356, '192.168.40.159', '18097846', 'Jose Eduardo Rojo', 1, 5, 0, 2, 2, 'Quevedo Via Principal, Apartamentos ', '4147349030/ 41473336', 'josechirino69@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1357, '192.168.40.16', 'V24786953', 'Evert Monsalve ', 2, 3, 0, 2, 2, 'Sara Linda Parte Alta, Via Principal, Detras De Finca Angy Nuhlen', '4124513266', ' MONSALVEEVERT@GMAIL.COM ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1358, '192.168.40.160', 'V19285262', 'Saidy Lopez', 2, 3, 0, 2, 2, 'Sector El Bucare, Frente Al Cementerio, Casa S/N Calle Uno, Isnotu', '4163754461', 'saidylopez19@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1359, '192.168.40.164', '26002925', 'Luis Villarreal', 1, 1, 0, 2, 2, 'Escuque, Urb Los Reyes Casa S-N ', '4247245982', 'Karmilebremo87@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1360, '192.168.40.17', '11554883', 'Rosa Josefina Bolivar De Castellanos', 1, 5, 0, 4, 2, 'Av. Principal La Legua Sector El Cacagual', '4127922454', ' bolivar2021rosa@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1361, '192.168.40.175', '19285519', 'Nelson Jesua Aguilar Castejon', 1, 4, 0, 2, 2, 'Via El Boqueron Casa Antiguo Dueño Passileo', '4124615278', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1362, '192.168.40.188', 'V12905523', 'Maria Andreina Aguilar Ocanto ', 1, 1, 0, 2, 2, 'La Loma Calle Lara', '4262724767', 'ma7323474@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1363, '192.168.40.19', '5105929', 'Belkis Helen Rodriguez Fernandez', 2, 3, 0, 4, 2, 'San Juan Av Principal Casa S/N', '4147462048', ' belkis010157@hotmail.com ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1364, '192.168.40.195', '26557048', 'Elizabeth Adriana Vergara Villarreal', 1, 5, 0, 4, 2, 'Sector Quevedo Av Principal Cerca De La Escuela', '4147445024', 'Eliadriavergara@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1365, '192.168.40.20', 'V7116901', 'Ymad Rafer ', 1, 1, 0, 2, 2, 'Calle Miranda Casa 36 Escuque ', '', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1366, '192.168.40.201', '5346950', 'Rosa Isabel Guerrero Sanchez (Daylu)', 1, 2, 0, 4, 2, 'Calle La Estancia Casa F07', '4247564285', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1367, '192.168.40.216', 'V7841545', 'Carmen Azuaje ', 1, 1, 0, 2, 2, 'Via El Alto Sector El Pepo Casa N07', '4245244463', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1368, '192.168.40.219', 'V9498841', 'Jesus Enrique Balza Ramirez', 1, 5, 0, 2, 2, 'Quevedo, Sector Cano, Casa S/N', '04247159935; 0414721', 'Yanelybalza02@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1369, '192.168.40.223', 'V13964423', 'Yessika Mercedes Hurtado Castellano', 1, 4, 0, 2, 2, 'Calle Vicente La Torre Donde Era Mrw', '4147150176; 41642459', 'YMHC423@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1370, '192.168.40.230', '5377948', 'Ricardo Baptista (Cortesia)', 1, 4, 0, 8, 2, 'La Laguneta Via Las Antenas ', '4265784884', ' RICARDO.MARIN18152@GMAIL.COM ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1371, '192.168.40.235', '13049436', 'Francisco Ricardo Vargas De Chomon', 1, 1, 0, 4, 2, 'Sector Candelillas Las Invaciones Parte Baja ', '4247432851', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1372, '192.168.40.236', '5762958', 'Maria Oliva Albarran Perez', 1, 4, 0, 2, 2, ' El Boqueron Sector La Picapica', '4120886816/416937198', ' maria6albarran@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1373, '192.168.40.240', '20789186', 'Luis Alberto Zabaleta Suarez', 1, 1, 0, 4, 2, 'Sector San Francisco Urb. Rafael Urdaneta 2Da Etapa Primera Casa ', '4264087525', ' luiszabaleta20@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1374, '192.168.40.245', '6134005', 'Cristian Martins', 1, 5, 0, 8, 2, 'Urb. Colinas De Carmania Calle 3 Casa 73', '4127310937', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1375, '192.168.40.248', '18457654', 'Yeison Segundo Suarez Godoy', 1, 1, 0, 4, 2, 'Urb Tabysquey, Escuque, Frente Los Apartamentos Casa S/N', '4261613972', ' yeisonsuarez564@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1376, '192.168.40.25', '7859388', 'Jose Alberto Medina Duarte', 1, 5, 0, 4, 2, 'La Mata Sector El Terreno Casa Nro. 86', '4169158565', '2016medinaj@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1377, '192.168.40.254', '15752700', 'Juana Del Valle Rivas Teran', 1, 5, 0, 4, 2, 'La Mata Calle Principla Parte Baja Sector San Benito, Via Los Conucos ', '4129666271', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1378, '192.168.40.34', 'V16605695', 'Maria Virginia Uzcategui ', 1, 1, 0, 2, 2, 'La Sabaneta Cerca De La Cruz De La Mision Casa S-N', '4126519695; 42471150', 'virginiauzcategui09@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1379, '192.168.40.43', '21492857', 'Antonio Enrique Finol Suarez', 1, 2, 0, 4, 2, 'Sector El Pensil Parte Alta Taller De Latoneria', '4247165117', 'Pendiente', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1380, '192.168.40.44', '16247118', 'Maria Carolina Mota Nava', 2, 3, 0, 4, 2, 'Sara Linda Sector Las Carmelitas Calle 3', '4267134180', ' mariamota22@gmail.com ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1381, '192.168.40.49', '13048728', 'Ender Giovanny Artigas Suarez', 2, 3, 0, 4, 2, 'Sector El Bucare De Isnotu Casa S/N', '4247556476', 'Enderartigas2011@gmail.com', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1382, '192.168.40.56', 'V4146380', 'Margarita Josefina Clara De Gonzalez', 1, 4, 0, 4, 2, 'Las Rurales Del Alto, Al Lado De Freddy Mendez, Casa S-N, La Union, Escuque ', '4246001231', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1383, '192.168.40.58', 'V-11898550', 'Fernando Javier Parra Mogollon', 1, 4, 0, 4, 2, 'Sector La Laguneta Callejon Villa Vicenzio', '4143741717', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1384, '192.168.40.74', '11798515', 'Jose Leonardo Chirinos Abreu', 2, 3, 0, 4, 2, 'Av. 5 Entrada Norte De Betijoque ', '4247409738', ' chirinosabreuleojose1@gmail.com ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1385, '192.168.40.79', 'V5778498', 'Jose Cornelio Sanchez', 1, 4, 0, 5, 2, 'Sector La Bomba Calle Principal, Casa S/N, La Union, Escuque', '4166018090', ' sjcornelio@hotmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1386, '192.168.40.90', 'J410337249', 'Inv. La Llamarada', 1, 4, 0, 4, 2, 'La Llamarada Sector Las Malvinas', '4143716642', ' gerencia.proyectos@sucasa.con.ve ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1387, '192.168.40.93', '11.947.085', 'Joel Jose Zambrano Perez', 1, 1, 0, 8, 2, 'Sector El Piñal Via Jirajara ', '0414 7228224', 'Joelzambrano1972@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1388, '192.168.50.10', 'V10715424', 'Alfredo Viloria', 1, 2, 0, 3, 2, 'Sector Los Canaletes, Calle Carretera El Alto Sabana Libre, Mun.Escuque', '4121604925; 41474785', 'alfredov64@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1389, '192.168.50.100', 'V6249026', 'Celio Sosa', 1, 2, 0, 3, 2, 'Calle Bolivar Sector Puente De Hierro, Casa S/N Sabana Libre Escuque', '4147277484', 'celiososa@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1390, '192.168.50.101', 'V5759719', 'Ana Abreu', 1, 2, 0, 3, 2, 'Sabana Libre, Calle San Rafael ', '4247040236', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1391, '192.168.50.102', 'V19644996', 'Rubendy Briceño ', 1, 2, 0, 3, 2, 'Calle Pueblo Nuevo, A 30Mts De La Posada La Nonna, Pq Sabana Libre, Mun  Escuque ', '4269767535; 27122197', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1392, '192.168.50.103', 'V23781529', 'Orlando Marin ', 1, 2, 0, 3, 2, 'Calle Pueblo Nuevo, Casa #26 Sabana Libre, Escuque ', '414748551', 'ORLANDOMMJ2023@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1393, '192.168.50.104', 'V29994263', 'Samuel Eduardo Torres Duarte ', 1, 2, 0, 3, 2, 'Calle 24 De Julio 65N ', '4163089801', 'SAMUELEDUARDOTORRES2022@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1394, '192.168.50.105', 'V19285519', 'Nelson Jesua Aguilar Castejon', 1, 4, 0, 3, 2, 'Urb Los Sauces, El Alto De Escuque, Frente Al Cementerio  Pq La Union, Mun Escuque ', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1395, '192.168.50.106', 'V15584627', 'Juan Hidalgo', 1, 4, 0, 3, 2, 'Calle Las Antenas, Casa S-N, Sector La Laguneta, Pq La Union, Mun Escuque ', '4166733125', 'JUANCARLOSHIDALGO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1396, '192.168.50.107', 'V9175414', 'Ana Tereza Montilla ', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, Av Principal, 1Era Etapa, Casa #37', '4247571787; 42453774', 'TEREZA.ALBARRAN@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1397, '192.168.50.108', 'V2627585', 'Gerardo Viloria ', 1, 4, 0, 3, 2, 'Laguneta, Via El Alto Casa S-N, Mas Arriba De Los Rosminianos, Pq La Union, Mun Escuque ', '4141775187; 41627612', 'VILORIAGERARDO073@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1398, '192.168.50.11', 'V29994595', 'Danyely Rondon ', 1, 5, 0, 3, 2, 'Sector La Antena, Mas Abajo De Johana Marquez, La Mata, Mun.Escuque', '4164290213; 41475873', 'danyelyrondon2@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1399, '192.168.50.111', 'V19102812', 'Andreina Matos ', 1, 2, 0, 3, 2, 'Calle Cruz De La Mision, Pq Sabana Libre, Mun Escuque ', '4162333878; 42461235', 'ANDREINA241@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1400, '192.168.50.112', 'V3966637', 'Mario Betancourt', 1, 2, 0, 3, 2, 'Urb La Ciudadela, Casa#97, Calle Principal, Diagonal Al Parque, Pq Sabana Libre, Mun Escuque ', '4147226196; 41473405', 'BCRUZMARIO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1401, '192.168.50.113', 'V23838171', 'Daniela Chinchilla', 1, 2, 0, 3, 2, 'Urb La Ciudadela, Casa #99, Calle Principal, Pq Sabana Libre, Mun Escuque ', '4247357865', 'KARYOLI27DANIELA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1402, '192.168.50.114', 'V12040503', 'Norelis Villamizar', 1, 2, 0, 3, 2, 'Los Pinos, Calle Cementerio, Casa 6B, Pq Sabana Libre, Mun Escuque ', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1403, '192.168.50.115', 'V21365882', 'Anthony Torres', 1, 2, 0, 3, 2, 'Entrada El Corozo, Sector Buenos Aires, Casa#11 Sabana Libre, Al Lado De La Bloquera', '4126490539; 02712221', 'anthonytorres2418@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1404, '192.168.50.116', 'V10401053', 'Pablo Ignacio Briceño Gonzalez ', 1, 2, 0, 3, 2, 'Entrada Al Corozo, Sabana Libre, Casa S-N, Ferreteria, Pq Sabana Libre, Mun Escuque ', '4261448875; 27122215', 'CARLOS0412BRICEñO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1405, '192.168.50.117', 'V16066258', 'Cristian Torres ', 1, 2, 0, 3, 2, 'Entrada Al Corozo Casa Verde S-N, Pq Sabana Libre, Mun Escuque ', '4121556469; 42477004', 'CRISTIANDLT@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1406, '192.168.50.118', 'V10908932', 'Margley Estrada ', 1, 2, 0, 3, 2, 'Via El Corozo, Sabana Libre A 350M De La Pasarela, Mun Escuque ', '4146998253', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1407, '192.168.50.119', 'V16267367', 'Jose Gregorio Moreno Suarez ', 1, 2, 0, 3, 2, 'Via El Corozo, Al Frente De Bloquera, Pq Sabana Libre, Mun Escuque', '4247139731', 'GREGORIOJOSEMORENOSUAREZ082@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1408, '192.168.50.12', 'V19643614', 'Jennifer Gallardo', 1, 4, 0, 3, 2, 'Alto De Escuque, Calle Consejo, Casa S/N Porton Azul', '4247338558', 'jennigallardo.94@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1409, '192.168.50.120', 'V3904404', 'Mara Kisis', 1, 2, 0, 3, 2, 'Via El Corozo Sector Buenos Aires Casa S/N', '4127178154', 'PENDIENTE', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1410, '192.168.50.121', 'V25374386', 'Rosangel Nuñez', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, Calle Principal, Casa I-15, Pq Sabana Libre, Mun Escuque ', '4121711563', 'ROSANGELNUñEZ001@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1411, '192.168.50.122', 'V20789502', 'Daniel Al Attar', 1, 2, 0, 3, 2, 'Urb El Saman 1, Casa #6, Pq Sabana Libre, Mun Escuque ', '4125311734', 'DANIELALATTAR@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1412, '192.168.50.123', 'V17831600', 'Ender Carrizo', 1, 2, 0, 3, 2, 'La Arboleda Sabana Libre ', '4247140250', 'ENDER_G@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1413, '192.168.50.124', 'V15752335', 'Guntis Rodolfo Kisis Moreno', 1, 2, 0, 3, 2, 'El Corozo Parte Alta, 250Mt De La Pasarela', '4261704939/426674249', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1414, '192.168.50.125', 'V24136384', 'Olga Valero', 1, 2, 0, 3, 2, 'El Corozo De Sabana Libre, Via Principal, Casa S-N', '4260335549; 42470224', 'EULESAB1@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1415, '192.168.50.126', 'V16535959', 'Silvana Jerez', 1, 2, 0, 3, 2, 'El Corozito De Sabana Libre, Casa S-N ', '4247318223', 'SILVANAJEREZ60@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1416, '192.168.50.127', 'V16535959', 'Mireya Linares ', 1, 2, 0, 3, 2, 'El Corozito De Sabana Libre, Casa S-N ', '4263764912', 'DUVERLYSDILIANA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1417, '192.168.50.128', 'V17830410', 'Lisbelly Abreu', 1, 2, 0, 3, 2, 'El Corozito De Sabana Libre, Casa S-N ', '4165198250', 'LISKARJ28@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1418, '192.168.50.129', 'V19285102', 'Maria Hernandez ', 1, 4, 0, 3, 2, 'Las Rurales Del Alto, Via Principal Quevedo Casa S-N', '4247577128; 41413235', 'MEHP1988@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1419, '192.168.50.13', 'V9173251', 'Alejandro Matheus', 1, 4, 0, 3, 2, 'Alto De Escuque, Calle El Ambulatorio Casa S/N', '4163084095; 42679971', 'valeracelina84@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1420, '192.168.50.130', 'V11896112', 'Sonia Molina', 1, 2, 0, 3, 2, 'El Corocito Sabana Libre ', '4264576314', 'SMMOLINARA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1421, '192.168.50.131', 'V32374076', 'Yorman Duarte ', 1, 2, 0, 3, 2, 'El Corozo ', '4268991645', 'YORMANUEL10@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1422, '192.168.50.132', 'V17831740', 'Scioly Duarte ', 1, 2, 0, 3, 2, 'Sector El Corozo De Sabana Libre, Casa S-N Mas Arriba Del Ambulatorio', '4167185432; 42471455', 'SCIOLYYERALDIKDUARTE@GMIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1423, '192.168.50.133', 'V5764034', 'Doris Duarte Aguilar', 1, 2, 0, 3, 2, 'Sector El Corozo Via Principal', '4167716737; 41653684', 'DORISIDUARTE2022@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1424, '192.168.50.134', 'V12797661', 'Ramon Duarte ', 1, 2, 0, 3, 2, 'Sector El Corocito Parte Alta, Via Principal', '4269829272; 42467669', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1425, '192.168.50.135', 'V18095069', 'Laura Henriquez', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, 2Da Etapa, Casa #014, Pq Sabana Libre, Mun Escuque ', '4247349177; 42654474', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1426, '192.168.50.136', 'V16535202', 'Sonia Uzcategui ', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, Casa #43, Pq Sabana Libre, Mun Escuque ', '4147222901', 'SOLUZTORRES@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1427, '192.168.50.137', 'V15752307', 'David Olmos ', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, Etapa 2, Casa #24, Pq Sabana Libre, Mun Escuque ', '4127258771', 'JESUSOLMOS180302@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1428, '192.168.50.139', 'V14460492', 'Heidi Jaimes', 1, 2, 0, 3, 2, 'Urb Vista Hermosa Etapa 1, Casa K-03, Pq Sabana Libre, Mun Escuque ', '4160701654; 41671930', 'ROERARP78@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1429, '192.168.50.14', 'V25733919', 'Yelsint Gallardo', 1, 4, 0, 3, 2, 'Sector Alto De Escuque, Via Principal Las Rurales Del Alto,', '4247323099', 'yelsintgallardo80@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1430, '192.168.50.140', 'V4060830', 'Manuel Viloria ', 1, 2, 0, 3, 2, 'Calle San Rafael, Casa S/N, Sector Los Canaletes, Fabrica De Urnas, Pq Sabana Libre, Mun Escuque ', '4147165589; 42648637', 'MANUELVILORIA60@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1431, '192.168.50.142	', 'V4657949	', 'Emilio Briceño', 1, 4, 0, 3, 2, 'El Alto De Escuque, Abasto El Oferton', '4146565680; 4169030553	', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1432, '192.168.50.143', 'V27618269', 'Jose David Briceño Gonzalez ', 1, 2, 0, 3, 2, 'Sector Los Pinos Via El Cementerio', '4121715860', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1433, '192.168.50.144', 'V26094121', 'Luz Ariana Carrizo', 1, 2, 0, 3, 2, 'Calle La Democracia Casa S-N, Casa De Portones Blancos', '4247711085; 41281887', 'SICOLOGALUZCARRIZO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1434, '192.168.50.145', 'V20655509', 'Karony Segovia ', 1, 4, 0, 3, 2, 'Alto De Escuque, Salida Ue Esteban Razquin ', '4147347313; 42657521', 'K3KRYSTAL@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1435, '192.168.50.150', 'V25006999', 'Jose Vargas ', 1, 2, 0, 3, 2, 'Sector El Corocito De Sabana Libre, Cruz De La Mision', '4148481323; 41408027', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1436, '192.168.50.151', 'V13896818', 'Yenny Maribel Briceño Olivar ', 1, 2, 0, 3, 2, 'Sector El Corocito De Sabana Libre, Cruz De La Mision, Ultima Casa ', '4266682910; 41625959', 'YOSELINVILORIA81@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1437, '192.168.50.152', 'V16534556', 'Maria Teresa Moreno Viloria', 1, 4, 0, 3, 2, 'Sector La Laguneta, Alto De Escuque, Casa #25', '4126362643; 42461080', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1438, '192.168.50.153', 'V10039474', 'Emerita Duran ', 1, 2, 0, 3, 2, 'Sector El Corocito, Al Lado Del Tanque, Tlf Fijo Cantv', '4163615590; 41693319', 'EMERITADELCARMEN@OUTLOOK.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1439, '192.168.50.154', 'V9323983', 'Walter Mora Garcia', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, 2Da Etapa, Casa N12', '4147335938; 42473413', 'WALMOR24@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO');
INSERT INTO `contratos` (`id`, `ip`, `cedula`, `nombre_completo`, `id_municipio`, `id_parroquia`, `id_comunidad`, `id_plan`, `id_vendedor`, `direccion`, `telefono`, `correo`, `fecha_instalacion`, `ident_caja_nap`, `puerto_nap`, `num_presinto_odn`, `id_olt`, `id_pon`, `estado`) VALUES
(1440, '192.168.50.155', 'V21365212', 'Landkler Josue Manzanilla Gonzalez ', 1, 2, 0, 3, 2, 'La Mata Calle Principal, Casa #20 Frente A La Piscina Don Pepe ', '4247266973; 41473017', 'LANDKLERMANZANILLA@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1441, '192.168.50.156', 'V15294229', 'Carolina Rojas (Escuela Nelly Mendez Quevedo)', 1, 5, 0, 8, 2, 'Quevedo Parte Alta ', '4261713152; 42611805', 'ESCUELAQUEVEDO@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1442, '192.168.50.157', 'V12458220', 'Yosmer Becerra', 1, 2, 0, 3, 2, 'Av Principal Al Lado De La Farmacia, ', '4265714309', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1443, '192.168.50.158', 'V27618269', 'Jose David Briceño Gonzalez ', 1, 2, 0, 5, 2, 'Sabana Libre, Perreros De La Esquina De La Plaza ', '4121715860; 42458308', 'OPSUJOSEBRICEñO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1444, '192.168.50.159	', 'V12038923	', 'Marianela Briceño', 1, 2, 0, 3, 2, 'Calle Bolivar, Parte Alta Casa S-N Sabana Libre	', '4247483888; 4123785477', 'SOFIA.PB07@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1445, '192.168.50.16', 'V9311739', 'Carlos Humberto Baptista Bickford', 1, 4, 0, 3, 2, 'Las Rurales Del Alto Via Pcpal Quevedo Casa S/N', '4169786399/ 41437573', 'chbbhumber@yahoo.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1446, '192.168.50.161', 'V2120346', 'Anibal Mendible', 1, 4, 0, 3, 2, 'Alto De Escuque Calle Sucre, Casa #3', '4164465589; 41280310', 'VALESKAMENDIBLE@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1447, '192.168.50.162	', 'V14460411', 'Jerry Briceño	', 1, 4, 0, 3, 2, 'Alto De Escuque Calle Miranda Casa #10', '4263693459; 4164465589', 'JERRYBREZ@GMAIL.COM\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1448, '192.168.50.163', 'V30048472', 'Brayan Rangel ', 1, 2, 0, 3, 2, 'Sabana Libre, Calle San Rafael, Casa S-N ', '4247155635; 41637663', 'BRAYANRANGEL635@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1449, '192.168.50.164', 'V9170244', 'Ricardo Utrilla', 1, 2, 0, 3, 2, 'Panamericana, Cerca De La Pasarela En La Entrada Del Corozo Sabana Libre ', '4247763260; 42496462', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1450, '192.168.50.165', 'V10403788', 'Levy Pichardo ', 1, 2, 0, 3, 2, 'Corocito De Sabana Libre', '4269780059', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1451, '192.168.50.166', 'V12542923', 'Yelisbeth Torres ', 1, 2, 0, 3, 2, 'Calle La Rivera Sabana Libre ', '4247183133; 27122199', 'YELISBETHTORRES72@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1452, '192.168.50.167', 'V21061420', 'Daniel Leal', 1, 2, 0, 3, 2, 'Calle Grupo Escolar Sector El Cementerio Casa S-N ', '4166731403; 27122198', 'DANIELLEAL2106@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1453, '192.168.50.168', 'V16533219', 'Edwinson Ruiz ', 1, 4, 0, 3, 2, 'Sector Divino Niño, Calle Sucre, Casa #38 Alto De Escuque ', '4147005369; 41433513', 'RJOSO992@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1454, '192.168.50.169', 'V15043827', 'Yohenny Betancourt', 1, 4, 0, 3, 2, 'Sector El Tiro, Casa S-N, Frente Al Galpon ', '4121786870; 41267130', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1455, '192.168.50.17	', 'V30866922	', 'David Briceño', 1, 4, 0, 3, 2, 'La Rurales Del Alto, Barbería.', '4167374586	', 'davidddelatorre21@gmail.com\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1456, '192.168.50.170', 'V30671288', 'Enderson Bravo', 1, 2, 0, 3, 2, 'El Corocito Parte Alta, Via Principal', '4241825213; 42611438', 'ENDERSONBRAVOJRSTAR@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1457, '192.168.50.171', 'V15430485', 'Maria Valecillos', 1, 4, 0, 3, 2, 'Sector El Tiro, Casa S-N, Diagonal Al Galpon', '4260377856', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1458, '192.168.50.172', 'V12798778', 'Romulo De Jesus Rondon Rondon', 1, 4, 0, 3, 2, 'Sector El Tiro Mas Abajo De Las Monjas ', '4267134680', 'ROMULORONDON59@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1459, '192.168.50.173', 'V27889407', 'Jesus Cardozo', 1, 4, 0, 3, 2, 'Sector La Bomba, Casa S-N ', '4160702708; 41243933', 'CARLOS.CARCAR2107@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1460, '192.168.50.174', 'V17391792', 'Diliana Abreu', 1, 4, 0, 3, 2, 'Sector El Tiro, A 100Mts De Las Monjas', '4123978068; 41229331', 'DILIANAABREU.1085@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1461, '192.168.50.175', 'V19287669', 'Johan Cecilio Hernandez Araujo', 1, 4, 0, 3, 2, 'Sector El Tiro Calle Principal Casa S/N Juan Diaz', '4125056518', 'hernandezgnb88@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1462, '192.168.50.176', 'V19643083', 'Norwis Jose Zambrano Abreu', 1, 4, 0, 3, 2, 'Sector La Quinta, Casa S/N Parte Baja', '4262727282', 'Norwisjose2015@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1463, '192.168.50.177', 'V15572288', 'Betty Navarro Alvarez', 1, 4, 0, 3, 2, 'Sector La Bomba, Via Principal', '4160725718; 41672507', 'MALOSATOSTY@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1464, '192.168.50.178', 'V7270602', 'Deisy Moreno', 1, 4, 0, 3, 2, 'Sector La Quinta, Hna Congregacion Comunidad De San Jose ', '4121751072; 41212014', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1465, '192.168.50.179', 'V-14135238', 'Liley Del Valle Rincon Perdomo', 1, 4, 0, 3, 2, 'La Quinta  Casa S/N', '4169081445', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1466, '192.168.50.18', 'V1258186', 'Rafael Laguna\n', 1, 4, 0, 3, 2, 'Calle La Laguna, Via Las Antenas Cerro Pobipom', '4247801547', 'lagunarafael255@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1467, '192.168.50.180', 'V16441186', 'Karen Diaz ', 1, 4, 0, 3, 2, 'Sector El Tiro Al Lado De La Monjas', '4122667789; 42476079', 'DIAZKARENS@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1468, '192.168.50.181', 'V9318771', 'Minerba Margarita Rondon Vargas', 1, 1, 0, 3, 2, 'Sector Juan Diaz, Frente A La Entrada El Tiro', '4264771478', 'Yas79fs@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1469, '192.168.50.182', 'V12940134', 'Rafael Angel Valero Gonzalez', 1, 4, 0, 3, 2, 'Sector El Tiro Via El Alto De Escuque ', '4127919825/ 04267706', 'r.angel26@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1470, '192.168.50.183', 'V27363309', 'Jeslania Hernandez Rangel', 1, 2, 0, 3, 2, 'Sabana Libre, Dos Casas Mas Arriba De Negra Hipolita ', '4163795578; 42624823', 'RANGELJOHANALIZ@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1471, '192.168.50.184', 'V29994454', 'Jhonder Barrios', 1, 2, 0, 3, 2, 'Av Principal, Calle Bolivar Casa S-N, Sabana Libre ', '4164556744; 27122194', 'YESENIAHERMINA81@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1472, '192.168.50.185', 'V27619094', 'Yonathan Jose Abreu ', 1, 2, 0, 3, 2, 'Via Principal Corocito, Sabana Libre ', '4262085888; 41634471', 'ABREUYONATHANJOSE@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1473, '192.168.50.186', 'V12351783', 'Daniel Armando Urdaneta Bracho', 1, 4, 0, 3, 2, 'La Quinta, Via Principal', '4147305240', 'durdaneta2409@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1474, '192.168.50.187', 'V31319784', 'Oscar Usechas ', 1, 4, 0, 3, 2, 'Sector La Bomba Casa S-N', '4269005795; 41626339', 'OSCARUSECHAS@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1475, '192.168.50.188', 'V18349620', 'Rosa Perez ', 1, 4, 0, 3, 2, 'El Alto De Escuque, Calle Miranda Casa #8', '4263677481; 42647771', 'PROSAURA926@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1476, '192.168.50.189	', 'V23594171	', 'Angela Briceño', 1, 2, 0, 3, 2, 'Sabana Libre, Calle Pueblo Nuevo', '4248681557	', 'BRICENOANGELAYUSLAY@GMAIL.COM\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1477, '192.168.50.19', 'V16377355', 'Mariandreina Torrealba ', 1, 4, 0, 8, 2, 'Sector La Laguneta, Frente A La Capilla Casa S/N Pq La Union, Mun Escuque ', '4162734292', 'mariandreinatp@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1478, '192.168.50.190', 'V30190372', 'Pierina Leon ', 1, 2, 0, 3, 2, 'Calle 24 De Julio, Sabana Libre', '424730895', 'PIALE.LEON9@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1479, '192.168.50.192', 'V4059314', 'Nelson Aguilar ', 1, 4, 0, 3, 2, 'Sector La Quinta Av Principal Entrada El Pao', '4121698446', 'NELSONAGUILAR01@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1480, '192.168.50.193', 'V20657894', 'Escarly Contreras ', 1, 4, 0, 3, 2, 'Via El Boqieron', '4166026554', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1481, '192.168.50.194', 'V-16882271', 'Cesar Augusto Contreras Muñoz', 1, 4, 0, 3, 2, 'Sector La Quinta Local Comercial Plan B', '4264545341', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1482, '192.168.50.195', 'V9997466', 'Marymer Jose Martinez De Chiquin', 1, 4, 0, 3, 2, 'Sector El Saladiro, Via La Quinta Boqueron Casa Sin Numero (Casa Color Naranja)', '4121253005', 'Maryjmartinez2510@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1483, '192.168.50.196', 'V4061760', 'Maria Rosalia Valero De Araujo', 1, 4, 0, 3, 2, 'Sector La Quinta Via El Boquero. Los Araujo ', '4247364871', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1484, '192.168.50.197	', 'V30976268	', 'Paola Briceño', 1, 4, 0, 3, 2, 'El Alto De Escuque Sector La Bomba Calle Principal Casa S/N', '4247503461', 'SHANTALLBRICENO5@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1485, '192.168.50.198', 'V10438045', 'Luis Antonio Villegas ', 1, 4, 0, 3, 2, 'Sector La Quinta Casa #40C-107', '4146645540; 41275190', 'LUIS_VILLEGAS1987@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1486, '192.168.50.199', 'V5507189', 'Jose Gregorio Leon Leon', 1, 4, 0, 3, 2, 'Urb La Gruta El Alto De Escuque ', '4268797529', 'JOSEGREGORIOLEONLEON89@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1487, '192.168.50.20', 'V10039747', 'Oleida Coromoto Matheus', 1, 4, 0, 3, 2, 'Las Rurales Del Alto, Diagonal Al Estadio', '4161884612; 42677382', 'balzaleo123@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1488, '192.168.50.200', 'V13262967', 'Alexandra Margarita Salas Angulo', 1, 4, 0, 3, 2, 'Las Rurales Del Alto De Escuque Via Al Estado', '4247335070', 'alexandramsalas84@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1489, '192.168.50.201', 'V17397064', 'Lisbeth Coromoto Billamburg Montilla', 1, 4, 0, 3, 2, 'Sector El Tiro ', '4120526409', 'LISBETHBRILLEMBORYG@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1490, '192.168.50.202', 'V18946712', 'Yesika Del Valle Fernandez Fernandez', 1, 4, 0, 3, 2, 'Centro Deportivo La Vino Tinto', '4120620440', 'yesikafer@hotmail.es', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1491, '192.168.50.203', 'v26784590', 'Sandra Carolina Usechas Lastra ', 1, 2, 0, 3, 2, 'Ciudadela Casa #71', '4247399055', 'SANDRAUSECHAS.96@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1492, '192.168.50.204', 'V18456637', 'Emily Pelaschier', 1, 2, 0, 3, 2, 'Calle Grupo Escolar, Sector El Saman Sabana Libre ', '4263768158; 41289466', 'PELASCHIEREMILY@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1493, '192.168.50.205	', 'V18457275	', 'Auris Roxana Briceño', 1, 2, 0, 3, 2, 'Sabana Libre Via El Alto', '4264779192; 2712211687', 'AURISBRICEÑO123@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1494, '192.168.50.206', 'V7215480', 'Wilmer Antonio Uzcategui Leal', 1, 2, 0, 3, 2, 'Sector Los Canaletes Calle La Riviera', '4167895389', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1495, '192.168.50.207', 'V19103039', 'Wilken Uzcategui', 1, 2, 0, 3, 2, 'Av Bolivar Sabana Libre, Casa S-N', '4147547130', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1496, '192.168.50.208', 'V13522540', 'Jeason Abreu', 1, 2, 0, 3, 2, 'Calle Grupo Escolar, Frente Al Saman 1', '4126801382', 'JEASON790@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1497, '192.168.50.209', 'V15752307', 'David Olmos ', 1, 2, 0, 3, 2, 'Sabana Libre, Frente A La Plaza Bolivar', '4127258771', 'ANTONIOOLMOS23@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1498, '192.168.50.21', 'V11898635', 'Jorge Luis Corona Bastidas', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Etapa 1, Calle Los Pardillos, Casa J12, Sabana Libre. Mun.Escuque', '4247263966', 'jorgecorona2121@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1499, '192.168.50.210', 'V17605792', 'Hector Pineda', 1, 2, 0, 3, 2, 'Calle Pueblo Nuevo, Sabana Libre', '4164076849', 'HEC_PINEDA_MORENO@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1500, '192.168.50.211', 'V9002711', 'Belkis Rojo', 1, 2, 0, 3, 2, 'Calle 24 De Julio Sabana Libre', '4264031477', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1501, '192.168.50.212', 'V4994684', 'Wilmer Claret Lugo Paz', 1, 1, 0, 3, 2, 'Sector Juan Diaz Detras De La Escuela', '4121319962/ 426-3878', 'wlat6@yahoo.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1502, '192.168.50.213', 'V19102476', 'Alexander Mendoza', 1, 1, 0, 3, 2, 'Urb Juan Diaz Detras De La Escuela Casa S-N', '4247650075; 41266661', 'JOSEALEXMENDOZA@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1503, '192.168.50.214', 'V25173052', 'Hecgleidys Sulbaran ', 1, 1, 0, 3, 2, 'Juan Dias Detras De La Escuela Casa S-N Frente Donde El Sr Wilmer Lugo ', '4126655091', 'hecgleidys.sulbaran@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1504, '192.168.50.215', 'V20430918', 'Ramina Betancourt', 1, 2, 0, 3, 2, 'Sabana Libre, Calle Grupo Escolar', '4147135275; 42606427', 'RAMI170390@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1505, '192.168.50.216', 'V9011850', 'Carmen Uzcategui', 1, 2, 0, 3, 2, 'Calle Grupo Escolar, Frente A La Clinica, Sabana Libre', '4247460177; 41472441', 'BELKISHG74@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1506, '192.168.50.217', 'V5503843', 'Ana Rivera', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, 2Da Etapa, Pq Sabana Libre, Mun Escuque ', '4167181755', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1507, '192.168.50.218', 'V10037688', 'Gabriel Pacheco ', 1, 2, 0, 3, 2, 'Urb Vista Hermosa, Casa E-10', '4147331207', 'CRISTALVAL1@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1508, '192.168.50.219', 'V5502202', 'Ana Maria Rondon De Hernandez', 1, 1, 0, 3, 2, 'Via Principal Juan Diaz', '4262715039 /41471416', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1509, '192.168.50.22', 'V4827348', 'Elizabeth Leon De Diaz', 1, 4, 0, 3, 2, 'Alto De Escuque, Casa#12 Frente A La Cancha, Calle Principal.', '4126472830; 04244564', 'elizaleonc57@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1510, '192.168.50.220', 'V17093161', 'Juan Carlos Goncalves Faria', 1, 1, 0, 3, 2, 'Via Principal Juan Diaz', '4147141655', 'jcgoncalves53.jcgf@gmal.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1511, '192.168.50.221', 'V13461769', 'Henry Antonio Hernandez Rivas', 1, 1, 0, 3, 2, 'Via Principal Juan Diaz', '4264574540/ 41208922', '2transdaz@gmal.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1512, '192.168.50.222', 'V15043161', 'Luis Eduardo Vetencourt Montilla', 1, 1, 0, 3, 2, 'Via Principal Juan Diaz', '.+56 953929758', 'luisev115@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1513, '192.168.50.223', 'V18984323', 'Ricardo Antonio Hernandez Rondon', 1, 1, 0, 3, 2, 'Via Principal Juan Diaz', '4147079158', 'ricardo_antonio.h.r@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1514, '192.168.50.224', 'V17095456', 'Julio Alfonso Briceño Salas', 1, 1, 0, 3, 2, 'Av Principal Juan Diaz ', '4247334401', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1515, '192.168.50.225', 'V10403589', 'Maricela Peña ', 1, 1, 0, 3, 2, 'Avenida Principal Juan Diaz, Frente A Cafe Juan Diaz Casa # 1-68', '4123774277', 'Jeanpaulg614@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1516, '192.168.50.226', 'V11610849', 'Carlos Linares ', 1, 1, 0, 3, 2, 'Sector Juan Diaz, Al Lado De La Unidad Eucativa Juan Diaz ', '4121600592', 'CARLOSJLINARESD@YAHOO.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1517, '192.168.50.227', 'V21062895', 'Anyelo Garcia', 1, 1, 0, 3, 2, 'Juan Diaz Detras De La Escuela ', '4263620626; 42475624', 'ESMERALDABRILLAMBURG@GMAIL.CO,', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1518, '192.168.50.228', 'V32007422', 'Jerome Marquez (Vaquera)', 1, 1, 0, 3, 2, 'Sector Juan Diaz, Via Principal La Vaquera ', '4125242615', 'Jeromemarquezafonso@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1519, '192.168.50.229	', 'V9494665	', 'Maria Auxiliadora Peña', 1, 2, 0, 3, 2, 'Urb La Ciudadela, Sabana Libre', '4263771200; 2712318607	', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1520, '192.168.50.23', 'V26094072', 'Ana Suarez', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa, Etapa 1, Calle La Estancia, Casab32', '4145328736; 41407493', 'gabisuarez305@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1521, '192.168.50.230', 'V12046832', 'Enrique Rangel Briceño ', 1, 1, 0, 3, 2, 'Sector Juan Diaz, Calle Principal ', '4269889950', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1522, '192.168.50.231	', 'V5763111	', 'Pedro Jose Hidalgo Briceño', 1, 4, 0, 3, 2, 'El Alto Las Rurales', '4247813233', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1523, '192.168.50.232', 'V', 'Homero Duran', 1, 4, 0, 3, 2, 'La Laguneta Via Las Monjas, El Alto De Escuque ', '', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1524, '192.168.50.233', 'V13522942', 'Humberto Godoy ', 1, 4, 0, 3, 2, 'Calle Principal El Alto De Escuque', '4265615348', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1525, '192.168.50.234', 'V32550745', 'Antonio Torres', 1, 4, 0, 3, 2, 'Sector La Laguneta Finla De La Calle La Capilla ', '4164163924', 'Antoniojtvolcanes24@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1526, '192.168.50.236', 'V3812667', 'Ramon Zambrano', 1, 4, 0, 3, 2, 'Sector San Benito El Alto', '4246608819', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1527, '192.168.50.237', 'V15752001', 'Jonny Plata ', 1, 2, 0, 3, 2, 'Via Panamericana, Entrada Al Corozo, Pasarela, Sabana Libre ', '4147327189; 41437182', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1528, '192.168.50.238', 'V16037494', 'Mirian Perez ', 1, 1, 0, 3, 2, 'Sector Juan Diaz, Via Principal El Alto', '4125928336; 41407489', 'MP4551732@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1529, '192.168.50.24', 'V20788528', 'Maria Luisa Velasquez', 1, 5, 0, 3, 2, 'Quevedo, Sector Cano, Casa S/N En La Esquina De La Piscina La Escondida', '4247643447; 42616707', 'marialuisabalza1990@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1530, '192.168.50.240', 'V31913284', 'Scarleth Vergara ', 1, 1, 0, 3, 2, 'Sector Juan Diaz, Via Principal El Alto', '4125262507; 42665974', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1531, '192.168.50.241', 'V15294644', 'Mary Liseth Viloria Perez', 1, 1, 0, 3, 2, 'Sector Juan Diaz Via Al Alto Cerca Del Spat', '4261720259', 'mlvp18@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1532, '192.168.50.242', 'V21064437', 'Anderson Viloria ', 1, 1, 0, 3, 2, 'Sector Juan Diaz, Entrada A Las Malvinas, Taller Mecanico', '4264883027', 'KIARAKATHERINE.G19@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1533, '192.168.50.243', 'V18097681', 'Hilmar Tapias ', 1, 1, 0, 3, 2, 'Sector Juan Diaz Detras De La Escuela', '4126865975', 'KHILMAR.TAPHER@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1534, '192.168.50.245', 'V1655860', 'Sirio De Jesus Valbuena Alvarado', 1, 4, 0, 3, 2, 'Via El Alto Spa-La Union', '4166712244', 'FLORDEMAYODELCE@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1535, '192.168.50.246', 'V19342046', 'Zynaith Gregoria Medina Rivas', 1, 1, 0, 3, 2, 'Sector Juan Diaz Via Al Alto De Escuque Av Principal', '4246100608', 'Diego_albeslanny@hotmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1536, '192.168.50.247', 'V11614318', 'Lilibeth Josefina Briceño Barreto', 1, 1, 0, 3, 2, 'Via Principal Sector Juan Diaz Casa S/N', '4247846048', 'lilibethbriceño1972@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1537, '192.168.50.248', 'V17392559', 'Wilson Salazar', 1, 4, 0, 3, 2, 'Sector Divino Niño, Calle Principal, Casa S-N', '4247322123; 42690478', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1538, '192.168.50.249', 'V26413390', 'Mailyn Canelon', 1, 4, 0, 3, 2, 'Sector Las Malvinas, Casa S-N, Casa Azul', '4247590382; 42646175', 'MAILYNCANELON25@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1539, '192.168.50.25', 'V16079427', 'Glenda Lopez', 1, 2, 0, 3, 2, 'Sector San Benito, Calle Miranda', '4247453705; 41642697', 'Glendacoromotol@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1540, '192.168.50.250	', 'V14929029	', 'Levis Marilin Peña Briceño', 1, 5, 0, 3, 2, 'Sector La Antena, La Mata', '4147423857', 'levismarilinpenabriceno@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1541, '192.168.50.251', 'V5762809', 'Wilian Salas ', 1, 2, 0, 3, 2, 'El Corocito De Sabana Libre', '4263708926', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1542, '192.168.50.252', 'V26690402', 'Yusmirania Salas ', 1, 2, 0, 3, 2, 'Residencias La Ciudadela. Calle 3, Casa #80', '4121746873; 41475018', 'YUSSALAS04@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1543, '192.168.50.253', 'V15294159', 'Leidy Bencomo', 1, 2, 0, 3, 2, 'Calle Bolivar, Sabana Libre', '4161378210', 'RBENCOMO8809@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1544, '192.168.50.254', 'V8134391', 'Maria Shelbert', 1, 2, 0, 3, 2, 'Urb. La Ciudadela,Calle El Saman Casa S/N ', '4147265727', 'montischel@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1545, '192.168.50.26', 'V11317950', 'Beatriz Duarte', 1, 2, 0, 3, 2, 'Calle Barrio Lindo, Casa S/N Al Lado De La Capilla San Benito, Sabana Libre, Parrq.Sabana Libre, Mun.Escuque', '4264257961; 41243908', 'Duartegabyy20@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1546, '192.168.50.27', 'V5195936', 'Yslarma Garcia', 1, 4, 0, 3, 2, 'Calle Paez, Casa #10, Alto De Escuque ', '4164744513', 'yslarrosariog@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1547, '192.168.50.28', 'V12456555', 'Alexander Gonzalez', 1, 4, 0, 3, 2, 'Alto De Escuque Sector La Huerta', '4269790981', 'servi_alex@hotmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1548, '192.168.50.29', 'V5495985', 'Ana Maria Leon', 1, 4, 0, 3, 2, 'Alto De Escuque, Calle Independencia, Casa S/N', '4247487359', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1549, '192.168.50.30', 'V3907060', 'Mercedes Del Rosario Leon De Viloria', 1, 4, 0, 3, 2, 'La Laguneta Cerca Del Cementerio', '4147530306/416480011', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1550, '192.168.50.31', 'V2623622', 'Edgar De Jesus Rivero Moreno', 1, 4, 0, 3, 2, 'Sector La Laguneta Casa Atardecer S/N', '4147314949', 'edgarriveroo48@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1551, '192.168.50.32', 'V10086364', 'Mariela Chiquinquira Jimenez Adrianza', 1, 4, 0, 3, 2, 'Casa #10 El Alto De Escuque Calle Santa Rosalia, La Union', '4147578510', ' mayej.830@gmail.com ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1552, '192.168.50.33	', 'V12041478	', 'Mireya Gonzales Peña		', 1, 4, 0, 3, 2, 'Sector Divino Niño, Alto De Escuque Via San Benito, Parrq.La Unión', '4168299270; 4163045986', 'Mireyagonzales694@gmail.com\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1553, '192.168.50.34', 'V12765457', 'Yesika Maria Segovia', 1, 4, 0, 3, 2, 'Sector Divino Niño, Calle Principal Casa S/N Alto De Escuque', '4125329794; 41625174', 'chelestiel2504@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1554, '192.168.50.35', 'V11610345', 'Mary Pajaro De Chacon', 1, 4, 0, 3, 2, 'El Alto De Escuque , Sector Las Casitas ', '4161372999', 'mpajaro811@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1555, '192.168.50.36', 'V17831941', 'Anali Andreina Avila Barrios', 1, 4, 0, 3, 2, 'Calle Juan Pablo Segundo, Sector La Laguneta, Al Lado De Las Casa Las Rosmini', '4166133098/424675731', 'zualyjose14@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1556, '192.168.50.37', 'V12457927', 'Glenda Camacho ( Iglesia Evangelica)', 1, 4, 0, 3, 2, 'Sector Las Casitas, El Alto, Casa S/N', '4163793487', 'OWACAMACHO03@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1557, '192.168.50.38', 'V20788775', 'Diego Haon', 1, 4, 0, 8, 2, 'El Alto De Escuque Calle Mranda Casa Nro 20', '4124252479/414724900', 'DIEGOHAONP@GMAIL.COM', '2025-10-01', '', '', '', 1, 2, 'ACTIVO'),
(1558, '192.168.50.39', 'V9323395', 'Omaira Teresa Fucil', 1, 4, 0, 3, 2, 'Sector Las Casitas El Alto De Escuque Casa S/N, La Union, Escuque ', '4147320837', 'omaira.fucil@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1559, '192.168.50.40	', 'V26784239	', 'Cristian Jose Valero Peña', 1, 4, 0, 3, 2, 'Alto De Escuque Calle Miranda Casa S/N	', '4122999545	', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1560, '192.168.50.42', 'V4415758', 'Raul Sequera', 1, 4, 0, 3, 2, 'Sector San Benito Alto De Escuque', '4247259375, 41652138', 'SEQUERA191@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1561, '192.168.50.43', 'V5791847', 'Adolfo Araujo', 1, 4, 0, 3, 2, 'Av Principal La Laguneta Calle Campo Rico Diagonal A La Capilla ', '4161643525', 'ADOLFO05_BATUTA@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1562, '192.168.50.44', 'V26036196', 'Siuberto Valderrama', 1, 2, 0, 3, 2, 'Calle La Democracia Con San Agustin', '4247408933', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1563, '192.168.50.45', 'V20656767', 'Jesus Medina', 1, 2, 0, 3, 2, 'Callejon San Agustin, Casa S-N Pq Sabana Libre, Mun Escuque ', '4247672678, 42641541', 'JESUSGMC@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1564, '192.168.50.46', 'V9006863', 'Tito Leon', 1, 4, 0, 3, 2, 'Sector La Laguneta Calle Las Antenas Casa S/N', '4147352975', 'LEONTITO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1565, '192.168.50.47', 'V3907238', 'Elizabet Delgado Gonzalez', 1, 4, 0, 3, 2, 'Alto De Escuque, Calle Sucre', '4247226316', 'Elizabethd874@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1566, '192.168.50.48', 'V9315728', 'Fidelia Josefina Suerez Pineda', 1, 4, 0, 3, 2, 'Alto De Escuque Calle Independencia Casa Nñ24', '4165944271, 42682807', 'FIDELIA_316@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1567, '192.168.50.49', 'V16377135', 'Amarilis Coromoto Pereira', 1, 4, 0, 3, 2, 'Sector Divino Niño;', '4149780135', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1568, '192.168.50.50', 'G20000357-0', 'Coorporacion Trujillana De Turismo (Posada El Alto)', 1, 4, 0, 3, 2, 'Posada Mirabel Del Alto De Escuque Frente A La Plaza', '2722361455, 42677084', 'CCTCOBRANZA/2022@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1569, '192.168.50.52', 'V4016884', 'Daysy Esperanza Perozo Guerrero', 1, 4, 0, 3, 2, 'Sector Los Barbechos Casa S/N El Alto De Escuque', '4168013454', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1570, '192.168.50.53', 'V14149630', 'Viliccy Bustos Diaz', 1, 2, 0, 3, 2, 'Urbanizacion Vista Hermosa Casa J10 Primera Etapa', '4247134506', 'BUSTOSRUIZVILICCY@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1571, '192.168.50.54	', 'V22892723	', 'Anyel Briceño', 1, 4, 0, 3, 2, 'Sector Las Rurales Del Alto Detras De La Capilla	', '4149796429, 4268285246	', 'ANYELBRICEALEXANDER@GMAIL.COM\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1572, '192.168.50.55', 'V24785916', 'Yajaira Del Carmen Briceño Olmos', 1, 4, 0, 3, 2, 'Sector La Laguneta Casa El Manantial Via El Alto De Escuque', '4165296536', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1573, '192.168.50.56', 'V27245801', 'Nilxon Parra', 1, 4, 0, 3, 2, 'Sector Las Rurales Del Alto Detras De La Capilla', '4247156938, 42472546', 'PARRANILJUNIOR@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1574, '192.168.50.57	', 'V9313441	', 'Maria Briceño	', 1, 4, 0, 3, 2, 'Sector Divino Niño', '4167136186, 4160264035	', 'MABRI.64.60@GMAIL.COM\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1575, '192.168.50.58', 'V10030738', 'Maria Dilia Briceño Gonzalez', 1, 4, 0, 3, 2, 'Urb Divino Niño Via Principal El Alto', '0426-413 7289', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1576, '192.168.50.59', 'V4444364', 'Consuelo Torres Montilla', 1, 2, 0, 3, 2, 'Calle Bella Vista Con 24 De Julio', '4147592154, 27122197', 'CONSUELOT751@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1577, '192.168.50.60', 'V10907114', 'Jesus Calderas', 1, 4, 0, 3, 2, 'Sector Divino Niño Casa Nñ60', '4262270128, 41665576', 'JESUSCALDERASQUINTERO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1578, '192.168.50.61', 'V18097653', 'Ligia Uzcategui', 1, 4, 0, 3, 2, '', '4247584539', 'CHARIDB426@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1579, '192.168.50.62', 'V17604218', 'Maria Eden Leal', 1, 4, 0, 3, 2, 'Alto De Escuque, Sector Mirabel , Casa S/N', '4122031363', 'mariaedenvalera3@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1580, '192.168.50.63	', 'V15825744	', 'Homero Peña', 1, 2, 0, 3, 2, 'Calle Bolivar Casa Sin Numero Frente A La Plaza Bolivar	', '4160976043	', 'cyberjose1977@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1581, '192.168.50.64', 'V11896638', 'Jose Luis Barrios Balza', 1, 2, 0, 4, 2, 'Urb.Vista Hermosa Calle Los Pardillos, Sector I Casa 32', '4125494882', 'Joseluisbarriosbalza24@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1582, '192.168.50.65', 'V9178105', 'Jaime Colls', 1, 2, 0, 3, 2, 'Urb.Vista Hermosa Calle Los Pardillos, Sector I Casa 31', '4163780030', 'JAIMECOLLS@YAHOO.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1583, '192.168.50.66', 'V24135981', 'Maria Fernanda Valero', 1, 2, 0, 3, 2, 'Urbanizacion Vista Hermosa 2Etapa Casa 005', '4247409500', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1584, '192.168.50.68', 'V11323664', 'Vladimir Perdomo', 1, 2, 0, 3, 2, 'Calle San Rafael Detras De La Cancha Diagonal Al Palon', '4269794635, 42449707', 'VLADIMIRPERDOMO447@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1585, '192.168.50.69', 'V15431758', 'Nataly Castellanos ', 1, 4, 0, 3, 2, 'Alto De Escuque Cerca De Las Monjas Sector Juan Pablo Segundo', '4147327492', 'NATALYCASTELLANOS08@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1586, '192.168.50.73', 'V11317544', 'Maria Consuelo Valero Balza', 1, 4, 0, 3, 2, 'Laguneta Cerca De Kennedy Diagonal Cementerio', '4269109792', 'Garciavalerok@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1587, '192.168.50.74', 'V25374633', 'Maryelibeth Gutierrez', 1, 2, 0, 3, 2, 'Sabana Libre', '4247585731, 41497704', 'MARYELIBETHGUTIERREZ89@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1588, '192.168.50.75', 'V10907635', 'Carlos Jose Diaz', 1, 2, 0, 3, 2, 'Urbanizacion Vista Hermosa Casa 01', '4265707912, 42692708', 'CARLOSJOSE0103@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1589, '192.168.50.76', 'V12044902', 'Yasmina Hoyos ', 1, 2, 0, 3, 2, 'Sector Brisas De San Benito', '4147366456', 'YASMINAHOYOS12@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1590, '192.168.50.77', 'V10400537', 'Angela Nardone ', 1, 4, 0, 3, 2, 'Sector La Laguneta, Casa #7 Via Principal ', '4268700330', 'ANGELA.MARIA.NARDONE@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1591, '192.168.50.78	', 'V9173366	', 'Juan Briceño', 1, 4, 0, 3, 2, 'Sector La Laguneta, Calle La Capilla Casa #10 	', '4140825045	', 'BAUTISTA2017VE@GMAIL.COM\r\n', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1592, '192.168.50.79', 'V15825706', 'Julio Viloria ', 1, 2, 0, 3, 2, 'Urb Vista Hermosa ', '4147302990', 'JULIOCESARVILORIAVILORIA@GMAI.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1593, '192.168.50.80', 'V16739929', 'Yosmer Flores ', 1, 4, 0, 3, 2, 'El Alto Sector San Benito Casa S-N', '4263788718', 'YOSLOZ8408@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1594, '192.168.50.81', 'V13461522', 'Antonio Leon ', 1, 2, 0, 3, 2, 'Sabana Libre Calle Comercio, Esquina Plaza Bolivar Sector Centro ', '4161700922; 02712219', 'BENIGNOLEON0901@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1595, '192.168.50.82', '10908825', 'Miguel Angel Aldana Castellanos', 1, 2, 0, 3, 2, 'Urb Vista Hermosa Calle La Estancia Casa Nro 45', '18137242544', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1596, '192.168.50.83', 'V9177558', 'Dioni Mendoza ', 1, 2, 0, 3, 2, 'Calle Pueblo Nuevo ', '4269767535', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1597, '192.168.50.84', 'V9317942', 'Pablo Abreu ', 1, 2, 0, 3, 2, 'Calle Democracia Casa #19', '4247070112; 42470701', 'ABREUPABLOLUIS@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1598, '192.168.50.85', 'V11324828', 'Deyanira Zambrano', 1, 2, 0, 3, 2, 'Calle 24 De Julio Casa S-N ', '4162655319', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1599, '192.168.50.86', 'V9311443', 'Magaly Rincon', 1, 2, 0, 3, 2, 'Vista Hermosa Calle Principal Casa H16', '4247390281', 'MAGALYRINCON65@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1600, '192.168.50.87', 'V14329014', 'Claudia Fragozo', 1, 2, 0, 3, 2, 'Urb Vista Hermosa Casa N10 Segunda Etapa ', '4147174321; 41646586', 'claudiafragoso2708@yahoo.es', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1601, '192.168.50.88', 'V10085824', 'Zulay Ortiz ', 1, 2, 0, 3, 2, 'Urb Ciudadela Calle 3 Casa 73', '4143629599; 41250545', 'ZYMIRANDA24@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1602, '192.168.50.89', 'V12665622', 'Jorge Lenin Paredes Araujo ', 1, 2, 0, 3, 2, 'Urb La Ciudadela Calle 2 Casa 41', '4265759009', 'JORGELENIN76@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1603, '192.168.50.90', 'V11894922', 'Sarai Quevedo ', 1, 2, 0, 3, 2, 'Urb Ciudadel Calle 2 Casa 40 ', '4147211700; 41492531', 'ALEJANDROLINARES384@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1604, '192.168.50.91', 'V17606252', 'Jean Carlos Villegas ', 1, 2, 0, 3, 2, 'Calle Comercio, Local S-N', '4263255598', 'JEAN_VILLEGAS20@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1605, '192.168.50.92', 'V13260194', 'Lucero Miranda ', 1, 2, 0, 3, 2, 'Urb La Ciudadela, Casa #11 Pq Sabana Libre, Mun Escuque ', '4147179993; 42657094', 'DIEGOOSUNA1004@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1606, '192.168.50.93', 'V4251943', 'Antonio Olmos ', 1, 2, 0, 3, 2, 'Urb El Saman 1, Quinta 13, Sabana Libre, Mun Escuque ', '4143712566', 'OLMOSDEMCA@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1607, '192.168.50.94', 'V17832239', 'Dayana Villa ', 1, 2, 0, 3, 2, 'Calle San Rafael, Casa S-N, Pq Sabana Libre, Mun Escuque ', '4246193160', 'GATIVILLA2525@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1608, '192.168.50.95', 'V9322721', 'Andres Gutierrez', 1, 2, 0, 3, 2, 'Calle Comercio, Bodega El Encanto ', '4265797697; 27122216', 'ANDRESGUTIERREZARAUJO@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1609, '192.168.50.96', 'V31898264', 'Edmanuel Mendez ', 1, 2, 0, 3, 2, 'Calle Cruz De La Mision, Sabana Libre ', '4167124572; 42474821', 'ENMANUELMENDEZ11237@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1610, '192.168.50.97', 'V10914458', 'Dalia Maldonado ', 1, 2, 0, 3, 2, 'Calle Bolivar, Local S-N Mas Arriba Del Arco, Rincon De La Claridad ', '4247556254', 'DALIA_CORO71@HOTMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1611, '192.168.50.99', 'V11251282', 'Yorely Suarez', 1, 4, 0, 3, 2, 'Sector Mirabel, Alto De Escuque , Casa S/N , Frente A La Cruz De La Mision, Parrq.La Union, Mun.Escuque', '4247736739; 41267077', 'yorelymontilla@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1612, '192.168.60.137', 'V18458759', 'Jesus Ramon Montilla Carrillo ', 1, 4, 0, 2, 2, 'Sector La Pica Pica Mas Arriba De Maria Albarran ', '4125498226', 'daisyruiz649@gmail.com', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1613, '192.168.60.170', 'V 14800029', 'Israel Jose Briceño Cadena ', 1, 2, 0, 2, 2, 'Las Cruces Parte Baja Sector Prado Verde', '4269883734', 'Joseysrraelbc.0210@gmail.con', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1614, '192.168.60.180', 'V19285121', 'Maryuly Perez ', 1, 4, 0, 2, 2, 'El Boqueron, Sector La Candelaria Casa S/N ', '4263121572', ' MARYORIPEREZ04@GMAIL.COM ', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1615, '192.168.60.199', 'V10754527', 'Maria Ascencion Mendoza Paredes ', 1, 1, 0, 2, 2, 'Las Delicias ', '4164272339; 42477618', 'MARIAASCENCIONMPA27@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1616, '192.168.60.200', 'V12055831', 'Mariela Verdu ', 1, 1, 0, 2, 2, 'Sector La Macarena, Casa S/N', '4167740076; 42475697', 'mary.bcv.1973@gmail.com', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1617, '192.168.60.201', 'V20085492', 'Gerardo Machado', 1, 1, 0, 2, 2, 'Urb Rafael Urdaneta Las Rurales Casa De Los Guardias ', '4269671974; 41249820', 'GMACHADOV90@GMAIL.COM', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1618, '192.168.60.32', 'V10036517', 'Jose Monagas', 2, 3, 0, 8, 2, 'Av 5 Sector El Jobo, Casa 47-85, Diagonal Al Cilarr, Betijoque ', '4260357818', 'JRMONAGAS@GMAIL.COM', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1619, '192.168.60.42', 'V23781341', 'Diego Rondon', 1, 4, 0, 2, 2, 'Sector La Pica Pica, El Boqueron Casa S-N ', '4160881849', 'DIEGO23RONDON@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1620, '192.168.60.61', 'V9326909', 'Jose Gregorio Hernandez ', 1, 4, 0, 2, 2, 'Sector La Pica Pica, Casa S-N, El Boqueron, Pq La Union, Mun Escuque ', '4166044944', 'MAITELYH@GMAIL.COM', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1621, '192.168.80.11', 'V11686921', 'Nilsia Aida Duran', 1, 1, 0, 2, 2, 'El Playon Via Principal', '04142456495; 0414256', ' Nilsiaaida48@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1622, '192.168.80.110', 'V9499765', 'Celeste Rivas', 1, 1, 0, 2, 2, 'Urb Fray Ignacio Alvarez, Vereda Las Estrellas, Casa 19-18, Escuque ', '4247003108', ' CELESTERIVAS969@GMAIL.COM ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1623, '192.168.80.12', 'V20430800', 'Wilfredo Jose Vielma Uzcategui', 1, 1, 0, 2, 2, 'Sector La Sabaneta Via Principal', '4247712067', ' wilfredovielma3@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1624, '192.168.80.121', 'V30189667', 'Cesar Godoy', 1, 1, 0, 2, 2, 'Sector La Loma Escuque Parte Alta, Callejon Despues De La Cruz, Casa S-N ', '4247158929', ' GODOYADRIAN523@GMAIL.COM ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1625, '192.168.80.16', 'V8051265', 'Diego Eliecer Rangel Ponce', 2, 3, 0, 2, 2, 'San Agustin Parte Alta, 250Mtros Antes De Los Radiadores ', '04147577712 / 042472', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1626, '192.168.80.17', 'V26123543', 'Laura Molina ', 1, 1, 0, 2, 2, 'Sector La Sabaneta, Via Pan De Azucar', '04142555497; 0424754', ' lauura19@gmal.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1627, '192.168.80.181', 'V 15827198', 'Maria De Los Santos Castellanos Villamizar', 2, 3, 0, 2, 2, 'San Agustin Parte Alta Avenida Principal Valera Betijoque 80M De Los Radiadores', '4147578532', ' Mariadesmillamizar19@gmail.com ', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1628, '192.168.80.195', 'V16464057', 'Silvia Yaneth Mijares Mazzey', 1, 2, 0, 3, 2, 'Vista Hermosa Etapa 2 Calle Principal Casa K11', '4247403056', '', '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1629, '192.168.80.199	', 'V18349706	', 'Maria Alejandra González Briceño', 1, 4, 0, 2, 2, 'Las Cruces Sector La Popa, Parrq.La Union, Mun.Escuque', '4125349223	', NULL, '2025-10-01', '', '', '', 1, 0, 'ACTIVO'),
(1631, '192.168.80.99', 'V9001435', 'Francisco Ernesto Peña Barreto', 2, 3, 0, 2, 2, 'Sara Linda Via Principal, Puesto De Chicharronera Francisco Peña ', '4140825581', '', '2025-10-01', '', '', '', 2, 0, 'ACTIVO'),
(1632, '192.168.90.100', 'V23781520', 'Jose Abreu', 1, 5, 0, 2, 2, 'Sector Cotiza, ultima Casa Granja Toño, Mun. Escuque', '4120954017', ' Tonidalmotor@gmail.com ', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1633, '192.168.90.171', '12927413', 'Cristian Jose Leon Valero ', 1, 1, 0, 2, 2, 'Sector Los Potreritos Casa S/N Finca California', '4166720340', '', '2025-10-01', '', '', '', 3, 0, 'ACTIVO'),
(1637, '192.168.1.1', '32283141', 'adrian ramirez prueba', 1, 2, 0, 3, 2, 'buen avista', '0426-4689848', 'adriamramirez.2605rg@gmail.com', '2025-10-14', '1', '1', '1', 1, 1, 'SUSPENDIDO'),
(1638, '192.168.1.1.2', '234234', 'prueba2', 1, 2, 0, 6, 2, 'qweqwdasdasd', '234234234', '@', '2025-10-14', '', '', '', 1, 0, 'INACTIVO'),
(1639, '123.123', '32123', 'prueba3', 1, 2, 0, 4, 2, 'prueba sabana libre', '2131', '@', '2025-10-15', '123', '123', '123', 1, 1, 'ACTIVO'),
(1640, '132.35.35', '122454', 'prueba', 1, 2, 0, 2, 2, 'beuna vista', '123', '@', '2025-10-15', '12', '12', '12', 1, 1, 'ACTIVO'),
(1641, '192.168.1.1.1', '123', 'prueba 3', 1, 2, 3, 2, 2, 'asd', '0', '@', '2025-10-16', '234', '123', '123', 1, 1, 'ACTIVO'),
(1642, '192.5.5.', '23423423', 'wefsdf', 1, 5, 0, 2, 2, 'wewerwer', '231234', '@', '2025-10-16', '', '', '', 3, 2, 'ACTIVO'),
(1643, '192.170', '123123', 'PRUEBA2.1', 1, 2, 1, 7, 2, 'SDFSDF', '34234', 'DAS@', '2025-10-30', '4234234', '345345', '34534', 2, 0, 'ACTIVO'),
(1644, '1921.1551', '23423423', 'PRUEBA', 1, 2, 0, 7, 2, 'RFGHF', '45345345', '@', '2025-10-30', '456456', '456456', '456456', 2, 0, 'ACTIVO'),
(1645, '123123', '32283141', 'adrian prueba 5', 1, 2, 1, 5, 2, 'buena vista', '456456456', '@', '2025-10-30', '345', '345', '345', 1, 2, 'ACTIVO'),
(1646, '123123123123', '34534534', 'dsfsdfsdf', 1, 2, 1, 7, 2, 'dfgdfg', '43534', 'ssdfs@', '2025-10-30', '456456', '456', '456', 1, 2, 'ACTIVO'),
(1647, '1231231232345', '123123', 'sdfsdf', 1, 2, 0, 5, 2, 'sdfgsdgsdg', '', '@', '2025-10-30', '45345', '345345', '345345', 2, 0, 'ACTIVO'),
(1648, '128.1', '34234', 'prueba contrato', 1, 2, 1, 5, 2, 'buena vista', '345345', '@', '2025-10-30', '', '', '', 1, 2, 'ACTIVO'),
(1649, '192.1291235', '234234', 'asfasfasf', 1, 1, 0, 4, 2, 'sdfsdfsdf', '345345345', 'asdasd@', '2025-10-30', '', '', '', 2, 0, 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_por_cobrar`
--

CREATE TABLE `cuentas_por_cobrar` (
  `id_cobro` int(11) NOT NULL,
  `id_contrato` int(11) NOT NULL COMMENT 'FK a la tabla contratos',
  `fecha_emision` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `monto_total` decimal(10,2) NOT NULL COMMENT 'Monto final a pagar',
  `estado` enum('PENDIENTE','PAGADO','VENCIDO','CANCELADO') NOT NULL DEFAULT 'PENDIENTE',
  `fecha_pago` datetime DEFAULT NULL,
  `referencia_pago` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_plan_cobrado` int(11) DEFAULT NULL COMMENT 'FK del Plan facturado en el momento de la emisión'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `frases_motivacionales`
--

CREATE TABLE `frases_motivacionales` (
  `id` int(11) NOT NULL,
  `frase` text NOT NULL,
  `autor` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `frases_motivacionales`
--

INSERT INTO `frases_motivacionales` (`id`, `frase`, `autor`) VALUES
(1, 'La mejor forma de predecir el futuro es creándolo.', 'Peter Drucker'),
(2, 'El éxito es la suma de pequeños esfuerzos repetidos día tras día.', 'Robert Collier'),
(3, 'La automatización no es el fin del trabajo, sino el inicio de la creatividad.', 'Wireless Supply, C.A.'),
(4, 'La única forma de hacer un gran trabajo es amar lo que haces.', 'Steve Jobs'),
(5, 'No cuentes los días, haz que los días cuenten.', 'Muhammad Ali'),
(6, 'La vida es aquello que te va sucediendo mientras estás ocupado haciendo otros planes.', 'John Lennon'),
(7, 'El secreto de salir adelante es empezar.', 'Mark Twain'),
(8, 'Sé el cambio que deseas ver en el mundo.', 'Mahatma Gandhi'),
(9, 'La mejor forma de predecir el futuro es creándolo.', 'Peter Drucker'),
(10, 'El éxito es la suma de pequeños esfuerzos repetidos día tras día.', 'Robert Collier'),
(11, 'La única forma de hacer un gran trabajo es amar lo que haces.', 'Steve Jobs'),
(12, 'No cuentes los días, haz que los días cuenten.', 'Muhammad Ali'),
(13, 'La felicidad no es algo ya hecho. Viene de tus propias acciones.', 'Dalai Lama'),
(14, 'Haz de cada día tu obra maestra.', 'John Wooden'),
(15, 'La creatividad es la inteligencia divirtiéndose.', 'Albert Einstein'),
(16, 'No te detengas, solo descansa si es necesario.', 'Paulo Coelho'),
(17, 'La duda es el principio de la sabiduría.', 'Aristóteles'),
(18, 'Siempre parece imposible hasta que se hace.', 'Nelson Mandela'),
(19, 'El arte de la vida consiste en hacer de la vida una obra de arte.', 'J. Kennedy'),
(20, 'Donde hay voluntad, hay camino.', 'Proverbio'),
(21, 'Cree en ti mismo y en lo que eres.', 'Maxime Lagacé'),
(22, 'La acción es la clave fundamental para todo éxito.', 'Pablo Picasso'),
(23, 'Nuestra mayor debilidad radica en renunciar.', 'Thomas A. Edison'),
(24, 'El propósito de nuestras vidas es ser felices.', 'Dalai Lama'),
(25, 'El fracaso es la oportunidad de empezar de nuevo, con más inteligencia.', 'Henry Ford'),
(26, 'Nunca es demasiado tarde para ser lo que podrías haber sido.', 'George Eliot'),
(27, 'Si puedes soñarlo, puedes hacerlo.', 'Walt Disney'),
(28, 'La disciplina es el puente entre metas y logros.', 'Jim Rohn'),
(29, 'Piensa en grande y no escuches a la gente que dice que no se puede hacer.', 'Grant Cardone'),
(30, 'No esperes. El momento nunca será perfecto.', 'Napoleon Hill'),
(31, 'El futuro pertenece a quienes creen en la belleza de sus sueños.', 'Eleanor Roosevelt'),
(32, 'La paciencia es amarga, pero su fruto es dulce.', 'Jean-Jacques Rousseau'),
(33, 'El pesimista ve dificultad en toda oportunidad. El optimista ve oportunidad en toda dificultad.', 'Winston Churchill'),
(34, 'La imaginación es más importante que el conocimiento.', 'Albert Einstein'),
(35, 'Nunca eres demasiado viejo para establecer una nueva meta o soñar un nuevo sueño.', 'C.S. Lewis'),
(36, 'El valor no es la ausencia de miedo, sino el triunfo sobre él.', 'Nelson Mandela'),
(37, 'Solo aquellos que se atreven a fallar grandemente pueden conseguir grandes éxitos.', 'Robert F. Kennedy'),
(38, 'Si no te gusta algo, cámbialo. Si no puedes cambiarlo, cambia tu actitud.', 'Maya Angelou'),
(39, 'La única limitación es aquella que tú mismo te pones.', 'Oprah Winfrey'),
(40, 'El momento más oscuro es justo antes del amanecer.', 'Paulo Coelho'),
(41, 'Cada día es una nueva oportunidad para cambiar tu vida.', 'Anónimo'),
(42, 'Las dificultades preparan a personas comunes para destinos extraordinarios.', 'C.S. Lewis'),
(43, 'La mente es como un paracaídas, solo funciona si se abre.', 'Albert Einstein'),
(44, 'Trabaja duro en silencio, deja que tu éxito haga el ruido.', 'Frank Ocean'),
(45, 'El único lugar donde el éxito viene antes que el trabajo es en el diccionario.', 'Vidal Sassoon'),
(46, 'No dejes que el ayer ocupe demasiado del hoy.', 'Will Rogers'),
(47, 'La perseverancia es caer siete veces y levantarse ocho.', 'Proverbio Japonés'),
(48, 'Incluso la noche más oscura terminará y el sol saldrá.', 'Victor Hugo'),
(49, 'La calidad no es un acto, es un hábito.', 'Aristóteles'),
(50, 'El cambio no llegará si esperamos por otra persona o por otro tiempo. Nosotros somos los que hemos estado esperando.', 'Barack Obama'),
(51, 'No te rindas. Sufre ahora y vive el resto de tu vida como un campeón.', 'Muhammad Ali'),
(52, 'El propósito de la vida no es ser feliz. Es ser útil, honorable, compasivo, y que haga alguna diferencia.', 'Ralph Waldo Emerson'),
(53, 'Lo que haces hace la diferencia, y tienes que decidir qué tipo de diferencia quieres hacer.', 'Jane Goodall'),
(54, 'La vida es 10% lo que te pasa y 90% cómo reaccionas a ello.', 'Charles R. Swindoll'),
(55, 'No midas el éxito por la altura de tus logros, sino por la profundidad del impacto.', 'Booker T. Washington'),
(56, 'La verdadera libertad es no tener nada que perder.', 'Janis Joplin'),
(57, 'La mejor venganza es el éxito masivo.', 'Frank Sinatra'),
(58, 'La sabiduría no es un producto de la escolaridad, sino del intento de toda la vida por adquirirla.', 'Albert Einstein'),
(59, 'Lo importante no es lo que miras, sino lo que ves.', 'Henry David Thoreau'),
(60, 'La mejor manera de empezar es dejar de hablar y empezar a hacer.', 'Walt Disney'),
(61, 'Cae siete veces y levántate ocho.', 'Proverbio Japonés'),
(62, 'La vida es un 10% lo que experimentas y un 90% cómo respondes a ello.', 'Dorothy M. Neddermeyer'),
(63, 'Solo se vive una vez, pero si lo haces bien, una vez es suficiente.', 'Mae West'),
(64, 'Ve con confianza en la dirección de tus sueños.', 'Henry David Thoreau'),
(65, 'El crecimiento comienza cuando la zona de confort termina.', 'Neale Donald Walsch'),
(66, 'El futuro es brillante si eres valiente.', 'Anónimo'),
(67, 'Nunca olvides por qué empezaste.', 'Anónimo'),
(68, 'Sé tu propia musa.', 'Anónimo'),
(69, 'La simplicidad es la máxima sofisticación.', 'Leonardo da Vinci'),
(70, 'La creatividad es el motor del cambio.', 'Anónimo'),
(71, 'El destino mezcla las cartas, y nosotros las jugamos.', 'Arthur Schopenhauer'),
(72, 'No tengas miedo de renunciar a lo bueno para ir por lo grandioso.', 'John D. Rockefeller'),
(73, 'Solo hay una manera de evitar la crítica: no hagas nada, no digas nada y no seas nada.', 'Aristóteles'),
(74, 'La vida es demasiado importante para tomarla en serio.', 'Oscar Wilde'),
(75, 'La educación es el arma más poderosa que puedes usar para cambiar el mundo.', 'Nelson Mandela'),
(76, 'Sueña en grande y atrévete a fallar.', 'Norman Vaughan'),
(77, 'El éxito no es el final, el fracaso no es fatal: es el coraje para continuar lo que cuenta.', 'Winston Churchill'),
(78, 'La mente es todo. Lo que piensas, te conviertes.', 'Buda'),
(79, 'Todo lo que necesitas está ya dentro de ti.', 'Proverbio'),
(80, 'Atrévete a vivir la vida que siempre has querido.', 'Oprah Winfrey'),
(81, 'No podemos ayudar a todos, pero todos pueden ayudar a alguien.', 'Ronald Reagan'),
(82, 'El secreto es rodearte de personas que te eleven.', 'Oprah Winfrey'),
(83, 'La alegría es la emoción de nuestro crecimiento.', 'Tony Robbins'),
(84, 'La perseverancia es el trabajo duro que haces después de cansarte del trabajo duro que ya hiciste.', 'Newt Gingrich'),
(85, 'La confianza en uno mismo es el primer secreto del éxito.', 'Ralph Waldo Emerson'),
(86, 'El cambio es la ley de la vida. Y aquellos que solo miran al pasado o al presente, se perderán el futuro.', 'J. Kennedy'),
(87, 'No se trata de dónde vienes, sino de a dónde vas.', 'Ella Fitzgerald'),
(88, 'Si no luchas por lo que quieres, nadie lo hará por ti.', 'Anónimo'),
(89, 'La verdadera felicidad está en el trabajo bien hecho.', 'Anónimo'),
(90, 'La humildad te hace aprender; la arrogancia te hace perder.', 'Anónimo'),
(91, 'El camino hacia el éxito está siempre en construcción.', 'Lily Tomlin'),
(92, 'El tiempo es limitado, no lo desperdicies viviendo la vida de otro.', 'Steve Jobs'),
(93, 'La mejor manera de apreciarte a ti mismo es empezar a actuar.', 'Anónimo'),
(94, 'La vida se encoge o se expande en proporción al valor de uno.', 'Anaïs Nin'),
(95, 'La clave para la creatividad es saber cómo ocultar tus fuentes.', 'Albert Einstein'),
(96, 'El futuro te pertenece si tienes fe en tu visión.', 'Anónimo'),
(97, 'El optimismo es la fe que conduce al logro.', 'Helen Keller'),
(98, 'La calidad es mucho mejor que la cantidad.', 'Steve Jobs'),
(99, 'La única fuente de conocimiento es la experiencia.', 'Albert Einstein'),
(100, 'Acepta la responsabilidad de tu vida. Reconoce que eres tú quien te llevará a donde quieres ir.', 'Les Brown'),
(101, 'La mente es un laboratorio, la vida es un experimento.', 'Anónimo'),
(102, 'El propósito es la brújula interna que guía tu camino.', 'Anónimo'),
(103, 'Cada momento es un nuevo comienzo.', 'T.S. Eliot'),
(104, 'diego y eduar se aman', 'el negro.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipio`
--

CREATE TABLE `municipio` (
  `id_municipio` int(11) NOT NULL,
  `nombre_municipio` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `municipio`
--

INSERT INTO `municipio` (`id_municipio`, `nombre_municipio`) VALUES
(1, 'Escuque'),
(2, 'Rafael Rangel');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `olt`
--

CREATE TABLE `olt` (
  `id_olt` int(11) NOT NULL,
  `nombre_olt` varchar(100) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `olt`
--

INSERT INTO `olt` (`id_olt`, `nombre_olt`, `marca`, `modelo`, `descripcion`) VALUES
(1, 'OLT Sabana Libre', 'V-SOL', '000000', 'Sabana Libre'),
(2, 'OLT Rafael Rangel', 'V-SOL', '000000', 'Rafael rangel'),
(3, 'OLT Colinas De Carmania', 'V-SOL', '000000', 'Colinas de Carmania ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `olt_parroquia`
--

CREATE TABLE `olt_parroquia` (
  `olt_id` int(11) NOT NULL,
  `parroquia_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `olt_parroquia`
--

INSERT INTO `olt_parroquia` (`olt_id`, `parroquia_id`) VALUES
(1, 2),
(1, 4),
(1, 5),
(1, 7),
(1, 8),
(2, 3),
(2, 4),
(2, 6),
(3, 1),
(3, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parroquia`
--

CREATE TABLE `parroquia` (
  `id_parroquia` int(11) NOT NULL,
  `nombre_parroquia` varchar(100) NOT NULL,
  `id_municipio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `parroquia`
--

INSERT INTO `parroquia` (`id_parroquia`, `nombre_parroquia`, `id_municipio`) VALUES
(1, 'Escuque', 1),
(2, 'Sabana Libre', 1),
(3, 'Jose Gregorio Hernandez', 2),
(4, 'La Union', 1),
(5, 'Santa Rita ', 1),
(6, 'Betijoque', 2),
(7, 'El Alto', 1),
(8, 'Juan Díaz', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planes`
--

CREATE TABLE `planes` (
  `id_plan` int(11) NOT NULL,
  `nombre_plan` varchar(255) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `planes`
--

INSERT INTO `planes` (`id_plan`, `nombre_plan`, `monto`, `descripcion`) VALUES
(1, 'Gala_650MBPS', 25.00, '650mbps ftth'),
(2, 'Gala_20MBPS', 23.20, '20mbps via radio'),
(3, 'Gala_250MBPS', 23.20, '250mbps ftth'),
(4, 'Gala_150MBPS', 17.50, '150mbps ftth plan preferencial'),
(5, 'Gala_100MBPS', 11.60, '100mbps ftth plan preferencial'),
(6, 'Gala_850MBPS', 35.00, '850mbps ftth'),
(7, 'Gala_1GBPS', 48.00, '1gbps ftth'),
(8, 'Gala_Exonerado', 0.00, 'exonerado global');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pon`
--

CREATE TABLE `pon` (
  `id_pon` int(11) NOT NULL,
  `nombre_pon` varchar(50) NOT NULL,
  `id_olt` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pon`
--

INSERT INTO `pon` (`id_pon`, `nombre_pon`, `id_olt`, `descripcion`) VALUES
(2, 'pon1', 1, 'sdfsdf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `usuario` varchar(100) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `nombre_completo` varchar(150) DEFAULT NULL,
  `rol` enum('Administrador','Operador') NOT NULL DEFAULT 'Operador'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `usuario`, `clave`, `nombre_completo`, `rol`) VALUES
(1, 'admin', '$2y$10$sxkYkCn1.1rN67tEhRwxKe7RA2H0nOmawAOFhj964u55QWlXDHzZu', 'Administrador Principal', 'Administrador'),
(6, 'adrian123', '$2y$10$SYiHYf5jHwsM5Bgs8Hpjou/MKfI3GUUzhrSogmi2KgGUvfhl519ca', 'Adrian Ramirez', 'Operador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `id_vendedor` int(11) NOT NULL,
  `nombre_vendedor` varchar(100) NOT NULL,
  `telefono_vendedor` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`id_vendedor`, `nombre_vendedor`, `telefono_vendedor`) VALUES
(1, 'Roberto', '+58 4264689848'),
(2, 'Oficina', '0424-123456789');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bancos`
--
ALTER TABLE `bancos`
  ADD PRIMARY KEY (`id_banco`);

--
-- Indices de la tabla `cobros_manuales_historial`
--
ALTER TABLE `cobros_manuales_historial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cobro_cxc` (`id_cobro_cxc`);

--
-- Indices de la tabla `comunidad`
--
ALTER TABLE `comunidad`
  ADD PRIMARY KEY (`id_comunidad`),
  ADD KEY `fk_comunidad_parroquia` (`id_parroquia`);

--
-- Indices de la tabla `contratos`
--
ALTER TABLE `contratos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ip` (`ip`),
  ADD KEY `fk_contrato_municipio` (`id_municipio`),
  ADD KEY `fk_contrato_parroquia` (`id_parroquia`),
  ADD KEY `fk_contrato_plan` (`id_plan`),
  ADD KEY `fk_contrato_vendedor` (`id_vendedor`),
  ADD KEY `id_olt` (`id_olt`),
  ADD KEY `id_pon` (`id_pon`),
  ADD KEY `id_comunidad` (`id_comunidad`);

--
-- Indices de la tabla `cuentas_por_cobrar`
--
ALTER TABLE `cuentas_por_cobrar`
  ADD PRIMARY KEY (`id_cobro`),
  ADD KEY `id_contrato` (`id_contrato`),
  ADD KEY `fk_cobro_plan` (`id_plan_cobrado`);

--
-- Indices de la tabla `frases_motivacionales`
--
ALTER TABLE `frases_motivacionales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `municipio`
--
ALTER TABLE `municipio`
  ADD PRIMARY KEY (`id_municipio`),
  ADD UNIQUE KEY `nombre_municipio` (`nombre_municipio`);

--
-- Indices de la tabla `olt`
--
ALTER TABLE `olt`
  ADD PRIMARY KEY (`id_olt`),
  ADD UNIQUE KEY `nombre_olt` (`nombre_olt`);

--
-- Indices de la tabla `olt_parroquia`
--
ALTER TABLE `olt_parroquia`
  ADD PRIMARY KEY (`olt_id`,`parroquia_id`),
  ADD KEY `parroquia_id` (`parroquia_id`);

--
-- Indices de la tabla `parroquia`
--
ALTER TABLE `parroquia`
  ADD PRIMARY KEY (`id_parroquia`),
  ADD KEY `id_municipio` (`id_municipio`);

--
-- Indices de la tabla `planes`
--
ALTER TABLE `planes`
  ADD PRIMARY KEY (`id_plan`);

--
-- Indices de la tabla `pon`
--
ALTER TABLE `pon`
  ADD PRIMARY KEY (`id_pon`),
  ADD KEY `idx_pon_olt` (`id_olt`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- Indices de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD PRIMARY KEY (`id_vendedor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bancos`
--
ALTER TABLE `bancos`
  MODIFY `id_banco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cobros_manuales_historial`
--
ALTER TABLE `cobros_manuales_historial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comunidad`
--
ALTER TABLE `comunidad`
  MODIFY `id_comunidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `contratos`
--
ALTER TABLE `contratos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1650;

--
-- AUTO_INCREMENT de la tabla `cuentas_por_cobrar`
--
ALTER TABLE `cuentas_por_cobrar`
  MODIFY `id_cobro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `frases_motivacionales`
--
ALTER TABLE `frases_motivacionales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT de la tabla `municipio`
--
ALTER TABLE `municipio`
  MODIFY `id_municipio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `parroquia`
--
ALTER TABLE `parroquia`
  MODIFY `id_parroquia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `planes`
--
ALTER TABLE `planes`
  MODIFY `id_plan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `pon`
--
ALTER TABLE `pon`
  MODIFY `id_pon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cobros_manuales_historial`
--
ALTER TABLE `cobros_manuales_historial`
  ADD CONSTRAINT `cobros_manuales_historial_ibfk_1` FOREIGN KEY (`id_cobro_cxc`) REFERENCES `cuentas_por_cobrar` (`id_cobro`);

--
-- Filtros para la tabla `comunidad`
--
ALTER TABLE `comunidad`
  ADD CONSTRAINT `fk_comunidad_parroquia` FOREIGN KEY (`id_parroquia`) REFERENCES `parroquia` (`id_parroquia`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `contratos`
--
ALTER TABLE `contratos`
  ADD CONSTRAINT `fk_contrato_municipio` FOREIGN KEY (`id_municipio`) REFERENCES `municipio` (`id_municipio`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_contrato_parroquia` FOREIGN KEY (`id_parroquia`) REFERENCES `parroquia` (`id_parroquia`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_contrato_plan` FOREIGN KEY (`id_plan`) REFERENCES `planes` (`id_plan`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_contrato_vendedor` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedores` (`id_vendedor`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `cuentas_por_cobrar`
--
ALTER TABLE `cuentas_por_cobrar`
  ADD CONSTRAINT `cuentas_por_cobrar_ibfk_1` FOREIGN KEY (`id_contrato`) REFERENCES `contratos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `olt_parroquia`
--
ALTER TABLE `olt_parroquia`
  ADD CONSTRAINT `olt_parroquia_ibfk_1` FOREIGN KEY (`olt_id`) REFERENCES `olt` (`id_olt`) ON DELETE CASCADE,
  ADD CONSTRAINT `olt_parroquia_ibfk_2` FOREIGN KEY (`parroquia_id`) REFERENCES `parroquia` (`id_parroquia`) ON DELETE CASCADE;

--
-- Filtros para la tabla `parroquia`
--
ALTER TABLE `parroquia`
  ADD CONSTRAINT `parroquia_ibfk_1` FOREIGN KEY (`id_municipio`) REFERENCES `municipio` (`id_municipio`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pon`
--
ALTER TABLE `pon`
  ADD CONSTRAINT `fk_pon_olt` FOREIGN KEY (`id_olt`) REFERENCES `olt` (`id_olt`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
