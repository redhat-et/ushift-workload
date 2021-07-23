#/bin/bash 
set -e 
SUDO=''
if (( $EUID != 0 )); then
    SUDO='sudo'
fi

external_volumes=$(ls -alth /dev/sd*  | grep -v sda | awk '{print $10}')
${SUDO} mkdir -p /data/

for disk in ${external_volumes}
do
    disk_name=$(echo "${disk}" | tr "/" " " | awk '{print $2}')
    echo "Create local-pvc-${disk_name}"

    #format mount point
    ${SUDO} mkfs.ext4 ${disk} 2>/dev/null
    #create dirctory
    ${SUDO} mkdir -p /data/local-pvc-${disk_name}
    ${SUDO}  /data/local-pvc-${disk_name}
    #mount for start up
${SUDO} tee -a /etc/fstab > /dev/null <<EOT
${disk} /data/local-pvc-${disk_name} auto noatime,noexec,nodiratime 0 0
EOT
    ${SUDO} mount -a ${disk} /data/local-pvc-${disk_name}
done