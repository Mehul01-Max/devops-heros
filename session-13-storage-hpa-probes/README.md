# Session 13: Storage, HPA, and Probes

This session focuses on Kubernetes storage, scaling, and health checks. We explore how persistent and ephemeral storage works, how to scale workloads with HPA, and how liveness, readiness, and startup probes keep applications healthy in production.

## Overview

In this session, we cover:

- EmptyDir and HostPath volumes
- Persistent Volumes (PV) and Persistent Volume Claims (PVC)
- StorageClass-based dynamic provisioning
- Horizontal Pod Autoscaler (HPA)
- Kubernetes probes for health management
- A mini-project combining storage and autoscaling

---

## 01. Volumes

Kubernetes volumes allow containers to share or persist data. In this section, we demonstrate different volume types and how they behave in pods.

![EmptyDir and HostPath volume setup](images/Screenshot%202026-10-07%20at%2000.24.47.png)

![Volume configuration and pod behavior](images/Screenshot%202026-10-07%20at%2000.26.43.png)

### Key Concepts

- `emptyDir`: temporary, container-local storage
- `hostPath`: mounts a path from the node filesystem
- Use cases: shared cache, temporary files, local debugging

---

## 02. Persistent Storage

Persistent storage ensures data survives pod restarts and rescheduling. In this section, we create a PV and PVC and bind them to a pod.

![PV and PVC creation](images/Screenshot%202026-10-07%20at%2000.27.37.png)

![Persistent storage validation](images/Screenshot%202026-10-07%20at%2000.30.20.png)

### Notes

- A `PersistentVolume` is cluster-level storage resource
- A `PersistentVolumeClaim` is a request from an application
- Binding happens automatically when storage matches the claim

---

## 03. StorageClass

A `StorageClass` enables dynamic provisioning, reducing manual storage setup. This section demonstrates how storage is provisioned automatically using class-based definitions.

![StorageClass configuration](images/Screenshot%202026-10-07%20at%2000.30.49.png)

### Why StorageClass matters

- Enables automatic volume creation
- Simplifies application deployment
- Works well with cloud-backed storage providers

---

## 04. Horizontal Pod Autoscaler (HPA)

HPA automatically scales pods based on CPU utilization or custom metrics. This section shows deployment scaling, metrics collection, and autoscaling behavior.

![HPA deployment and scaling](images/Screenshot%202026-10-07%20at%2000.32.30.png)

![Autoscaler behavior and resource usage](images/Screenshot%202026-10-07%20at%2000.32.40.png)

### HPA Summary

- Scales the number of replicas dynamically
- Uses metric thresholds such as CPU utilization
- Helps maintain application performance under load

---

## 05. Probes

Kubernetes probes help determine whether a container is ready and healthy. In this section, we configure and test liveness, readiness, and startup probes.

![Liveness probe configuration](images/Screenshot%202026-10-07%20at%2000.34.11.png)

![Readiness and startup probe validation](images/Screenshot%202026-10-07%20at%2000.34.15.png)

![Probe behavior and status checks](images/Screenshot%202026-10-07%20at%2000.34.19.png)

### Probe Types

- `LivenessProbe`: restarts the container if it is unhealthy
- `ReadinessProbe`: prevents traffic before the app is ready
- `StartupProbe`: delays liveness/readiness checks until startup completes

---

## Mini Project

The mini-project integrates the concepts learned in the session into a complete Kubernetes setup with storage, autoscaling, and health checks.

### Project Structure

- `namespace.yaml`
- `deployment.yaml`
- `service.yaml`
- `pvc.yaml`
- `hpa.yaml`
- `README.md`

### Objective

Deploy a workload that:

- stores data using persistent volume claims
- scales automatically based on resource demand
- exposes health checks for safe rollout and recovery

---

## Useful Commands

```bash
kubectl get pv
kubectl get pvc
kubectl get hpa
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl get deployment
```

---

## Conclusion

Session 13 introduces the foundation for production-ready Kubernetes workloads. Storage ensures persistence, HPA ensures scalability, and probes ensure reliability and self-healing. Together, these features make applications more resilient, performant, and easier to manage in real-world environments.
