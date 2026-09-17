# Session 12: Ingress, ConfigMaps, and Secrets

This session covers Kubernetes ConfigMaps, Secrets, Ingress routing, TLS, and a complete frontend/backend demo.

## 01. ConfigMap

The application ConfigMap is created and inspected with `kubectl describe configmap` and JSONPath.

![ConfigMap creation and inspection](images/Screenshot%202026-09-17%20at%2022.14.39.png)

## 02. Secret

A database Secret is created, listed, and decoded for verification.

![Secret creation and decoding](images/Screenshot%202026-09-17%20at%2022.18.35.png)

## 03. Ingress

The NGINX Ingress add-on is enabled, HTTP routes are configured, and a TLS certificate is created for HTTPS access.

![Ingress and TLS configuration](images/Screenshot%202026-09-17%20at%2022.21.10.png)

## 04. Full Demo

The complete demo connects ConfigMaps and Secrets to frontend and backend deployments, Services, and Ingress routing.

![Full demo configuration and resources](images/Screenshot%202026-09-17%20at%2022.25.09.png)

![Full demo deployments, Services, and Ingress](images/Screenshot%202026-09-17%20at%2022.25.20.png)
