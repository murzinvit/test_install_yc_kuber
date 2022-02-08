resource "yandex_kubernetes_cluster" "test-kuber" {
  name        = "test-kuber"
  description = "description"

  network_id = yandex_vpc_network.internal.id

  master {
    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.internal-a.zone
        subnet_id = yandex_vpc_subnet.internal-a.id
      }

      location {
        zone      = yandex_vpc_subnet.internal-b.zone
        subnet_id = yandex_vpc_subnet.internal-b.id
      }

      location {
        zone      = yandex_vpc_subnet.internal-c.zone
        subnet_id = yandex_vpc_subnet.internal-c.id
      }
    }

    version   = "1.21"
    public_ip = true

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        day        = "monday"
        start_time = "15:00"
        duration   = "3h"
      }

      maintenance_window {
        day        = "friday"
        start_time = "10:00"
        duration   = "4h30m"
      }
    }
  }

  service_account_id      = yandex_iam_service_account.admin.id
  node_service_account_id = yandex_iam_service_account.instances-editor.id

  labels = {
    my_key       = "my_labels"
    my_other_key = "my_key"
  }

  release_channel = "STABLE"
}

    resource "yandex_kubernetes_node_group" "node-group-0" {
      cluster_id = yandex_kubernetes_cluster.test-kuber.id
      name       = "test-group-auto"
      version    = "1.21"


      instance_template {
        platform_id = "standard-v2"
        nat         = true

        resources {
          core_fraction = 20
          memory        = 2
          cores         = 2
        }

        boot_disk {
          type = "network-hdd"
          size = 64
        }

        scheduling_policy {
          preemptible = false
        }
      }

      scale_policy {
        auto_scale {
          min     = 2
          max     = 3
          initial = 2
        }
      }

      allocation_policy {
        location {
          zone = "ru-central1-a"
        }
      }
    }