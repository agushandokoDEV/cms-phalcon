/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : bp_cms

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2018-03-19 16:44:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_setting
-- ----------------------------
DROP TABLE IF EXISTS `app_setting`;
CREATE TABLE `app_setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `apps_title` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of app_setting
-- ----------------------------

-- ----------------------------
-- Table structure for app_template
-- ----------------------------
DROP TABLE IF EXISTS `app_template`;
CREATE TABLE `app_template` (
  `template_name` varchar(50) NOT NULL,
  `template` varchar(50) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`template_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of app_template
-- ----------------------------
INSERT INTO `app_template` VALUES ('default', 'default', '1');

-- ----------------------------
-- Table structure for c_comment_post
-- ----------------------------
DROP TABLE IF EXISTS `c_comment_post`;
CREATE TABLE `c_comment_post` (
  `comment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) DEFAULT NULL,
  `comment_date` datetime DEFAULT NULL,
  `ip_addr` varchar(50) DEFAULT NULL,
  `comment_post` text,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of c_comment_post
-- ----------------------------

-- ----------------------------
-- Table structure for c_media
-- ----------------------------
DROP TABLE IF EXISTS `c_media`;
CREATE TABLE `c_media` (
  `media_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `media_type` varchar(50) DEFAULT NULL,
  `media_name` varchar(200) DEFAULT NULL,
  `media_author` varchar(50) DEFAULT NULL,
  `media_date` datetime DEFAULT NULL,
  `media_path` varchar(255) DEFAULT NULL,
  `file_size` varchar(30) DEFAULT NULL,
  `file_extension` varchar(10) DEFAULT NULL,
  `media_caption` text,
  `album_id` int(11) DEFAULT NULL,
  `media_guide` varchar(255) DEFAULT NULL,
  `video_duration` varchar(50) DEFAULT NULL,
  `video_cover` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`media_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of c_media
-- ----------------------------
INSERT INTO `c_media` VALUES ('1', 'image', 'Perkenalan-Phalcon-Tutorial-phalcon.png', 'myadmin', '2018-03-11 11:39:44', '/multimedia/image/20180311/225x120/225x120_20180311113943perkenalan-phalcon-tutorial-phalcon.png', '31.80 KB', 'png', 'phalcon', '13', '20180311113943perkenalan-phalcon-tutorial-phalcon.png', null, null);
INSERT INTO `c_media` VALUES ('2', 'image', 'Chrysanthemum.jpg', 'myadmin', '2018-03-18 22:22:27', '/multimedia/image/20180318/225x120/225x120_20180318222226chrysanthemum.jpg', '858.78 KB', 'jpg', 'tes', '13', '20180318222226chrysanthemum.jpg', null, null);
INSERT INTO `c_media` VALUES ('3', 'image', 'Desert  asas.jpg', 'myadmin', '2018-03-18 22:22:43', '/multimedia/image/20180318/225x120/225x120_20180318222242desert__asas.jpg', '826.11 KB', 'jpg', 'testing', '13', '20180318222242desert__asas.jpg', null, null);

-- ----------------------------
-- Table structure for c_post
-- ----------------------------
DROP TABLE IF EXISTS `c_post`;
CREATE TABLE `c_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `post_author` varchar(50) DEFAULT NULL,
  `post_title` text,
  `post_content` longtext,
  `post_status` enum('publish','draft','autosave') DEFAULT NULL,
  `post_slug` varchar(200) DEFAULT NULL,
  `post_type` varchar(100) DEFAULT NULL,
  `post_create` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `post_modified` datetime DEFAULT NULL,
  `post_modified_by` varchar(50) DEFAULT NULL,
  `menu_order` int(11) DEFAULT '0',
  `post_cover` int(11) DEFAULT NULL,
  `post_comment_status` tinyint(4) DEFAULT '1',
  `publish_on` datetime DEFAULT NULL,
  `post_language` enum('en','id') DEFAULT 'id' COMMENT 'id = indonesia, en=inggris',
  `post_parent` bigint(20) DEFAULT '0',
  `visibility` enum('public','private') DEFAULT 'public',
  `post_relation_lang` bigint(20) DEFAULT NULL,
  `post_reference` text,
  `event_location_name` varchar(255) DEFAULT NULL,
  `event_location_addres` text,
  `event_date_start` datetime DEFAULT NULL,
  `event_date_end` datetime DEFAULT NULL,
  `event_location_long` varchar(50) DEFAULT NULL,
  `event_location_lat` varchar(50) DEFAULT NULL,
  `post_category` varchar(100) DEFAULT NULL,
  `post_reminder` enum('Y','N') DEFAULT 'N',
  `publish_schedule` datetime DEFAULT NULL,
  `custom_url` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`post_id`),
  FULLTEXT KEY `post_reference` (`post_reference`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of c_post
-- ----------------------------
INSERT INTO `c_post` VALUES ('3', 'myadmin', 'page 2', '', 'publish', 'page-2', 'page', '2018-03-09 15:33:47', '2018-03-10 23:23:56', 'myadmin', '1', null, '1', '2018-03-09 15:33:54', 'id', '0', 'public', null, null, '', '', null, null, '', '', '', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('4', 'myadmin', 'Page 1', '', 'publish', 'page-1', 'page', '2018-03-09 16:53:57', '2018-03-10 23:24:03', 'myadmin', '0', null, '1', '2018-03-09 16:54:08', 'id', '0', 'public', null, null, '', '', null, null, '', '', '', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('5', 'myadmin', 'Index Tutorial Belajar PHP Duniailkom', '<p><strong>PHP</strong>&nbsp;merupakan bahasa wajib programmer web. Sampai saat ini PHP masih menjadi standar bahasa pemograman server side untuk pembuatan website. Duniailkom mencoba membuat artikel dan tutorial sebagai bahan belajar PHP untuk pemula. Tutorial PHP akan dibagi menjadi beberapa bagian, yaitu&nbsp;<strong>Tutorial PHP Dasar</strong>,&nbsp;<strong>Tutorial PHP Lanjutan</strong>,<strong>&nbsp;Tutorial Pemrograman Berbasis Objek PHP</strong>&nbsp;<em>(Object Oriented Programming &ndash; OOP)</em>, dan Artikel seputar perkembangan PHP.</p>\r\n<p><a href=\"https://www.duniailkom.com/tutorial-belajar-php-dan-index-artikel-php/#phpdasar\">Tutorial PHP dasar&nbsp;</a>ditujukan untuk pengguna awam atau pemula yang ingin mempelajari PHP dari dasar. Tutorial belajar PHP ini disusun secara sistematis. Pembahasan akan dimulai dari pengertian PHP, sejarah PHP, cara instalasi XAMPP yang digunakan untuk menjalankan PHP, selanjutnya masuk kepada cara penulisan dasar PHP seperti tipe data, perulangan, struktur logika, serta cara penggunaan fungsi PHP.</p>\r\n<p><a href=\"https://www.duniailkom.com/tutorial-belajar-php-dan-index-artikel-php/#phpfungsibawaan\">Tutorial Fungsi Bawaan PHP&nbsp;</a>Berisi pembahasan mengenai fungsi-fungsi (function) bawaan PHP. PHP menyediakan ribuan fungsi bawaan yang bisa kita gunakan.</p>\r\n<p><a href=\"https://www.duniailkom.com/tutorial-belajar-php-dan-index-artikel-php/#phpmysql\">Tutorial PHP MySQL&nbsp;</a>akan membahas tentang cara menghubungkan PHP dengan database MySQL. 3 cara koneksi PHP ke MySQL: mysql extension, mysqli extension dan PDO akan kita bahas secara detail.</p>\r\n<p><a href=\"https://www.duniailkom.com/tutorial-belajar-php-dan-index-artikel-php/#phpform\">Tutorial PHP Form</a>&nbsp;akan membahas tentang cara penanganan form HTML menggunakan PHP. Kita akan membahas cara penanganan method GET, POST, serta tentang aspek keamanannya.</p>\r\n<p><a href=\"https://www.duniailkom.com/tutorial-belajar-php-dan-index-artikel-php/#phpoop\">Tutorial Pemrograman Berbasis Objek (OOP) PHP</a>&nbsp;akan membahas tentang cara penulisan PHP menggunakan object, atau dikenal juga dengan Object Oriented Programming PHP. Pemrograman Berbasis Objek merupakan standar cara penulisan PHP modern.</p>\r\n<p><a href=\"https://www.duniailkom.com/tutorial-belajar-php-dan-index-artikel-php/#phpartikel\">Artikel PHP&nbsp;</a>akan membahas perkembangan PHP serta tips dan trik dalam membuat code PHP agar lebih efisien.</p>\r\n<p>&nbsp;</p>\r\n<p>sumber :&nbsp;<a href=\"https://www.duniailkom.com/tutorial-belajar-php-dan-index-artikel-php/\" target=\"_blank\" rel=\"noopener\">https://www.duniailkom.com/tutorial-belajar-php-dan-index-artikel-php/</a></p>', 'publish', 'index-tutorial-belajar-php-duniailkom', 'posting', '2018-03-10 17:39:52', '2018-03-10 23:02:34', 'myadmin', '0', null, '1', '2018-03-10 17:42:19', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('10', 'myadmin', 'Tutorial Belajar PHP Part 1: Pengertian dan Fungsi PHP dalam Pemrograman Web', '<h3>Pengertian PHP</h3>\r\n<p><strong>PHP</strong>&nbsp;adalah&nbsp;<em>bahasa pemrograman script server-side yang didesain untuk pengembangan web. Selain itu, PHP juga bisa digunakan sebagai bahasa pemrograman umum</em>&nbsp;(<a title=\"PHP - Wikipedia\" href=\"http://en.wikipedia.org/wiki/PHP\" target=\"_blank\" rel=\"noopener\">wikipedia</a>). PHP di kembangkan pada tahun 1995 oleh&nbsp;<strong>Rasmus Lerdorf</strong>, dan sekarang dikelola oleh&nbsp;<strong>The PHP Group</strong>. Situs resmi PHP beralamat di&nbsp;<a title=\"Situs Resmi PHP\" href=\"http://www.php.net/\" target=\"_blank\" rel=\"noopener\">http://www.php.net</a>.</p>\r\n<p>PHP disebut bahasa pemrograman&nbsp;<strong>server side</strong>&nbsp;karena PHP diproses pada komputer server. Hal ini berbeda dibandingkan dengan bahasa pemrograman client-side seperti JavaScript yang diproses pada web browser (client).</p>\r\n<p>Pada awalnya&nbsp;<strong>PHP</strong>&nbsp;merupakan singkatan dari&nbsp;<em><strong>Personal Home Page.</strong>&nbsp;</em>Sesuai dengan namanya, PHP digunakan untuk membuat website pribadi. Dalam beberapa tahun perkembangannya, PHP menjelma menjadi bahasa pemrograman web yang powerful dan tidak hanya digunakan untuk membuat halaman web sederhana, tetapi juga website populer yang digunakan oleh jutaan orang seperti wikipedia, wordpress, joomla, dll.</p>\r\n<p>Saat ini PHP adalah singkatan dari&nbsp;<strong>PHP: Hypertext Preprocessor</strong>, sebuah kepanjangan&nbsp;<em>rekursif</em>, yakni permainan kata dimana kepanjangannya terdiri dari singkatan itu sendiri:&nbsp;<strong>P</strong>HP<strong>: H</strong>ypertex<strong>t P</strong>reprocessor.</p>\r\n<p>PHP dapat digunakan dengan gratis (free) dan bersifat&nbsp;<em>Open Source</em>. PHP dirilis dalam lisensi&nbsp;<em>PHP License</em><strong>,</strong>&nbsp;sedikit berbeda dengan lisensi&nbsp;<em>GNU General Public License (GPL)</em>&nbsp;yang biasa digunakan untuk proyek&nbsp;<em>Open Source</em>.</p>\r\n<p>Kemudahan dan kepopuleran&nbsp;<strong>PHP</strong>&nbsp;sudah menjadi standar bagi programmer web di seluruh dunia. Menurut&nbsp;<a href=\"http://en.wikipedia.org/wiki/PHP#Use\" target=\"_blank\" rel=\"noopener\">wikipedia&nbsp;</a>pada februari 2014, sekitar 82% dari web server di dunia menggunakan PHP. PHP juga menjadi dasar dari&nbsp;<em>aplikasi CMS (Content Management System)</em>&nbsp;populer seperti&nbsp;<em>Joomla, Drupal,&nbsp;</em>dan<em>&nbsp;WordPress.</em></p>\r\n<p>Dikutip dari situs&nbsp;<a title=\"Market share Server Side Programming Language \" href=\"http://w3techs.com/technologies/overview/programming_language/allhttp://\" target=\"_blank\" rel=\"noopener\">w3techs.com</a>, (diakses pada 18 Desember 2014), berikut adalah market share penggunaan bahasa pemrograman server-side untuk mayoritas website di seluruh dunia :</p>\r\n<p><a class=\"cboxElement\" href=\"https://www.duniailkom.com/wp-content/uploads/2013/12/Market-Share-PHP.png\"><img class=\"aligncenter size-full wp-image-4257 colorbox-1604\" src=\"https://www.duniailkom.com/wp-content/uploads/2013/12/Market-Share-PHP.png\" sizes=\"(max-width: 522px) 100vw, 522px\" srcset=\"https://www.duniailkom.com/wp-content/uploads/2013/12/Market-Share-PHP.png 522w, https://www.duniailkom.com/wp-content/uploads/2013/12/Market-Share-PHP-150x86.png 150w, https://www.duniailkom.com/wp-content/uploads/2013/12/Market-Share-PHP-300x172.png 300w, https://www.duniailkom.com/wp-content/uploads/2013/12/Market-Share-PHP-254x146.png 254w, https://www.duniailkom.com/wp-content/uploads/2013/12/Market-Share-PHP-50x28.png 50w, https://www.duniailkom.com/wp-content/uploads/2013/12/Market-Share-PHP-190x110.png 190w, https://www.duniailkom.com/wp-content/uploads/2013/12/Market-Share-PHP-156x90.png 156w\" alt=\"Market Share PHP\" width=\"522\" height=\"300\"></a>Dapat dilihat dari tampilan diatas bahwa mayoritas website modern saat ini menggunakan PHP.</p>\r\n<hr>\r\n<h3>Fungsi PHP Dalam Pemrograman Web</h3>\r\n<p>Untuk membuat halaman web, sebenarnya PHP bukanlah bahasa pemrograman yang wajib digunakan. Kita bisa saja membuat website hanya menggunakan HTML saja. Web yang dihasilkan dengan HTML (dan CSS) ini dikenal dengan website statis, dimana konten dan halaman web bersifat tetap.</p>\r\n<p>Sebagai perbandingan, website dinamis yang bisa dibuat menggunakan PHP adalah situs web yang bisa menyesuaikan tampilan konten tergantung situasi. Website dinamis juga bisa menyimpan data ke dalam database, membuat halaman yang berubah-ubah sesuai input dari&nbsp;<em>user</em>, memproses form, dll.</p>\r\n<p>Untuk pembuatan web, kode&nbsp;<strong>PHP</strong>&nbsp;biasanya di sisipkan kedalam dokumen HTML. Karena fitur inilah PHP disebut juga sebagai&nbsp;<strong>Scripting Language</strong>&nbsp;atau bahasa pemrograman&nbsp;<strong>script</strong>.</p>\r\n<p>Sebagai contoh penggunaan PHP, misalkan kita ingin membuat list dari nomor 1 sampai nomor 10. Dengan menggunakan HTML murni, kita bisa membuatnya secara manual seperti kode berikut ini:</p>\r\n<pre class=\"language-markup\"><code>&lt;!DOCTYPE html&gt;\r\n&lt;html&gt;\r\n&lt;head&gt;\r\n&lt;title&gt;Contoh list dengan HTML&lt;/title&gt;\r\n&lt;/head&gt;\r\n&lt;body&gt;\r\n&lt;h2&gt;Daftar Absensi Mahasiswa&lt;/h2&gt;\r\n&lt;ol&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-1&lt;/li&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-2&lt;/li&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-3&lt;/li&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-4&lt;/li&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-5&lt;/li&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-6&lt;/li&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-7&lt;/li&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-8&lt;/li&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-9&lt;/li&gt;\r\n&lt;li&gt;Nama Mahasiswa ke-10&lt;/li&gt;\r\n&lt;/ol&gt;\r\n&lt;/body&gt;\r\n&lt;/html&gt;</code></pre>\r\n<p>Halaman HTML tersebut dapat dibuat dengan mudah dengan cara men-<em>copy-paste</em>&nbsp;tag&nbsp;<strong>&lt;li&gt;</strong>sebanyak 10 kali dan mengubah sedikit angka-angka no urut di belakangnya. Namun jika yang kita inginkan adalah menambahkan list tersebut menjadi 100 atau 1000 list, cara&nbsp;<em>copy-paste</em>tersebut menjadi tidak efektif.</p>\r\n<p>Jika menggunakan&nbsp;<strong>PHP</strong>, kita tinggal membuat perulangan&nbsp;<strong>for</strong>&nbsp;sebanyak 1000 kali dengan perintah yang lebih singkat seperti berikut ini:</p>\r\n<div>\r\n<pre class=\"language-markup\"><code>&lt;!DOCTYPE html&gt;\r\n&lt;html&gt;\r\n&lt;head&gt;\r\n&lt;title&gt;Contoh list dengan PHP&lt;/title&gt;\r\n&lt;/head&gt;\r\n&lt;body&gt;\r\n&lt;h2&gt;Daftar Absensi Mahasiswa&lt;/h2&gt;\r\n&lt;ol&gt;\r\n&lt;?php\r\nfor ($i= 1; $i &lt;= 1000; $i++) \r\n{\r\necho \"&lt;li&gt;Nama Mahasiswa ke-$i&lt;/li&gt;\";\r\n}\r\n?&gt;\r\n&lt;/ol\r\n&lt;/body&gt;\r\n&lt;/html&gt;\r\n</code></pre>\r\n<p><a class=\"cboxElement\" href=\"https://www.duniailkom.com/wp-content/uploads/2013/12/Contoh-Penggunaan-PHP-dalam-HTML.png\"><img class=\"aligncenter colorbox-1604\" src=\"https://www.duniailkom.com/wp-content/uploads/2013/12/Contoh-Penggunaan-PHP-dalam-HTML.png\" alt=\"Contoh Penggunaan PHP dalam HTML\" width=\"622\" height=\"358\"></a></p>\r\n<div class=\"code-block code-block-5\">sumber :&nbsp;<a href=\"https://www.duniailkom.com/pengertian-dan-fungsi-php-dalam-pemograman-web/\" target=\"_blank\" rel=\"noopener\">https://www.duniailkom.com/pengertian-dan-fungsi-php-dalam-pemograman-web/</a></div>\r\n</div>', 'publish', 'tutorial-belajar-php-part-1-pengertian-dan-fungsi-php-dalam-pemrograman-web', 'posting', '2018-03-10 18:03:16', '2018-03-10 23:02:26', 'myadmin', '0', null, '1', '2018-03-10 18:04:27', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('11', 'myadmin', 'Tutorial Belajar HTML Dasar Untuk Pemula', '<p><strong>HTML</strong>&nbsp;atau&nbsp;<em><strong>Hypertext Markup Language</strong></em>&nbsp;adalah dasar dari semua halaman web di internet. Jika anda ingin mempelajari cara membuat website, maka&nbsp;<a title=\"Tutorial Belajar HTML Dasar Untuk Pemula\" href=\"https://www.duniailkom.com/tutorial-belajar-html-dasar-untuk-pemula/\">Tutorial Belajar HTML Dasar Untuk Pemula</a>di duniailkom ini adalah langkah pertama anda.</p>\r\n<hr>\r\n<p>Duniailkom telah mempersiapkan 15 tutorial HTML dasar yang ditujukan untuk pemula yang ingin mempelajari HTML dari awal. Dalam tutorial ini kita akan mempelajari tentang pengertian HTML, cara membuat file HTML, berkenalan dengan tag dan atribut HTML, hingga membahas tag-tag penting HTML, seperti tag &lt;a&gt;, tag &lt;img&gt;, &lt;table&gt;, dan tag &lt;form&gt; HTML.</p>\r\n<p>Dalam mempelajari HTML, harap diingat bahwa HTML dirancang untuk membuat struktur dasar dari halaman web. Jika anda ingin merubah tampilan dari sebuah tag, misalnya ingin membuat&nbsp;<em>background</em>&nbsp;paragraf berwarna merah, atau ingin memberi efek bayangan pada gambar, sebaiknya menggunakan&nbsp;<a title=\"Tutorial Belajar CSS Dasar untuk Pemula\" href=\"https://www.duniailkom.com/tutorial-belajar-css-dasar/\">CSS</a>, bukan langsung dari HTML.</p>\r\n<p>Tutorial ini ditujukan sebagai tutorial singkat untuk membuat halaman web sederhana dengan cepat.</p>\r\n<div class=\"code-block code-block-4\">Pembahasan mendalam untuk topik topik yang lebih lengkap akan dipisahkan ke dalam Tutorial HTML Lanjutan, seperti Cara membuat menggunakan tabel, cara menformat text, cara membuat form, serta pembahasan khusus mengenai perkembangan terbaru dari HTML, yakni HTML5.</div>', 'publish', 'tutorial-belajar-html-dasar-untuk-pemula', 'posting', '2018-03-10 22:21:33', '2018-03-10 23:03:24', 'myadmin', '0', null, '1', '2018-03-10 22:23:15', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('12', 'myadmin', 'Belajar HTML Dasar Part 1: Pengertian HTML', '<h3>Pengertian HTML</h3>\r\n<p><strong>HTML</strong>&nbsp;adalah singkatan dari&nbsp;<strong>Hypertext Markup Language</strong>. Disebut&nbsp;<strong>hypertext</strong>&nbsp;karena di dalam HTML sebuah text biasa dapat berfungsi lain, kita dapat membuatnya menjadi&nbsp;<strong>link</strong>&nbsp;yang dapat berpindah dari satu halaman ke halaman lainnya hanya dengan meng-<em>klik</em>&nbsp;text tersebut. Kemampuan text inilah yang dinamakan&nbsp;<strong>hypertext</strong>, walaupun pada implementasinya nanti tidak hanya text yang dapat dijadikan&nbsp;<strong>link</strong>.</p>\r\n<p>Disebut&nbsp;<strong>Markup Language</strong>&nbsp;karena bahasa&nbsp;<strong>HTML</strong>&nbsp;menggunakan tanda (<em>mark</em>), untuk menandai bagian-bagian dari text. Misalnya, text yang berada di antara tanda tertentu akan menjadi tebal, dan jika berada di antara tanda lainnya akan tampak besar. Tanda ini di kenal sebagai HTML&nbsp;<strong>tag</strong>.</p>\r\n<p>Jika anda ingin melihat bagaimana sebenarnya HTML, silahkan klik kanan halaman ini, lalu pilih&nbsp;<em>View Page Source</em>&nbsp;(di&nbsp;<em>Browser Mozilla Firefox</em>&nbsp;atau&nbsp;<em>Google Chrome</em>). Akan tampil sebuah halaman baru yang merupakan kode&nbsp;<strong>HTML</strong>&nbsp;dari halaman ini.</p>\r\n<p>Jika anda merasa terintimidasi dengan kode-kode tersebut, anda tidak sendiri, saya juga mengalaminya. Namun, kita akan mempelajari sebagian besar kode-kode ini di&nbsp;<a title=\"Tutorial Belajar HTML dan Index Artikel HTML\" href=\"https://www.duniailkom.com/tutorial-belajar-html-dan-index-artikel-html/\"><strong>Tutorial Belajar HTML di duniailkom</strong></a>.</p>\r\n<p><a class=\"cboxElement\" href=\"https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2.jpg\"><img class=\"size-full wp-image-680 aligncenter colorbox-600\" title=\"Cara Melihat Source Code HTML\" src=\"https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2.jpg\" sizes=\"(max-width: 570px) 100vw, 570px\" srcset=\"https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2.jpg 570w, https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2-300x151.jpg 300w, https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2-260x131.jpg 260w, https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2-50x25.jpg 50w, https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2-526x265.jpg 526w, https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2-82x41.jpg 82w, https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2-98x50.jpg 98w, https://www.duniailkom.com/wp-content/uploads/2013/04/Belajar-HTML-Pengertian-HTML-2-178x90.jpg 178w\" alt=\"Cara Melihat Source Code HTML\" width=\"570\" height=\"288\"></a></p>\r\n<p><strong>HTML&nbsp;</strong>merupakan bahasa dasar pembuatan web. Disebut dasar karena dalam membuat web, jika hanya menggunakan&nbsp;<strong>HTML</strong>&nbsp;tampilan web terasa hambar. Terdapat banyak bahasa pemrograman web yang ditujukan untuk memanipulasi kode&nbsp;<strong>HTML</strong>, seperti&nbsp;<strong>Ja</strong><strong>v</strong><strong>aScript</strong>&nbsp;dan&nbsp;<strong>PHP</strong>. Akan tetapi sebelum anda belajar&nbsp;<strong>JavaScript</strong>&nbsp;maupun&nbsp;<strong>PHP</strong>, memahami HTML merupakan hal yang paling awal.</p>\r\n<div class=\"code-block code-block-4\"><ins class=\"adsbygoogle\" data-ad-client=\"ca-pub-4485409480112862\" data-ad-slot=\"9501700098\" data-ad-format=\"rectangle\" data-adsbygoogle-status=\"done\"><ins id=\"aswift_3_expand\"><ins id=\"aswift_3_anchor\"><iframe width=\"706\" height=\"280\" name=\"aswift_3\"></iframe></ins></ins></ins></div>\r\n<p><strong>HTML</strong>&nbsp;bukanlah&nbsp;bahasa pemrograman (<em>programming language</em>), tetapi bahasa&nbsp;<strong>markup</strong>&nbsp;(<em>markup language</em>), hal ini terdengar sedikit aneh, tapi jika anda telah mengenal bahasa pemrograman lain, dalam HTML tidak akan ditemukan struktur yang biasa di temukan dalam bahasa pemrograman seperti&nbsp;<em>IF, LOOP</em>, maupun&nbsp;<em>variabel</em>.&nbsp;<strong>HTML</strong>&nbsp;hanya sebuah bahasa struktur yang fungsinya untuk menandai bagian-bagian dari sebuah halaman.</p>\r\n<p>Selain&nbsp;<strong>HTML</strong>, dikenal juga&nbsp;<strong>xHTML</strong>&nbsp;yang merupakan singkatan dari&nbsp;<em>eXtensible Hypertext Markup Language</em>.&nbsp;<strong>xHTML</strong>&nbsp;merupakan versi lama dari&nbsp;<strong>HTML</strong>&nbsp;(sebelum era HTML5 seperti saat ini). xHTML menggunakan aturan penulisan yang lebih ketat. Jika anda menemukan artikel yang membahas xHTML, bisa disamakan dengan HTML, karena perbedaannya tidak terlalu banyak.<strong><br></strong></p>\r\n<h3>Versi terbaru HTML: HTML5</h3>\r\n<p>Saat ini versi terbaru dari HTML adalah HTML5. HTML5 berisi beberapa fitur baru, tapi tetap membawa mayoritas fitur dari versi HTML sebelumnya, yakni HTML 4 dan xHTML.</p>\r\n<p>File HTML harus dijalankan dari aplikasi web browser. Dalam tutorial belajar HTML dasar selanjutnya, kita akan membahas tentang<a href=\"https://www.duniailkom.com/belajar-html-mengenal-fungsi-browser/\">&nbsp;Fungsi Web Browser.</a></p>', 'publish', 'belajar-html-dasar-part-1-pengertian-html', 'posting', '2018-03-10 22:23:42', '2018-03-10 23:03:48', 'myadmin', '0', null, '1', '2018-03-10 22:24:22', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('13', 'myadmin', 'Belajar HTML Dasar Part 5: Pengertian Tag, Elemen, dan Atribut pada HTML', '<h3>Pengertian Tag dalam HTML</h3>\r\n<p>Sebagai sebuah bahasa markup,&nbsp;<strong>HTML</strong>&nbsp;membutuhkan cara untuk memberitahu web browser untuk apa fungsi sebuah text. Apakah text itu ditulis sebagai sebuah&nbsp;<em>paragraf, list</em>, atau sebagai&nbsp;<em>link.</em>&nbsp;Dalam&nbsp;<strong>HTML</strong>, tanda ini dikenal dengan istilah&nbsp;<strong>tag</strong>.</p>\r\n<p>Hampir semua tag di dalam&nbsp;<strong>HTML</strong>&nbsp;ditulis secara berpasangan, yakni&nbsp;<strong>tag pembuka</strong>&nbsp;dan&nbsp;<strong>tag penutup</strong>, dimana objek yang dikenai perintah tag berada di&nbsp;<strong><em>antara</em>&nbsp;</strong>tag pembuka dan tag penutup. Objek disini dapat berupa text, gambar, maupun video. Penulisan tag berada di antara&nbsp;<em>dua kurung siku: &ldquo;&lt;&rdquo;&nbsp;</em>dan<em>&nbsp;&ldquo;&gt;&rdquo;</em>.</p>\r\n<p>Berikut adalah format dasar penulisan tag HTML:</p>\r\n<pre class=\"language-markup\"><code>&lt;tag_pembuka&gt;objek yang dikenai perintah tag&lt;/tag_penutup&gt;</code></pre>\r\n<p>Sebagai contoh, perhatikan kode HTML berikut :</p>\r\n<pre class=\"language-markup\"><code>&lt;p&gt; Ini adalah sebuah paragraf &lt;/p&gt;</code></pre>\r\n<ul class=\"list list_tick\">\r\n<li><strong>&lt;p&gt;</strong>&nbsp;adalah tag pembuka, dalam contoh ini&nbsp;<em><strong>p</strong></em>&nbsp;adalah tag untuk&nbsp;<em>paragraf.</em></li>\r\n<li><strong>&lt;/p&gt;</strong>&nbsp;adalah tag penutup paragraf. Perbedaannya dengan tag pembuka terletak dari tanda&nbsp;<em>forward slash</em>&nbsp;(/)</li>\r\n</ul>\r\n<p>Jika lupa memberikan penutup tag, umumnya browser akan &ldquo;<em>memaafkan</em>&rdquo; kesalahan ini dan tetap menampilkan hasilnya seolah-olah kita menuliskan tag penutup. Walaupun ini sepertinya memudahkan, tidak jarang malah bikin bingung.</p>\r\n<p>Sebagai contoh lain, jika ingin membuat suatu text dalam sebuah paragraf yang di tulis tebal atau miring, di dalam&nbsp;<strong>HTML</strong>&nbsp;dapat ditulis sebagai berikut:</p>\r\n<pre class=\"language-markup\"><code>&lt;p&gt;Ini adalah sebuah paragraf. &lt;i&gt;Hanya kumpulan beberapa kalimat&lt;/i&gt;. \r\nParagraf ini terdiri dari &lt;b&gt;3 kalimat&lt;/b&gt;&lt;/p&gt;.</code></pre>\r\n<p>Hasil dari kode&nbsp;<strong>HTML</strong>&nbsp;diatas, diterjemahkan oleh browser menjadi:</p>\r\n<p>&ldquo;Ini adalah sebuah paragraf.&nbsp;<em>Tidak lain dari kumpulan beberapa kalimat</em>. Paragraf ini terdiri dari&nbsp;<strong>3 kalimat</strong>.&rdquo;</p>\r\n<p>Tag&nbsp;<strong>&lt;i&gt;</strong>&nbsp;pada kode&nbsp;<strong>HTML</strong>&nbsp;diatas memberikan perintah kepada browser untuk menampilkan text secara garis miring (i, singkatan dari&nbsp;<strong><em>italic</em></strong>), dan tag&nbsp;<strong>&lt;b&gt;</strong>&nbsp;untuk menebalkan tulisan (b, singkatan dari&nbsp;<strong><em>bold</em></strong>).</p>\r\n<h3>Pengertian Element dalam HTML</h3>\r\n<p><strong>Element</strong>&nbsp;adalah isi dari tag yang berada&nbsp;diantara&nbsp;tag pembuka dan tag penutup, termasuk tag itu sendiri dan atribut yang dimilikinya (jika ada). Sebagai contoh perhatikan kode HTML berikut:</p>\r\n<pre class=\"language-markup\"><code>&lt;p&gt; Ini adalah sebuah paragraf &lt;/p&gt;</code></pre>\r\n<p>Pada contoh diatas, &ldquo;&lt;p&gt;Ini adalah sebuah paragraf&lt;/p&gt;&rdquo; merupakan&nbsp;<strong>element</strong>&nbsp;<strong>p</strong>.</p>\r\n<p>Element tidak hanya berisi text, namun juga bisa tag lain.</p>\r\n<p>Contoh:</p>\r\n<pre class=\"language-markup\"><code>&lt;p&gt; Ini adalah sebuah &lt;em&gt;paragraf&lt;/em&gt; &lt;/p&gt;</code></pre>\r\n<h3>Pengertian Atribut dalam HTML</h3>\r\n<p><strong>Atribut</strong>&nbsp;adalah informasi tambahan yang diberikan kepada&nbsp;<em>tag</em>. Informasi ini bisa berupa instruksi untuk warna dari text, besar huruf dari text, dll. Setiap atribut memiliki pasangan&nbsp;<strong>nama</strong>&nbsp;dan&nbsp;<strong>nilai</strong>(<em>value</em>) yang ditulis dengan&nbsp;<strong>name=&rdquo;value&rdquo;</strong>. Value diapit tanda kutip, boleh menggunakan tanda kutip satu (&lsquo;) atau dua (&ldquo;).</p>\r\n<pre class=\"language-markup\"><code>&lt;a href=\"https://www.duniailkom.com\"&gt;ini adalah sebuah link&lt;/a&gt;</code></pre>\r\n<p>Pada kode HTML diatas,<em><strong>&nbsp;href=&rdquo;https://www.duniailkom.com&rdquo;&nbsp;</strong></em>adalah<strong>&nbsp;atribut. href</strong>&nbsp;merupakan&nbsp;<em>nama dari atribut</em>, dan&nbsp;<em>https://www.duniailkom.com</em>&nbsp;adalah&nbsp;<em>value</em>&nbsp;atau nilai dari atribut tersebut.</p>\r\n<p>Tidak semua tag membutuhkan atribut, tapi anda akan sering melihat sebuah tag dengan atribut, terutama atribut&nbsp;<strong>id</strong>&nbsp;dan&nbsp;<strong>class</strong>&nbsp;yang sering digunakan untuk manipulasi halaman web menggunakan&nbsp;<a title=\"Tutorial Belajar CSS Dasar untuk Pemula\" href=\"https://www.duniailkom.com/tutorial-belajar-css-dasar/\">CSS&nbsp;</a>maupun&nbsp;<a title=\"Tutorial Belajar JavaScript Dasar Untuk Pemula\" href=\"https://www.duniailkom.com/tutorial-belajar-javascript-dasar-untuk-pemula/\">JavaScript</a>.</p>\r\n<p>HTML memiliki banyak atribut yang beberapa diantaranya hanya cocok untuk tag tertentu saja. Sebagai contoh, atribut &ldquo;<em><strong>href</strong></em>&rdquo; diatas hanya digunakan untuk tag&nbsp;<em><strong>&lt;a</strong></em>&gt; saja (dan beberapa tag lain). Penjelasan tentang tujuan dan pengertian dari atribut seperti href ini akan kita bahas pada tutorial-tutorial selanjutnya.</p>\r\n<p>Pada tutorial kali ini, kita telah mempelajari salah satu aspek terpenting di dalam HTML, yakni&nbsp;<a title=\"Belajar HTML Dasar: Pengertian Tag, Elemen, dan Atribut pada HTML\" href=\"https://www.duniailkom.com/belajar-html-pengertian-tag-elemen-dan-atribut-pada-html/\">Pengertian Tag, Elemen, dan Atribut pada HTML</a>. Dalam tutorial HTML dasar selanjutnya, kita akan mempelajari tentang&nbsp;<a href=\"https://www.duniailkom.com/belajar-html-mengenal-struktur-dasar-html/\">Struktur Dasar Halaman HTML</a>.</p>', 'publish', 'belajar-html-dasar-part-5-pengertian-tag-elemen-dan-atribut-pada-html', 'posting', '2018-03-10 22:25:43', '2018-03-10 23:03:39', 'myadmin', '0', null, '1', '2018-03-10 22:29:05', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('14', 'myadmin', 'Tutorial Belajar CSS Part 1: Pengertian CSS, Apa yang dimaksud dengan CSS?', '<h3>Pengertian CSS</h3>\r\n<p>Dalam bahasa bakunya, seperti di kutip dari&nbsp;<a href=\"http://en.wikipedia.org/wiki/Cascading_Style_Sheets\">wikipedia</a>,&nbsp;<strong>CSS</strong>&nbsp;<strong>adalah</strong>&nbsp;&ldquo;<em>kumpulan kode yang digunakan untuk mendefenisikan desain dari bahasa markup&rdquo; ,&nbsp;</em>dimana bahasa markup ini&nbsp;salah satunya adalah&nbsp;<strong>HTML</strong>.</p>\r\n<p>Untuk pengertian bebasnya,&nbsp;<strong>CSS adalah</strong>&nbsp;kumpulan kode program yang digunakan untuk mendesain atau mempercantik tampilan halaman HTML. Dengan CSS kita bisa mengubah desain dari text, warna, gambar dan latar belakang dari (hampir) semua kode&nbsp;<strong>tag HTML</strong>.</p>\r\n<p><strong>CSS</strong>&nbsp;biasanya selalu dikaitkan dengan HTML, karena keduanya memang saling melengkapi. HTML ditujukan untuk membuat&nbsp;<strong>struktur</strong>, atau konten dari halaman web. Sedangkan CSS digunakan untuk&nbsp;<strong>tampilan</strong>&nbsp;dari halaman web tersebut. Istilahnya, &ldquo;<em>HTML for content, CSS for Presentation&rdquo;</em>.</p>\r\n<hr>\r\n<h3>Fungsi dan Kegunaan CSS</h3>\r\n<p>Awal mula diperlukannya&nbsp;<strong>CSS</strong>&nbsp;dikarenakan kebutuhan akan halaman web yang semakin kompleks. Pada awal kemunculan HTML, kita bisa membuat suatu paragraf bewarna merah dengan menulis langsung kode tersebut didalam tag HTML, atau membuat latar belakang sebuah halaman dengan warna biru. Contoh kode HTML untuk hal itu adalah sebagai berikut:</p>\r\n<pre class=\"language-markup\"><code>&lt;!DOCTYPE html&gt;\r\n&lt;html&gt;\r\n&lt;head&gt;\r\n      &lt;title&gt;Test Tag Font HTML&lt;/title&gt;\r\n&lt;/head&gt;\r\n&lt;body&gt;\r\n  &lt;p&gt;\r\n    CSS merupakan bahasanya &lt;font color=\"red\"&gt;desainer web&lt;/font&gt;.\r\n    Namun sebenarnya, apa itu CSS?\r\n  &lt;br /&gt;\r\n    &lt;font color=\"red\"&gt;CSS &lt;/font&gt; adalah kumpulan kode yang digunakan\r\n    untuk mendefenisikan desain dari bahasa markup,\r\n    &lt;font color=\"red\"&gt;salah satunya adalah HTML&lt;/font&gt;.\r\n  &lt;br /&gt;\r\n    Dengan CSS kita bisa mengubah desain dari\r\n    &lt;font color=\"red\"&gt;text, warna, gambar dan latar belakang&lt;/font&gt;\r\n    dari (hampir) semua kode tag HTML.\r\n  &lt;/p&gt;\r\n&lt;/body&gt;\r\n&lt;/html&gt;\r\n</code></pre>\r\n<p><a class=\"cboxElement\" href=\"https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-tanpa-CSS.png\"><img class=\"aligncenter size-full wp-image-1270 colorbox-1263\" src=\"https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-tanpa-CSS.png\" sizes=\"(max-width: 619px) 100vw, 619px\" srcset=\"https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-tanpa-CSS.png 619w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-tanpa-CSS-150x79.png 150w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-tanpa-CSS-300x159.png 300w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-tanpa-CSS-260x138.png 260w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-tanpa-CSS-50x26.png 50w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-tanpa-CSS-190x100.png 190w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-tanpa-CSS-169x90.png 169w\" alt=\"Contoh HTML tanpa CSS\" width=\"619\" height=\"329\"></a></p>\r\n<p>Saya menggunakan&nbsp;<strong>tag &lt;font&gt;</strong>&nbsp;untuk membuat beberapa kata di dalam paragraf tersebut berwarna merah. Hal ini tidak salah, dan semuanya berjalan sesuai keinginan. Untuk sebuah artikel yang memiliki 5 paragraf, kita tinggal copy-paste tag&nbsp;<strong>&lt;font color=&rdquo;red&rdquo;&gt;</strong>&nbsp;pada kata-kata tertentu.</p>\r\n<p>Namun setelah website tersebut memiliki katakanlah 50 artikel seperti diatas, dan karena sesuatu hal anda ingin merubah seluruh text merah tadi menjadi biru, maka akan dibutuhkan waktu yang lama untuk mengubahnya satu persatu, halaman per halaman.</p>\r\n<p>Dalam kondisi inilah CSS mencoba&nbsp;<em>&lsquo;memisahkan&rsquo;</em>&nbsp;<strong>tampilan</strong>&nbsp;dari&nbsp;<strong>konten</strong>. Untuk paragraf yang sama, berikut kode HTML bila ditambahkan kode CSS:</p>\r\n<pre class=\"language-markup\"><code>&lt;!DOCTYPE html&gt;\r\n&lt;html&gt;\r\n&lt;head&gt;\r\n&lt;title&gt;Test Background Color CSS&lt;/title&gt;\r\n&lt;style type=\"text/css\"&gt;\r\n.warna {\r\ncolor: red;\r\n}\r\n&lt;/style&gt;\r\n&lt;/head&gt;\r\n  \r\n&lt;body&gt;\r\n    &lt;p&gt;\r\n      CSS merupakan bahasanya &lt;span class=warna&gt;desainer web&lt;/span&gt;.\r\n      Namun sebenarnya, apa itu CSS?\r\n    &lt;br /&gt;\r\n      &lt;span class=warna&gt;CSS &lt;/span&gt;adalah kumpulan kode\r\n      yang digunakan untuk mendefenisikan desain dari bahasa markup,\r\n      &lt;span class=warna&gt;salah satunya adalah HTML&lt;/span&gt;.\r\n    &lt;br /&gt;\r\n      Dengan CSS kita bisa mengubah desain dari\r\n      &lt;span class=warna&gt;text, warna, gambar dan latar belakang&lt;/span&gt;\r\n      dari (hampir) semua kode tag HTML.\r\n    &lt;/p&gt;\r\n&lt;/body&gt;\r\n&lt;/html&gt;</code></pre>\r\n<p><a class=\"cboxElement\" href=\"https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-dengan-CSS.png\"><img class=\"aligncenter size-full wp-image-1269 colorbox-1263\" src=\"https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-dengan-CSS.png\" sizes=\"(max-width: 619px) 100vw, 619px\" srcset=\"https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-dengan-CSS.png 619w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-dengan-CSS-150x79.png 150w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-dengan-CSS-300x159.png 300w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-dengan-CSS-260x138.png 260w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-dengan-CSS-50x26.png 50w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-dengan-CSS-190x100.png 190w, https://www.duniailkom.com/wp-content/uploads/2013/10/Contoh-HTML-dengan-CSS-169x90.png 169w\" alt=\"Contoh HTML dengan CSS\" width=\"619\" height=\"329\"></a></p>\r\n<p>Dalam contoh&nbsp;<strong>CSS</strong>&nbsp;diatas, saya mengubah&nbsp;<strong>tag &lt;font</strong>&gt; menjadi&nbsp;<strong>tag &lt;span</strong>&gt;.&nbsp;<strong>Tag &lt;span</strong>&gt; sendiri merupakan tag yang&nbsp;<em>tidak bermakna</em>, namun bisa di kostumasi menggunakan CSS.&nbsp;<strong>Tag span</strong>&nbsp;saya tambahkan dengan atribut atribut&nbsp;<strong>class=&rdquo;warna&rdquo;.</strong>&nbsp;Atribut&nbsp;<strong>class</strong>&nbsp;berguna untuk memasukkan kode CSS pada&nbsp;<strong>tag &lt;style&gt;</strong>&nbsp;di bagian head. (Lebih lanjut tentang tag &lt;span&gt;, telah kita bahas di&nbsp;<a href=\"https://www.duniailkom.com/belajar-html-pengertian-tag-span-dan-div/\">tutorial belajar HTML lanjutan: pengertian tag span dan div</a>)</p>\r\n<p>Jika kita ingin merubah seluruh warna menjadi biru, maka tinggal mengubah isi dari CSS&nbsp;<strong>color: red</strong>&nbsp;menjadi&nbsp;<strong>color:blue,&nbsp;</strong>dan seluruh tag yang memiliki&nbsp;<strong>class=&rdquo;warna&rdquo;</strong>&nbsp;akan otomatis berubah menjadi biru.</p>', 'publish', 'tutorial-belajar-css-part-1-pengertian-css-apa-yang-dimaksud-dengan-css', 'posting', '2018-03-10 22:36:01', '2018-03-18 23:39:38', 'myadmin', '0', null, '1', '2018-03-10 22:37:22', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('15', 'myadmin', 'Tutorial Belajar CSS Part 2: Cara Menginput Kode CSS ke Halaman HTML', '<p>Jika dalam tutorial CSS sebelumnya kita telah mempelajari&nbsp;<a title=\"Tutorial Belajar CSS: Pengertian CSS, Apa yang dimaksud dengan CSS?\" href=\"https://www.duniailkom.com/tutorial-belajar-css-part-1-pengertian-css-apa-yang-dimaksud-dengan-css/\">Pengertian CSS</a>, pada tutorial kali ini kita akan membahas&nbsp;<a title=\"Tutorial Belajar CSS: Cara Menginput Kode CSS ke Halaman HTML\" href=\"https://www.duniailkom.com/tutorial-belajar-css-cara-menginput-kode-css-ke-halaman-html/\">cara menginput kode CSS ke halaman HTML</a>.</p>\r\n<p>Sebagaimana telah dipelajari pada saat pembahasan tentang HTML (pada artikel&nbsp;<a href=\"https://www.duniailkom.com/tutorial-belajar-html-langkah-pertama-untuk-membuat-web/\">tutorial belajar HTML</a>), HTML pada dasarnya&nbsp; adalah kumpulan dari tag-tag yang disusun sehingga memiliki bagian-bagian tertentu, seperti&nbsp;<em>paragraf</em>,&nbsp;<em>list</em>,&nbsp;<em>tabel</em>&nbsp;dan sebagainya. CSS digunakan untuk mendesain tag-tag HTML ini.</p>\r\n<p>Secara garis besar, terdapat 3 cara menginput kode CSS ke dalam HTML, yaitu metode&nbsp;<strong>Inline Style</strong>,&nbsp;<strong>Internal Style Sheets</strong>, dan&nbsp;<strong>External Style Sheets</strong>.</p>\r\n<hr>\r\n<h3>Metode Inline Style</h3>\r\n<p><strong>Metode Inline Style</strong>&nbsp;adalah cara menginput kode CSS langsung ke dalam tag HTML dengan menggunakan atribut&nbsp;<strong>style</strong>, contoh penggunaan&nbsp;<em>Metode Inline Style CSS</em>&nbsp;adalah sebagai berikut:</p>\r\n<pre class=\"language-markup\"><code>&lt;!DOCTYPE html&gt;\r\n&lt;html&gt;\r\n&lt;head&gt;\r\n     &lt;title&gt;Contoh Inline Style CSS&lt;/title&gt;\r\n&lt;/head&gt;\r\n&lt;body&gt;\r\n&lt;h2 style=\"background-color:black; color:white\" &gt;\r\nText ini akan bewarna putih dan background warna hitam\r\n&lt;/h2&gt;\r\n&lt;/body&gt;\r\n&lt;/html&gt;</code></pre>\r\n<p><a class=\"cboxElement\" href=\"https://www.duniailkom.com/wp-content/uploads/2013/10/Cara-Menginput-CSS-Metode-Inline-Style.png\"><img class=\"aligncenter size-full wp-image-1290 colorbox-1286\" src=\"https://www.duniailkom.com/wp-content/uploads/2013/10/Cara-Menginput-CSS-Metode-Inline-Style.png\" sizes=\"(max-width: 649px) 100vw, 649px\" srcset=\"https://www.duniailkom.com/wp-content/uploads/2013/10/Cara-Menginput-CSS-Metode-Inline-Style.png 649w, https://www.duniailkom.com/wp-content/uploads/2013/10/Cara-Menginput-CSS-Metode-Inline-Style-150x76.png 150w, https://www.duniailkom.com/wp-content/uploads/2013/10/Cara-Menginput-CSS-Metode-Inline-Style-300x152.png 300w, https://www.duniailkom.com/wp-content/uploads/2013/10/Cara-Menginput-CSS-Metode-Inline-Style-260x132.png 260w, https://www.duniailkom.com/wp-content/uploads/2013/10/Cara-Menginput-CSS-Metode-Inline-Style-50x25.png 50w, https://www.duniailkom.com/wp-content/uploads/2013/10/Cara-Menginput-CSS-Metode-Inline-Style-190x96.png 190w, https://www.duniailkom.com/wp-content/uploads/2013/10/Cara-Menginput-CSS-Metode-Inline-Style-177x90.png 177w\" alt=\"Cara Menginput CSS, Metode Inline Style\" width=\"649\" height=\"330\"></a></p>\r\n<p>Dalam kode diatas, saya menyisipkan atribut&nbsp;<strong>style</strong>&nbsp;pada tag&nbsp;<strong>&lt;h2&gt;</strong>, nilai dari atribut&nbsp;<strong>style</strong>&nbsp;ini adalah kode CSS yang ingin diterapkan.</p>\r\n<p>Penggunaan tag CSS seperti ini walaupun praktis, namun tidak disarankan, karena kode CSS langsung tergabung dengan HTML, dan tidak memenuhi tujuan dibuatnya CSS agar desain terpisah dengan konten.</p>', 'publish', 'tutorial-belajar-css-part-2-cara-menginput-kode-css-ke-halaman-html', 'posting', '2018-03-10 22:37:28', '2018-03-10 23:03:58', 'myadmin', '0', null, '1', '2018-03-10 22:38:14', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('16', 'myadmin', 'Tutorial Belajar JavaScript Dasar Untuk Pemula', '<p>Dalam sesi tutorial kali ini, kita akan mempelajari tentang&nbsp;<strong>JavaScript</strong>.&nbsp;<a href=\"https://www.duniailkom.com/tutorial-belajar-javascript-dasar-untuk-pemula/\">Tutorial belajar JavaScript dasar untuk pemula</a>&nbsp;dibuat untuk anda yang ingin mempelajari&nbsp;<em>JavaScript</em>.&nbsp;<em>JavaScript</em>&nbsp;merupakan salah satu bahasa pemograman web yang sangat pesat perkembangannya saat ini.</p>\r\n<hr>\r\n<p><strong>JavaScript</strong>&nbsp;adalah bahasa pemograman yang digunakan untuk membuat interaksi atau menambah fitur web dinamis kedalam sebuah web. Untuk membuat halaman web, anda tidak harus menggunakan&nbsp;<em>JavaScript</em>. Namun, saat ini&nbsp;<em>JavaScript</em>&nbsp;hadir dalam hampir setiap halaman web modern. Sehingga&nbsp;<em>JavaScript</em>&nbsp;adalah salah satu bahasa pemograman web yang wajib di kuasai.</p>\r\n<p><em>Javascript</em>&nbsp;merupakan bagian dari 3 teknologi penting yang harus dikuasai programmer web, yakni&nbsp;<strong>HTML</strong>&nbsp;untuk konten (isi dari website),&nbsp;<strong>CSS</strong>&nbsp;untuk tampilan (presentation), dan&nbsp;<strong>JavaScript</strong>&nbsp;untuk interaksi (behavior).</p>\r\n<p>Hampir seluruh website modern saat ini menggunakan&nbsp;<em>JavaScript</em>&nbsp;untuk membuat berbagai aplikasi yang dapat berinteraksi dengan user, seperti&nbsp;<em>validasi form HTML</em>, games, kalkulator, fitur&nbsp;<em>chatting</em>, dll.</p>\r\n<p>Contoh sederhana penggunaan&nbsp;<em>JavaScript</em>&nbsp;dapat anda lihat pada situs&nbsp;<strong>duniailkom</strong>&nbsp;ini. Cobalah&nbsp;<em>scroll</em>&nbsp;halaman web sampai bawah, dan pada pojok kanan bawah browser akan muncul tanda panah yang jika di-klik akan membuat jendela web browser kembali ke posisi awal halaman. Ini adalah fitur sederhana yang dapat di buat menggunakan&nbsp;<em>JavaScript</em>.</p>\r\n<p>Dalam mempelajari&nbsp;<em>JavaScript</em>, anda sebaiknya telah menguasai dasar-dasar&nbsp;<strong>HTML</strong>, dan bisa membuat halaman web sederhana menggunakan&nbsp;<strong>HTML</strong>. Pengetahuan tentang&nbsp;<strong>CSS</strong>&nbsp;dan&nbsp;<strong>PHP</strong>&nbsp;juga akan membantu, walaupun tidak diharuskan.</p>', 'publish', 'tutorial-belajar-javascript-dasar-untuk-pemula', 'posting', '2018-03-10 22:38:46', '2018-03-10 23:03:11', 'myadmin', '0', null, '1', '2018-03-10 22:39:12', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('17', 'myadmin', 'Tutorial Belajar JavaScript Part 1: Pengertian dan Fungsi JavaScript dalam Pemrograman Web', '<h3>Pengertian JavaScript</h3>\r\n<p><strong>JavaScript</strong>&nbsp;adalah bahasa pemrograman web yang bersifat&nbsp;<em>Client Side</em><em>&nbsp;Programming Language</em>.&nbsp;<strong>Client Side Programming Language&nbsp;</strong>adalah tipe bahasa pemrograman yang pemrosesannya dilakukan oleh&nbsp;<em>client</em>. Aplikasi&nbsp;<em>client</em>&nbsp;yang dimaksud merujuk kepada&nbsp;<em>web browser</em>&nbsp;seperti&nbsp;<strong>Google Chrome</strong>&nbsp;<strong>dan Mozilla Firefox</strong>.</p>\r\n<p>Bahasa pemrograman&nbsp;<em>Client Side</em>&nbsp;berbeda dengan bahasa pemrograman&nbsp;<em>Server Side</em><em>&nbsp;</em>seperti PHP, dimana untuk&nbsp;<em>server side&nbsp;</em>seluruh kode program dijalankan di sisi server.</p>\r\n<p>Untuk menjalankan&nbsp;<strong>JavaScript</strong>, kita hanya membutuhkan aplikasi&nbsp;<em>text editor</em>&nbsp;dan&nbsp;<em>web browser</em>.&nbsp;<strong>JavaScript</strong>&nbsp;memiliki fitur:&nbsp;<em>high-level&nbsp;</em><em>programming&nbsp;</em><em>language, client-side, loosely tiped</em>&nbsp;dan berorientasi objek.</p>\r\n<hr>\r\n<h3>Fungsi JavaScript Dalam Pemograman Web</h3>\r\n<p><strong>JavaScript</strong>&nbsp;pada awal perkembangannya berfungsi untuk membuat interaksi antara user dengan situs web menjadi lebih cepat tanpa harus menunggu pemrosesan di&nbsp;<em>web server</em>. Sebelum&nbsp;<em>javascript</em>, setiap interaksi dari user harus diproses oleh&nbsp;<em>web server</em>.</p>\r\n<p>Bayangkan ketika kita mengisi&nbsp;<em>form registrasi</em>&nbsp;untuk pendaftaran sebuah situs web, lalu men-klik tombol&nbsp;<em>submit</em>, menunggu sekitar 20 detik untuk website memproses isian form tersebut, dan mendapati halaman yang menyatakan bahwa terdapat kolom form yang masih belum diisi.</p>\r\n<p>Untuk keperluan seperti inilah&nbsp;<strong>JavaScript&nbsp;</strong>dikembangkan. Pemrosesan untuk mengecek apakah seluruh form telah terisi atau tidak, bisa dipindahkan dari&nbsp;<em>web server</em>&nbsp;ke dalam&nbsp;<em>web browser</em>.</p>\r\n<p>Dalam perkembangan selanjutnya,&nbsp;<em>JavaScript</em>&nbsp;tidak hanya berguna untuk&nbsp;<em>validasi form</em>, namun untuk berbagai keperluan yang lebih modern. Berbagai animasi untuk mempercantik halaman web, fitur chatting, efek-efek modern, games, semuanya bisa dibuat menggunakan&nbsp;<em>JavaScript</em>.</p>\r\n<p>Akan tetapi karena sifatnya yang dijalankan di sisi client yakni di dalam web browser yang digunakan oleh pengunjung situs, user sepenuhnya dapat mengontrol eksekusi JavaScript. Hampir semua web browser menyediakan fasilitas untuk mematikan JavaScript, atau bahkan mengubah kode JavaScript yang ada. Sehingga kita tidak bisa bergantung sepenuhnya kepada JavaScript.</p>\r\n<hr>\r\n<h3>Perkembangan JavaScript Saat Ini</h3>\r\n<p>Dalam perkembangannya,&nbsp;<strong>JavaScript</strong>&nbsp;mengalami permasalahan yang sama seperti kode pemograman web yang bersifat&nbsp;<em>client side&nbsp;</em>seperti<em>&nbsp;</em><strong>CSS</strong>, yakni bergantung kepada implementasi web browser.</p>\r\n<p>Kode&nbsp;<em>JavaScript</em>&nbsp;yang kita buat, bisa saja tidak bekerja di&nbsp;<em>Internet Explorer</em>, karena web browser tersebut tidak mendukungnya. Sehingga programmer harus bekerja extra untuk membuat kode program agar bisa &ldquo;mengakali&rdquo; dukungan dari web browser.</p>\r\n<p>Karena hal tersebut,&nbsp;<strong>JavaScript&nbsp;</strong>pada awalnya termasuk bahasa pemograman yang rumit, karena harus membuat beberapa kode program untuk berbagai web browser.</p>\r\n<p>Namun, beberapa tahun belakangan ini,&nbsp;<strong>JavaScript</strong>&nbsp;kembali bersinar berkat kemudahan yang ditawari oleh komunitas programmer yang membuat library&nbsp;<strong>JavaScript</strong>&nbsp;seperti&nbsp;<a href=\"https://www.duniailkom.com/tutorial-belajar-jquery-bagi-pemula/\"><strong>jQuery</strong></a>. Library ini memudahkan kita membuat program&nbsp;<strong>JavaScript</strong>&nbsp;untuk semua web browser, dan membuat fitur-fitur canggih yang sebelumnya membutuhkan ribuan baris kode program menjadi sederhana.</p>\r\n<p>Kedepannya,&nbsp;<strong>JavaScript</strong>&nbsp;akan tetap menjadi kebutuhan programmer, apalagi untuk situs saat ini yang mengharuskan punya banyak fitur modern sebagai standar.</p>', 'publish', 'tutorial-belajar-javascript-part-1-pengertian-dan-fungsi-javascript-dalam-pemrograman-web', 'posting', '2018-03-10 22:39:23', '2018-03-10 23:02:54', 'myadmin', '0', null, '1', '2018-03-10 22:39:56', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('18', 'myadmin', 'Tutorial Belajar JavaScript Part 3: Cara Menjalankan Kode Program JavaScript', '<h3>Aplikasi Untuk Menjalankan JavaScript</h3>\r\n<p><strong>JavaScript</strong>&nbsp;merupakan&nbsp;<em>bahasa script</em>&nbsp;yang berjalan pada&nbsp;<em>web browser</em>, sehingga program yang dibutuhkan untuk menjalankan&nbsp;<em>JavaScript</em>&nbsp;hanyalah sebuah aplikasi&nbsp;<strong>text editor</strong>&nbsp;dan sebuah&nbsp;<strong>web browser</strong>&nbsp;seperti&nbsp;<em>Google Chrome</em>&nbsp;atau&nbsp;<em>Mozilla Firefox</em>.</p>\r\n<p>Untuk aplikasi&nbsp;<em>text editor</em>, anda bisa menggunakan aplikasi notepad bawaan Windows, atau menggunakan aplikasi khusus&nbsp;<em>text editor</em>. Salah satu aplikasi text editor sederhana yang saya gunakan adalah&nbsp;<strong>Notepad++</strong>&nbsp;yang ringan dan bersifat gratis. Untuk menginstall aplikasi&nbsp;<strong>Notepad++</strong>&nbsp;ini pernah saya bahas pada tutorial&nbsp;<a title=\"Belajar HTML Dasar: Memilih Aplikasi Editor HTML (Notepad++)\" href=\"https://www.duniailkom.com/belajar-html-memilih-aplikasi-editor-html/\">Memilih Aplikasi Editor HTML</a>.</p>\r\n<p>Pilihan&nbsp;<em>web browser</em>&nbsp;bukan sesuatu yang mutlak. Anda bebas menggunakan aplikasi web browser kesukaan. Terdapat beberapa jenis aplikasi web browser populer yang bisa diinstall dengan gratis. Anda bahkan bisa menginstall seluruhnya, seperti yang pernah saya bahas pada tutorial&nbsp;<a title=\"Belajar HTML Dasar: Mengenal Fungsi Browser\" href=\"https://www.duniailkom.com/belajar-html-mengenal-fungsi-browser/\">Mengenal Fungsi Web Browser</a>.</p>\r\n<p>Pada sesi tutorial JavaScript di duniailkom, saya menggunakan web browser&nbsp;<strong>Google Chrome</strong>&nbsp;dan&nbsp;<strong>Mozilla Firefox</strong>.</p>\r\n<hr>\r\n<h3>Cara Menjalankan kode JavaScript</h3>\r\n<p>Jika aplikasi&nbsp;<em>Notepad++</em>&nbsp;dan web browser telah tersedia, saatnya mencoba menjalankan aplikasi&nbsp;<strong>JavaScript</strong>&nbsp;pertama anda.</p>\r\n<div class=\"code-block code-block-4\">\r\n<p>Cara penulisan&nbsp;<em>JavaScript</em>&nbsp;mirip dengan penulisan bahasa pemograman web lainnya seperti&nbsp;<strong>PHP</strong>dan&nbsp;<strong>CSS</strong>, yakni dengan menyisipkan kode JavaScript di dalam HTML.</p>\r\n<p>Silahkan buka aplikasi text editor, lalu ketikkan kode berikut:</p>\r\n<pre class=\"language-javascript\"><code>&lt;!DOCTYPE html&gt;\r\n&lt;html&gt;\r\n&lt;head&gt;\r\n&lt;title&gt;Belajar JavaScript di Duniailkom&lt;/title&gt;\r\n&lt;script type=\"text/javascript\"&gt;\r\nfunction tambah_semangat()\r\n{\r\n   var a=document.getElementById(\"div_semangat\");\r\n   a.innerHTML+=\"&lt;p&gt;Sedang Belajar JavaScript, Semangat...!!!&lt;/p&gt;\";\r\n}\r\n&lt;/script&gt;\r\n&lt;/head&gt;\r\n&lt;body&gt;\r\n&lt;h1&gt;Belajar JavaScript&lt;/h1&gt;\r\n&lt;p&gt; Saya sedang belajar JavaScript di duniailkom.com &lt;/p&gt;\r\nKlik tombol ini untuk menambahkan kalimat baru:\r\n&lt;button id=\"tambah\" onclick=\"tambah_semangat()\"&gt;Semangaat..!!&lt;/button&gt;\r\n&lt;div id=\"div_semangat\"&gt;&lt;/div&gt;\r\n&lt;/body&gt;\r\n&lt;/html&gt;</code></pre>\r\n<p>Savelah kode HTML diatas dengan nama:&nbsp;<strong><em>belajar_js.html</em></strong>. Folder tempat anda menyimpan file HTML ini tidak menjadi masalah, karena kita tidak perlu meletakkannya dalam folder web server seperti file&nbsp;<strong>PHP</strong>. Saya membuat sebuah folder baru di&nbsp;<strong><em>D:\\BelajarHTML\\Javascript</em></strong>. Savelah di folder tersebut.</p>\r\n<p>Perhatikan bahwa nama file dari contoh JavaScript kita berakhiran&nbsp;<strong>.html</strong>, karena pada dasarnya kode tersebut adalah kode HTML yang &lsquo;<em>disiipkan&rsquo;</em>&nbsp;dengan&nbsp;<strong>JavaScript</strong>.</p>\r\n<p>Untuk menjalankan file tersebut, sama seperti HTML biasa, kita tinggal double klik&nbsp;<strong><em>belajar_js.html</em></strong>dan hasilnya akan tampil di dalam web browser.</p>\r\n<p><a class=\"cboxElement\" href=\"https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program.png\"><img class=\"aligncenter size-full wp-image-2671 colorbox-2665\" src=\"https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program.png\" sizes=\"(max-width: 549px) 100vw, 549px\" srcset=\"https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program.png 549w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-150x77.png 150w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-300x154.png 300w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-260x133.png 260w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-50x25.png 50w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-190x97.png 190w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-175x90.png 175w\" alt=\"Cara Menjalankan Kode Program JavaScript - Contoh Program\" width=\"549\" height=\"282\"></a></p>\r\n<p>Untuk menguji kode&nbsp;<em>JavaScript</em>&nbsp;yang telah dibuat, silahkan klik tombol&nbsp;<em>&ldquo;Semangaat..!!&rdquo;</em>&nbsp;beberapa kali, dan kalimat baru akan ditambahkan di akhir halaman web kita.</p>\r\n<p><a class=\"cboxElement\" href=\"https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-2.png\"><img class=\"aligncenter size-full wp-image-2674 colorbox-2665\" src=\"https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-2.png\" sizes=\"(max-width: 549px) 100vw, 549px\" srcset=\"https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-2.png 549w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-2-150x111.png 150w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-2-300x222.png 300w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-2-196x146.png 196w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-2-50x37.png 50w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-2-148x110.png 148w, https://www.duniailkom.com/wp-content/uploads/2014/05/Cara-Menjalankan-Kode-Program-JavaScript-Contoh-Program-2-121x90.png 121w\" alt=\"Cara Menjalankan Kode Program JavaScript - Contoh Program 2\" width=\"549\" height=\"407\"></a></p>\r\n<p><em><strong>Selamat!!</strong></em>, anda telah berhasil menjalankan kode&nbsp;<em>JavaScript</em>.</p>\r\n<p>Terlepas dari kode&nbsp;<strong><em>JavaScript</em></strong>&nbsp;yang saya tulis diatas (kita akan mempelajarinya dalam tutorial-tutorial selanjutnya), kode tersebut pada dasarnya berfungsi untuk menambahkan sebuah kalimat kedalam halaman web&nbsp;setelah&nbsp;halaman web tampil di&nbsp;<em>web browser</em>.</p>\r\n<p>Fitur inilah yang membuat&nbsp;<strong><em>JavaScript</em>&nbsp;</strong>menawarkan kelebihannya, dimana kita bisa merubah apapun yang terdapat dalam halaman web saat web telah dikirim ke&nbsp;<em>web browser</em>. Bahkan dengan men-klik sebuah tombol, kita bisa mengganti seluruh isi halaman web tanpa harus berpindah halaman.</p>\r\n</div>', 'publish', 'tutorial-belajar-javascript-part-3-cara-menjalankan-kode-program-javascript', 'posting', '2018-03-10 22:40:15', '2018-03-10 23:02:46', 'myadmin', '0', null, '1', '2018-03-10 22:41:21', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('20', 'myadmin', 'Tutorial Belajar MySQL Part 1: Pengertian MySQL dan Kelebihan MySQL', '<p>Mengawali tutorial belajar MySQL di&nbsp;<a href=\"https://www.duniailkom.com/\">duniailkom.com</a>, pada Tutorial MySQL kali ini kita akan membahas tentang<a title=\"Tutorial Belajar MySQL: Pengertian MySQL dan Kelebihan MySQL\" href=\"https://www.duniailkom.com/tutorial-mysql-alasan-menggunakan-mysql/\">&nbsp;pengertian MySQL dan kelebihan MySQL</a>&nbsp;jika dibandingkan dengan aplikasi database lainnya. Kepopuleran MySQL tidak hanya karena gratis, tetapi juga merupakan sebuah aplikasi database yang dapat disandingkan dengan aplikasi database berbayar lain, seperti&nbsp;<strong>Oracle</strong>dan&nbsp;<strong>Microsoft SQL Server</strong>.</p>\r\n<p>Kepopuleran MySQL juga disebabkan karena&nbsp;<strong>MySQL</strong>&nbsp;merupakan salah satu aplikasi standar dalam pengembangan web, bersama dengan&nbsp;<em><strong>Web Server Apache</strong></em>, dan bahasa pemrograman&nbsp;<em><strong>PHP</strong></em>.</p>\r\n<h3>Pengertian MySQL sebagai RDBMS</h3>\r\n<p>Bagi mahasiswa maupun&nbsp;<em>web developer</em>, kalau bicara database, kemungkinan besar akan membicarakan MySQL. Tapi, kenapa harus MySQL? Bagaimana dengan Oracle? Jawaban singkat, padat dan tepat adalah:&nbsp;<em>gratis</em>&nbsp;dan&nbsp;<em>user friendly</em>.</p>\r\n<p>MySQL adalah salah satu aplikasi&nbsp;<strong>RDBMS (Relational Database Management System)</strong>. Pengertian sederhana RDBMS adalah: aplikasi database yang menggunakan&nbsp;<strong>prinsip relasional</strong>. Apa itu prinsip relasional? Kita akan membicarakannya dalam tutorial berikutnya.</p>\r\n<p>MySQL juga bukan satu-satunya RDBMS, list lengkapnya ada di&nbsp;<a title=\"List RDBMS\" href=\"http://en.wikipedia.org/wiki/Comparison_of_relational_database_management_systems\" target=\"_blank\" rel=\"nofollow noopener\">wikipedia</a>. Diantaranya yang banyak dikenal adalah:&nbsp;<em>Oracle, Sybase, Microsoft Access, Microsoft SQL Server, dan PostgreSQL.</em></p>\r\n<p>MySQL bersifat gratis dan open source. Artinya setiap orang boleh menggunakan dan mengembangkan aplikasi ini. Namun walaupun gratis, MySQL di support oleh ribuan programmer dari seluruh dunia, dan merupakan sebuah aplikasi RDBMS yang lengkap, cepat, dan reliabel.</p>\r\n<p><a class=\"cboxElement\" href=\"https://www.duniailkom.com/wp-content/uploads/2017/12/situs_mysql.jpg\"><img class=\"aligncenter wp-image-7583 colorbox-76\" src=\"https://www.duniailkom.com/wp-content/uploads/2017/12/situs_mysql.jpg\" sizes=\"(max-width: 654px) 100vw, 654px\" srcset=\"https://www.duniailkom.com/wp-content/uploads/2017/12/situs_mysql.jpg 1000w, https://www.duniailkom.com/wp-content/uploads/2017/12/situs_mysql-150x79.jpg 150w, https://www.duniailkom.com/wp-content/uploads/2017/12/situs_mysql-300x159.jpg 300w, https://www.duniailkom.com/wp-content/uploads/2017/12/situs_mysql-768x406.jpg 768w\" alt=\"Situs Resmi MySQL\" width=\"654\" height=\"346\"></a></p>\r\n<p>Berikut beberapa keunggulan MySQL dibandingkan dengan RDBMS lainnya:</p>\r\n<h4>Speed</h4>\r\n<p>Sebuah studi dari eWeek di February 2002 yang membandingkan performa kecepatan MySQL dengan RDBMS lainnya, seperti&nbsp;<em>Microsoft SQL Server 2000, IBM DB2, Oracle 9i dan Sybase</em>&nbsp;:</p>\r\n<p>&ldquo;<em>MySQL has the best overall performance and that MySQL scalability matches Oracle &hellip; MySQL had the highest throughput, even exceeding the numbers generated by Oracle</em>.&rdquo;</p>\r\n<p>Yang terjemahan bebasnya, MySQL memiliki kecepatan yang lebih dibandingkan pesaing yang berbayar. Bagi anda ingin membaca paper tersebut, tersedia di situs MySQL</p>\r\n<h4>Reliability</h4>\r\n<p>Biasanya sesuatu yang gratis susah diandalkan, bahkan banyak bug dan sering hang. Tidak demikian dengan MySQL, karena sifatnya yang open source, setiap orang dapat berkontribusi memeriksa bug dan melakukan&nbsp;<em>test case</em>&nbsp;untuk berbagai skenario yang memerlukan sistem 24 jam online, multi-user dan data ratusan GB. Hasilnya, MySQL merupakan RDBMS yang reliabel namun memiliki performa diatas rata-rata.</p>\r\n<h4>Skalability</h4>\r\n<p>MySQL dapat memproses data yang sangat besar dan kompleks, tanpa ada penurunan performa yang berarti, juga mendukung sistem multi-prosesor. MySQL juga dipakai oleh perusahaan-perusahaan besar di dunia, seperti&nbsp;<em>Epson, New York Times, Wikipedia, Google, Facebook,&nbsp;</em>bahkan<em>NASA</em>.</p>\r\n<h4>User Friendly</h4>\r\n<p>Instalasi dan mempelajari MySQL cukup mudah dan tidak dipusingkan dengan banyak settingan. Cukup&nbsp;<a href=\"http://www.mysql.com/downloads/mysql/\" target=\"_blank\" rel=\"nofollow noopener\">download aplikasi MySQL</a>&nbsp;dan install, kita dapat menggunakan MySQL dalam waktu kurang dari 5 menit (dengan asumsi tidak mati lampu).</p>\r\n<h4>Portability and Standard Compliance</h4>\r\n<p>Database MySQL dapat dengan mudah berpindah dari satu sistem ke sistem lainnya. Misalkan dari sistem Windows ke Linux. Aplikasi MySQL juga dapat berjalan di sistem&nbsp;<strong>Linux</strong>&nbsp;(<em>RedHat, SuSE, Mandrake, Debian</em>),&nbsp;<strong>Embedded Linux</strong>&nbsp;(<em>MontaVista, LynuxWorks BlueCat</em>),<strong>Unix</strong>&nbsp;(<em>Solaris, HP-UX, AIX</em>), BSD (Mac OS X, FreeBSD),&nbsp;<strong>Windows</strong>&nbsp;(<em>Windows 2000, Windows NT</em>) dan&nbsp;<strong>RTOS</strong>&nbsp;(<em>QNX</em>).</p>\r\n<h4>Multiuser Support</h4>\r\n<p>Dengan menerapkan&nbsp;<strong>arsitektur client-server</strong>. Ribuan pengguna dapat mengakses database MySQL dalam waktu yang bersamaan.</p>\r\n<h4>Internationalization</h4>\r\n<p>Atau dalam bahasa sederhananya, mendukung beragam bahasa. Dengan dukungan penuh terhadap unicode, maka aksara non-latin seperti jepang, cina, dan korea bisa digunakan di dalam MySQL.</p>\r\n<h4>Wide Application Support</h4>\r\n<p>Biasanya database RDBMS tidak digunakan sendirian, namun ditemani dengan aplikasi atau bahasa pemrograman lainnya untuk menyediakan interface, seperti<em>&nbsp;C, C++, C#, Java, Delphi, Visual Basic, &nbsp;Perl Python dan PHP</em>. Ke semua itu di dukung oleh API (Application Programming Interface) oleh MySQL.</p>\r\n<div class=\"code-block code-block-4\">&nbsp;</div>', 'publish', 'tutorial-belajar-mysql-part-1-pengertian-mysql-dan-kelebihan-mysql', 'posting', '2018-03-10 22:42:14', '2018-03-10 23:02:02', 'myadmin', '0', null, '1', '2018-03-10 22:43:17', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('21', 'myadmin', 'Tutorial Belajar MySQL Part 10: Dasar Penulisan Query MySQL', '<p>Setelah koneksi ke&nbsp;<a href=\"https://www.duniailkom.com/tutorial-mysql-menjalankan-mysql-server/\">MySQL Server</a>&nbsp;dan&nbsp;<a href=\"https://www.duniailkom.com/tutorial-mysql-menjalankan-mysql-client/\">MySQL Client</a>&nbsp;berhasil, saatnya kita mempelajari perintah-perintah MySQL. Untuk &nbsp;<a href=\"https://www.duniailkom.com/tutorial-mysql-dasar-penulisan-query-mysql/\">Tutorial Belajar MySQL: Dasar Penulisan Query MySQL</a>&nbsp;ini&nbsp;kita akan mempelajari format dan cara penulisan perintah (<strong>query</strong>) MySQL dengan&nbsp;<strong>cmd</strong>&nbsp;Windows, dan beberapa tata cara penulisan (<strong>syntax)</strong>&nbsp;MySQL.</p>\r\n<hr>\r\n<h3>Menjalankan Perintah (query) MySQL</h3>\r\n<p>Setiap perintah, atau sering juga disebut &ldquo;<strong>query</strong>&rdquo; di dalam MySQL harus diakhiri dengan tanda titik koma &ldquo;<strong>;</strong>&rdquo; dan akan dieksekusi setelah tombol&nbsp;<strong>Enter</strong>&nbsp;ditekan. Selama query MySQL&nbsp;belum&nbsp;diakhiri dengan &ldquo;;&rdquo; maka itu dianggap masih dalam satu perintah.</p>\r\n<p>Ketika kita menjalankan sebuah perintah MySQL (<em>query</em>), query tersebut akan dikirim dari&nbsp;<strong>MySQL Client</strong>&nbsp;ke&nbsp;<strong>MySQL Server</strong>&nbsp;untuk di proses, setelah proses selesai, hasilnya akan dikirim kembali ke&nbsp;<strong>MySQL Client</strong>.</p>\r\n<p>Agar lebih mudah memahami query MySQL, kita akan langsung praktek beberapa query sederhana. Silahkan jalankan&nbsp;<em>MySQL Server</em>&nbsp;dan masuk sebagai user&nbsp;<strong>root</strong>&nbsp;dari&nbsp;<em>MySQL Client</em>(tutorialnya telah kita bahas pada&nbsp;<a href=\"https://www.duniailkom.com/tutorial-mysql-menjalankan-mysql-server/\">Tutorial Belajar MySQL: Cara Menjalankan MySQL Server</a>, dan&nbsp;<a href=\"https://www.duniailkom.com/tutorial-mysql-menjalankan-mysql-client/\">Tutorial Belajar MySQL: Cara Menjalankan MySQL Client</a>).</p>\r\n<p>Setelah masuk ke dalam&nbsp;<em><strong>MySQL Client</strong></em>&nbsp;(ditandai dengan awalan&nbsp;<strong>mysql&gt;</strong>&nbsp;pada jendela cmd), kita akan mencoba beberapa perintah MySQL sederhana. Ketikkan perintah berikut:&nbsp;<strong>SELECT NOW();</strong>lalu akhiri dengan&nbsp;<strong>Enter</strong>&nbsp;pada keyboard.</p>\r\n<pre class=\"language-markup\"><code>mysql&gt; SELECT NOW();\r\n+---------------------+\r\n| NOW()               |\r\n+---------------------+\r\n| 2014-11-13 09:21:08 |\r\n+---------------------+\r\n1 row in set (0.69 sec)</code></pre>\r\n<p>Contoh&nbsp;<em>query</em>&nbsp;diatas adalah untuk menampilkan tanggal dan waktu saat ini dengan fungsi&nbsp;<strong>NOW().</strong>&nbsp;Query tersebut akan menghasilkan hasil yang berbeda-beda tergantung saat anda menjalankannya.</p>\r\n<p>Perintah&nbsp;<strong>SELECT</strong>&nbsp;kebanyakan digunakan untuk proses pembacaan data dari&nbsp;<strong>database</strong>, tetapi juga dapat digunakan untuk menampilkan hasil dari fungsi tambahan, seperti fungsi&nbsp;<strong>NOW()</strong>, yang kita coba kali ini. Hasil&nbsp;<em>query MySQL</em>&nbsp;akan ditampilkan dalam bentuk tabel pada&nbsp;<strong>cmd</strong>&nbsp;windows, hasil ini dikirim dari&nbsp;<em>MySQL Server</em>.</p>\r\n<p>Selain hasil dalam bentuk tabel, hampir setiap perintah query, MySQL juga akan menampilkan banyaknya baris yang dipengaruhi dan lamanya waktu eksekusi. Pada contoh kita diatas, ditampilkan keterangan: 1 row in set (0.00 sec). Keterangan ini berarti query kita diproses selama 0 detik (0 second), dan mempengaruhi 1 baris (1 row). o detik disini bukan berarti query tersebut akan tampil seketika, namun karena perintah yang sederhana, MySQL (mungkin) hanya membutuhkan waktu 0,001 sekian detik untuk memproses (dibulatkan menjadi 0,00).</p>\r\n<p>Sebagai contoh query lainnya, kita akan mencoba untuk menampilkan nama user yang sedang aktif dan versi MySQL Server yang digunakan pada saat ini. Untuk menampilkan keterangan ini, MySQL menyediakan fungsi&nbsp;<strong>USER()</strong>&nbsp;dan&nbsp;<strong>VERSION()</strong></p>\r\n<pre class=\"language-php\"><code>mysql&gt; SELECT NOW(),USER(),VERSION();\r\n+---------------------+----------------+------------+\r\n| NOW()               | USER()         | VERSION()  |\r\n+---------------------+----------------+------------+\r\n| 2014-11-13 09:21:37 | root@localhost | 5.6.21-log |\r\n+---------------------+----------------+------------+\r\n1 row in set (0.11 sec)</code></pre>\r\n<p>Dapat dilihat dari contoh&nbsp;<em>query</em>&nbsp;tersebut, untuk setiap fungsi dipisahkan dengan tanda koma &ldquo;,&rdquo;.</p>\r\n<p>Penulisan perintah (query) MySQL juga&nbsp;tidak harus&nbsp;dalam satu baris. Misalnya, kita bisa menjalankan query berikut:</p>\r\n<pre class=\"language-php\"><code>mysql&gt; SELECT NOW(),\r\n    -&gt; USER(),\r\n    -&gt; VERSION();\r\n+---------------------+----------------+------------+\r\n| NOW()               | USER()         | VERSION()  |\r\n+---------------------+----------------+------------+\r\n| 2014-11-13 09:22:50 | root@localhost | 5.6.21-log |\r\n+---------------------+----------------+------------+\r\n1 row in set (0.00 sec)</code></pre>\r\n<p>&nbsp;</p>', 'publish', 'tutorial-belajar-mysql-part-10-dasar-penulisan-query-mysql', 'posting', '2018-03-10 22:43:30', '2018-03-10 23:02:11', 'myadmin', '0', null, '1', '2018-03-10 22:45:28', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('22', 'myadmin', 'Widyatama Informatics Festival (WIFi) 2018 – Bandung', '<p><strong>Widyatama Informatics Festival (WIFi) 2018</strong></p>\r\n<p><strong>Tanggal:</strong>&nbsp;3 Maret 2018<br><strong>Tempat:</strong>&nbsp;GSG Universitas Widyatama Bandung<br><strong>Pukul:</strong>&nbsp;08.00&ndash;Selesai<br><strong>HTM:</strong></p>\r\n<ul>\r\n<li>Seminar:\r\n<ul>\r\n<li>Presale I: 35k s.d tanggal 21 Februari 2018</li>\r\n<li>Presale II: 45k s.d tanggal 28 Februari 2018</li>\r\n<li>OTS: 55k</li>\r\n</ul>\r\n</li>\r\n<li>Lomba: 135k/team</li>\r\n</ul>\r\n<p><a class=\"\" href=\"http://jadwalevent.web.id/wp-content/uploads/2018/02/POSTER-SEMINAR-1.jpg\"><img class=\"aligncenter size-full wp-image-55675 tc-smart-load-skip tc-smart-loaded\" src=\"http://jadwalevent.web.id/wp-content/uploads/2018/02/POSTER-SEMINAR-1.jpg\" sizes=\"(max-width: 1000px) 100vw, 1000px\" srcset=\"http://jadwalevent.web.id/wp-content/uploads/2018/02/POSTER-SEMINAR-1.jpg 1000w, http://jadwalevent.web.id/wp-content/uploads/2018/02/POSTER-SEMINAR-1-768x1057.jpg 768w\" alt=\"\" width=\"1000\" height=\"1376\"></a></p>\r\n<p>HIMATIF UNIVERSITAS WIDYATAMA PROUDLY PRESENT.</p>\r\n<p>WIFI 2018&nbsp;Seminar dan Lomba tentang teknologi dengan tema &rdquo; Invisible technology visible impact&rdquo;&nbsp;<strong>Dengan pembicara pembicara yang sudah ahli pada bidangnya.</strong></p>\r\n<p><strong>Yaitu:</strong></p>\r\n<ul>\r\n<li>&nbsp;Ir.Onno Widodo Purbo. M.Eng . Ph.D (Pakar IT)</li>\r\n<li>&nbsp;Ir.Budi Rahardjo M.Sc , Ph.D (Pakar IT)</li>\r\n</ul>\r\n<p><strong>Kompetisi (SMA/SMK @3org/team) :</strong></p>\r\n<ol>\r\n<li>Programming</li>\r\n<li>Networking</li>\r\n<li>Web Design</li>\r\n</ol>\r\n<p>Pendaftaran lomba dapat di lakukan secara online melalui link berikut&nbsp;</p>\r\n<p><a href=\"http://goo.gl/eNCbmK\" target=\"_blank\" rel=\"noopener\"><strong>Http://goo.gl/eNCbmK</strong></a></p>\r\n<p>Tentunya dengan harga yang telah ditentukan kalian akan mendapatkan:</p>\r\n<ul>\r\n<li>: Seminar Kit</li>\r\n<li>: Sertifikat</li>\r\n<li>: Snack</li>\r\n</ul>\r\n<p><strong>Untuk Info lebih lanjut bisa hubungi kontak di bawah :&nbsp;</strong></p>\r\n<ul>\r\n<li>CP Seminar (Line) :\r\n<ul>\r\n<li>TRSRDW / 0821-1012-3583</li>\r\n<li>INTANMULIAWATI09 / 0821-1883-3040</li>\r\n</ul>\r\n</li>\r\n<li>CP Lomba :\r\n<ul>\r\n<li>Dony : 081217553856/ Line surbakti_d</li>\r\n<li>Sanni : 087882262288/ Line sanisahidah</li>\r\n</ul>\r\n</li>\r\n</ul>\r\n<p>Sampai berjumpa nanti!</p>\r\n<p>&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;&mdash;</p>\r\n<p><strong>Follow our official account:</strong></p>\r\n<ul>\r\n<li>Instagram : @wifi2018.widyatama</li>\r\n<li>YouTube: himatifTV</li>\r\n<li>Twitter: @Himatif_Utama</li>\r\n<li>Line : @kcv6263n (Include @).</li>\r\n</ul>', 'publish', 'widyatama-informatics-festival-wifi-2018-bandung', 'posting', '2018-03-10 22:53:22', '2018-03-10 23:00:54', 'myadmin', '0', null, '1', '2018-03-10 22:55:43', 'id', '0', 'public', null, null, 'Universitas Widyatama', 'Jalan Cikutra No.204A, Sukapada, Cibeunying Kidul, Sukapada, Cibeunying Kidul, Kota Bandung, Jawa Barat 40125, Indonesia', '2018-03-21 08:00:00', '2018-03-20 10:00:00', '107.64562610000007', '-6.8977681', 'event', 'Y', null, 'N');
INSERT INTO `c_post` VALUES ('23', 'myadmin', 'SEMINAR DAN WORKSHOP Explore (LINE) Chatbot “Build Operate and Transfer”', '<p><strong>SEMINAR DAN WORKSHOP Explore (LINE) Chatbot &ldquo;Build Operate and Transfer&rdquo;</strong></p>\r\n<p><strong>Tanggal:</strong>&nbsp;Sabtu, 10 Februari 2018<br /><strong>Tempat:</strong>&nbsp;Gedung Miracle dan Lab 7, Universitas Komputer Indonesia, Bandung<br /><strong>Waktu</strong></p>\r\n<ul>\r\n<li>Seminar: 07.30-12.00 WIB</li>\r\n<li>Workshop: 12.30-15.00 WIB</li>\r\n</ul>\r\n<p><strong>HTM:</strong></p>\r\n<ul>\r\n<li>Seminar: 45K</li>\r\n<li>Seminar + Workshop: 100K (Kuota Terbatas)</li>\r\n</ul>\r\n<p><a class=\"\" href=\"http://jadwalevent.web.id/wp-content/uploads/2018/01/Pamflet-fix-fix.jpg\" target=\"_blank\" rel=\"noopener\"><img class=\"aligncenter wp-image-54715 size-full tc-smart-load-skip tc-smart-loaded\" title=\"SEMINAR DAN WORKSHOP Explore (LINE) Chatbot &ldquo;Build Operate and Transfer&rdquo;\" src=\"http://jadwalevent.web.id/wp-content/uploads/2018/01/Pamflet-fix-fix.jpg\" sizes=\"(max-width: 1000px) 100vw, 1000px\" srcset=\"http://jadwalevent.web.id/wp-content/uploads/2018/01/Pamflet-fix-fix.jpg 1000w, http://jadwalevent.web.id/wp-content/uploads/2018/01/Pamflet-fix-fix-768x1086.jpg 768w\" alt=\"SEMINAR DAN WORKSHOP Explore (LINE) Chatbot &ldquo;Build Operate and Transfer&rdquo;\" width=\"1000\" height=\"1414\" /></a></p>\r\n<p><strong>Pembicara (Pemateri) :</strong></p>\r\n<p>Toni Haryanto (Co-Founder &amp; CIO at Codepolitan)<br />Fata El Islami (Co-Founder Islamify )</p>\r\n<p>Fasilitas :</p>\r\n<ul>\r\n<li>&radic; Pengetahuan</li>\r\n<li>&radic; Sertifikat</li>\r\n<li>&radic; Seminar Kit</li>\r\n<li>&radic; Snack</li>\r\n<li>&radic; Doorprize!!</li>\r\n</ul>\r\n<p><strong>&nbsp;REGISTRASI</strong><br />&nbsp;Tanggal :<br />18 Jan &ndash; 07 Feb 2018</p>\r\n<p><strong>Waktu Pendaftaran :</strong><br />09.00- 15.00 WIB</p>\r\n<p><strong>&nbsp;Pendaftaran :</strong></p>\r\n<ul>\r\n<li>&radic; Lorong pelataran ekonomi UNIKOM</li>\r\n<li>&radic; Sekretariat HMIF R4417 UNIKOM<br />Atau</li>\r\n<li>&radic;&nbsp;<a href=\"http://bit.ly/seminarHMIF\" target=\"_blank\" rel=\"noopener\"><strong>bit.ly/seminarHMIF</strong></a>&nbsp;(Registrasi Online)</li>\r\n</ul>\r\n<p><strong>&nbsp;Narahubung</strong>&nbsp;:</p>\r\n<p>&ndash; Prayoga 089649402582<br />&ndash; Siti Melinda&nbsp; 081222448193</p>', 'publish', 'seminar-dan-workshop-explore-line-chatbot-build-operate-and-transfer', 'posting', '2018-03-10 22:56:14', null, null, '0', null, '1', '2018-03-10 22:59:11', 'id', '0', 'public', null, null, 'Universitas Komputer Indonesia', 'Jalan Dipatiukur No. 112-116, Coblong, Lebakgede, Bandung, Lebakgede, Coblong, Kota Bandung, Jawa Barat 40132, Indonesia', '2018-03-21 08:00:00', '2018-03-21 12:00:00', '107.61529510000003', '-6.886824499999999', 'event', 'Y', null, 'N');
INSERT INTO `c_post` VALUES ('24', 'myadmin', 'Phalcon - Framework PHP dengan Performa Paling Cepat', '<p>Phalcon merupakan&nbsp;<em>framework</em>&nbsp;PHP paling cepat saat ini. Kecepatan eksekusi programnya mengalahkan beberapa framework terkenal. Phalcon juga sempat menjadi perbincangan menarik di salah satu forum PHP Indonesia. Diawali dari thread salah satu anggota yang membagikan hasil survey&nbsp;Popular PHP Framework oleh SitePoint (<a class=\"vglnk\" href=\"http://www.sitepoint.com/best-php-frameworks-2014\" rel=\"nofollow\">http://www.sitepoint.com/best-php-frameworks-2014</a>), selanjutnya banyak member yang berkomentar dan tidak menyangka bahwa nama yang&nbsp;terasa asing ini menempati urutan kedua terpopular setelah&nbsp;<a href=\"http://laravel.com/\" target=\"_blank\" rel=\"noopener\">Laravel</a>&nbsp;dengan perolehan 16.73%. Jujur, pada waktu itu pun saya adalah salah satunya yang baru tahu nama&nbsp;Phalcon.</p>\r\n<p>Project Phalcon sendiri sebenarnya sudah dimulai sejak 2012, kemudian baru meraih&nbsp;<em>stable release&nbsp;</em>&nbsp;tidak lama ini tepatnya pada 6 June 2014.&nbsp;Framework ini ditulis dalam bahasa C, C++, dan PHP. Phalcon juga menggunakan pola MVC seperti halnya&nbsp;<em>framework</em>&nbsp;popular lainnya seperti Cake, Codeigniter, Yii, Laravel, dll. Catatan penting yang harus&nbsp;kita&nbsp;tahu, ternyata wujud Phalcon adalah PHP C-Extension. Phalcon tidak ditulis dalam plain PHP.</p>\r\n<p>Kamu tidak akan menemukan folder berisi file .php seperti halnya&nbsp;<em>framework</em>lain. Contoh extension sendiri seperti yang biasa kita gunakan BCMath, Ctype, FTP, MySQL, ODBC, Overload, PCRE, Session dan Curl. &nbsp;Jika sudah terpasang, kita dapat memanggil fungsi tersebut langsung di&nbsp;<em>source code</em>&nbsp;php.</p>\r\n<p>Phalcon dibungkus dalam ekstensi C, bertujuan untuk&nbsp;menangani lebih banyak request. Jika ditulis dalam C maka kecepatan eksekusi program akan lebih cepat dan penggunaan resource juga berkurang.</p>\r\n<p>Sebagai framework, Phalcon pun sudah menyediakan berbagai alat perang yang kita butuhkan seperti : ORM, Pagination, Cache, Form Builder, dan Template Engine bernama&nbsp;<strong>Volt</strong>. Kamu bisa lihat lebih lengkap disini&nbsp;<a class=\"vglnk\" href=\"http://docs.phalconphp.com/\" rel=\"nofollow\">http://docs.phalconphp.com</a></p>\r\n<p>Project open source ini sudah diunggah di&nbsp;<a href=\"https://github.com/phalcon/cphalcon\" target=\"_blank\" rel=\"noopener\">github</a>. Sampai sekarang Phalcon telah mempunyai 58 kontributor, 3662 stars, juga 518 fork.&nbsp;Kamu juga bisa ikut bertanya, berdiskusi dan berkontribusi dalam&nbsp;<a href=\"http://forum.phalconphp.com/\" target=\"_blank\" rel=\"noopener\">forum resminya</a>&nbsp;. Untuk komunitas di&nbsp;Indonesia,&nbsp;kamu bisa kunjungi&nbsp;<a href=\"https://www.facebook.com/groups/219267124894634\" target=\"_blank\" rel=\"noopener\">Phalcon PHP Indonesia</a>. Memang jika kita tengok anggotanya baru 241 orang,&nbsp;framework ini belum terlalu terkenal di Indonesia.</p>\r\n<p>Buat kamu yang tertarik belajar, saya sarankan untuk mengikuti live tutorial di&nbsp;<a href=\"http://try.phalconphp.com/\" target=\"_blank\" rel=\"noopener\">Try Phalcon</a>.&nbsp;Jika ingin mencicipi langsung di kompi kamu,&nbsp;kamu bisa mengunduhnya&nbsp;<a href=\"http://phalconphp.com/en/download\" target=\"_blank\" rel=\"noopener\">disini</a>.</p>\r\n<p>Sumber:&nbsp;<a href=\"http://phalconphp.com/\" target=\"_blank\" rel=\"noopener\">http://phalconphp.com</a><a href=\"http://en.wikipedia.org/wiki/Phalcon_(framework)\" target=\"_blank\" rel=\"noopener\">http://en.wikipedia.org/wiki/Phalcon_(framework)</a></p>', 'publish', 'phalcon-framework-php-dengan-performa-paling-cepat', 'posting', '2018-03-11 11:37:53', null, null, '0', '1', '1', '2018-03-11 11:40:33', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');
INSERT INTO `c_post` VALUES ('25', 'myadmin', 'Mengenal Apa itu Framework CodeIgniter', '<h3><strong>Apa itu Framework?</strong></h3>\r\n<p>Framework atau dalam bahasa indonesia dapat diartikan sebagai &ldquo;kerangka kerja&rdquo; merupakan kumpulan dari fungsi-fungsi/prosedur-prosedur dan class-class untuk tujuan tertentu yang sudah siap digunakan sehingga bisa lebih mempermudah dan mempercepat pekerjaan seorang programer, tanpa harus membuat fungsi atau class dari awal.</p>\r\n<p><strong>Alasan mengapa menggunakan Framework</strong></p>\r\n<ul>\r\n<li>Mempercepat dan mempermudah pembangunan sebuah aplikasi web.</li>\r\n<li>Relatif memudahkan dalam proses maintenance karena sudah ada pola tertentu dalam sebuah framework (dengan syarat programmermengikuti pola standar yang ada)</li>\r\n<li>Umumnya framework menyediakan fasilitas-fasilitas yang umum dipakai sehingga kita tidak perlu membangun dari awal (misalnya validasi, ORM, pagination, multiple database, scaffolding, pengaturan session, error handling, dll</li>\r\n<li>Lebih bebas dalam pengembangan jika dibandingkan CMS</li>\r\n</ul>\r\n<p>&nbsp;</p>\r\n<h3><strong>Apa itu CodeIgniter</strong></h3>\r\n<div><img src=\"https://idcloudhost.com/wp-content/uploads/2017/08/CI.png\" /></div>\r\n<p>CodeIgniter adalah sebuah web application network yang bersifat open source yang digunakan untuk membangun aplikasi php dinamis.</p>\r\n<p>CodeIgniter menjadi sebuah framework PHP dengan model MVC&nbsp;<code>(Model, View, Controller)</code>&nbsp;untuk membangun website dinamis dengan menggunakan PHP yang dapat mempercepat pengembang untuk membuat sebuah aplikasi web. Selain ringan dan cepat, CodeIgniter juga memiliki dokumentasi yang super lengkap disertai dengan contoh implementasi kodenya. Dokumentasi yang lengkap inilah yang menjadi salah satu alasan kuat mengapa banyak orang memilih CodeIgniter sebagai framework pilihannya. Karena kelebihan-kelebihan yang dimiliki oleh CodeIgniter, pembuat PHP Rasmus Lerdorf memuji CodeIgniter di frOSCon (Agustus 2008) dengan mengatakan bahwa dia menyukai CodeIgniter karena &ldquo;it is faster, lighter and the least like a framework.&rdquo;</p>\r\n<p>CodeIgniter pertamakali dikembangkan pada tahun&nbsp;<code>2006 oleh Rick Ellis</code>. Dengan logo api yang menyala, CodeIgniter dengan cepat &ldquo;membakar&rdquo; semangat para web developer untuk mengembangkan web dinamis dengan cepat dan mudah menggunakan framework PHP yang satu ini.</p>\r\n<div>\r\n<p><strong>Perbandingan PHP Biasa dengan CodeIgniter</strong></p>\r\n</div>\r\n<div>\r\n<p><img class=\"\" src=\"https://idcloudhost.com/wp-content/uploads/2017/08/1.jpg\" width=\"481\" height=\"227\" /></p>\r\n<p>&nbsp;</p>\r\n</div>\r\n<div>\r\n<p><strong>Alur Kerja Framework CodeIgniter</strong></p>\r\n</div>\r\n<div><img class=\"\" title=\"Mengenal Apa Itu Framework CodeIgniter\" src=\"https://idcloudhost.com/wp-content/uploads/2017/08/2.jpg\" alt=\"Mengenal Apa Itu Framework CodeIgniter\" width=\"505\" height=\"174\" /></div>\r\n<ul>\r\n<li><strong>Index.php</strong>: Index.php disini berfungsi sebagai file pertama dalam program yang akan dibaca oleh program.</li>\r\n<li><strong>The Router</strong>: Router akan memeriksa HTTP request untuk menentukan hal apa yang harus dilakukan oleh program.</li>\r\n<li><strong>Cache File</strong>: Apabila dalam program sudah terdapat &ldquo;cache file&rdquo; maka file tersebut akan langsung dikirim ke browser. File cache inilah yang dapat membuat sebuah website dapat di buka dengan lebih cepat. Cache file dapat melewati proses yang sebenarnya harus dilakukan oleh program codeigniter.</li>\r\n<li><strong>Security</strong>: Sebelum file controller di load keseluruhan, HTTP request dan data yang disubmit oleh user akan disaring terlebih dahulu melalui fasilitas security yang dimiliki oleh codeigniter.</li>\r\n<li><strong>Controller</strong>: Controller akan membuka file model, core libraries, helper dan semua resources yang dibutuhkan dalam program tersebut.</li>\r\n<li><strong>View</strong>: Hal yang terakhir akan dilakukan adalah membaca semua program yang ada dalam view file dan mengirimkannya ke browser supaya dapat dilihat. Apabila file view sudah ada yang di &ldquo;cache&rdquo; maka file view baru yang belum ter-cache akan mengupdate file view yang sudah ada.</li>\r\n</ul>\r\n<p>&nbsp;</p>\r\n<p><strong>Contoh File untuk Model, View dan Controller</strong></p>\r\n<ol>\r\n<li><strong>Model / buku_model.php<br /></strong>\r\n<p>&nbsp;</p>\r\n<div>\r\n<p><img class=\"\" title=\"Mengenal Apa Itu Framework CodeIgniter\" src=\"https://idcloudhost.com/wp-content/uploads/2017/08/3.jpg\" alt=\"Mengenal Apa Itu Framework CodeIgniter\" width=\"480\" height=\"351\" /></p>\r\n</div>\r\n</li>\r\n<li><strong>View / buku_view.php<br /></strong>\r\n<p>&nbsp;</p>\r\n<div>\r\n<p><img class=\"\" title=\"Mengenal Apa Itu Framework CodeIgniter\" src=\"https://idcloudhost.com/wp-content/uploads/2017/08/4.jpg\" alt=\"Mengenal Apa Itu Framework CodeIgniter\" width=\"483\" height=\"373\" /></p>\r\n</div>\r\n</li>\r\n<li><strong>Controller / buku.php<br /></strong>\r\n<p>&nbsp;</p>\r\n<div><img class=\"\" title=\"Mengenal Apa Itu Framework CodeIgniter\" src=\"https://idcloudhost.com/wp-content/uploads/2017/08/5.jpg\" alt=\"Mengenal Apa Itu Framework CodeIgniter\" width=\"476\" height=\"306\" /></div>\r\n</li>\r\n</ol>', 'publish', 'mengenal-apa-itu-framework-codeigniter', 'posting', '2018-03-11 11:55:22', null, null, '0', null, '1', '2018-03-11 11:57:01', 'id', '0', 'public', null, null, '', '', null, null, '', '', 'web-programming', 'N', null, 'N');

-- ----------------------------
-- Table structure for c_post_category
-- ----------------------------
DROP TABLE IF EXISTS `c_post_category`;
CREATE TABLE `c_post_category` (
  `id_category` bigint(20) NOT NULL AUTO_INCREMENT,
  `tags_slug` varchar(100) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `tags_title` varchar(50) DEFAULT NULL,
  `catagory` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of c_post_category
-- ----------------------------
INSERT INTO `c_post_category` VALUES ('49', 'seminar', '23', 'seminar', 'event');
INSERT INTO `c_post_category` VALUES ('50', 'seminar-bandung', '23', 'seminar bandung', 'event');
INSERT INTO `c_post_category` VALUES ('51', 'seminar-it-bandung', '23', 'seminar IT bandung', 'event');
INSERT INTO `c_post_category` VALUES ('52', 'workshop', '23', 'workshop', 'event');
INSERT INTO `c_post_category` VALUES ('53', 'toni-haryanto', '23', 'Toni Haryanto', 'event');
INSERT INTO `c_post_category` VALUES ('54', 'fata-el-islami', '23', 'Fata El Islami', 'event');
INSERT INTO `c_post_category` VALUES ('55', 'seminar', '22', 'seminar', 'event');
INSERT INTO `c_post_category` VALUES ('56', 'seminar-bandung', '22', 'seminar bandung', 'event');
INSERT INTO `c_post_category` VALUES ('57', 'seminar-it-bandung', '22', 'seminar IT bandung', 'event');
INSERT INTO `c_post_category` VALUES ('58', 'ironno-widodo-purbo', '22', 'Ir.Onno Widodo Purbo', 'event');
INSERT INTO `c_post_category` VALUES ('59', 'irbudi-rahardjo-msc-phd', '22', 'Ir.Budi Rahardjo M.Sc , Ph.D', 'event');
INSERT INTO `c_post_category` VALUES ('60', 'mysql', '20', 'mysql', 'web-programming');
INSERT INTO `c_post_category` VALUES ('61', 'mysql', '21', 'mysql', 'web-programming');
INSERT INTO `c_post_category` VALUES ('62', 'php', '10', 'php', 'web-programming');
INSERT INTO `c_post_category` VALUES ('63', 'php', '5', 'php', 'web-programming');
INSERT INTO `c_post_category` VALUES ('64', 'javascript', '18', 'javascript', 'web-programming');
INSERT INTO `c_post_category` VALUES ('65', 'javascript', '17', 'javascript', 'web-programming');
INSERT INTO `c_post_category` VALUES ('66', 'javascript', '16', 'javascript', 'web-programming');
INSERT INTO `c_post_category` VALUES ('67', 'html', '11', 'html', 'web-programming');
INSERT INTO `c_post_category` VALUES ('68', 'html', '13', 'html', 'web-programming');
INSERT INTO `c_post_category` VALUES ('69', 'html', '12', 'html', 'web-programming');
INSERT INTO `c_post_category` VALUES ('70', 'css', '15', 'css', 'web-programming');
INSERT INTO `c_post_category` VALUES ('72', 'php', '24', 'php', 'web-programming');
INSERT INTO `c_post_category` VALUES ('73', 'php-framework', '24', 'php framework', 'web-programming');
INSERT INTO `c_post_category` VALUES ('74', 'phalcon', '24', 'phalcon', 'web-programming');
INSERT INTO `c_post_category` VALUES ('75', 'php', '25', 'php', 'web-programming');
INSERT INTO `c_post_category` VALUES ('76', 'php-framework', '25', 'php framework', 'web-programming');
INSERT INTO `c_post_category` VALUES ('77', 'codeigniter', '25', 'codeigniter', 'web-programming');
INSERT INTO `c_post_category` VALUES ('78', 'css', '14', 'css', 'web-programming');

-- ----------------------------
-- Table structure for c_post_views
-- ----------------------------
DROP TABLE IF EXISTS `c_post_views`;
CREATE TABLE `c_post_views` (
  `id_post_views` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip_addr` varchar(30) DEFAULT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `total_views` int(11) DEFAULT '1',
  `last_read` datetime DEFAULT NULL,
  PRIMARY KEY (`id_post_views`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of c_post_views
-- ----------------------------
INSERT INTO `c_post_views` VALUES ('1', '127.0.0.1', '6', '1', '2018-04-01 15:15:31');
INSERT INTO `c_post_views` VALUES ('2', '127.0.0.1', '7', '1', '2018-02-01 15:15:35');
INSERT INTO `c_post_views` VALUES ('3', '127.0.0.1', '8', '1', '2018-01-01 15:15:38');
INSERT INTO `c_post_views` VALUES ('4', '127.0.0.1', '5', '9', '2018-03-19 00:28:10');
INSERT INTO `c_post_views` VALUES ('5', '127.0.0.1', '10', '42', '2018-03-11 15:15:50');
INSERT INTO `c_post_views` VALUES ('6', '127.0.0.1', '23', '11', '2018-03-19 00:49:26');
INSERT INTO `c_post_views` VALUES ('7', '127.0.0.1', '22', '6', '2018-03-19 00:04:12');
INSERT INTO `c_post_views` VALUES ('8', '127.0.0.1', '21', '5', '2018-03-12 12:32:31');
INSERT INTO `c_post_views` VALUES ('9', '127.0.0.1', '20', '1', '2018-03-10 23:47:24');
INSERT INTO `c_post_views` VALUES ('10', '127.0.0.1', '18', '1', '2018-03-10 23:47:27');
INSERT INTO `c_post_views` VALUES ('11', '127.0.0.1', '11', '4', '2018-03-10 23:50:20');
INSERT INTO `c_post_views` VALUES ('12', '127.0.0.1', '25', '92', '2018-03-19 10:11:41');
INSERT INTO `c_post_views` VALUES ('13', '127.0.0.1', '24', '11', '2018-03-13 22:15:46');
INSERT INTO `c_post_views` VALUES ('14', '127.0.0.1', '14', '24', '2018-03-19 10:56:36');
INSERT INTO `c_post_views` VALUES ('15', '127.0.0.1', '15', '1', '2018-03-19 10:56:40');

-- ----------------------------
-- Table structure for m_access_list
-- ----------------------------
DROP TABLE IF EXISTS `m_access_list`;
CREATE TABLE `m_access_list` (
  `roles` varchar(32) NOT NULL,
  `resources_name` varchar(32) NOT NULL,
  `access_name` varchar(32) NOT NULL,
  `allowed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`roles`,`resources_name`,`access_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_access_list
-- ----------------------------
INSERT INTO `m_access_list` VALUES ('developer', '-207864bf944ebf058f58', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', '-4de6b48526deafa0cab5', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', '-5231c27c56cc0a013e68', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', '-c345f9f5acfefb086f59', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'advertising', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'advertising', 'delete', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'advertising', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'advertising', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'dashboard', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'datacategory', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'datacategory', 'delete', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'datacategory', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'datacategory', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'datatags', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'datatags', 'delete', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'datatags', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'manualbook', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'media', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'media', 'delete', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'media', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'media', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'menu', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'menu', 'delete', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'menu', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'menu', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'menuakses', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'menuakses', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'menuposisi', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'menuposisi', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'pagemenuposition', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'pagemenuposition', 'delete', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'pagemenuposition', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'pagemenuposition', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'post', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'post', 'delete', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'post', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'post', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'postingtype', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'postingtype', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'postingtype', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'roles', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'roles', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'roles', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'template', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'template', 'delete', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'template', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'template', 'index', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'users', 'add', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'users', 'edit', '1');
INSERT INTO `m_access_list` VALUES ('developer', 'users', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', '-207864bf944ebf058f58', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', '-4de6b48526deafa0cab5', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', '-5231c27c56cc0a013e68', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', '-90582bc699896410f8f5', 'index', '0');
INSERT INTO `m_access_list` VALUES ('guest', '-c345f9f5acfefb086f59', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'advertising', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'advertising', 'delete', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'advertising', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'advertising', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'dashboard', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'datacategory', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'datacategory', 'delete', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'datacategory', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'datacategory', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'datatags', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'datatags', 'delete', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'datatags', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'manualbook', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'media', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'media', 'delete', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'media', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'media', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'menu', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'menu', 'delete', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'menu', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'menu', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'menuakses', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'menuakses', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'menuposisi', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'menuposisi', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'pagemenuposition', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'pagemenuposition', 'delete', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'pagemenuposition', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'pagemenuposition', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'post', 'add', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'post', 'delete', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'post', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'post', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'postingtype', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'postingtype', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'postingtype', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'roles', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'roles', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'roles', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'template', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'template', 'delete', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'template', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'template', 'index', '1');
INSERT INTO `m_access_list` VALUES ('guest', 'users', 'add', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'users', 'delete', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'users', 'edit', '0');
INSERT INTO `m_access_list` VALUES ('guest', 'users', 'index', '1');

-- ----------------------------
-- Table structure for m_advertisement
-- ----------------------------
DROP TABLE IF EXISTS `m_advertisement`;
CREATE TABLE `m_advertisement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `advertiser` varchar(100) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` enum('Y','N') DEFAULT 'N',
  `url_web` varchar(255) DEFAULT NULL,
  `post_location` enum('home','all') DEFAULT NULL,
  `contract` enum('extend','new') DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_advertisement
-- ----------------------------
INSERT INTO `m_advertisement` VALUES ('1', 'bootstrap', '2018-02-28 00:00:00', '2018-03-10 00:00:00', 'Y', 'https://getbootstrap.com', 'home', 'extend', '1000');
INSERT INTO `m_advertisement` VALUES ('2', 'phalcon', '2018-03-01 00:00:00', '2018-03-31 00:00:00', 'Y', 'https://phalconphp.com/', 'all', 'new', '2000');

-- ----------------------------
-- Table structure for m_album
-- ----------------------------
DROP TABLE IF EXISTS `m_album`;
CREATE TABLE `m_album` (
  `album_id` int(11) NOT NULL AUTO_INCREMENT,
  `album_name` varchar(30) DEFAULT NULL,
  `album_parent_id` int(11) DEFAULT '0',
  PRIMARY KEY (`album_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_album
-- ----------------------------
INSERT INTO `m_album` VALUES ('1', 'Root', '0');
INSERT INTO `m_album` VALUES ('11', 'codeigniter', '14');
INSERT INTO `m_album` VALUES ('12', 'mysql', '1');
INSERT INTO `m_album` VALUES ('13', 'phalcon', '14');
INSERT INTO `m_album` VALUES ('14', 'framework', '1');
INSERT INTO `m_album` VALUES ('15', 'html', '1');
INSERT INTO `m_album` VALUES ('16', 'workshop', '1');
INSERT INTO `m_album` VALUES ('17', 'bandung', '16');
INSERT INTO `m_album` VALUES ('18', 'javascript', '17');
INSERT INTO `m_album` VALUES ('19', 'tes', '16');

-- ----------------------------
-- Table structure for m_category
-- ----------------------------
DROP TABLE IF EXISTS `m_category`;
CREATE TABLE `m_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) DEFAULT NULL,
  `slug` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_category
-- ----------------------------
INSERT INTO `m_category` VALUES ('7', 'Event', 'event');
INSERT INTO `m_category` VALUES ('8', 'Web Programming', 'web-programming');

-- ----------------------------
-- Table structure for m_icon
-- ----------------------------
DROP TABLE IF EXISTS `m_icon`;
CREATE TABLE `m_icon` (
  `icon_name` varchar(50) NOT NULL,
  PRIMARY KEY (`icon_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_icon
-- ----------------------------
INSERT INTO `m_icon` VALUES ('fa fa-address-book');
INSERT INTO `m_icon` VALUES ('fa fa-address-book-o');
INSERT INTO `m_icon` VALUES ('fa fa-address-card');
INSERT INTO `m_icon` VALUES ('fa fa-address-card-o');
INSERT INTO `m_icon` VALUES ('fa fa-area-chart');
INSERT INTO `m_icon` VALUES ('fa fa-at');
INSERT INTO `m_icon` VALUES ('fa fa-balance-scale');
INSERT INTO `m_icon` VALUES ('fa fa-ban');
INSERT INTO `m_icon` VALUES ('fa fa-bar-chart');
INSERT INTO `m_icon` VALUES ('fa fa-barcode');
INSERT INTO `m_icon` VALUES ('fa fa-bell');
INSERT INTO `m_icon` VALUES ('fa fa-bell-o');
INSERT INTO `m_icon` VALUES ('fa fa-bell-slash');
INSERT INTO `m_icon` VALUES ('fa fa-bell-slash-o');
INSERT INTO `m_icon` VALUES ('fa fa-book');
INSERT INTO `m_icon` VALUES ('fa fa-bookmark');
INSERT INTO `m_icon` VALUES ('fa fa-bookmark-o');
INSERT INTO `m_icon` VALUES ('fa fa-briefcase');
INSERT INTO `m_icon` VALUES ('fa fa-building');
INSERT INTO `m_icon` VALUES ('fa fa-building-o');
INSERT INTO `m_icon` VALUES ('fa fa-bullhorn');
INSERT INTO `m_icon` VALUES ('fa fa-calculator');
INSERT INTO `m_icon` VALUES ('fa fa-calendar');
INSERT INTO `m_icon` VALUES ('fa fa-calendar-check-o');
INSERT INTO `m_icon` VALUES ('fa fa-calendar-minus-o');
INSERT INTO `m_icon` VALUES ('fa fa-calendar-o');
INSERT INTO `m_icon` VALUES ('fa fa-calendar-plus-o');
INSERT INTO `m_icon` VALUES ('fa fa-calendar-times-o');
INSERT INTO `m_icon` VALUES ('fa fa-camera');
INSERT INTO `m_icon` VALUES ('fa fa-camera-retro');
INSERT INTO `m_icon` VALUES ('fa fa-cc-mastercard');
INSERT INTO `m_icon` VALUES ('fa fa-cc-paypal');
INSERT INTO `m_icon` VALUES ('fa fa-cc-visa');
INSERT INTO `m_icon` VALUES ('fa fa-code');
INSERT INTO `m_icon` VALUES ('fa fa-cog');
INSERT INTO `m_icon` VALUES ('fa fa-cogs');
INSERT INTO `m_icon` VALUES ('fa fa-comment');
INSERT INTO `m_icon` VALUES ('fa fa-comment-o');
INSERT INTO `m_icon` VALUES ('fa fa-commenting');
INSERT INTO `m_icon` VALUES ('fa fa-commenting-o');
INSERT INTO `m_icon` VALUES ('fa fa-credit-card');
INSERT INTO `m_icon` VALUES ('fa fa-credit-card-alt');
INSERT INTO `m_icon` VALUES ('fa fa-database');
INSERT INTO `m_icon` VALUES ('fa fa-desktop');
INSERT INTO `m_icon` VALUES ('fa fa-download');
INSERT INTO `m_icon` VALUES ('fa fa-envelope');
INSERT INTO `m_icon` VALUES ('fa fa-envelope-o');
INSERT INTO `m_icon` VALUES ('fa fa-envelope-open');
INSERT INTO `m_icon` VALUES ('fa fa-envelope-open-o');
INSERT INTO `m_icon` VALUES ('fa fa-exclamation-triangle');
INSERT INTO `m_icon` VALUES ('fa fa-external-link');
INSERT INTO `m_icon` VALUES ('fa fa-external-link-square');
INSERT INTO `m_icon` VALUES ('fa fa-fax');
INSERT INTO `m_icon` VALUES ('fa fa-female');
INSERT INTO `m_icon` VALUES ('fa fa-file-text');
INSERT INTO `m_icon` VALUES ('fa fa-file-text-o');
INSERT INTO `m_icon` VALUES ('fa fa-globe');
INSERT INTO `m_icon` VALUES ('fa fa-graduation-cap');
INSERT INTO `m_icon` VALUES ('fa fa-history');
INSERT INTO `m_icon` VALUES ('fa fa-home');
INSERT INTO `m_icon` VALUES ('fa fa-inbox');
INSERT INTO `m_icon` VALUES ('fa fa-info');
INSERT INTO `m_icon` VALUES ('fa fa-info-circle');
INSERT INTO `m_icon` VALUES ('fa fa-male');
INSERT INTO `m_icon` VALUES ('fa fa-map-marker');
INSERT INTO `m_icon` VALUES ('fa fa-newspaper-o');
INSERT INTO `m_icon` VALUES ('fa fa-pencil');
INSERT INTO `m_icon` VALUES ('fa fa-pencil-square');
INSERT INTO `m_icon` VALUES ('fa fa-pencil-square-o');
INSERT INTO `m_icon` VALUES ('fa fa-percent');
INSERT INTO `m_icon` VALUES ('fa fa-phone');
INSERT INTO `m_icon` VALUES ('fa fa-phone-square');
INSERT INTO `m_icon` VALUES ('fa fa-picture-o');
INSERT INTO `m_icon` VALUES ('fa fa-pie-chart');
INSERT INTO `m_icon` VALUES ('fa fa-print');
INSERT INTO `m_icon` VALUES ('fa fa-question');
INSERT INTO `m_icon` VALUES ('fa fa-question-circle');
INSERT INTO `m_icon` VALUES ('fa fa-question-circle-o');
INSERT INTO `m_icon` VALUES ('fa fa-road');
INSERT INTO `m_icon` VALUES ('fa fa-rss');
INSERT INTO `m_icon` VALUES ('fa fa-rss-square');
INSERT INTO `m_icon` VALUES ('fa fa-search');
INSERT INTO `m_icon` VALUES ('fa fa-server');
INSERT INTO `m_icon` VALUES ('fa fa-share');
INSERT INTO `m_icon` VALUES ('fa fa-sticky-note');
INSERT INTO `m_icon` VALUES ('fa fa-sticky-note-o');
INSERT INTO `m_icon` VALUES ('fa fa-street-view');
INSERT INTO `m_icon` VALUES ('fa fa-suitcase');
INSERT INTO `m_icon` VALUES ('fa fa-tachometer');
INSERT INTO `m_icon` VALUES ('fa fa-tag');
INSERT INTO `m_icon` VALUES ('fa fa-tags');
INSERT INTO `m_icon` VALUES ('fa fa-tasks');
INSERT INTO `m_icon` VALUES ('fa fa-thumb-tack');
INSERT INTO `m_icon` VALUES ('fa fa-thumbs-o-up');
INSERT INTO `m_icon` VALUES ('fa fa-thumbs-up');
INSERT INTO `m_icon` VALUES ('fa fa-trash');
INSERT INTO `m_icon` VALUES ('fa fa-trash-o');
INSERT INTO `m_icon` VALUES ('fa fa-trophy');
INSERT INTO `m_icon` VALUES ('fa fa-university');
INSERT INTO `m_icon` VALUES ('fa fa-user-circle');
INSERT INTO `m_icon` VALUES ('fa fa-user-o');
INSERT INTO `m_icon` VALUES ('fa fa-user-plus');
INSERT INTO `m_icon` VALUES ('fa fa-users');
INSERT INTO `m_icon` VALUES ('fa fa-window-close');

-- ----------------------------
-- Table structure for m_media_advertisement
-- ----------------------------
DROP TABLE IF EXISTS `m_media_advertisement`;
CREATE TABLE `m_media_advertisement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_advertisement` int(11) DEFAULT NULL,
  `media_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_media_advertisement
-- ----------------------------
INSERT INTO `m_media_advertisement` VALUES ('12', '2', '1');
INSERT INTO `m_media_advertisement` VALUES ('13', '2', '2');
INSERT INTO `m_media_advertisement` VALUES ('14', '2', '3');
INSERT INTO `m_media_advertisement` VALUES ('15', '1', '3');

-- ----------------------------
-- Table structure for m_menu
-- ----------------------------
DROP TABLE IF EXISTS `m_menu`;
CREATE TABLE `m_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `resources_name` varchar(50) NOT NULL,
  `access_name` varchar(30) NOT NULL,
  `menu_title` varchar(30) DEFAULT NULL,
  `menu_parent_id` int(11) DEFAULT '0',
  `menu_order` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0' COMMENT '0=tidak aktif, 1 = aktif',
  `show_menu` enum('N','Y') DEFAULT 'N',
  `icon` varchar(50) DEFAULT NULL,
  `parent_only` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`menu_id`,`resources_name`,`access_name`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_menu
-- ----------------------------
INSERT INTO `m_menu` VALUES ('1', 'dashboard', 'index', 'Dashboard', '0', '0', 'monitoring laman dashboard', '0', 'Y', 'fa fa-desktop', 'N');
INSERT INTO `m_menu` VALUES ('3', 'users', 'index', 'Users', '51', '2', 'Manajemen users', '0', 'Y', 'fa fa-user-circle', 'N');
INSERT INTO `m_menu` VALUES ('4', 'users', 'add', 'Tambah users baru', '0', null, null, '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('6', 'roles', 'index', 'Roles', '51', '3', '', '0', 'Y', 'fa fa-address-card-o', 'N');
INSERT INTO `m_menu` VALUES ('7', 'roles', 'add', 'Tambah Role', '0', null, null, '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('8', 'roles', 'edit', 'Edit Roles', '0', null, null, '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('9', 'menu', 'index', 'Menu', '61', '6', 'Manajemen Menu', '0', 'Y', 'fa fa-file-text', 'N');
INSERT INTO `m_menu` VALUES ('10', 'menu', 'add', 'Tambah Menu', '0', null, null, '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('11', 'menu', 'edit', 'Edit Menu', '0', null, null, '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('12', 'menu', 'delete', null, '0', null, null, '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('14', 'menuakses', 'index', 'Users Akses', '51', '4', 'set akses user menu', '0', 'Y', 'fa fa-ban', 'N');
INSERT INTO `m_menu` VALUES ('15', 'menuposisi', 'index', 'Menu Position', '61', '7', 'set posisi menu admin', '0', 'Y', 'fa fa-map-marker', 'N');
INSERT INTO `m_menu` VALUES ('17', 'menuakses', 'edit', 'update akses users', '0', null, 'set akses modul', '0', 'N', '', 'N');
INSERT INTO `m_menu` VALUES ('18', 'menuposisi', 'edit', 'set posisi menu', '0', null, 'set posisi menu', '0', 'N', '', 'N');
INSERT INTO `m_menu` VALUES ('20', 'postingtype', 'add', 'tambah data', '0', null, 'tambah data', '0', 'N', 'add', 'N');
INSERT INTO `m_menu` VALUES ('21', 'postingtype', 'index', 'Posting Type', '61', '8', 'tipe posting', '0', 'Y', 'fa fa-question-circle-o', 'N');
INSERT INTO `m_menu` VALUES ('22', 'postingtype', 'edit', 'edit data', '0', null, 'edit data', '0', 'N', 'create', 'N');
INSERT INTO `m_menu` VALUES ('24', 'post', 'add', 'tambah data', '0', null, 'tambah data', '0', 'N', 'fa fa-plus', 'N');
INSERT INTO `m_menu` VALUES ('25', 'post', 'index', 'Post', '0', null, 'posting data', '0', 'Y', 'fa fa-pencil-square-o', 'N');
INSERT INTO `m_menu` VALUES ('26', 'post', 'edit', 'edit data', '0', null, 'edit data', '0', 'N', 'fa fa-pencil', 'N');
INSERT INTO `m_menu` VALUES ('27', 'post', 'delete', 'delete data', '0', null, 'delete data', '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('29', 'media', 'add', 'tambah data', '0', null, 'tambah data', '0', 'N', 'fa fa-plus', 'N');
INSERT INTO `m_menu` VALUES ('30', 'media', 'index', 'Media', '62', '10', 'Media', '0', 'Y', 'fa fa-picture-o', 'N');
INSERT INTO `m_menu` VALUES ('31', 'media', 'edit', 'edit data', '0', null, 'edit data', '0', 'N', 'fa fa-pencil', 'N');
INSERT INTO `m_menu` VALUES ('32', 'media', 'delete', 'delete data', '0', null, 'delete data', '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('45', 'manualbook', 'index', 'Manual book MyCms', '0', '17', 'Manual book MyCms', '0', 'Y', 'fa fa-book', 'N');
INSERT INTO `m_menu` VALUES ('51', '-c345f9f5acfefb086f59', 'index', 'Manajemen Users', '0', '1', 'Manajemen  data users', '0', 'Y', 'fa fa-users', 'Y');
INSERT INTO `m_menu` VALUES ('53', '-5231c27c56cc0a013e68', 'index', 'Apps', '0', '14', 'Frontend apps', '0', 'Y', 'fa fa-globe', 'Y');
INSERT INTO `m_menu` VALUES ('54', 'template', 'index', 'Template', '53', '15', 'Data template', '0', 'Y', 'fa fa-pencil-square-o', 'N');
INSERT INTO `m_menu` VALUES ('55', 'pagemenuposition', 'index', 'Page Menu Position', '53', '16', 'Page Menu Position', '0', 'Y', 'fa fa-tags', 'N');
INSERT INTO `m_menu` VALUES ('56', 'pagemenuposition', 'edit', 'Edit page menu position', '0', null, 'Edit page menu position', '0', 'N', 'fa fa-pencil', 'N');
INSERT INTO `m_menu` VALUES ('57', 'template', 'add', 'tambah data', '0', null, 'tambah data', '0', 'N', 'fa fa-plus', 'N');
INSERT INTO `m_menu` VALUES ('58', 'template', 'edit', 'edit data', '0', null, 'edit data', '0', 'N', 'fa fa-pencil', 'N');
INSERT INTO `m_menu` VALUES ('59', 'template', 'delete', 'delete data', '0', null, 'delete data', '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('60', 'users', 'edit', 'Edit Users', '0', null, 'Edit users', '0', 'N', 'fa fa-pencil', 'N');
INSERT INTO `m_menu` VALUES ('61', '-4de6b48526deafa0cab5', 'index', 'Manajemen Menu', '0', '5', 'Manajemen data menu', '0', 'Y', 'fa fa-balance-scale', 'Y');
INSERT INTO `m_menu` VALUES ('62', '-207864bf944ebf058f58', 'index', 'Data Master', '0', '9', 'Data master', '0', 'Y', 'fa fa-database', 'Y');
INSERT INTO `m_menu` VALUES ('63', 'datatags', 'index', 'Tags', '62', '12', 'Master data tags', '0', 'Y', 'fa fa-bookmark-o', 'N');
INSERT INTO `m_menu` VALUES ('64', 'datatags', 'delete', 'delete tags', '0', null, 'delete tags', '0', 'N', '', 'N');
INSERT INTO `m_menu` VALUES ('65', 'datatags', 'add', 'Tambah tags', '0', null, 'tambah data tags', '0', 'N', '', 'N');
INSERT INTO `m_menu` VALUES ('66', 'datacategory', 'add', 'tambah data', '0', null, 'tambah data', '0', 'N', 'fa fa-plus', 'N');
INSERT INTO `m_menu` VALUES ('67', 'datacategory', 'index', 'Category', '62', '11', 'master data category', '0', 'Y', 'fa fa-bookmark', 'N');
INSERT INTO `m_menu` VALUES ('68', 'datacategory', 'edit', 'edit data', '0', null, 'edit data', '0', 'N', 'fa fa-pencil', 'N');
INSERT INTO `m_menu` VALUES ('69', 'datacategory', 'delete', 'delete data', '0', null, 'delete data', '0', 'N', null, 'N');
INSERT INTO `m_menu` VALUES ('70', 'pagemenuposition', 'add', 'pagemenuposition', '0', null, 'membuat post type page dengan custom url', '0', 'N', '', 'N');
INSERT INTO `m_menu` VALUES ('71', 'pagemenuposition', 'delete', '', '0', null, 'delete post type page custom url', '0', 'N', '', 'N');
INSERT INTO `m_menu` VALUES ('76', 'advertising', 'add', 'tambah data', '0', null, 'tambah data', '0', 'N', 'fa fa-plus', 'N');
INSERT INTO `m_menu` VALUES ('77', 'advertising', 'index', 'Advertising', '62', '13', 'advertising', '0', 'Y', 'fa fa-briefcase', 'N');
INSERT INTO `m_menu` VALUES ('78', 'advertising', 'edit', 'edit data', '0', null, 'edit data', '0', 'N', 'fa fa-pencil', 'N');
INSERT INTO `m_menu` VALUES ('79', 'advertising', 'delete', 'delete data', '0', null, 'delete data', '0', 'N', null, 'N');

-- ----------------------------
-- Table structure for m_post_action
-- ----------------------------
DROP TABLE IF EXISTS `m_post_action`;
CREATE TABLE `m_post_action` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) DEFAULT NULL,
  `author` varchar(50) DEFAULT NULL,
  `ket` enum('delete','update') DEFAULT NULL,
  `act_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_post_action
-- ----------------------------
INSERT INTO `m_post_action` VALUES ('1', '25', null, 'update', '2018-03-11 11:57:02');
INSERT INTO `m_post_action` VALUES ('2', '29', null, 'update', '2018-03-11 15:48:40');
INSERT INTO `m_post_action` VALUES ('3', '29', null, 'delete', '2018-03-11 15:48:48');
INSERT INTO `m_post_action` VALUES ('4', '32', null, 'update', '2018-03-11 15:51:24');
INSERT INTO `m_post_action` VALUES ('5', '32', null, 'delete', '2018-03-11 15:51:32');
INSERT INTO `m_post_action` VALUES ('6', '33', null, 'update', '2018-03-11 15:52:51');
INSERT INTO `m_post_action` VALUES ('7', '33', 'myadmin', 'update', '2018-03-11 15:53:23');
INSERT INTO `m_post_action` VALUES ('8', '33', 'myadmin', 'delete', '2018-03-11 15:53:31');
INSERT INTO `m_post_action` VALUES ('9', '34', null, 'delete', '2018-03-11 15:55:12');
INSERT INTO `m_post_action` VALUES ('10', '3', 'myadmin', 'update', '2018-03-11 20:21:41');
INSERT INTO `m_post_action` VALUES ('11', '4', 'myadmin', 'update', '2018-03-11 20:21:42');
INSERT INTO `m_post_action` VALUES ('12', '3', 'myadmin', 'update', '2018-03-11 20:21:47');
INSERT INTO `m_post_action` VALUES ('13', '4', 'myadmin', 'update', '2018-03-11 20:21:48');
INSERT INTO `m_post_action` VALUES ('14', '3', 'myadmin', 'update', '2018-03-11 21:03:41');
INSERT INTO `m_post_action` VALUES ('15', '4', 'myadmin', 'update', '2018-03-11 21:03:41');
INSERT INTO `m_post_action` VALUES ('16', '3', 'myadmin', 'update', '2018-03-11 21:03:42');
INSERT INTO `m_post_action` VALUES ('17', '4', 'myadmin', 'update', '2018-03-11 21:03:43');
INSERT INTO `m_post_action` VALUES ('18', '3', 'myadmin', 'update', '2018-03-11 21:30:25');
INSERT INTO `m_post_action` VALUES ('19', '4', 'myadmin', 'update', '2018-03-11 21:30:26');
INSERT INTO `m_post_action` VALUES ('20', '3', 'myadmin', 'update', '2018-03-11 21:30:28');
INSERT INTO `m_post_action` VALUES ('21', '4', 'myadmin', 'update', '2018-03-11 21:30:28');
INSERT INTO `m_post_action` VALUES ('22', '3', 'myadmin', 'update', '2018-03-11 21:30:33');
INSERT INTO `m_post_action` VALUES ('23', '4', 'myadmin', 'update', '2018-03-11 21:30:33');
INSERT INTO `m_post_action` VALUES ('24', '3', 'myadmin', 'update', '2018-03-11 21:30:36');
INSERT INTO `m_post_action` VALUES ('25', '4', 'myadmin', 'update', '2018-03-11 21:30:36');
INSERT INTO `m_post_action` VALUES ('26', '3', 'myadmin', 'update', '2018-03-11 21:52:37');
INSERT INTO `m_post_action` VALUES ('27', '4', 'myadmin', 'update', '2018-03-11 21:52:37');
INSERT INTO `m_post_action` VALUES ('28', '4', 'myadmin', 'update', '2018-03-12 12:21:56');
INSERT INTO `m_post_action` VALUES ('29', '3', 'myadmin', 'update', '2018-03-12 12:21:56');
INSERT INTO `m_post_action` VALUES ('30', '4', 'myadmin', 'update', '2018-03-12 12:21:57');
INSERT INTO `m_post_action` VALUES ('31', '3', 'myadmin', 'update', '2018-03-12 12:21:57');
INSERT INTO `m_post_action` VALUES ('32', '4', 'myadmin', 'update', '2018-03-12 12:22:59');
INSERT INTO `m_post_action` VALUES ('33', '3', 'myadmin', 'update', '2018-03-12 12:22:59');
INSERT INTO `m_post_action` VALUES ('34', '3', 'myadmin', 'update', '2018-03-12 22:25:17');
INSERT INTO `m_post_action` VALUES ('35', '4', 'myadmin', 'update', '2018-03-12 22:25:17');
INSERT INTO `m_post_action` VALUES ('36', '29', null, 'update', '2018-03-12 22:25:17');
INSERT INTO `m_post_action` VALUES ('37', '4', 'myadmin', 'update', '2018-03-12 22:25:28');
INSERT INTO `m_post_action` VALUES ('38', '3', 'myadmin', 'update', '2018-03-12 22:25:28');
INSERT INTO `m_post_action` VALUES ('39', '29', null, 'update', '2018-03-12 22:25:28');
INSERT INTO `m_post_action` VALUES ('40', '29', 'myadmin', 'update', '2018-03-12 22:55:59');
INSERT INTO `m_post_action` VALUES ('41', '30', null, 'delete', '2018-03-12 23:25:34');
INSERT INTO `m_post_action` VALUES ('42', '31', null, 'delete', '2018-03-12 23:26:13');
INSERT INTO `m_post_action` VALUES ('43', '4', 'myadmin', 'update', '2018-03-12 23:39:06');
INSERT INTO `m_post_action` VALUES ('44', '32', null, 'update', '2018-03-12 23:39:06');
INSERT INTO `m_post_action` VALUES ('45', '3', 'myadmin', 'update', '2018-03-12 23:39:06');
INSERT INTO `m_post_action` VALUES ('46', '32', null, 'update', '2018-03-13 21:29:09');
INSERT INTO `m_post_action` VALUES ('47', '32', null, 'update', '2018-03-13 21:30:36');
INSERT INTO `m_post_action` VALUES ('48', '32', null, 'update', '2018-03-13 21:30:57');
INSERT INTO `m_post_action` VALUES ('49', '32', null, 'update', '2018-03-13 21:31:11');
INSERT INTO `m_post_action` VALUES ('50', '32', null, 'delete', '2018-03-13 21:31:34');
INSERT INTO `m_post_action` VALUES ('51', '4', 'myadmin', 'update', '2018-03-13 21:32:10');
INSERT INTO `m_post_action` VALUES ('52', '3', 'myadmin', 'update', '2018-03-13 21:32:10');
INSERT INTO `m_post_action` VALUES ('53', '33', null, 'update', '2018-03-13 21:32:10');
INSERT INTO `m_post_action` VALUES ('54', '4', 'myadmin', 'update', '2018-03-13 21:34:06');
INSERT INTO `m_post_action` VALUES ('55', '3', 'myadmin', 'update', '2018-03-13 21:34:07');
INSERT INTO `m_post_action` VALUES ('56', '33', null, 'update', '2018-03-13 21:34:07');
INSERT INTO `m_post_action` VALUES ('57', '4', 'myadmin', 'update', '2018-03-13 21:34:33');
INSERT INTO `m_post_action` VALUES ('58', '3', 'myadmin', 'update', '2018-03-13 21:34:33');
INSERT INTO `m_post_action` VALUES ('59', '33', null, 'update', '2018-03-13 21:34:33');
INSERT INTO `m_post_action` VALUES ('60', '4', 'myadmin', 'update', '2018-03-13 21:34:35');
INSERT INTO `m_post_action` VALUES ('61', '3', 'myadmin', 'update', '2018-03-13 21:34:35');
INSERT INTO `m_post_action` VALUES ('62', '33', null, 'update', '2018-03-13 21:34:35');
INSERT INTO `m_post_action` VALUES ('63', '4', 'myadmin', 'update', '2018-03-13 21:34:37');
INSERT INTO `m_post_action` VALUES ('64', '3', 'myadmin', 'update', '2018-03-13 21:34:37');
INSERT INTO `m_post_action` VALUES ('65', '33', null, 'update', '2018-03-13 21:34:37');
INSERT INTO `m_post_action` VALUES ('66', '33', null, 'delete', '2018-03-13 21:43:16');
INSERT INTO `m_post_action` VALUES ('67', '34', null, 'delete', '2018-03-13 21:44:37');
INSERT INTO `m_post_action` VALUES ('68', '27', null, 'delete', '2018-03-17 14:50:38');
INSERT INTO `m_post_action` VALUES ('69', '14', 'myadmin', 'update', '2018-03-18 23:39:38');

-- ----------------------------
-- Table structure for m_post_type
-- ----------------------------
DROP TABLE IF EXISTS `m_post_type`;
CREATE TABLE `m_post_type` (
  `post_type` varchar(50) NOT NULL,
  `post_type_des` varchar(100) DEFAULT NULL,
  `post_type_status` enum('Y','N') DEFAULT 'Y',
  `post_title` varchar(30) DEFAULT NULL,
  `post_icon` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`post_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_post_type
-- ----------------------------
INSERT INTO `m_post_type` VALUES ('page', 'posting dengan type page', 'Y', 'Page', 'fa fa-file-text');
INSERT INTO `m_post_type` VALUES ('posting', 'post dengan type posting', 'Y', 'Article', 'fa fa-newspaper-o');

-- ----------------------------
-- Table structure for m_roles
-- ----------------------------
DROP TABLE IF EXISTS `m_roles`;
CREATE TABLE `m_roles` (
  `roles` varchar(30) NOT NULL,
  `description` text,
  `roles_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`roles`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_roles
-- ----------------------------
INSERT INTO `m_roles` VALUES ('developer', 'developer', 'Depelover');
INSERT INTO `m_roles` VALUES ('guest', 'guest roles users', 'Guest');

-- ----------------------------
-- Table structure for m_tags
-- ----------------------------
DROP TABLE IF EXISTS `m_tags`;
CREATE TABLE `m_tags` (
  `tags_id` int(11) NOT NULL AUTO_INCREMENT,
  `tags_title` varchar(30) DEFAULT NULL,
  `tags_slug` varchar(50) NOT NULL,
  `tags_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`tags_id`,`tags_slug`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_tags
-- ----------------------------
INSERT INTO `m_tags` VALUES ('1', 'php', 'php', 'web-programming');
INSERT INTO `m_tags` VALUES ('2', 'html', 'html', 'web-programming');
INSERT INTO `m_tags` VALUES ('3', 'css', 'css', 'web-programming');
INSERT INTO `m_tags` VALUES ('4', 'javascript', 'javascript', 'web-programming');
INSERT INTO `m_tags` VALUES ('5', 'mysql', 'mysql', 'web-programming');
INSERT INTO `m_tags` VALUES ('6', 'seminar', 'seminar', 'event');
INSERT INTO `m_tags` VALUES ('7', 'seminar bandung', 'seminar-bandung', 'event');
INSERT INTO `m_tags` VALUES ('8', 'seminar IT bandung', 'seminar-it-bandung', 'event');
INSERT INTO `m_tags` VALUES ('9', 'workshop', 'workshop', 'event');
INSERT INTO `m_tags` VALUES ('10', 'Toni Haryanto', 'toni-haryanto', 'event');
INSERT INTO `m_tags` VALUES ('11', 'Fata El Islami', 'fata-el-islami', 'event');
INSERT INTO `m_tags` VALUES ('12', 'Ir.Onno Widodo Purbo', 'ironno-widodo-purbo', 'event');
INSERT INTO `m_tags` VALUES ('13', 'Ir.Budi Rahardjo M.Sc , Ph.D', 'irbudi-rahardjo-msc-phd', 'event');
INSERT INTO `m_tags` VALUES ('14', 'php framework', 'php-framework', 'web-programming');
INSERT INTO `m_tags` VALUES ('15', 'phalcon', 'phalcon', 'web-programming');
INSERT INTO `m_tags` VALUES ('16', 'codeigniter', 'codeigniter', 'web-programming');

-- ----------------------------
-- Table structure for m_template
-- ----------------------------
DROP TABLE IF EXISTS `m_template`;
CREATE TABLE `m_template` (
  `name` varchar(50) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '0',
  `screenshot` varchar(100) DEFAULT NULL,
  `template` enum('N','Y') DEFAULT 'N',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_template
-- ----------------------------
INSERT INTO `m_template` VALUES ('mytemplate2', 'Template 2', '0', null, 'N');

-- ----------------------------
-- Table structure for m_users
-- ----------------------------
DROP TABLE IF EXISTS `m_users`;
CREATE TABLE `m_users` (
  `username` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(150) DEFAULT NULL,
  `roles` varchar(50) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0' COMMENT '0=belum ubah password, 1=sudah ubah password',
  `full_name` varchar(50) DEFAULT NULL,
  `acces_post_type` varchar(100) DEFAULT NULL,
  `show_all_author` enum('Y','N') DEFAULT 'N',
  `mapping_author` text,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of m_users
-- ----------------------------
INSERT INTO `m_users` VALUES ('agushandoko', 'agus.prio.handoko@gmail.com', '$2y$08$RVY2TWhVbVBkU01FZnJWW.6Ax0IFdstchEv.GaiDTB3W.J3S54DoK', 'developer', '2018-03-19 01:09:28', null, '0', 'agus handoko', null, 'Y', '*');
INSERT INTO `m_users` VALUES ('guest', 'guest@mycms.com', '$2y$08$Ym1kNGhicGxPNDVJaENlYO1PqEiDk4fKQGD9Sk4QNl1hgHvmN/9W.', 'guest', '2018-03-03 02:54:22', '2018-03-19 04:42:45', '1', 'guest', '[\"posting\"]', 'N', '[\"guest\"]');
INSERT INTO `m_users` VALUES ('myadmin', 'agus.prio.handoko@gmail.com', '$2y$08$VHBGTHJQSlhiVFlmVWtFUe2tW8FIhV65b3Bzzqux.IfIx6m9B.cfq', 'developer', '2017-09-13 10:34:01', '2018-03-19 04:42:29', '1', 'Administrator', '[\"page\",\"posting\"]', 'Y', '*');

-- ----------------------------
-- Table structure for r_relation_post_media
-- ----------------------------
DROP TABLE IF EXISTS `r_relation_post_media`;
CREATE TABLE `r_relation_post_media` (
  `r_media_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) DEFAULT NULL,
  `media_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`r_media_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of r_relation_post_media
-- ----------------------------
INSERT INTO `r_relation_post_media` VALUES ('1', '14', '3');
INSERT INTO `r_relation_post_media` VALUES ('2', '14', '2');

-- ----------------------------
-- Table structure for r_relation_tags
-- ----------------------------
DROP TABLE IF EXISTS `r_relation_tags`;
CREATE TABLE `r_relation_tags` (
  `id_relation_tags` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) DEFAULT NULL,
  `tags_slug` varchar(255) DEFAULT NULL,
  `post_parent` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id_relation_tags`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of r_relation_tags
-- ----------------------------
