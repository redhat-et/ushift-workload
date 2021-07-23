#!/bin/bash 
if [ -z ${1} ];
then 
  echo "Usage: ./$0 create"
  echo "to create pv ./$0 create"
  echo "to delete pv ./$0 delete"
  exit $?
fi

action=${1}

external_volumes=$(ls -alth /dev/sd*  | grep -v sda | awk '{print $10}')

for disk in ${external_volumes}
do

  disk_name=$(echo "${disk}" | tr "/" " " | awk '{print $2}')
  echo "Create local-pv-${disk_name}"
  size=$(sudo fdisk -l | grep ${disk} | grep -oE "[0-9]{1}.*GiB" | tr 'GiB' ' ' | awk '$1=$1')
  if [ -d /data/local-pvc-${disk_name} ];
  then 
cat > persistentVolume-${disk_name}.yaml << EOF
apiVersion: v1
kind: PersistentVolume
metadata:
  name: local-pv-${disk_name}
spec:
  capacity:
    storage: ${size}Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: microshift-local-storage
  local:
    path: /data/local-pvc-${disk_name}
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - ${HOSTNAME}
EOF
    kubectl ${action} -f persistentVolume-${disk_name}.yaml
    sleep 2s
  fi 
done

kubectl get pv 

