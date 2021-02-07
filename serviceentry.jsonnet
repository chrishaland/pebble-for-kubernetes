function(name, namespace, port) {
    apiVersion: 'networking.istio.io/v1beta1',
    kind: 'ServiceEntry',
    metadata: {
        name: name,
        namespace: 'istio-system'
    },
    spec: {
        endpoints: [
            { address: '%s.%s.svc.cluster.local' % [name, namespace] }
        ],
        hosts: [
            'pebble'
        ],
        location: 'MESH_INTERNAL',
        ports: [
            { name: 'https', number: port, protocol: 'TCP' },
        ],
        resolution: 'DNS'
    },
}
