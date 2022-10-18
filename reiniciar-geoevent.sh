#!/bin/bash

##################################################################
# script que reinicia servicio geoevent-ufro de arcgis 10.8
# version :0.4
# Update  :01.10.2022
##################################################################

#RUTAS
PATH_SERVER=/home/arcgis/arcgis/server
PATH_GATEWAY=/home/arcgis/arcgis/server/GeoEvent/gateway/bin
PATH_GEOEVENT=/home/arcgis/arcgis/server/GeoEvent/bin

#MATA PROCESO ArcGis* ejecutados por el usuario arcgis
#killall -9 ArcG*  
#killall -9 ArcGISGeoEventG
#killall -9 ArcGISGeoEvent-
#echo "MATANDO PROCESOS.."
#sleep 1m

if [ "$(whoami)" = 'arcgis' ];
then 

#DETENER GEOEVENT SERVER
sh $PATH_SERVER/stopserver.sh 
#DETENER GATEWAY
sh $PATH_GATEWAY/ArcGISGeoEventGateway-service stop
#DETENER GEOEVENT
sh $PATH_GEOEVENT/ArcGISGeoEvent-service stop

sleep 500
#INICIA GEOEVENT SERVER
sh $PATH_SERVER/startserver.sh
echo "ESPERE 2 MINUTO POR FAVOR..."
sleep 2m

#INICIA GATEWAY
sh $PATH_GATEWAY/ArcGISGeoEventGateway-service start
echo "ESPERE 7 MINUTOS POR FAVOR..."
sleep 7m

#INICIA GEOEVENT
sh $PATH_GEOEVENT/ArcGISGeoEvent-service start
echo "PROCESO FINALIZADO, VERIFICAR GEOEVENT : https://geoevent.cmcc.ufro.cl:6143/geoevent/manager/index.html"

else
    echo "ERROR: El usuario arcgis debe ejecutar estos servicios"

fi 

###IMPORTANTE###
#
#SI ESTE PROCESO FALLA ES NECESARIO MATAR TODO LOS PROCESOS DEL USUARIO ARCGIS DESDE EL ROOT
#Y VOLVER A INTENTAR CON ESTE SCRIPT.
