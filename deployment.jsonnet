function(name, namespace, version, port) {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
        name: name,
        namespace: namespace
    },
    spec: {
        replicas: 1,
        selector: {
            matchLabels: {
                app: name,
                version: version
            }
        },
        template: {
            metadata: {
                labels: {
                    app: name,
                    version: version
                }
            },
            spec: {
                containers: [
                    {
                        name: name,
                        image: 'letsencrypt/pebble:%s' % version,
                        resources: {
                            requests: { memory: '16Mi', cpu: '25m' },
                            limits: { memory: '32Mi', cpu: '50m' }
                        },
                        ports: [
                            { containerPort: port }
                        ],
                        env: [
                            { name: 'PEBBLE_VA_NOSLEEP', value: '1' },
                            { name: 'PEBBLE_VA_ALWAYS_VALID', value: '1' },
                        ]
                    }
                ]
            }
        }
    }
}
