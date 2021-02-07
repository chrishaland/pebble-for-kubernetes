# pebble-for-kubernetes
Pebble and cert-manager manifests for Kubernetes, written in jsonnet.

**Install cert-manager:**

Documentation can be found [here](https://cert-manager.io/docs/installation/kubernetes/).

```
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.1.0/cert-manager.yaml
```

**Install Pebble:**

```
jsonnet \
  --tla-str NAME='pebble' \
  --tla-str NAMESPACE='cert-manager' \
  --tla-str PEBBLE_TAG='latest' \
  --tla-str ISSUER_EMAIL='example@example.com' \
  --yaml-stream \
  main.jsonnet | kubectl apply --filename -
```

**Getting the certificate authority:**

CA's root and intermediate certificates are regenerated on [every launch](https://github.com/letsencrypt/pebble#ca-root-and-intermediate-certificates). This script downloads the certificates:

```
PEBBLE_NAMESPACE='cert-manager' && \
PEBBLE_POD=$(kubectl -n $PEBBLE_NAMESPACE get pod --selector 'app=pebble' --output name) && \
kubectl -n $PEBBLE_NAMESPACE exec $PEBBLE_POD -- wget -O - https://localhost:15000/roots/0 --no-check-certificate > ca.crt && \
kubectl -n $PEBBLE_NAMESPACE exec $PEBBLE_POD -- wget -O - https://localhost:15000/intermediates/0 --no-check-certificate > im.crt
```