local namespace = import 'namespace.jsonnet';
local service = import 'service.jsonnet';
local deployment = import 'deployment.jsonnet';
local secret = import 'secret.jsonnet';
local issuer = import 'issuer.jsonnet';

local PEBBLE_PORT = 14000;
local ISTIO_ENABLED = false;

function(
    NAME='pebble',
    NAMESPACE='cert-manager',
    PEBBLE_TAG='latest',
    ISSUER_EMAIL='example@example.com'
) [
    namespace(NAMESPACE, ISTIO_ENABLED),
    service(NAME, NAMESPACE, PEBBLE_PORT),
    deployment(NAME, NAMESPACE, PEBBLE_TAG, PEBBLE_PORT),
    issuer(NAME, NAMESPACE, PEBBLE_PORT, ISSUER_EMAIL)
]
