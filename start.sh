#!/bin/bash

#Asegurar existencia de logs
touch /pvpgn/var/pvpgn/bnetd.log
touch /root/.wine/drive_c/d2gs/d2gs.log
touch /root/.wine/drive_c/d2gs/d2ge.log

#Iniciar servicios PvPGN con logs redirigidos
echo "? Iniciando PvPGN..."
/pvpgn/sbin/d2dbs -f >> /pvpgn/var/pvpgn/bnetd.log 2>&1 &
/pvpgn/sbin/d2cs -f >> /pvpgn/var/pvpgn/bnetd.log 2>&1 &
/pvpgn/sbin/bnetd -f >> /pvpgn/var/pvpgn/bnetd.log 2>&1 &

sleep 3

#Iniciar D2GS con logs redirigidos (Wine)
/root/.wine/drive_c/d2gs/start.sh >> /root/.wine/drive_c/d2gs/d2gs.log 2>> /root/.wine/drive_c/d2gs/d2ge.log &
#Mantener proceso vivo si todo va en background
tail -f /pvpgn/var/pvpgn/bnetd.log
