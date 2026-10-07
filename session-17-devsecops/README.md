# Session 17: DevSecOps

This session focuses on integrating security into the DevOps workflow. We cover secure container registries, Kubernetes deployment security, SAST, software composition analysis, secret scanning, container image scanning, and security gates.

---

## 1. Container Registry

Secure container registry practices are essential for protecting images and controlling access to trusted artifacts.

![Container registry setup](images/Screenshot%202026-10-07%20at%2001.08.23.png)

---

## 2. Kubernetes Deployment Security

Kubernetes workloads must be deployed with secure configuration, proper services, and controlled traffic exposure.

![Kubernetes deployment and service](images/Screenshot%202026-10-07%20at%2001.08.28.png)

---

## 3. DevSecOps Workflow Summary

This lab demonstrates how security checks are introduced across the development lifecycle, including image protection, scanning, and policy enforcement.

---

## 4. Key Takeaways

- Security should be built into CI/CD pipelines
- Container images must be scanned before deployment
- Secrets must never be hardcoded
- Kubernetes workloads should be validated before release
- Security gates help prevent vulnerable code from reaching production
