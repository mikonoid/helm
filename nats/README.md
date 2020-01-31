# NATS

[NATS](https://nats.io/) is an open-source, cloud-native messaging system. It provides a lightweight server that is written in the Go programming language.


### Introduction

This chart bootstraps a [NATS](https://github.com/bitnami/bitnami-docker-nats) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

Bitnami charts can be used with [Kubeapps](https://kubeapps.com/) for deployment and management of Helm Charts in clusters. This chart has been tested to work with NGINX Ingress, cert-manager, fluentd and Prometheus on top of the [BKPR](https://kubeprod.io/).

### Prerequisites

- Kubernetes 1.12+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure

### Installing the Chart



### Deploy  NATS cluster with 3 replicas and releasename "my-cluster"
```
helm install --set replicaCount=3 --name my-cluster

```

The command deploys NATS on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

### Uninstalling the Chart

To uninstall/delete the `my-cluster` deployment:

```bash
$ helm delete my-cluster
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

### Configuration

The following table lists the configurable parameters of the NATS chart and their default values.

| Parameter                            | Description                                                                                  | Default                                                       |
| ------------------------------------ | -------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| `global.image.registry.host`              | Global Docker image registry                                                                 | `nil`                                                         |
| `global.image.pullSecret`           | Global Docker registry secret names as an array                                              | `[]` (does not add image pull secret to deployed pods)              |
| `image.tag`                          | NATS Image tag                                                                               | `{TAG_NAME}`                                                  |
| `image.pullPolicy`                   | Image pull policy                                                                            | `Always`                                                      |
| `nats.client.auth.enabled`           | Switch to enable/disable client authentication                                               | `true`                                                        |
| `nats.client.auth.user`              | Client authentication user                                                                   | `nats_cluster`                                                |
| `nats.client.auth.password`          | Client authentication password                                                               | `random alhpanumeric string (10)`                             |
| `cluster.auth.enabled`               | Switch to enable/disable cluster authentication                                              | `true`                                                        |
| `cluster.auth.user`                  | Cluster authentication user                                                                  | `nats_cluster`                                                |
| `cluster.auth.password`              | Cluster authentication password                                                              | `random alhpanumeric string (10)`                             |
| `debug.enabled`                      | Switch to enable/disable debug on logging                                                    | `false`                                                       |
| `debug.trace`                        | Switch to enable/disable trace debug level on logging                                        | `false`                                                       |
| `debug.logtime`                      | Switch to enable/disable logtime on logging                                                  | `false`                                                       |
| `maxConnections`                     | Max. number of client connections                                                            | `nil`                                                         |
| `maxControlLine`                     | Max. protocol control line                                                                   | `nil`                                                         |
| `maxPayload`                         | Max. payload                                                                                 | `nil`                                                         |
| `writeDeadline`                      | Duration the server can block on a socket write to a client                                  | `nil`                                                         |
| `replicaCount`                       | Number of NATS nodes                                                                         | `1`                                                           |
| `resourceType`                       | NATS cluster resource type under Kubernetes (Supported: StatefulSets, or Deployment)         | `statefulset`                                                 |
| `securityContext.enabled`            | Enable security context                                                                      | `true`                                                        |
| `securityContext.fsGroup`            | Group ID for the container                                                                   | `1001`                                                        |
| `securityContext.runAsUser`          | User ID for the container                                                                    | `1001`                                                        |
| `statefulset.updateStrategy`         | Statefulsets Update strategy                                                                 | `OnDelete`                                                    |
| `statefulset.rollingUpdatePartition` | Partition for Rolling Update strategy                                                        | `nil`                                                         |
| `podLabels`                          | Additional labels to be added to pods                                                        | {}                                                            |
| `priorityClassName`                  | Name of pod priority class                                                                   | `nil`                                                         |
| `podAnnotations`                     | Annotations to be added to pods                                                              | {}                                                            |
| `nodeSelector`                       | Node labels for pod assignment                                                               | `nil`                                                         |
| `schedulerName`                      | Name of an alternate                                                                         | `nil`                                                         |
| `antiAffinity`                       | Anti-affinity for pod assignment                                                             | `soft`                                                        |
| `tolerations`                        | Toleration labels for pod assignment                                                         | `nil`                                                         |
| `resources`                          | CPU/Memory resource requests/limits                                                          | {}                                                            |
| `extraArgs`                          | Optional flags for NATS                                                                      | `[]`                                                          |
| `livenessProbe.initialDelaySeconds`  | Delay before liveness probe is initiated                                                     | `30`                                                          |
| `livenessProbe.periodSeconds`        | How often to perform the probe                                                               | `10`                                                          |
| `livenessProbe.timeoutSeconds`       | When the probe times out                                                                     | `5`                                                           |
| `livenessProbe.successThreshold`     | Minimum consecutive successes for the probe to be considered successful after having failed. | `1`                                                           |
| `livenessProbe.failureThreshold`     | Minimum consecutive failures for the probe to be considered failed after having succeeded.   | `6`                                                           |
| `readinessProbe.initialDelaySeconds` | Delay before readiness probe is initiated                                                    | `5`                                                           |
| `readinessProbe.periodSeconds`       | How often to perform the probe                                                               | `10`                                                          |
| `readinessProbe.timeoutSeconds`      | When the probe times out                                                                     | `5`                                                           |
| `readinessProbe.failureThreshold`    | Minimum consecutive failures for the probe to be considered failed after having succeeded.   | `6`                                                           |
| `readinessProbe.successThreshold`    | Minimum consecutive successes for the probe to be considered successful after having failed. | `1`                                                           |
| `client.service.type`                | Kubernetes Service type (NATS client)                                                        | `ClusterIP`                                                   |
| `client.service.port`                | NATS client port                                                                             | `4222`                                                        |
| `client.service.nodePort`            | Port to bind to for NodePort service type (NATS client)                                      | `nil`                                                         |
| `client.service.annotations`         | Annotations for NATS client service                                                          | {}                                                            |
| `client.service.loadBalancerIP`      | loadBalancerIP if NATS client service type is `LoadBalancer`                                 | `nil`                                                         |
| `cluster.service.type`               | Kubernetes Service type (NATS cluster)                                                       | `ClusterIP`                                                   |
| `cluster.service.port`               | NATS cluster port                                                                            | `6222`                                                        |
| `cluster.service.nodePort`           | Port to bind to for NodePort service type (NATS cluster)                                     | `nil`                                                         |
| `cluster.service.annotations`        | Annotations for NATS cluster service                                                         | {}                                                            |
| `cluster.service.loadBalancerIP`     | loadBalancerIP if NATS cluster service type is `LoadBalancer`                                | `nil`                                                         |
| `monitoring.service.type`            | Kubernetes Service type (NATS monitoring)                                                    | `ClusterIP`                                                   |
| `monitoring.service.port`            | NATS monitoring port                                                                         | `8222`                                                        |
| `monitoring.service.nodePort`        | Port to bind to for NodePort service type (NATS monitoring)                                  | `nil`                                                         |
| `monitoring.service.annotations`     | Annotations for NATS monitoring service                                                      | {}                                                            |
| `monitoring.service.loadBalancerIP`  | loadBalancerIP if NATS monitoring service type is `LoadBalancer`                             | `nil`                                                         |                                                       |
| `networkPolicy.enabled`              | Enable NetworkPolicy                                                                         | `false`                                                       |
| `networkPolicy.allowExternal`        | Allow external connections                                                                   | `true`                                                        |
| `metrics.enabled`                    | Enable Prometheus metrics via exporter side-car                                              | `false`                                                       |
| `metrics.image.registry`             | Prometheus metrics exporter image registry                                                   | `docker.io`                                                   |
| `metrics.image.repository`           | Prometheus metrics exporter image name                                                       | `synadia/prometheus-nats-exporter`                            |
| `metrics.image.tag`                  | Prometheus metrics exporter image tag                                                        | `0.1.0`                                                       |
| `metrics.image.pullPolicy`           | Prometheus metrics image pull policy                                                         | `IfNotPresent`                                                |
| `metrics.image.pullSecrets`          | Prometheus metrics image pull secrets                                                        | `[]` (does not add image pull secrets to deployed pods)       |
| `metrics.port`                       | Prometheus metrics exporter port                                                             | `7777`                                                        |
| `metrics.podAnnotations`             | Prometheus metrics exporter annotations                                                      | `prometheus.io/scrape: "true"`,  `prometheus.io/port: "7777"` |
| `metrics.resources`                  | Prometheus metrics exporter resource requests/limit                                          | {}                                                            |
| `sidecars`                           | Attach additional containers to the pod                                                      | `nil`                                                         |



### [Rolling VS Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

Bitnami will release a new chart updating its containers if a new version of the main container, significant changes, or critical vulnerabilities exist.

## Sidecars

If you have a need for additional containers to run within the same pod as NATS (e.g. an additional metrics or logging exporter), you can do so via the `sidecars` config parameter. Simply define your container according to the Kubernetes container spec.

```yaml
sidecars:
- name: your-image-name
  image: your-image
  imagePullPolicy: Always
  ports:
  - name: portname
   containerPort: 1234
```
