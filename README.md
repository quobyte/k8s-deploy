## Quobyte inside Kubernetes

In this repository you can find the files to maintain a Quobyte cluster inside Kubernetes.

In order to get a nice experience and avoid errors you will have to start a Kubernetes cluster in GKE.
The cluster should run on the latest static version (we tested with 1.16.9-gke.2) and requires at least four nodes. In order to be able to scale up you should enable auto scaling for the default pool. For discovery or demo purposes n1-standard will work fine for production you want to use at least c2-standard with 8 vCPUs.

We offer two different deployments you can select from:

1. gke-deploy.yaml
This deployment assumes that everything happens inside your kubernetes cluster. You can't access Quobyte Volumes from outside (e.g. GCE)
2. gke-deploy-hybrid.yaml
