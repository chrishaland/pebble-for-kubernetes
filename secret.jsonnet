function(name, namespace) {
    apiVersion: 'v1',
    kind: 'Secret',
    metadata: {
        name: name,
        namespace: namespace
    }
}