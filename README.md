# SpringBoot2 - CRUD con Spring Boot y WampServer

Aplicación CRUD completa desarrollada con Spring Boot, Thymeleaf y MariaDB/MySQL usando **WampServer (WAMPP)**.

## Tecnologías Utilizadas

- **Java 17**
- **Spring Boot 3.x**
- **Spring Data JPA / Hibernate**
- **Thymeleaf** (motor de plantillas)
- **MariaDB / MySQL** (vía WampServer)
- **Maven**

## Prerrequisitos

Antes de ejecutar la aplicación, asegúrate de tener instalado:

1. **Java 17** o superior → [https://www.oracle.com/java/technologies/downloads/](https://www.oracle.com/java/technologies/downloads/)
2. **Maven 3.6+** → [https://maven.apache.org/download.cgi](https://maven.apache.org/download.cgi)
3. **WampServer (WAMPP)** → [https://www.wampserver.com/](https://www.wampserver.com/)
4. **Git** → [https://git-scm.com/](https://git-scm.com/)

## Instalación y Configuración

### 1. Clonar el repositorio

```bash
git clone https://github.com/DanielBogdanMitroi/SpringBoot2.git
cd SpringBoot2
```

### 2. Configurar WampServer (WAMPP) y MariaDB

1. **Instalar WampServer:**
   - Descarga desde [https://www.wampserver.com/](https://www.wampserver.com/)
   - Instala WampServer en tu sistema (Windows)
   - Asegúrate de que esté en español si lo prefieres

2. **Iniciar WampServer:**
   - Haz clic en el icono de WampServer en la bandeja del sistema
   - Espera a que el icono se ponga **verde** (servidor activo)
   - Si está **naranja** o **rojo**, verifica que Apache y MySQL estén iniciados

3. **Configurar la Base de Datos:**
   - Haz clic en el icono de WAMP → MySQL → MySQL Console
   - O accede a phpMyAdmin: [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
   - Usuario por defecto: `root`
   - Contraseña por defecto: *vacía* (sin contraseña)

4. **Ejecutar el Script SQL:**
   - En phpMyAdmin, ve a la pestaña "SQL"
   - Ejecuta el script ubicado en `database/schema.sql`

5. **Verificar el puerto de MySQL:**
   - Por defecto, WAMP usa el puerto **3306**
   - Si has cambiado el puerto, actualiza `application.properties`

### 3. Configurar application.properties

El archivo `src/main/resources/application.properties` ya está configurado para WampServer. Verifica que los datos coincidan con tu configuración:

```properties
spring.datasource.url=jdbc:mariadb://localhost:3306/springboot_crud
spring.datasource.username=root
spring.datasource.password=
```

### 4. Compilar y ejecutar

```bash
mvn clean install
mvn spring-boot:run
```

La aplicación estará disponible en: [http://localhost:8080](http://localhost:8080)

## Estructura del Proyecto

```
SpringBoot2/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/danielmitroi/
│   │   │       ├── model/
│   │   │       ├── repository/
│   │   │       ├── service/
│   │   │       └── controller/
│   │   └── resources/
│   │       ├── templates/
│   │       └── application.properties
├── database/
│   └── schema.sql
├── WAMPP-SETUP.md
└── pom.xml
```

## Funcionalidades

- ✅ Listar usuarios
- ✅ Crear usuario
- ✅ Editar usuario
- ✅ Eliminar usuario
- ✅ Validación de formularios
- ✅ Interfaz web con Thymeleaf

## Consejos para WAMP

- **Icono Verde:** Todo funciona correctamente
- **Icono Naranja:** Uno de los servicios (Apache/MySQL) no está corriendo
- **Icono Rojo:** Ningún servicio está activo
- **phpMyAdmin:** Interfaz web para gestionar bases de datos fácilmente
- **MySQL Console:** Acceso directo a la línea de comandos de MySQL
- **Reiniciar servicios:** Click derecho → Restart All Services

## Solución de Problemas

### Error: "Cannot connect to database"
- Verifica que el icono de WampServer esté **verde**
- Comprueba que MySQL esté corriendo en WampServer

### Error: "Port 3306 already in use"
- Otro proceso está usando el puerto 3306
- En WampServer, ve a: Icono WAMP → MySQL → my.ini
- Cambia `port=3306` por otro valor (ej: `port=3307`)
- Actualiza también `application.properties` con el nuevo puerto

### Error: "Access denied for user 'root'@'localhost'"
- Verifica las credenciales en phpMyAdmin: [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
- Por defecto WAMP usa usuario `root` sin contraseña
- Si tienes contraseña configurada, actualiza `spring.datasource.password` en `application.properties`

### WampServer no arranca (icono naranja/rojo)
- **Conflicto con el puerto 80:** Skype u otro programa puede estar usando el puerto 80
  - Cierra Skype o configúralo para no usar el puerto 80/443
  - O cambia el puerto de Apache en WampServer
- **Test Port 80:** Haz clic en el icono de WAMP → Apache → Test Port 80

### Error: "Could not create connection to database server"
- Verifica que el servicio MySQL esté corriendo en WampServer
- Haz clic en icono WAMP → MySQL → Start/Resume Service

## Guía Completa de WampServer

Para una guía más detallada sobre la instalación y configuración de WampServer, consulta el archivo [WAMPP-SETUP.md](WAMPP-SETUP.md).

## Licencia

Este proyecto es de código abierto para uso educativo.
