#!/bin/bash

set -e

# Cargar variables del .env
source /env

echo "Ì†ΩÌ¥ß Aplicando configuraciones desde .env dentro del contenedor..."

# 1. realm.conf
REALM_FILE="/pvpgn/etc/pvpgn/realm.conf"
if [[ -f "$REALM_FILE" ]]; then
  sed -i 's|^#\?\s*\".*PvPGN Closed Realm.*|"'$REALM_NAME'"\t"PvPGN Closed Realm"\t'$IP_PRIVADA':6113|' "$REALM_FILE"
fi

# 2. d2cs.conf
D2CS_FILE="/pvpgn/etc/pvpgn/d2cs.conf"
if [[ -f "$D2CS_FILE" ]]; then
  sed -i 's|^realmname\s*=.*|realmname = "'$REALM_NAME'"|' "$D2CS_FILE"
  sed -i 's|^servaddrs\s*=.*|servaddrs = '$IP_PRIVADA':6113|' "$D2CS_FILE"
  sed -i 's|^gameservlist\s*=.*|gameservlist = '$IP_PRIVADA'|' "$D2CS_FILE"
  sed -i 's|^bnetdaddr\s*=.*|bnetdaddr = '$IP_PRIVADA':6112|' "$D2CS_FILE"
fi

# 3. d2dbs.conf
D2DBS_FILE="/pvpgn/etc/pvpgn/d2dbs.conf"
if [[ -f "$D2DBS_FILE" ]]; then
  sed -i 's|^servaddrs\s*=.*|servaddrs = '$IP_PRIVADA':6114|' "$D2DBS_FILE"
  sed -i 's|^gameservlist\s*=.*|gameservlist = '$IP_PRIVADA'|' "$D2DBS_FILE"
fi

# 4. address_translation.conf (l√≠neas exactas reemplazadas sin duplicar)
ADDR_TRANS_FILE="/pvpgn/etc/pvpgn/address_translation.conf"
if [[ -f "$ADDR_TRANS_FILE" ]]; then
  IFS=',' read -ra LAN_ARRAY <<< "$IP_LANS"

  # L√≠nea 84: eliminar y reemplazar por nuevas LAN IPs
  sed -i '84d' "$ADDR_TRANS_FILE"
  for idx in "${!LAN_ARRAY[@]}"; do
    PORT=$((6112 + idx))
    sed -i "$((84+idx-1)) a ${LAN_ARRAY[$idx]}:$PORT   $IP_PUBLICA:$PORT      $SUBNET  ANY" "$ADDR_TRANS_FILE"
  done

  # L√≠nea 109 - √∫nica
  sed -i '109c\'$IP_PRIVADA':6113   '$IP_PUBLICA':6113      '$SUBNET'  ANY' "$ADDR_TRANS_FILE"

  # L√≠nea 132 - √∫nica
  sed -i '132c\'$IP_PRIVADA':4000   '$IP_PUBLICA':4000      '$SUBNET'     ANY' "$ADDR_TRANS_FILE"
fi

# 5. d2gs.reg
REG_FILE="/root/.wine/drive_c/d2gs/d2gs.reg"
if [[ -f "$REG_FILE" ]]; then
  sed -i 's|^@=.*|@="'$REALM_NAME'"|' "$REG_FILE"
  sed -i 's|^\"D2CSIP\"=.*|"D2CSIP"="'$IP_PRIVADA'"|' "$REG_FILE"
  sed -i 's|^\"D2DBSIP\"=.*|"D2DBSIP"="'$IP_PRIVADA'"|' "$REG_FILE"
fi

echo "‚úÖ Configuraci√≥n aplicada exitosamente desde .env."
