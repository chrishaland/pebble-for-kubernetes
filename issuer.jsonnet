function(name, namespace, port, email) {
    apiVersion: 'cert-manager.io/v1',
    kind: 'ClusterIssuer',
    metadata: {
        name: name,
        namespace: namespace
    },
    spec: {
        acme: {
            email: email,
            server: 'https://%s.%s.svc.cluster.local:%s/dir' % [name, namespace, port],
            privateKeySecretRef: {
                name: name
            },
            solvers: [
                {
                    http01: {
                        ingress: {
                            class: 'nginx'
                        }
                    }
                }
            ]
        }
    }
}