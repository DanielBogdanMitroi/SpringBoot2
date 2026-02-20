# Guía Completa de Configuración de WampServer (WAMPP)

Esta guía explica cómo instalar y configurar WampServer para usar con la aplicación Spring Boot CRUD.

## Índice

1. [Requisitos Previos](#requisitos-previos)
2. [Instalación de WampServer](#instalación-de-wampserver)
3. [Iniciar WampServer y entender los iconos](#iniciar-wampserver-y-entender-los-iconos)
4. [Configuración para Spring Boot](#configuración-para-spring-boot)
5. [Configuración Avanzada](#configuración-avanzada)
6. [Problemas Comunes y Soluciones](#problemas-comunes-y-soluciones)
7. [Comandos Útiles de MySQL Console](#comandos-útiles-de-mysql-console)
8. [Checklist de Verificación Final](#checklist-de-verificación-final)

---

## Requisitos Previos

Antes de instalar WampServer, asegúrate de tener instalados los siguientes componentes:

### Visual C++ Redistributable (Obligatorio)

WampServer requiere las siguientes versiones de Visual C++ Redistributable:

- **VC++ 2012** (vc11)
- **VC++ 2013** (vc12)
- **VC++ 2015-2019** (vc14 y vc15)
- **VC++ 2019** (vc16) - para versiones recientes de WampServer

Puedes descargarlos desde:
- [Microsoft Visual C++ Redistributable](https://support.microsoft.com/es-es/topic/las-últimas-descargas-de-visual-c-compatibles-2647da03-1eea-4433-9aff-95f26a218cc0)

> **Nota:** Si falta algún VC++ Redistributable, WampServer mostrará advertencias durante la instalación.

### Sistema Operativo

- Windows 7 / 8 / 10 / 11 (64-bit recomendado)
- Al menos 500 MB de espacio libre en disco

---

## Instalación de WampServer

### Paso 1: Descargar WampServer

1. Ve a la página oficial: [https://www.wampserver.com/](https://www.wampserver.com/)
2. Haz clic en **"WAMPSERVER 64 BITS"** (recomendado para sistemas modernos)
3. Descarga el instalador (archivo `.exe`)

### Paso 2: Ejecutar el instalador

1. Haz doble clic en el instalador descargado
2. Acepta el acuerdo de licencia
3. Elige la carpeta de instalación (por defecto: `C:\wamp64`)
4. Selecciona los componentes a instalar (deja los predeterminados)
5. Haz clic en **"Instalar"**

### Paso 3: Configuración inicial

1. El instalador preguntará por el navegador predeterminado → elige tu navegador
2. El instalador preguntará por el editor de texto → elige tu editor favorito
3. Haz clic en **"Finalizar"**

---

## Iniciar WampServer y entender los iconos

### Iniciar WampServer

1. Busca **WampServer** en el menú de inicio y ábrelo
2. El icono de WampServer aparecerá en la **bandeja del sistema** (esquina inferior derecha)

### Sistema de iconos de colores

| Color | Significado | Acción |
|-------|-------------|--------|
| 🟢 **Verde** | Todo funciona correctamente | Puedes usar la aplicación |
| 🟠 **Naranja** | Uno de los servicios no está corriendo | Verifica Apache o MySQL |
| 🔴 **Rojo** | Ningún servicio está activo | Reinicia WampServer |

### ¿Qué hacer si el icono no está verde?

**Icono Naranja:**
1. Haz clic en el icono de WAMP
2. Verifica cuál servicio no está corriendo (Apache o MySQL)
3. Haz clic en el servicio y selecciona **"Start/Resume Service"**

**Icono Rojo:**
1. Haz clic derecho en el icono de WAMP
2. Selecciona **"Restart All Services"**
3. Espera unos segundos y verifica que el icono cambie a verde

---

## Configuración para Spring Boot

### Paso 1: Verificar que MySQL esté corriendo

1. Haz clic en el icono verde de WampServer en la bandeja del sistema
2. Ve a **MySQL → MySQL Console**
3. Presiona **Enter** (sin contraseña por defecto)
4. Si ves el prompt `mysql>`, MySQL está funcionando correctamente

### Paso 2: Acceder a phpMyAdmin

1. Abre tu navegador web
2. Ve a: [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
3. Usuario: `root`
4. Contraseña: *dejar en blanco* (vacía por defecto)
5. Haz clic en **"Iniciar sesión"**

### Paso 3: Crear la base de datos

**Opción A: Desde phpMyAdmin (Recomendado)**

1. En phpMyAdmin, haz clic en la pestaña **"SQL"**
2. Copia el contenido del archivo `database/schema.sql`
3. Pégalo en el campo de texto
4. Haz clic en **"Continuar"** o **"Go"**
5. Verifica que la base de datos `springboot_crud` aparezca en el panel izquierdo

**Opción B: Desde MySQL Console**

1. Haz clic en el icono WAMP → MySQL → MySQL Console
2. Presiona **Enter** cuando pida contraseña
3. Copia y pega el script `database/schema.sql`
4. Presiona **Enter**

### Paso 4: Verificar la configuración de application.properties

Asegúrate de que el archivo `src/main/resources/application.properties` tenga:

```properties
spring.datasource.url=jdbc:mariadb://localhost:3306/springboot_crud
spring.datasource.username=root
spring.datasource.password=
```

---

## Configuración Avanzada

### Cambiar el puerto de MySQL (si el 3306 está ocupado)

1. Haz clic en el icono de WAMP
2. Ve a **MySQL → my.ini**
3. Busca la línea `port=3306`
4. Cámbiala por el nuevo puerto, ej: `port=3307`
5. Guarda el archivo
6. Reinicia MySQL desde WampServer
7. Actualiza también `application.properties`:
   ```properties
   spring.datasource.url=jdbc:mariadb://localhost:3307/springboot_crud
   ```

### Cambiar el puerto de Apache (si el 80 está ocupado)

1. Haz clic en el icono de WAMP
2. Ve a **Apache → httpd.conf**
3. Busca la línea `Listen 80`
4. Cámbiala por el nuevo puerto, ej: `Listen 8081`
5. Guarda el archivo y reinicia Apache

### Establecer contraseña para root en MySQL

1. Accede a phpMyAdmin: [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
2. Haz clic en **"Cuentas de usuario"**
3. Haz clic en **"Editar privilegios"** junto a `root@localhost`
4. Ve a la pestaña **"Cambiar contraseña"**
5. Ingresa la nueva contraseña y haz clic en **"Continuar"**
6. Actualiza `application.properties`:
   ```properties
   spring.datasource.password=tu_nueva_contraseña
   ```

---

## Problemas Comunes y Soluciones

### Error: "Cannot connect to database"

**Causa:** MySQL no está corriendo o hay un problema de conexión.

**Solución:**
1. Verifica que el icono de WampServer esté **verde**
2. Haz clic en icono WAMP → MySQL → Start/Resume Service
3. Verifica que la URL en `application.properties` sea correcta

### Error: "Port 3306 already in use"

**Causa:** Otro programa (como una instalación anterior de MySQL) está usando el puerto 3306.

**Solución:**
1. Abre el Administrador de tareas → Pestaña "Servicios"
2. Busca cualquier servicio MySQL y detén los que no sean de WAMP
3. O cambia el puerto de MySQL en WampServer (ver sección de Configuración Avanzada)

### Error: "Access denied for user 'root'@'localhost'"

**Causa:** Las credenciales son incorrectas.

**Solución:**
1. Verifica en phpMyAdmin que el usuario `root` existe: [http://localhost/phpmyadmin](http://localhost/phpmyadmin)
2. Si configuraste contraseña, actualiza `spring.datasource.password` en `application.properties`
3. Si olvidaste la contraseña, puedes resetearla desde WampServer

### WampServer no arranca (icono naranja/rojo)

**Causa posible 1: Conflicto con el puerto 80 (Apache)**

- Skype, IIS u otro programa usa el puerto 80
- **Solución:** Cierra Skype o configúralo para no usar el puerto 80/443
- Haz clic en icono WAMP → Apache → **Test Port 80**

**Causa posible 2: Falta Visual C++ Redistributable**

- **Solución:** Instala todos los VC++ Redistributables requeridos (ver Requisitos Previos)

**Causa posible 3: Antivirus bloqueando WampServer**

- **Solución:** Agrega WampServer a las excepciones de tu antivirus

### Error: "Could not create connection to database server"

**Causa:** El servicio MySQL no está iniciado.

**Solución:**
1. Haz clic en el icono de WAMP en la bandeja del sistema
2. Ve a **MySQL → Start/Resume Service**
3. Espera a que el servicio inicie completamente
4. Intenta ejecutar la aplicación de nuevo

---

## Comandos Útiles de MySQL Console

Para acceder a MySQL Console: Icono WAMP → MySQL → MySQL Console

```sql
-- Mostrar todas las bases de datos
SHOW DATABASES;

-- Seleccionar la base de datos del proyecto
USE springboot_crud;

-- Mostrar tablas de la base de datos actual
SHOW TABLES;

-- Ver estructura de la tabla user
DESCRIBE user;

-- Ver todos los registros de la tabla user
SELECT * FROM user;

-- Borrar todos los registros (mantiene la estructura)
TRUNCATE TABLE user;

-- Eliminar la base de datos completa (cuidado!)
DROP DATABASE springboot_crud;

-- Ver la versión de MySQL/MariaDB
SELECT VERSION();

-- Ver el puerto actual de MySQL
SHOW VARIABLES LIKE 'port';

-- Ver el usuario actual
SELECT USER();
```

---

## Checklist de Verificación Final

Antes de ejecutar la aplicación Spring Boot, verifica que:

- [ ] WampServer está instalado y el icono es **verde** 🟢
- [ ] MySQL está corriendo (verificado desde MySQL Console o phpMyAdmin)
- [ ] La base de datos `springboot_crud` fue creada correctamente
- [ ] La tabla `user` existe en la base de datos
- [ ] El archivo `application.properties` tiene la URL correcta
- [ ] El usuario `root` tiene acceso a la base de datos
- [ ] El puerto 3306 está disponible (o actualizado en `application.properties`)
- [ ] Java 17+ está instalado (`java -version`)
- [ ] Maven está instalado (`mvn -version`)

### Comandos de verificación

```bash
# Verificar Java
java -version

# Verificar Maven
mvn -version

# Compilar el proyecto
mvn clean compile

# Ejecutar la aplicación
mvn spring-boot:run
```

Si todos los puntos del checklist están marcados y la aplicación inicia correctamente, podrás acceder a: [http://localhost:8080](http://localhost:8080)

---

## Recursos Adicionales

- [Documentación oficial de WampServer](https://www.wampserver.com/)
- [Foro oficial de WampServer](https://forum.wampserver.com/)
- [phpMyAdmin Documentación](https://www.phpmyadmin.net/docs/)
- [Spring Boot Documentación](https://spring.io/projects/spring-boot)
