# 📝 Blog Laravel + Vue.js 3

<div align="center">

![Laravel](https://img.shields.io/badge/Laravel-10.x-FF2D20?style=for-the-badge&logo=laravel&logoColor=white)
![Vue.js](https://img.shields.io/badge/Vue.js-3.x-4FC08D?style=for-the-badge&logo=vue.js&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.x-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

**Sistema de blog moderno con API REST y SPA desarrollado para prueba técnica**

</div>

## 🎯 Características Principales

| Funcionalidad | Descripción | Estado |
|--------------|-------------|---------|
| **API REST** | Backend Laravel con endpoints completos | ✅ |
| **SPA Frontend** | Vue.js 3 + Bootstrap 5 responsive | ✅ |
| **CRUD Autores** | Gestión completa con validación | ✅ |
| **CRUD Posts** | Con subida de imágenes | ✅ |
| **Vista Pública** | Blog para visitantes | ✅ |
| **Panel Admin** | Interfaz de administración | ✅ |
| **Base de Datos** | MySQL con migraciones Laravel | ✅ |

## 🏗️ Arquitectura

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Vue.js 3 SPA  │ ──▶│  Laravel API    │ ──▶│   MySQL DB      │
│   (Frontend)    │    │   (Backend)     │    │  (Database)     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
      Bootstrap 5           REST API              Eloquent ORM
```

### Stack Tecnológico
- **Backend**: Laravel 10, PHP 8.1+, MySQL 8.0
- **Frontend**: Vue.js 3, Bootstrap 5, Axios
- **Tools**: Vite, Composer, NPM

### Estructura de Base de Datos
```sql
-- Motor: MySQL 8.0
autores (id, nombre, apellidos, timestamps)
posts (id, titulo, contenido, imagen, autor_id FK, timestamps)
-- Relación: autores(1) -> posts(N)
```

## 🚀 Instalación Rápida
### 1. Prerrequisitos
```bash
# Verificar versiones
php --version    # >= 8.1
node --version   # >= 16
mysql --version  # >= 8.0
```

### 2. Clonar e Instalar
```bash
git clone <repository-url>
cd Blog_Laravel_Vuejs
composer install
npm install
```

### 3. Configuración
```bash
# Copiar entorno
cp .env.example .env

# Editar .env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=nombre_database
DB_USERNAME=usuario_database
DB_PASSWORD=password_database

# Generar clave
php artisan key:generate
```

### 4. Base de Datos
```bash
# Crear DB 'laravel' en MySQL
mysql -u root -p -e "CREATE DATABASE laravel"

# Ejecutar migraciones
php artisan migrate

# Datos de prueba (opcional)
php artisan db:seed
```

### 5. Compilar y Ejecutar
```bash
npm run build
php artisan serve
npm run dev
```

## 🌐 URLs de Acceso

| Sección | URL | Descripción |
|---------|-----|-------------|
| **Blog Público** | http://localhost:8000/ | Vista de posts para visitantes |
| **Administración** | http://localhost:8000/admin | Panel de gestión |
| **API** | http://localhost:8000/api/ | Endpoints REST |

## 📋 Funcionalidades Implementadas

### 🔐 Panel de Administración (Sin autenticación)
- ✅ **Gestión de Autores**: Crear, editar, listar, eliminar
- ✅ **Gestión de Posts**: CRUD completo con imágenes
- ✅ **Subida de Archivos**: Validación de tipo y tamaño
- ✅ **Interfaz Reactiva**: Modales Bootstrap funcionales
- ✅ **Validación**: Frontend y backend integrados

### 🌍 Vista Pública
- ✅ **Listado de Posts**: Grid responsive con paginación
- ✅ **Detalle de Post**: Modal con información completa
- ✅ **Información de Autor**: Nombre completo por post
- ✅ **Navegación**: Enlaces entre secciones

## 🛠️ API Endpoints

### Autores
```http
GET    /api/autores        # Listar todos
POST   /api/autores        # Crear nuevo
GET    /api/autores/{id}    # Obtener específico
PUT    /api/autores/{id}    # Actualizar
DELETE /api/autores/{id}    # Eliminar
```

### Posts
```http
GET    /api/posts          # Listar todos
POST   /api/posts          # Crear nuevo (multipart/form-data)
GET    /api/posts/{id}      # Obtener específico
PUT    /api/posts/{id}      # Actualizar (multipart/form-data)
DELETE /api/posts/{id}      # Eliminar
```

## 📂 Estructura del Proyecto

```
Blog/
├── app/
│   ├── Http/Controllers/Api/
│   │   ├── AutorController.php    # API Autores
│   │   └── PostController.php     # API Posts
│   └── Models/
│       ├── Autor.php             # Modelo con relaciones
│       └── Post.php              # Modelo con relaciones
├── database/
│   ├── migrations/               # Esquema de BD
│   └── seeders/                  # Datos de prueba
├── resources/
│   ├── js/components/
│   │   ├── BlogPublic.vue        # Vista pública
│   │   └── BlogAdmin.vue         # Panel admin
│   └── views/                    # Templates Blade
├── routes/
│   ├── api.php                   # Rutas API
│   └── web.php                   # Rutas web
├── public/images/                # Imágenes subidas
├── database_script.sql           # Script SQL completo
└── README.md                     # Esta documentación
```

## 📋 Entregables del Proyecto

✅ **Script SQL**: `database_script.sql` con esquema MySQL completo  
✅ **Migraciones Laravel**: Sistema de versionado de BD  
✅ **API Backend**: Laravel 10 con controladores y modelos  
✅ **Frontend SPA**: Vue.js 3 + Bootstrap 5 (puntaje adicional)  
✅ **Relaciones Eloquent**: hasMany/belongsTo sin DB::raw  
✅ **Documentación**: README completo con instrucciones  

## Uso de la Aplicación

### Vista Pública
- **URL**: `http://localhost:8000`
- Muestra todos los posts publicados
- Permite ver el detalle de cada post
- Navegación hacia el panel de administración

### Panel de Administración
- **URL**: `http://localhost:8000/admin`
- Gestión de autores (crear, editar, eliminar)
- Gestión de posts (crear, editar, eliminar)
- Subida de imágenes para posts

## API Endpoints

### Autores
- `GET /api/autores` - Listar todos los autores
- `POST /api/autores` - Crear nuevo autor
- `GET /api/autores/{id}` - Obtener autor específico
- `PUT /api/autores/{id}` - Actualizar autor
- `DELETE /api/autores/{id}` - Eliminar autor

### Posts
- `GET /api/posts` - Listar todos los posts
- `POST /api/posts` - Crear nuevo post (con imagen)
- `GET /api/posts/{id}` - Obtener post específico
- `PUT /api/posts/{id}` - Actualizar post
- `DELETE /api/posts/{id}` - Eliminar post

## Arquitectura

### Backend (Laravel)
- **Modelos**: `App\Models\Autor`, `App\Models\Post`
- **Controladores API**: `App\Http\Controllers\Api\AutorController`, `App\Http\Controllers\Api\PostController`
- **Controlador Web**: `App\Http\Controllers\BlogController`
- **Migraciones**: `database/migrations/`
- **Seeders**: `database/seeders/`

### Frontend (Vue.js)
- **Componentes principales**:
  - `BlogPublic.vue` - Vista pública del blog
  - `BlogAdmin.vue` - Panel de administración
- **Comunicación**: Axios para peticiones HTTP a la API
- **Estilos**: Bootstrap 5 + Bootstrap Icons

### Rutas
- **Web**: `/` (vista pública), `/admin` (administración)
- **API**: `/api/autores`, `/api/posts`

## Características Técnicas

- **Validación**: Validación de formularios tanto en frontend como backend
- **Manejo de imágenes**: Subida y almacenamiento de imágenes en `public/images`
- **Responsive**: Diseño adaptativo con Bootstrap
- **SPA**: Componentes Vue.js para experiencia de usuario fluida
- **RESTful API**: Arquitectura REST para comunicación frontend-backend

## Comandos Útiles

```bash
# Limpiar cache
php artisan cache:clear
php artisan config:clear
php artisan view:clear

# Recrear base de datos
php artisan migrate:refresh --seed

# Ver rutas disponibles
php artisan route:list

# Optimizar para producción
php artisan optimize
```

## Tecnologías Utilizadas

- **Backend**: Laravel 10, PHP 8.1+, MySQL
- **Frontend**: Vue.js 3, Bootstrap 5, Axios
- **Build Tools**: Vite, Laravel Mix
- **Arquitectura**: API REST, SPA

## Notas Adicionales

- Las imágenes se almacenan en `public/images/`
- El proyecto usa Eloquent ORM para todas las operaciones de base de datos
- No se requiere autenticación para el panel de administración (según especificaciones)
- La comunicación frontend-backend es completamente mediante API REST
