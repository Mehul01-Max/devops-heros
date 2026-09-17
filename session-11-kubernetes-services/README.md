# Session 11: Kubernetes Services

This session covers the main Kubernetes Service types and how applications are accessed inside and outside the cluster.

## Services Overview

![All services running](images/allTheServicesRunning.png)

## 01. ClusterIP Service

A ClusterIP Service provides internal access to pods from within the Kubernetes cluster.

![ClusterIP deployment and internal service access](images/Screenshot%202026-09-17%20at%2022.38.00.png)

![ClusterIP service endpoints](images/Screenshot%202026-09-17%20at%2022.38.05.png)

## 02. NodePort Service

A NodePort Service exposes an application on a port available on each Kubernetes node.

![NodePort service URL](images/Screenshot%202026-09-17%20at%2022.35.04.png)

![NodePort deployment and service](images/Screenshot%202026-09-17%20at%2022.35.09.png)

## 03. LoadBalancer Service

A LoadBalancer Service provides an externally accessible endpoint through a load balancer.

![LoadBalancer service and Minikube tunnel](images/Screenshot%202026-09-17%20at%2022.40.02.png)

## 04. ExternalName Service

An ExternalName Service maps a Kubernetes Service name to an external DNS name.

![ExternalName service and DNS lookup](images/Screenshot%202026-09-17%20at%2022.40.51.png)

## 05. Headless Service

A headless Service uses `clusterIP: None` and allows DNS discovery of individual StatefulSet pods.

![Headless Service StatefulSet and DNS discovery](images/Screenshot%202026-09-17%20at%2022.43.03.png)
