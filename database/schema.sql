-- =====================================================
-- Script SQL para WampServer (WAMPP)
-- =====================================================
-- Instrucciones de uso:
-- 
-- Opción 1: Desde phpMyAdmin (recomendado)
--   1. Abre http://localhost/phpmyadmin
--   2. Ve a la pestaña "SQL"
--   3. Copia y pega este script completo
--   4. Click en "Continuar" o "Go"
--
-- Opción 2: Desde MySQL Console
--   1. Click en icono WAMP → MySQL → MySQL Console
--   2. Presiona Enter (sin contraseña por defecto)
--   3. Copia y pega este script
-- =====================================================

CREATE DATABASE IF NOT EXISTS springboot_crud
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE springboot_crud;

CREATE TABLE IF NOT EXISTS user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO user (name, email, phone) VALUES
('Juan Pérez', 'juan.perez@example.com', '666123456'),
('María García', 'maria.garcia@example.com', '666234567'),
('Carlos López', 'carlos.lopez@example.com', '666345678')
ON DUPLICATE KEY UPDATE name=name;

SELECT * FROM user;

-- =====================================================
-- COMANDOS ÚTILES PARA WAMPSERVER
-- =====================================================
-- SHOW DATABASES;
-- SHOW TABLES;
-- DESCRIBE user;
-- TRUNCATE TABLE user;
-- DROP DATABASE springboot_crud;
