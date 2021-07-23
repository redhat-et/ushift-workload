# Local Persistent Volumes

**Check extra volumes**
```
$ ls -alth /dev/sd*
brw-rw---- 1 root disk 8,  1 Jul 23 11:53 /dev/sda1
brw-rw---- 1 root disk 8,  2 Jul 23 11:53 /dev/sda2
brw-rw---- 1 root disk 8, 80 Jul 23 11:53 /dev/sdf
brw-rw---- 1 root disk 8, 64 Jul 23 11:53 /dev/sde
brw-rw---- 1 root disk 8,  0 Jul 23 11:53 /dev/sda
brw-rw---- 1 root disk 8, 16 Jul 23 11:53 /dev/sdb
brw-rw---- 1 root disk 8, 32 Jul 23 11:53 /dev/sdc
brw-rw---- 1 root disk 8, 48 Jul 23 11:53 /dev/sdd
```

**Create Storage Class**
```
cat > storageClass.yaml << EOF
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: microshift-local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF

kubectl create -f storageClass.yaml
```
**Run the mount volumes script to configure drives and create data directories**
```
./mount-volumes.sh
```

**Run the create-local-persistent-volume.sh to create local volumes**
```
./create-local-persistent-volume.sh
```


**Validate local volumes have been created**
```
$ kubectl get pv
NAME           CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS               REASON   AGE
local-pv-sdb   16Gi       RWO            Retain           Available           microshift-local-storage            3m32s
local-pv-sdc   16Gi       RWO            Retain           Available           microshift-local-storage            3m29s
local-pv-sdd   16Gi       RWO            Retain           Available           microshift-local-storage            3m27s
local-pv-sde   16Gi       RWO            Retain           Available           microshift-local-storage            3m35s
local-pv-sdf   16Gi       RWO            Retain           Available           microshift-local-storage            3m37s
```

**Set microshift-local-storage  as default**
```
$ kubectl patch storageclass microshift-local-storage  -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}
```

**validate default storage class**
```
$ kubectl get sc
NAME                                 PROVISIONER                        RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
kubevirt-hostpath-provisioner        kubevirt.io/hostpath-provisioner   Delete          WaitForFirstConsumer   false                  3h10m
microshift-local-storage (default)   kubernetes.io/no-provisioner       Delete          WaitForFirstConsumer   false                  45m
```