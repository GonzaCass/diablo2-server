# Servidor Diablo II: Lord of Destruction 1.14d en Docker

Este proyecto contiene una imagen de Docker unificada para correr un servidor **PvPGN + D2GS** de Diablo II: LoD 1.14d, lista para usar en red LAN o Internet.

## ?? Componentes

- **PvPGN**: Servidor de Battle.net alternativo para autenticación, chat y partidas.
- **D2GS**: Diablo II Game Server.
- **Wine 2.0.1**: Compilado con `sock.c` modificado para compatibilidad con D2GS.
- **Docker**: Imagen autoiniciable y parametrizable.

## ?? Configuración

1. Clonar el proyecto:

```bash
git clone https://github.com/gonzacass/diablo2-server.git
cd diablo2-server
