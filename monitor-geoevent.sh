#!/usr/bin/bash

#---------------------------------------------------------------------------
#Monitorea servicio geoevent, cuando detecta problemas reinicia el servicio 
#VERSION: 0.1 
#UPDATE : 21.09.2022
#---------------------------------------------------------------------------

#HASH GEOEVENT
HASH='4f52f942b6722d4c203a5d6b953b709787dbb3f0153b2198e1ae2781afa3e67b  -'

#URL GEOEVENT
URL="https://geoevent.cmcc.ufro.cl:6143/geoevent/manager/index.html"

#HASH ACTUAL
HASH_ACTUAL=$(curl --insecure $URL|sha256sum)

#VERIFICANDO ESTADO DEL SERVICIO

if [ "$HASH" = "$HASH_ACTUAL" ]; then
  echo "TRUE"
else
  echo "FALSE" 
  sleep 5m
  HASH_ACTUAL=$(curl --insecure $URL|sha256sum)
  if [ "$HASH" != "$HASH_ACTUAL" ]; then
    reiniciar-geoevent2   #LLAMAR AL SCRIPT DE REINICIO
  break 
  fi

fi


#VERIFICANDO LOS HASH CALCULADOS...

#Largo cadena 1
longitud=$((${#HASH} - 2))
echo "LARGO:"$longitud
echo $HASH

#Largo cadena 2
longitud=$((${#HASH_ACTUAL} - 2))
echo "LARGO:"$longitud
echo $HASH_ACTUAL

#DEBUG
printf "<%q>\n" "$HASH"
printf "<%q>\n" "$HASH_ACTUAL"
