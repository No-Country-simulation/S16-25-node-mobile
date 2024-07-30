---

# Documentación de la API de PatitasEnRed

## Introducción

PatitasEnRed es una plataforma que conecta refugios de animales con personas interesadas en adoptar, donar o reportar animales. Esta API proporciona acceso a diversas funcionalidades, incluyendo la gestión de usuarios, refugios, animales, publicaciones y calificaciones.

## Base URL

`http://https://patitasenred.onrender.com/api/v1`

## Autenticación

La API utiliza JWT para la autenticación. Se requiere un token JWT válido en el encabezado `Authorization` para acceder a rutas protegidas.

### Ejemplo de Encabezado de Autorización

```
Authorization: Bearer <token>
```

## Rutas de la API

### 1. Autenticación

#### **POST** `/auth/login`

_Inicia sesión un usuario._

**Parámetros de Entrada:**

```json
{
  "email": "usuario@example.com",
  "password": "tu-contraseña"
}
```

**Respuesta Exitosa:**

```json
{
  "token": "<token-del-usuario>",
  "rol": "User",
  "id":" a21342390sfkasdf23429034a"
}
```

#### **POST** `/auth/register`

_Registra un nuevo usuario._

**Parámetros de Entrada:**

```json
{
  "nombre": "Nombre del Usuario",
  "email": "usuario@example.com",
  "password": "tu-contraseña"
}
```

**Respuesta Exitosa:**

```json
{
  "message": "Usuario registrado correctamente"
}
```

### 2. Usuarios

#### **GET** `/user/`

_Obtiene una lista de todos los usuarios._

**Requiere:** Token de Admin en auth bearer

**Respuesta Exitosa:**

```json
{
"total":"N",
"users": [ 
		{
      "nombre": "Juan Pablo",
      "rol": "User",
      "telefono": 123456789,
      "email": "ejemplo@ejemplo.com",
      "tipoDocumento": "DNI",
      "documento": 12345678,
      "poseeAnimales": true,
      "conviveMenores": false,
      "patio": true,
      "dimensiones": 150,
      "direccion": "Calle Falsa 123, Ciudad, País",
      "imagenPerfil": "https://res.cloudinary.com/dcp2ljagc/image/upload/v1721727681/tb8csrtafbwmz25efe7w.webp",
      "animales": [],
      "donaciones": [],
      "denuncias": [],
      "calificaciones": [],
      "id": "655y719d4426bd49de015ad1"
  },
  ...
  ]
}
```

#### **GET** `/user/:id`

_Obtiene los detalles de un usuario específico._

**Requiere:** Token de autenticación (solo rol Admin)

**Respuesta Exitosa:**

```json
{
      "nombre": "Juan Pablo",
      "rol": "User",
      "telefono": 123456789,
      "email": "ejemplo@ejemplo.com",
      "tipoDocumento": "DNI",
      "documento": 12345678,
      "poseeAnimales": true,
      "conviveMenores": false,
      "patio": true,
      "dimensiones": 150,
      "direccion": "Calle Falsa 123, Ciudad, País",
      "imagenPerfil": "https://res.cloudinary.com/dcp2ljagc/image/upload/v1721727681/tb8csrtafbwmz25efe7w.webp",
      "animales": [],
      "donaciones": [],
      "denuncias": [],
      "calificaciones": [],
      "id": "655y719d4426bd49de015ad1"
}
```

#### **PUT** `/user/:id`

_Actualiza los detalles de un usuario específico._

**Requiere:** Token de autenticación (por el momento no se requiere ninguna autenticacion, cuando salga a produccion se limitará )

**Parámetros de Entrada (ejemplo):**

```json
{
  "nombre": "Nuevo Nombre",
  "email": "nuevo-email@example.com"
}
```

**Respuesta Exitosa:**

```json
{
  <Objeto con los atributos actualizados>
}
```

#### **DELETE** `/user/:id`

_Elimina un usuario específico._

**Requiere:** Token de administrador auth Bearer

**Respuesta Exitosa:**

```json
{
  "message": "Usuario eliminado"
}
```

### 3. Refugios

#### **GET** `/refugio/`

_Obtiene una lista de todos los refugios._

**Respuesta Exitosa:**

```json
{
"total":"N",
"refugios":[
  {
    "id": "refugioId",
    "nombre": "Nombre del Refugio",
    "correo": "correo@refugio.com",
    "telefono": "+123456789",
    "gerente": "id-del-gerente",
    "image": "url-de-la-imagen"
  },
  ...]
  }
```

#### **POST** `/refugio/`

_Crea un nuevo refugio._

**Requiere:** Token de autenticación

**Parámetros de Entrada:**

```json
{
  "nombre": "Nombre del Refugio",
  "correo": "correo@refugio.com",
  "telefono": "+123456789",
  "gerente": "id-del-gerente",
  "image": "archivo-de-imagen"
}
```

**Respuesta Exitosa:**

```json
{
  <Objeto con los datos del refugio>
}
```

#### **GET** `/refugio/:id`

_Obtiene los detalles de un refugio específico._

**Respuesta Exitosa:**

```json
{
  "nombre": "Nombre del Refugio",
  "image": "url-de-la-imagen",
  "correo": "correo@refugio.com",
  "telefono": "+123456789",
  "gerente": "id-del-gerente",
  "animales": ["array-de-objetos"],
  "publicaciones": ["array-de-objetos"],
  "createdAt": "2024-07-30T19:17:11.598Z",
  "updatedAt": "2024-07-30T19:17:11.598Z",
  "id": "refugioId"
}
```

#### **PUT** `/refugio/:id`

_Actualiza los detalles de un refugio específico._

**Requiere:** Token de autenticación(por el momento no necesita, luego se actualizara)si se necesita enviar por body el id del gerente, el usuario debe tener rol de Gerente

**Parámetros de Entrada:**

```json
{
  "nombre": "Nuevo Nombre",
  "correo": "nuevo-correo@refugio.com",
  "telefono": "nuevo-987654321",
  "gerente": "id-del-gerente",
  "image": "nuevo-archivo"
}
```

**Respuesta Exitosa:**

```json
{
  <objeto actualizado>
}
```

#### **DELETE** `/refugio/:id`

_Elimina un refugio específico._

**Requiere:** Token de autenticación(por el momento no es necesario, luego se actualizara)

**Respuesta Exitosa:**

```json
{
  "message": "Refugio eliminado exitosamente"
}
```

### 4. Animales

#### **GET** `/animal/`

_Obtiene una lista de todos los animales disponibles para adopción._

**Respuesta Exitosa:**

```json
{
"total":"N",
"animales":[
  {
    "tamanio": "Mediano",
      "sexo": "Macho",
      "estadoSalud": [],
      "nombre": "pepe",
      "especie": "Ave",
      "edad": 2,
      "peso": 1,
      "image": "https://res.cloudinary.com/dcp2ljagc/image/upload/v1721364291/c9hmkg2ieyrebwamlzry.webp",
      "estado": "Activo",
      "createdAt": "2024-07-19T04:44:52.196Z",
      "updatedAt": "2024-07-30T06:28:58.063Z",
      "adopcion": "66a88829431e461b3d54b0f9",
      "id": "6699ef449f5a5a1507262f5d"
  },
  ...
]}
```

#### **POST** `/animal/`

_Crea un nuevo animal disponible para adopción._

**Requiere:** Token de autenticación(no requerido por el momento)

**Parámetros de Entrada:**

```json
{
  "nombre": "Nombre del Animal requerido ",
  "especie": "Especie del Animal- Perro por defecto",
  "edad": 3 requerido ,
  "peso": 15 requerido ,
  "image": "url-de-la-imagen",
  "estado": "Activo por defecto",
  "refugio": "id-del-refugio-requerido",
   "raza": "raza del animal";
	"tamanio": 'Chico', 'Mediano'(por defecto) o 'Grande' ;
	"sexo": "Macho"(por defecto) o "Hembra";
	"estadoSalud": 'Sano'(por defecto), 'Enfermo', 'Vulnerable', 'Castrado', 'Desparasitado'o 'Otro';
	"adopcion": "id-adopcion-no-requerido";
  
}
```

**Respuesta Exitosa:**

```json
{
  <objeto del animal creado>
}
```

#### **GET** `/animal/:id`

_Obtiene los detalles de un animal específico._

**Respuesta Exitosa:**

```json
{
  "nombre": "Buddy",
  "especie": "Perro",
  "edad": 3,
  "peso": 10,
  "image": "https://res.cloudinary.com/dcp2ljagc/image/upload/v1722375256/ez7o5it20yn1sjik7rgb.jpg",
  "estado": "Activo",
  "refugio": "66a93c3709c745e375649e34",
  "tamanio": "Mediano",
  "sexo": "Macho",
  "estadoSalud": ["Enfermo"],
  "createdAt": "2024-07-30T21:34:17.692Z",
  "updatedAt": "2024-07-30T21:34:17.692Z",
  "id": "66a95c5927c3c53b1acf1b92"
}
```

#### **PUT** `/animal/:id`

_Actualiza los detalles de un animal específico._

**Requiere:** Token de autenticación(no requerido al momento )

**Parámetros de Entrada:**

```json
{
  "estadoSalud":"Sano"
}
```

**Respuesta Exitosa:**

```json
{
  "nombre": "Buddy",
  "especie": "Perro",
  "edad": 3,
  "peso": 10,
  "image": "https://res.cloudinary.com/dcp2ljagc/image/upload/v1722375256/ez7o5it20yn1sjik7rgb.jpg",
  "estado": "Activo",
  "refugio": "66a93c3709c745e375649e34",
  "tamanio": "Mediano",
  "sexo": "Macho",
  "estadoSalud": [
    "Sano"
  ],
  "createdAt": "2024-07-30T21:34:17.692Z",
  "updatedAt": "2024-07-30T21:51:32.406Z",
  "id": "66a95c5927c3c53b1acf1b92"
}
```

#### **DELETE** `/animal/:id`

_Elimina un animal específico._

**Requiere:** Token de autenticación(no requerido por el momento)

**Respuesta Exitosa:**

```json
{
  "message": "Animal eliminado"
}
```

### 5. Publicaciones

#### **GET** `/post/`

_Obtiene una lista de todas las publicaciones._

**Respuesta Exitosa:**

```json
[
"total":"N",
"posts":
  {
    "titulo": "Gaviotas",
      "texto": "lorem ipsum",
      "image": "https://res.cloudinary.com/dcp2ljagc/image/upload/v1722378575/fctblsorrz0gtg9fiaip.jpg",
      "status": "ACTIVO",
      "refugio": {
        "nombre": "Refugio Florencio Varela",
        "image": "https://res.cloudinary.com/dcp2ljagc/image/upload/v1722367031/lik5e8hz996z09p1y9it.jpg",
        "correo": "rfvecoparque@ecoparque.com",
        "telefono": "42424242",
        "gerente": "66a060d96eb745499d30cc3c",
        "animales": [],
        "publicaciones": [
          "66a96950ed76ad13e5adb142"
        ],
        "createdAt": "2024-07-30T19:17:11.598Z",
        "updatedAt": "2024-07-30T22:29:36.278Z",
        "id": "66a93c3709c745e375649e34"
      },
      "createdAt": "2024-07-30T22:29:36.186Z",
      "updatedAt": "2024-07-30T22:29:36.186Z",
      "id": "66a96950ed76ad13e5adb142"
  },
  ...
]
```

#### **POST** `/post/`

_Crea una nueva publicación._

**Requiere:** Token de autenticación(por el momento no aplica)

**Parámetros de Entrada:**

```json
{
  "titulo": "Gaviotas",
  "texto": "lorem ipsum",
  "status": "ACTIVO"(no requerido),
  "refugio": "id-del-refugio"(requerido),
  "image": "arcivo-de-imagen"
}
```

**Respuesta Exitosa:**

```json
{
  <Objeto creado>
}
```

#### **GET** `/post/:id`

_Obtiene los detalles de una publicación específica._

**Respuesta Exitosa:**

```json
{
  "titulo": "Título de la Publicación",
  "texto": "Texto de la Publicación",
  "image": "url-de-la-imagen",
  "status": "ACTIVO",
  "refugio": "id-del-refugio",
  "createdAt": "2024-07-30T22:29:36.186Z",
  "updatedAt": "2024-07-30T22:29:36.186Z",
  "id": "postId"
}
```

#### **PUT** `/post/:id`

_Actualiza los detalles de una publicación

 específica._

**Requiere:** Token de autenticación(no requerido ahora, se actualizará ) 

**Parámetros de Entrada:** (formato JSON)

```json
{
  "titulo": "Nuevo Título",
  "texto": "Nuevo Texto",
  "status": "INACTIVO",
  "image": "nueva-url-de-la-imagen"
}
```

**Respuesta Exitosa:**

```json
{
  <Objeto actualizado>
}
```

#### **DELETE** `/post/:id`

_Elimina una publicación específica._

**Requiere:** Token de autenticación(no aplica por ahora)

**Respuesta Exitosa:**

```json
{
  "message": "Publicación eliminada"
}
```
### 6. Adopciones (desarrollando documentación )

#### **GET** `/adopt/`

_Obtiene una lista de todas las adopciones._

**Respuesta Exitosa:**

```json
[
  {
    "id": "ratingId",
    "rate": 5,
    "texto": "Comentario sobre el refugio",
    "user": "id-del-usuario",
    "refugio": "id-del-refugio"
  },
  ...
]
```

#### **POST** `/rating/`

_Crea una nueva calificación._

**Requiere:** Token de autenticación

**Parámetros de Entrada:**

```json
{
  "rate": 5,
  "texto": "Comentario sobre el refugio",
  "user": "id-del-usuario",
  "refugio": "id-del-refugio"
}
```

**Respuesta Exitosa:**

```json
{
  "message": "Calificación creada exitosamente"
}
```

#### **GET** `/rating/:id`

_Obtiene los detalles de una calificación específica._

**Respuesta Exitosa:**

```json
{
  "id": "ratingId",
  "rate": 5,
  "texto": "Comentario sobre el refugio",
  "user": "id-del-usuario",
  "refugio": "id-del-refugio"
}
```

#### **PUT** `/rating/:id`

_Actualiza los detalles de una calificación específica._

**Requiere:** Token de autenticación

**Parámetros de Entrada:**

```json
{
  "rate": 4,
  "texto": "Nuevo comentario sobre el refugio"
}
```

**Respuesta Exitosa:**

```json
{
  "message": "Calificación actualizada exitosamente"
}
```

#### **DELETE** `/rating/:id`

_Elimina una calificación específica._

**Requiere:** Token de autenticación

**Respuesta Exitosa:**

```json
{
  "message": "Calificación eliminada exitosamente"
}
```
### 7. Calificaciones (en desarrollo no testear)

#### **GET** `/rating/`

_Obtiene una lista de todas las calificaciones._

**Respuesta Exitosa:**

```json
[
  {
    "id": "ratingId",
    "rate": 5,
    "texto": "Comentario sobre el refugio",
    "user": "id-del-usuario",
    "refugio": "id-del-refugio"
  },
  ...
]
```

#### **POST** `/rating/`

_Crea una nueva calificación._

**Requiere:** Token de autenticación

**Parámetros de Entrada:**

```json
{
  "rate": 5,
  "texto": "Comentario sobre el refugio",
  "user": "id-del-usuario",
  "refugio": "id-del-refugio"
}
```

**Respuesta Exitosa:**

```json
{
  "message": "Calificación creada exitosamente"
}
```

#### **GET** `/rating/:id`

_Obtiene los detalles de una calificación específica._

**Respuesta Exitosa:**

```json
{
  "id": "ratingId",
  "rate": 5,
  "texto": "Comentario sobre el refugio",
  "user": "id-del-usuario",
  "refugio": "id-del-refugio"
}
```

#### **PUT** `/rating/:id`

_Actualiza los detalles de una calificación específica._

**Requiere:** Token de autenticación

**Parámetros de Entrada:**

```json
{
  "rate": 4,
  "texto": "Nuevo comentario sobre el refugio"
}
```

**Respuesta Exitosa:**

```json
{
  "message": "Calificación actualizada exitosamente"
}
```

#### **DELETE** `/rating/:id`

_Elimina una calificación específica._

**Requiere:** Token de autenticación

**Respuesta Exitosa:**

```json
{
  "message": "Calificación eliminada exitosamente"
}
```

---


