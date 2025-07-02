-- =====================================================
-- Script de Base de Datos para Blog Laravel + Vue.js 3
-- Motor de Base de Datos: MySQL 8.0+
-- =====================================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS `laravel` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE `laravel`;

-- =====================================================
-- Tabla: autores
-- Descripción: Almacena información de los autores del blog
-- =====================================================
CREATE TABLE `autores` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellidos` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Tabla: posts
-- Descripción: Almacena los posts del blog
-- =====================================================
CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenido` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `autor_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_autor_id_foreign` (`autor_id`),
  CONSTRAINT `posts_autor_id_foreign` FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- Datos de ejemplo para autores
-- =====================================================
INSERT INTO `autores` (`nombre`, `apellidos`, `created_at`, `updated_at`) VALUES
('Juan', 'Pérez García', NOW(), NOW()),
('María', 'González López', NOW(), NOW()),
('Carlos', 'Rodríguez Martín', NOW(), NOW());

-- =====================================================
-- Datos de ejemplo para posts (opcional)
-- =====================================================
-- INSERT INTO `posts` (`titulo`, `contenido`, `imagen`, `autor_id`, `created_at`, `updated_at`) VALUES
-- ('Mi Primer Post', 'Este es el contenido de mi primer post en el blog...', 'images/ejemplo1.jpg', 1, NOW(), NOW()),
-- ('Tecnología Moderna', 'Hablemos sobre las últimas tendencias en tecnología...', 'images/ejemplo2.jpg', 2, NOW(), NOW()),
-- ('Desarrollo Web', 'Tips y consejos para el desarrollo web moderno...', 'images/ejemplo3.jpg', 3, NOW(), NOW());

-- =====================================================
-- Índices adicionales para optimización
-- =====================================================
CREATE INDEX `idx_posts_autor_id` ON `posts` (`autor_id`);
CREATE INDEX `idx_posts_created_at` ON `posts` (`created_at`);
CREATE INDEX `idx_autores_nombre` ON `autores` (`nombre`);

-- =====================================================
-- Configuraciones adicionales
-- =====================================================

-- Configurar formato de fecha
SET time_zone = '+00:00';

-- Verificar las tablas creadas
SHOW TABLES;

-- Verificar estructura de tablas
DESCRIBE `autores`;
DESCRIBE `posts`;

-- =====================================================
-- Consultas útiles para verificación
-- =====================================================

-- Contar registros
-- SELECT COUNT(*) as total_autores FROM autores;
-- SELECT COUNT(*) as total_posts FROM posts;

-- Listar autores con cantidad de posts
-- SELECT 
--     a.id,
--     a.nombre,
--     a.apellidos,
--     COUNT(p.id) as total_posts,
--     a.created_at
-- FROM autores a
-- LEFT JOIN posts p ON a.id = p.autor_id
-- GROUP BY a.id, a.nombre, a.apellidos, a.created_at
-- ORDER BY total_posts DESC;

-- Listar posts con información del autor
-- SELECT 
--     p.id,
--     p.titulo,
--     p.contenido,
--     p.imagen,
--     CONCAT(a.nombre, ' ', a.apellidos) as autor_completo,
--     p.created_at
-- FROM posts p
-- INNER JOIN autores a ON p.autor_id = a.id
-- ORDER BY p.created_at DESC;

-- =====================================================
-- Notas importantes:
-- =====================================================
-- 1. Este script está diseñado para MySQL 8.0+
-- 2. Las relaciones están configuradas con CASCADE DELETE
-- 3. Los índices mejoran el rendimiento de las consultas
-- 4. El charset utf8mb4 soporta emojis y caracteres especiales
-- 5. Las migraciones de Laravel generarán estas mismas tablas
-- =====================================================
