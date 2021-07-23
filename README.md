# ushift-workload

Example workloads that can  be ran on [microshift](https://github.com/redhat-et/microshift) cluster.

## Steps to setup Mircoshift
To give Microshift a try, simply install a recent test version (we don't provide stable releases yet) on a Fedora-derived Linux distro (we've only tested Fedora, RHEL, and CentOS Stream so far) using:

### Run install script
```
curl -sfL https://raw.githubusercontent.com/redhat-et/microshift/main/install.sh | sh -
```

###  Verify the cluster has deployed
```
watch -n 5 kubectl get all -A --context microshift
```

### Optional: Install oc-cli
```
curl -OL https://raw.githubusercontent.com/tosin2013/openshift-4-deployment-notes/master/pre-steps/configure-openshift-packages.sh
chmod +x configure-openshift-packages.sh
./configure-openshift-packages.sh -i
```

## Links:
https://github.com/redhat-et/microshift