# Servidor Diablo II: Lord of Destruction 1.14d en Docker

Este proyecto contiene una imagen **Docker unificada** lista para levantar un servidor privado de **Diablo II: LoD 1.14d**, que combina:

- **PvPGN** para autenticación, chat y lobby estilo Battle.net
- **D2GS** como servidor de juego real
- **Wine** (2.0.1) preconfigurado para correr D2GS en Linux

Ideal para LAN parties, servidores privados entre amigos, o simplemente para revivir la gloria de Santuario como en los viejos tiempos.

---

## Componentes

- **PvPGN** (`bnetd`) compilado y adaptado para compatibilidad con la versión 1.14d
- **D2GS** funcional sobre Wine (sin necesidad de Windows)
- **Docker** como entorno contenedor con un `entrypoint` personalizado
- Scripts automáticos para reemplazo de configuraciones vía `.env`
- Inicialización automática de carpetas `logs`, `etc`, `var` y creación de archivos de log si no existen
- Script opcional `copyConfFromContainer.sh` para validar cómo quedaron configurados los archivos dentro del contenedor después de iniciado

---

## Requisitos

- Docker instalado (versión 20 o superior recomendada)
- Git (opcional, para clonar el repositorio)
- Archivo `.env` con tus configuraciones de red y realm

---

## Cómo usar

1. **Cloná este repositorio:**

```bash
git clone https://github.com/gonzacass/diablo2-server.git
cd diablo2-server
```

2. **Creá tu archivo `.env` desde el ejemplo:**

```bash
cp .env_example .env
```

> Si no ves el archivo `.env_example`, asegurate de descargarlo desde el repositorio o crearlo manualmente según el formato a continuación.

3. **Editá `.env` y completá tus datos:**

```dotenv
# Archivo: .env_example

# Configuraciones de red
IP_PRIVADA=          # Ej: 192.168.0.100
IP_PUBLICA=          # Tu IP pública o del host
SUBNET=              # Ej: 192.168.0.0/24

# Realm
REALM_NAME=          # Ej: JokerRealm

# IPs de equipos LAN separadas por coma (sin espacios)
IP_LANS=             # Ej: 192.168.0.10,192.168.0.11
```

4. **Construí y ejecutá el contenedor:**

```bash
docker compose up --build -d
```

> Nota: Este repositorio contiene archivos requeridos para que el contenedor funcione correctamente. **Clonarlo es obligatorio**. Si usás solo la imagen desde Docker Hub, debés montar los volúmenes correspondientes, copiar los archivos necesarios y proporcionar un `.env` válido.

---

## Docker Image disponible

Podés usar la imagen si ya tenés los archivos locales configurados:

```bash
docker pull gonzacass/diablo2-full:1.0
```

> Requiere montar archivos desde el repo original. No funciona por sí sola sin `.env`, scripts ni configuraciones.

---

## Agradecimientos

Este proyecto está basado e inspirado en el trabajo original de [**espenmjos**](https://github.com/espenmjos), quien creó una de las primeras imágenes funcionales de Docker que combinan PvPGN y D2GS para Diablo II. ¡Gracias por mantener viva la llama de Lut Gholein!

---

## Licencia

Este proyecto se distribuye con fines educativos y personales. El uso de los archivos del juego es responsabilidad de cada usuario.

---

# Diablo II: Lord of Destruction 1.14d Server in Docker

This project provides a **unified Docker image** ready to launch a private server for **Diablo II: LoD 1.14d**, including:

- **PvPGN** for authentication, chat, and Battle.net-style lobby
- **D2GS** as the actual game server
- **Wine** (2.0.1) preconfigured to run D2GS on Linux

Perfect for LAN parties, private games with friends, or simply reliving the glory of Sanctuary.

---

## Components

- **PvPGN** (`bnetd`) compiled and tuned for 1.14d compatibility
- **D2GS** running under Wine (no Windows needed)
- **Docker** as container platform with custom `entrypoint`
- Configuration replacement via `.env` environment variables
- Auto-creation of `logs`, `etc`, and `var` folders and required log files if missing
- Optional script `copyConfFromContainer.sh` to inspect configuration after the container is up

---

## Requirements

- Docker installed (version 20+ recommended)
- Git (optional, for cloning the repository)
- `.env` file with your custom settings

---

## Usage

1. **Clone this repository:**

```bash
git clone https://github.com/gonzacass/diablo2-server.git
cd diablo2-server
```

2. **Create your `.env` file from the example:**

```bash
cp .env_example .env
```

> If `.env_example` is not included, create it manually following the example below.

3. **Edit `.env` with your values:**

```dotenv
# File: .env_example

# Network configuration
IP_PRIVADA=          # e.g. 192.168.0.100
IP_PUBLICA=          # Your public IP or host IP
SUBNET=              # e.g. 192.168.0.0/24

# Realm
REALM_NAME=          # e.g. JokerRealm

# LAN client IPs, comma-separated (no spaces)
IP_LANS=             # e.g. 192.168.0.10,192.168.0.11
```

4. **Build and launch the container:**

```bash
docker compose up --build -d
```

> Note: This repository includes all required files. **Cloning is mandatory**. If you use only the Docker image from Docker Hub, you must mount the correct volumes, copy necessary files, and supply a valid `.env` file.

---

## Docker Image Available

Use the image only if you already have the project files:

```bash
docker pull gonzacass/diablo2-full:1.0
```

> Will not work standalone. You must mount `.env`, config scripts, and conf files for it to function.

---

## Credits

Special thanks to [**espenmjos**](https://github.com/espenmjos), whose work combining PvPGN and D2GS into a working Docker image inspired this project.

---

## License

This project is distributed for educational and personal use only. Usage of game files is the responsibility of each user.

---

Happy hunting in Sanctuary!
