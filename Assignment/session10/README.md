# Session 10: Kubernetes Core Objects

This session covers Kubernetes deployment strategies and service-based traffic routing.

## 01. Rolling Update

A rolling update replaces application pods gradually while keeping the deployment available.

![Rolling update deployment and service](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.48.03.png)

![Rolling update in progress](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.48.18.png)

![Rolling update rollout history](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.48.24.png)

![Rolling update completed](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.48.29.png)

## 02. Blue-Green Deployment

A blue-green deployment runs two application versions and switches the Service selector between them.

![Blue-green deployments](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.48.33.png)

![Blue-green Service selector](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.48.39.png)

![Blue-green Service endpoints](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.48.54.png)

![Blue-green service verification](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.49.08.png)

## 03. Canary Deployment

A canary deployment sends traffic to a small number of new-version pods while the stable version continues serving most traffic.

![Canary stable deployment rollout](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.49.15.png)

![Canary deployment pods](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.49.28.png)

![Canary traffic distribution](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.49.31.png)

![Canary deployment scaling and endpoints](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.49.38.png)

![Canary traffic verification](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.49.48.png)

## 04. Recreate Deployment

A recreate deployment stops the existing version before starting the replacement version.

![Recreate deployment rollout](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.49.31.png)

![Recreate deployment rollback](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.49.38.png)

![Kubernetes Services verification](../../session10-k8s-core-objects/images/Screenshot%202026-09-17%20at%2021.49.48.png)
