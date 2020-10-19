## Quobyte inside Kubernetes

In this repository you can find the files to maintain a Quobyte cluster running on Kubernetes.

### Requirements

* The Quobyte server pods must run on a dedicated node pool, i.e. the VMs/machines in this node pool must not run any other pods. This is required to guarantee the stability and performance of your storage system.
* You can run one Quobyte cluster per kubernetes cluster. If you want to run multiple Quobyte clusters, each needs a separate kubernetes cluster. You can access Quobyte clusters from outside Kubernetes (or another k8s cluster) when you use external dns (see further down).
* Kubernetes version 1.17.12-gke.500 or 1.17.9-gke.6300, use other versions at your own risk.
* For production use the minimum node pool configuration is 6 or more VMs, each at least n2-standard-16. For functional testing you can run with a lower number of VMs. Howeverm, we strongly discourage using smaller machine types.
* If you want to access the Quobyte cluster from the outside world (i.e. other k8s clusters, GCE VMs), you have to enable external-dns. To use this yoiu must allow all external API calls from yor GKE Kubernetes cluster. This should be done when you create the cluster. In addition, you need a properly configured Cloud DNS zone.

### Deploying the cluster

We offer two different deployments you can select from:

1. kubectl apply -f gke-quobyte-deploy-pre.yaml
   This version runs witout external dns and the storage can only be used from inside the cluster.
2. kubectl apply -f gke-quobyte-deploy-extdns-pre.yaml
   This version uses external-dns (see requirements above), the storage can be accessed from anywhere.
