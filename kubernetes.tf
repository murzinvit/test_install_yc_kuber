resource "yandex_kubernetes_cluster" "kuber-cluster" {
    name        = "kub-test"
    network_id = yandex_vpc_network.internal.id

    master {
    zonal {
        zone      = "ru-central1-a"
        subnet_id = yandex_vpc_subnet.internal-a.id
    }

    version   = "1.21"
    public_ip = true
    }

    release_channel = "RAPID"
    network_policy_provider = "CALICO"

    node_service_account_id = yandex_iam_service_account.docker-registry.id
    service_account_id      = yandex_iam_service_account.instances-editor.id
    depends_on = [
      yandex_vpc_network.internal, yandex_vpc_subnet.internal-a, yandex_vpc_subnet.internal-b, yandex_vpc_subnet.internal-c
    ]

}