# ????? Servidor Diablo II: Lord of Destruction 1.14d en Docker

Este proyecto contiene una imagen **Docker unificada** lista para levantar un servidor privado de **Diablo II: LoD 1.14d**, que combina:

- ?? **PvPGN** para autenticación, chat y lobby estilo Battle.net
- ?? **D2GS** como servidor de juego real
- ?? **Wine** (2.0.1) preconfigurado para correr D2GS en Linux

Ideal para LAN parties, servidores privados entre amigos, o simplemente para revivir la gloria de Santuario como en los viejos tiempos.

---

## ?? Componentes

- **PvPGN** (`bnetd`) compilado y adaptado para compatibilidad con la versión 1.14d
- **D2GS** funcional sobre Wine (sin necesidad de Windows)
- **Docker** como entorno contenedor con un `entrypoint` personalizado
- Scripts automáticos para reemplazo de configuraciones vía `.env`

---

## ?? Requisitos

- Docker instalado (versión 20 o superior recomendada)
- Git (opcional, para clonar el repositorio)
- Archivo `.env` con tus configuraciones de red y realm

---

## ?? Cómo usar

1. **Cloná este repositorio:**

```bash
git clone https://github.com/gonzacass/diablo2-server.git
cd diablo2-server
```

2. **Creá tu archivo `.env` desde el ejemplo:**

```bash
cp .env_example .env
```

3. **Editá `.env` y completá tus datos:**

```dotenv
# Archivo: .env_example

# Configuraciones de red
IP_PRIVADA=		      # Ej: 192.168.0.100
IP_PUBLICA=		      # Tu IP pública o del host
SUBNET=	      # Ej: 192.168.0.0/24

# Realm
REALM_NAME=	      # Ej: JokerRealm

# IPs de equipos LAN separadas por coma (sin espacios)
IP_LANS=	      # Ej: 192.168.0.10,192.168.0.11
```

4. **Construí y ejecutá el contenedor:**

```bash
docker compose up --build -d
```

> Nota: Este repositorio contiene archivos requeridos para que el contenedor funcione correctamente. Si usás solo la imagen desde Docker Hub, debés montar los volúmenes correspondientes y proporcionar un `.env` válido.

---

## ?? Imagen Docker disponible

Ya podés usar directamente la imagen sin clonar el repo:

```bash
docker pull gonzacass/diablo2-full:1.0
```

> Recordá que necesitarás montar los archivos del repositorio y el `.env` correctamente si no clonás el proyecto.

---

## ?? Agradecimientos

Este proyecto está basado e inspirado en el trabajo original de [**espenmjos**](https://github.com/espenmjos), quien creó una de las primeras imágenes funcionales de Docker que combinan PvPGN y D2GS para Diablo II. ¡Gracias por mantener viva la llama de Lut Gholein! ??

---

## ?? Licencia

Este proyecto se distribuye con fines educativos y personales. El uso de los archivos del juego es responsabilidad de cada usuario.

---

¡Buena cacería en Santuario! ????
