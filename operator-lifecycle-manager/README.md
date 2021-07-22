
# Install operator-lifecycle-manager
The Operator Framework is an open source toolkit to manage Kubernetes native applications, called Operators, in an effective, automated, and scalable way.

## Install command
```
./operator-lifecycle-manager-install.sh v0.18.2 https://github.com/operator-framework/operator-lifecycle-manager/releases/download
```

## Verify operator-lifecycle-manager is installed
```
$ kubectl get pods -n olm
NAME                                READY   STATUS    RESTARTS   AGE
catalog-operator-64bd4f69f6-sp457   1/1     Running   0          2m44s
olm-operator-789475dcf9-2vhd7       1/1     Running   0          2m44s
operatorhubio-catalog-2rxvn         1/1     Running   0          2m26s
packageserver-8848f6957-cwkrs       1/1     Running   0          2m25s
packageserver-8848f6957-jw4td       1/1     Running   0          2m25s
```

## Install applications on operatorhub.io
* https://operatorhub.io/

## Github Link
* https://github.com/operator-framework/operator-lifecycle-manager/