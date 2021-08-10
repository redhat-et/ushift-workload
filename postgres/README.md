# Install Postgres on microshift


## Install helm 
```
$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

**Change kubeconfig to run helm charts**
```
$ chmod go-r ~/.kube/config
```
## Configure local storage 
* [Local Persistent Volumes](../local-storage)

## Start postgres install 
[postgres-operator Releases](https://github.com/CrunchyData/postgres-operator/releases)

**Clone the postgres-operator repo**
```
git clone https://github.com/CrunchyData/postgres-operator.git
cd postgres-operator
git checkout v4.7.0
cd installers/helm
```

**Create pgo namespace**
```
kubectl create namespace pgo
```

**run helm install**
```
helm install postgres-operator . -n pgo
```

**validate that operator is installed**
```
kubectl get pods -n pgo
NAME                                READY   STATUS    RESTARTS   AGE
postgres-operator-85cbf887f-lxpnz   4/4     Running   1          3m40s
```

**run client setup** 
```
curl https://raw.githubusercontent.com/CrunchyData/postgres-operator/v4.7.0/installers/kubectl/client-setup.sh > client-setup.sh
chmod +x client-setup.sh
./client-setup.sh
```

**Configure ~/.bashrc for the pgo cli**

**Create port forward for operator api**
```
kubectl -n pgo port-forward svc/postgres-operator 8443:8443
```

**In new terminal connect to create cluster** 
```
pgo create cluster cofffeeshop -n pgo
```

**Verify database is running**
```
$ kubectl get pods -n pgo
NAME                                                READY   STATUS    RESTARTS   AGE
backrest-backup-cofffeeshop-vm8dz                   1/1     Running   0          9s
cofffeeshop-6b47c8cbb6-v4lqz                        1/1     Running   0          41s
cofffeeshop-backrest-shared-repo-6578f65889-xxk99   1/1     Running   0          43s
postgres-operator-85cbf887f-86v4l                   4/4     Running   0          63m
```

**validate local storage volumes**
```
kubectl get pvc -n pgo
NAME                    STATUS   VOLUME         CAPACITY   ACCESS MODES   STORAGECLASS               AGE
cofffeeshop             Bound    local-pv-sdf   16Gi       RWO            microshift-local-storage   6m28s
cofffeeshop-pgbr-repo   Bound    local-pv-sdc   16Gi       RWO            microshift-local-storage   6m28s
```

