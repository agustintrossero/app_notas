/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

drop database if exists app_notas_db;
create database app_notas_db;
use app_notas_db;

drop table if exists usuarios;
create table  usuarios(
id int primary key NOT NULL AUTO_INCREMENT,
nombre VARCHAR(10) not null COLLATE utf8_unicode_ci,
apellido VARCHAR(10) not null COLLATE utf8_unicode_ci,
email VARCHAR(20) unique not null COLLATE utf8_unicode_ci
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES usuarios write;
/*!40000 ALTER TABLE usuarios DISABLE KEYS */;
INSERT INTO usuarios (nombre, apellido, email)
VALUES ('Anne-corinne', 'McLennan', 'amclennan0@webmd.com'),
('Birgitta', 'Swinfon', 'bswinfon1@yahoo.com'),
('Audrie', 'Sorby', 'asorby2@stanford.edu'),
('Baillie', 'Chillingsworth', 'bchillingsworth3@shutterfly.com'),
('Elden', 'Legan', 'elegan4@unc.edu'),
('Jemmy', 'Greetland', 'jgreetland5@youtube.com'),
('Oralla', 'Caudell', 'ocaudell6@princeton.edu'),
('Raynor', 'Riordan', 'rriordan7@usatoday.com'),
('Ruttger', 'Franceschelli', 'rfranceschelli8@people.com.cn'),
('Janos', 'Scambler', 'jscambler9@hao123.com');
/*!40000 ALTER TABLE usuarios ENABLE KEYS */;
UNLOCK TABLES;

drop table if exists notas ;
create table notas(
id int primary key NOT NULL AUTO_INCREMENT,
titulo VARCHAR(100) not null COLLATE utf8_unicode_ci,
fecha_creacion timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, 
fecha_ultima_modificacion timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
descripcion text not null COLLATE utf8_unicode_ci,
se_puede_eliminar tinyint default 1,
categorias int not null,
id_usuario int not null,
key notas_categorias_nota_categoria_id_foreign (categorias),
key notas_id_usuario_id_foreign  (id_usuario),
constraint notas_categorias_nota_categoria_id_foreign  foreign key (categorias) references nota_categoria(id),
constraint notas_id_usuario_id_foreign  foreign key (id_usuario) references usuarios(id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES notas write;
/*!40000 ALTER TABLE notas  DISABLE KEYS */;
INSERT into notas(titulo, fecha_creacion, fecha_ultima_modificacion, descripcion, categorias, id_usuario)
values ('Toxostoma curvirostre', '2014-06-01 22:06:23', '2019-08-26 06:24:49', 'Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.',1,10),
('Chionis alba', '2014-11-03 22:49:16', '2019-12-27 23:40:27', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.',2,9),
('Phalacrocorax carbo', '2014-02-11 04:23:53', '2020-03-06 07:45:06', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',3,8),
('Deroptyus accipitrinus', '2014-01-09 16:16:54', '2019-05-13 02:50:04', 'Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus.',4,7),
('Pitangus sulphuratus', '2014-08-31 04:06:41', '2020-01-22 02:27:58', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',5,6),
('Macropus rufus', '2014-09-21 11:44:40', '2019-05-13 14:50:11', 'Aenean sit amet justo.',6,5),
('Gymnorhina tibicen', '2014-04-20 04:54:40', '2019-10-06 12:03:54', 'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.',7,4),
('Pseudocheirus peregrinus', '2014-12-06 06:52:25', '2019-10-21 01:45:36', 'Nullam sit amet turpis elementum ligula vehicula consequat.',8,3),
('Alcelaphus buselaphus caama', '2014-08-11 18:43:59', '2020-01-25 07:22:05', 'Maecenas pulvinar lobortis est. Phasellus sit amet erat. Nulla tempus.',9,2),
('Eira barbata', '2014-09-21 11:44:17', '2019-07-06 00:08:08', 'Ut tellus. Nulla ut erat id mauris vulputate elementum.',10,1);
/*!40000 ALTER TABLE notas ENABLE KEYS */;
UNLOCK TABLES;

drop table if exists gestiones;
create table gestiones(
id int primary key NOT NULL AUTO_INCREMENT,
id_usuario int not null,
id_nota int not null,
gestion enum('creación','modificacion','eliminación') NOT NULL,
fecha_de_gestion timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
key gestiones_id_usuario_usuarios_id_foreign (id_usuario),
key gestiones_id_nota_notas_id (id_nota),
constraint gestiones_id_usuario_usuarios_id_foreign foreign key (id_usuario) references usuarios (id),
constraint gestiones_id_nota_notas_id foreign key (id_nota) references notas(id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES gestiones write;
/*!40000 ALTER TABLE gestiones  DISABLE KEYS */;
insert into gestiones (id_usuario, id_nota, gestion, fecha_de_gestion )
values (10,1,'eliminación', '2020-04-20 04:54:40'),    
(8,3,'creación', '2019-05-13 14:50:11'),
(7,4,'eliminación', '2019-12-06 06:52:25'),
(6,5,'eliminación', '2019-08-11 18:43:59'),
(5,6,'modificacion', '2020-01-25 07:22:05'),
(4,7,'modificacion', '2019-07-06 00:08:08'),
(3,8,'creación', '2019-09-21 11:44:17'),
(2,9,'creación', '2019-11-05 10:42:02'),
(1,10,'modificacion', '2019-06-01 22:06:23');
/*!40000 ALTER TABLE gestiones ENABLE KEYS */;
UNLOCK TABLES;


drop table if exists nota_categoria;
create table nota_categoria(
id int primary key NOT NULL auto_increment,
id_categoria int not null,
id_nota int not null,
key nota_categoria_id_categoria_categorias_id (id_categoria),
key nota_categoria_id_nota_notas_id (id_nota),
constraint nota_categoria_id_categoria_categorias_id foreign key (id_categoria) references categorias(id),
constraint nota_categoria_id_nota_notas_id foreign key (id_nota) references notas(id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES  nota_categoria write;
/*!40000 ALTER TABLE  nota_categoria  DISABLE KEYS */;
insert into nota_categoria (id_categoria, id_nota)
values (1,3),(2,4),(3,5),(4,6),(5,7),(6,8),(7,9),(8,10),(9,1),(10,2);
/*!40000 ALTER TABLE nota_categoria ENABLE KEYS */;
UNLOCK TABLES;

drop table if exists categorias;
create table categorias(
id int primary key NOT NULL AUTO_INCREMENT,
nombre VARCHAR(20) not null COLLATE utf8_unicode_ci
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES  categorias write;
/*!40000 ALTER TABLE  categorias  DISABLE KEYS */;
insert into categorias (nombre)
values ('Masonry Precast'),
('Hard Tile Stone'),
('Misc Steel (Fabrication)'),
('Masonry'),
('Masonry Ort'),
('Structural and Misc Steel (Fabrication)'),
('Roofing (Metal)'),
('Rockng rol'),
('Rooting Styles'),
('Masonry Precast');
/*!40000 ALTER TABLE categorias ENABLE KEYS */;
UNLOCK TABLES;