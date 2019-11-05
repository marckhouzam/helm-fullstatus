# Helm fullstatus plugin

This plugin extends 'helm status' with the status of the kubernetes
resources that have been deployed through the specified helm release.
It behaves similarly to how 'helm2 status' behaves.

## Installation

This plugin requires `kubectl` to be installed and available on your $PATH.

To install the plugin:

```
helm plugin install https://github.com/marckhouzam/helm-fullstatus
```

## Usage

```
$ helm fullstatus RELEASE_NAME [flags]
```
where flags are the same flag as the `helm status` command.

For example, for a release named `nginx_rel` within namespace `nginx_ns`, the command:
```
$ helm fullstatus --namespace nginx_ns nginx_rel
```
will provide the standard `helm status` output followed by something like:

```
NAME                                         SECRETS   AGE
serviceaccount/nginx-nginx-ingress           1         4h9m
serviceaccount/nginx-nginx-ingress-backend   1         4h9m

NAME                                                        AGE
clusterrole.rbac.authorization.k8s.io/nginx-nginx-ingress   4h9m

NAME                                                               AGE
clusterrolebinding.rbac.authorization.k8s.io/nginx-nginx-ingress   4h9m

NAME                                                 AGE
role.rbac.authorization.k8s.io/nginx-nginx-ingress   4h9m

NAME                                                        AGE
rolebinding.rbac.authorization.k8s.io/nginx-nginx-ingress   4h9m

NAME                                          TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
service/nginx-nginx-ingress-controller        LoadBalancer   10.109.134.220   <pending>     80:31903/TCP,443:31726/TCP   4h9m
service/nginx-nginx-ingress-default-backend   ClusterIP      10.107.14.157    <none>        80/TCP                       4h9m

NAME                                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-nginx-ingress-controller        1/1     1            1           4h9m
deployment.apps/nginx-nginx-ingress-default-backend   1/1     1            1           4h9m
```
