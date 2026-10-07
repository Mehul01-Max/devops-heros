# Session 14: Kubernetes Troubleshooting

This session focuses on diagnosing and fixing common Kubernetes issues using practical command-line techniques. We learn how to inspect pod states, identify failures, read logs, troubleshoot services, and resolve issues like crash loops, image pull errors, pending pods, and DNS/service misconfigurations.

## Overview

Kubernetes troubleshooting is a critical skill for DevOps and platform engineers. In real-world environments, applications fail for many reasons such as:

- pod not starting
- image not found
- pending scheduling issues
- readiness/liveness failures
- missing service selectors or DNS records
- configuration and networking problems

This lab walks through the most common debugging commands and a few real failure scenarios.

---

## 1. `kubectl get` - Inspect cluster resources

The first step in troubleshooting is checking the current state of pods, services, deployments, and nodes.

![kubectl get pods](images/Screenshot%202026-10-07%20at%2000.39.15.png)

### Common commands

```bash
kubectl get pods
kubectl get pods -o wide
kubectl get deployments
kubectl get services
kubectl get nodes
```

This gives a quick overview of whether workloads are running, pending, failed, or not scheduled.

---

## 2. `kubectl describe` - Get detailed pod and resource information

`kubectl describe` is used to find the root cause of a pod issue. It shows events, conditions, container state, and object metadata.

![kubectl describe pod](images/Screenshot%202026-10-07%20at%2000.39.25.png)

### Useful examples

```bash
kubectl describe pod <pod-name>
kubectl describe deployment <deployment-name>
kubectl describe service <service-name>
```

This command is especially useful when pods are stuck in `Pending`, `CrashLoopBackOff`, or `ImagePullBackOff` states.

---

## 3. `kubectl logs` - View application logs

Logs help identify runtime errors such as failed database connections, bad startup scripts, or application crashes.

![kubectl logs output](images/Screenshot%202026-10-07%20at%2000.42.32.png)

![Application logs showing healthy behavior](images/Screenshot%202026-10-07%20at%2000.42.39.png)

### Common usage

```bash
kubectl logs <pod-name>
kubectl logs -f <pod-name>
kubectl logs <pod-name> --previous
```

If an app is failing at startup, logs often reveal the real cause faster than any other command.

---

## 4. `kubectl exec` - Access a running container

`kubectl exec` allows you to run commands inside a container for checks like environment validation, file inspection, and service testing.

![kubectl exec into a container](images/Screenshot%202026-10-07%20at%2000.43.54.png)

### Example

```bash
kubectl exec -it <pod-name> -- sh
kubectl exec -it <pod-name> -- bash
```

This is useful for:

- checking app files
- testing network connectivity
- validating environment variables
- confirming installed packages or config files

---

## 5. Kubernetes events - Understand what happened

Events provide a timeline of pod and cluster activity. They help track scheduling, image pulls, restarts, and failed readiness checks.

![kubectl get events](images/Screenshot%202026-10-07%20at%2000.45.19.png)

![Events for a pod and container lifecycle](images/Screenshot%202026-10-07%20at%2000.45.28.png)

### Command

```bash
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl describe pod <pod-name>
```

Events are often the fastest way to discover why a pod failed or stayed pending.

---

## 6. CrashLoopBackOff troubleshooting

A `CrashLoopBackOff` state means the container restarts repeatedly because it exits immediately after startup failure.

![CrashLoopBackOff diagnosis](images/Screenshot%202026-10-07%20at%2000.46.39.png)

![Crash loop fix and verification](images/Screenshot%202026-10-07%20at%2000.46.43.png)

### Typical causes

- bad command or entrypoint
- invalid application code
- environment misconfiguration
- missing dependencies or secrets

### Commands

```bash
kubectl get pods
kubectl logs <pod-name>
kubectl describe pod <pod-name>
```

The workflow is usually:

1. identify the pod
2. inspect logs
3. fix the config or app
4. redeploy and recheck status

---

## 7. ImagePullBackOff troubleshooting

`ImagePullBackOff` means Kubernetes could not pull the image from the registry. This is usually due to an invalid image name, authentication issue, or missing repository access.

![Image pull failure](images/Screenshot%202026-10-07%20at%2000.48.44.png)

![Image pull fix and pod recovery](images/Screenshot%202026-10-07%20at%2000.48.51.png)

### Common checks

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl get events
```

Check for:

- wrong image name
- typo in repository or tag
- private registry auth issues
- network/registry access problems

---

## 8. Pending pods troubleshooting

A pod in `Pending` state has been created but has not been scheduled onto a node. This is often caused by resource constraints or node selector issues.

![Pending pod status](images/Screenshot%202026-10-07%20at%2000.49.53.png)

![Pending pod fix and successful scheduling](images/Screenshot%202026-10-07%20at%2000.50.57.png)

### Common reasons

- no available node
- insufficient CPU or memory
- taints and tolerations
- node selector mismatch
- scheduling constraints

### Example checks

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl get nodes
kubectl describe node <node-name>
```

---

## 9. Service and DNS troubleshooting

Service issues can prevent traffic from reaching the pod even when the pod is healthy. This is often caused by incorrect selectors, ports, or DNS configuration.

![Service configuration and endpoints](images/Screenshot%202026-10-07%20at%2000.52.43.png)

![Checking service and endpoint health](images/Screenshot%202026-10-07%20at%2000.55.28.png)

### Useful commands

```bash
kubectl get svc
kubectl describe service <service-name>
kubectl get endpoints
kubectl get pods -o wide
kubectl exec -it <pod-name> -- nslookup <service-name>
```

If a service does not route traffic, verify:

- selector matches pod labels
- target port matches container port
- cluster IP is assigned
- pods are ready and reachable
- DNS resolution works within the cluster

---

## Mini Project: End-to-End Troubleshooting

The mini-project combines multiple troubleshooting scenarios into a single environment and demonstrates how to:

- identify broken pods
- inspect service routing
- debug failed containers
- diagnose image-pull issues
- validate health after fixes

![Mini-project troubleshooting setup](images/Screenshot%202026-10-07%20at%2000.55.42.png)

![Mini-project running successfully after fixes](images/Screenshot%202026-10-07%20at%2000.55.50.png)

---

## Troubleshooting Workflow

A standard Kubernetes troubleshooting flow is:

1. `kubectl get pods` - see the current state
2. `kubectl describe pod` - inspect events and conditions
3. `kubectl logs` - review container output
4. `kubectl exec` - test inside the app container
5. `kubectl get svc` / `kubectl get endpoints` - verify networking
6. fix the configuration or deployment
7. redeploy and validate the result

---

## Key Commands Summary

```bash
kubectl get pods
kubectl get pods -o wide
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl logs -f <pod-name>
kubectl exec -it <pod-name> -- sh
kubectl get svc
kubectl get endpoints
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl describe node <node-name>
```

---

## Conclusion

Session 14 teaches the real-world debugging mindset needed for Kubernetes operations. The most important skill is not just running commands, but interpreting the output correctly and tracing failures from the pod to the cluster level.

By mastering `get`, `describe`, `logs`, `exec`, and `events`, you can diagnose most Kubernetes issues quickly and with confidence.
