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
            server: 'https://pebble:%s/dir' % port,
            privateKeySecretRef: {
                name: name
            },
            skipTLSVerify: true,
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