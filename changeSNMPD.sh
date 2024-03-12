#!/bin/bash

# Vérifier si le fichier .env existe
if [ ! -f .env ]; then
    echo "Le fichier .env n'existe pas. Veuillez le créer avec les valeurs nécessaires."
    exit 1
fi

# Charger les variables du fichier .env
source .env

# Modifier sysLocation, sysContact et agentaddress
sed -i "s/^sysLocation.*/sysLocation $SYS_LOCATION/" /etc/snmp/snmpd.conf
sed -i "s/^sysContact.*/sysContact $SYS_CONTACT/" /etc/snmp/snmpd.conf
sed -i "s/^agentAddress.*/agentAddress $AGENT_ADDRESS/" /etc/snmp/snmpd.conf

# Mettre en commentaire les lignes par défaut rocommunity
sed -i 's/^rocommunity/#rocommunity/' /etc/snmp/snmpd.conf

# Rajouter la ligne rwcommunity avec la communauté et l'adresse SNMP indiquées dans le fichier .env
echo "rwcommunity $RW_COMMUNITY $SNMP_SERVER_ADDRESS" >> /etc/snmp/snmpd.conf

echo "Modifications effectuées avec succès dans /etc/snmp/snmpd.conf"
