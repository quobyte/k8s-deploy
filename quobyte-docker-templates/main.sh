#!/bin/bash
# Set S3 Endpoint
_S3=s3.quobyte.local

MYNAME=$NODENAME
NODENUM=$(echo "$MYNAME" | tr -dc "0-9")


function replaceOrAddParam () {
    local config_file=$1
    local config_param=$2
    local config_value=$3

    if grep ^"$config_param" "$config_file";then
        sed -i "s/$config_param=.*/$config_param=$config_value/" "$config_file"
    else
        # param not present so far, add at the end
        echo "$config_param"="$config_value" >> "$config_file"
    fi
}


uname -a

if [[ $NODENUM < 5 ]]; then
mkdir -p /var/lib/quobyte/devices/registry
    fi
 
mkdir -p /var/lib/quobyte/devices/metadata
mkdir -p /var/lib/quobyte/devices/data0
mkdir -p /var/lib/quobyte/devices/data1

if [ "$MYNAME" == "quobyte-0" ];then
    if [ -e /var/lib/quobyte/devices/registry/QUOBYTE_DEV_SETUP ];then 
        echo "registry exists"
    else
        /usr/bin/qbootstrap -y -d /var/lib/quobyte/devices/registry
    fi
else
    if [ -e /var/lib/quobyte/devices/registry/QUOBYTE_DEV_SETUP ];then 
        echo "registry exists"
    elif 
        [[ $NODENUM < 5 ]]; then
        /usr/bin/qmkdev -d -t REGISTRY /var/lib/quobyte/devices/registry
    fi
fi

if [ -e /var/lib/quobyte/devices/metadata/QUOBYTE_DEV_SETUP ];then 
    echo "metadata exists"
else
    /usr/bin/qmkdev -d -t METADATA /var/lib/quobyte/devices/metadata
fi

if [ -e /var/lib/quobyte/devices/data0/QUOBYTE_DEV_SETUP ];then 
    echo "data exists"
else
    /usr/bin/qmkdev -d -t DATA /var/lib/quobyte/devices/data0
fi

if [ -e /var/lib/quobyte/devices/data1/QUOBYTE_DEV_SETUP ];then
    echo "data exists"
else
    /usr/bin/qmkdev -d -t DATA /var/lib/quobyte/devices/data1
fi


QUOBYTE_WEBCONSOLE_PORT=8080

echo "registry=quobyte-0.quobyte.default.svc.cluster.local,quobyte-1.quobyte.default.svc.cluster.local,quobyte-2.quobyte.default.svc.cluster.local,quobyte-3.quobyte.default.svc.cluster.local" > /etc/quobyte/host.cfg
echo "hostname_override=$MYNAME" >> /etc/quobyte/data.cfg
echo "hostname_override=$MYNAME" >> /etc/quobyte/metadata.cfg
echo "hostname_override=$MYNAME" >> /etc/quobyte/api.cfg
echo "hostname_override=$MYNAME" >> /etc/quobyte/registry.cfg
echo "hostname_override=$MYNAME" >> /etc/quobyte/s3.cfg
echo "hostname_override=$MYNAME" >> /etc/quobyte/webconsole.cfg

if [ -n "$QUOBYTE_RPC_PORT" ]; then echo rpc.port=$QUOBYTE_RPC_PORT > /etc/quobyte/$QUOBYTE_SERVICE.cfg; fi
if [ -n "$QUOBYTE_HTTP_PORT" ]; then echo http.port=$QUOBYTE_HTTP_PORT >> /etc/quobyte/$QUOBYTE_SERVICE.cfg; fi
if [ -n "$QUOBYTE_API_PORT" ]; then echo api.port=$QUOBYTE_API_PORT >> /etc/quobyte/$QUOBYTE_SERVICE.cfg; fi
if [ -n "$QUOBYTE_S3_HOSTNAME" ]; then echo s3.hostname=$QUOBYTE_S3_HOSTNAME >> /etc/quobyte/$QUOBYTE_SERVICE.cfg; fi
if [ -n "$QUOBYTE_S3_PORT" ]; then echo s3.port=$QUOBYTE_S3_PORT >> /etc/quobyte/$QUOBYTE_SERVICE.cfg; fi
if [ -n "$QUOBYTE_S3_SECURE_PORT" ]; then echo s3.secure.port=$QUOBYTE_S3_SECURE_PORT >> /etc/quobyte/$QUOBYTE_SERVICE.cfg; fi
if [ -n "$QUOBYTE_WEBCONSOLE_PORT" ]; then echo webconsole.port=$QUOBYTE_WEBCONSOLE_PORT >> /etc/quobyte/$QUOBYTE_SERVICE.cfg; fi
if [ -n "$QUOBYTE_EXTRA_SERVICE_CONFIG" ]; then echo $QUOBYTE_EXTRA_SERVICE_CONFIG >> /etc/quobyte/$QUOBYTE_SERVICE.cfg; fi
if [ -n "$QUOBYTE_DEBUG_PORT" ]; then echo REMOTE_DEBUGGING_PORT=$QUOBYTE_DEBUG_PORT >> /etc/default/quobyte; fi
if [ -n "$QUOBYTE_ENABLE_ASSERTIONS" ]; then echo ENABLE_ASSERTIONS=$QUOBYTE_ENABLE_ASSERTIONS >> /etc/default/quobyte; fi
if [ -n "$HOST_IP" ]; then echo public_ip=$HOST_IP >> /etc/quobyte/$QUOBYTE_SERVICE.cfg; fi

if [ -n "$QUOBYTE_MAX_MEM_REGISTRY" ]; then replaceOrAddParam "/etc/default/quobyte" "MAX_MEM_REGISTRY" "$QUOBYTE_MAX_MEM_REGISTRY"; fi
if [ -n "$QUOBYTE_MAX_MEM_METADATA" ]; then replaceOrAddParam "/etc/default/quobyte" "MAX_MEM_METADATA" "$QUOBYTE_MAX_MEM_METADATA"; fi
if [ -n "$QUOBYTE_MAX_MEM_DATA" ]; then replaceOrAddParam "/etc/default/quobyte" "MAX_MEM_DATA" "$QUOBYTE_MAX_MEM_DATA"; fi
if [ -n "$QUOBYTE_MAX_MEM_API" ]; then replaceOrAddParam "/etc/default/quobyte" "MAX_MEM_API" "$QUOBYTE_MAX_MEM_API"; fi
if [ -n "$QUOBYTE_MAX_MEM_WEBCONSOLE" ]; then replaceOrAddParam "/etc/default/quobyte" "MAX_MEM_WEBCONSOLE" "$QUOBYTE_MAX_MEM_WEBCONSOLE"; fi
if [ -n "$QUOBYTE_MAX_MEM_S3" ]; then replaceOrAddParam "/etc/default/quobyte" "MAX_MEM_S3" "$QUOBYTE_MAX_MEM_S3"; fi
if [ -n "$QUOBYTE_MIN_MEM_METADATA" ]; then replaceOrAddParam "/etc/default/quobyte" "MIN_MEM_METADATA" "$QUOBYTE_MIN_MEM_METADATA"; fi
if [ -n "$QUOBYTE_MIN_MEM_DATA" ]; then replaceOrAddParam "/etc/default/quobyte" "MIN_MEM_DATA" "$QUOBYTE_MIN_MEM_DATA"; fi
if [ -n "$QUOBYTE_MIN_MEM_REGISTRY" ]; then replaceOrAddParam "/etc/default/quobyte" "MIN_MEM_REGISTRY" "$QUOBYTE_MIN_MEM_REGISTRY"; fi
if [ -n "$QUOBYTE_MIN_MEM_API" ]; then replaceOrAddParam "/etc/default/quobyte" "MIN_MEM_API" "$QUOBYTE_MIN_MEM_API"; fi
if [ -n "$QUOBYTE_MIN_MEM_WEBCONSOLE" ]; then replaceOrAddParam "/etc/default/quobyte" "MIN_MEM_WEBCONSOLE" "$QUOBYTE_MIN_MEM_WEBCONSOLE"; fi
if [ -n "$QUOBYTE_MIN_MEM_S3" ]; then replaceOrAddParam "/etc/default/quobyte" "MIN_MEM_S3" "$QUOBYTE_MIN_MEM_S3"; fi

#grep -q "/devices" /proc/mounts
#if [ $? -ne 0 ]; then
#  echo test.device_dir=/devices >> /etc/quobyte/$QUOBYTE_SERVICE.cfg
#fi

echo "constants.webconsole.setup_wizard.enable=false" >> /etc/quobyte/webconsole.cfg

for QUOBYTE_SERVICE in $QUOBYTE_SERVICES
do
  echo test.device_dir=/var/lib/quobyte/devices >> /etc/quobyte/$QUOBYTE_SERVICE.cfg
  echo logging.file_name= >> /etc/quobyte/$QUOBYTE_SERVICE.cfg
  echo logging.stdout=true >> /etc/quobyte/$QUOBYTE_SERVICE.cfg

  SERVICE_UUID=$(grep "^ *uuid" "/etc/quobyte/$QUOBYTE_SERVICE.cfg" | awk -F = '{print $2}')
  if [[ -z $SERVICE_UUID ]]; then
    SERVICE_UUID=$(uuidgen)
    echo uuid=$SERVICE_UUID >> /etc/quobyte/$QUOBYTE_SERVICE.cfg
  fi
done

export LIMIT_OPEN_FILES=100000
export LIMIT_MAX_PROCESSES=16384

ulimit -n $LIMIT_OPEN_FILES
# Maximize the virtual memory limit to make sure that Java can set the MaxHeapSize (-Xmx) correctly.
ulimit -v unlimited
ulimit -u $LIMIT_MAX_PROCESSES

#echo "Running Quobyte service $QUOBYTE_SERVICE $SERVICE_UUID in container"
#echo "Service configuration:"
#cat /etc/quobyte/$QUOBYTE_SERVICE.cfg

for QUOBYTE_SERVICE in $QUOBYTE_SERVICES
do
/usr/bin/quobyte-$QUOBYTE_SERVICE &
done
/usr/bin/qmgmt -r user login admin quobyte
while [[ $(/usr/bin/qmgmt device list | grep -c "not registered") != 0 ]]
do 
  echo "Waiting for devices to be registered"
  sleep 1
done

/usr/bin/qmgmt volume config import RF1 /RF1.cfg
/usr/bin/qmgmt volume config import RF3 /RF3.cfg
/usr/bin/qmgmt volume config import EC42 /EC42.cfg
/usr/bin/qmgmt volume config import S3-objects /S3-objects.cfg

/usr/bin/qmgmt volume create vol-RF1 root root RF1
/usr/bin/qmgmt volume create vol-RF3 root root RF3
/usr/bin/qmgmt volume create vol-EC42 root root EC42
/usr/bin/qmgmt volume create "S3 Objects" root root S3-objects

sed -i "s/__S3__/${_S3}/g" /system.cfg
/usr/bin/qmgmt systemconfig import /system.cfg
pkill -9 /usr/bin/quobyte-s3 && /usr/bin/quobyte-s3

rm -f /*.cfg

tail -f /var/log/lastlog
