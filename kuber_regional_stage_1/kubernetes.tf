resource "yandex_kubernetes_cluster" "test-kuber" {
  name        = "test-kuber"
  description = "description"

  network_id = yandex_vpc_network.network-1.id

  master {
    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.public-subnet-a.zone
        subnet_id = yandex_vpc_subnet.public-subnet-a.id
      }

      location {
        zone      = yandex_vpc_subnet.public-subnet-b.zone
        subnet_id = yandex_vpc_subnet.public-subnet-b.id
      }

      location {
        zone      = yandex_vpc_subnet.public-subnet-c.zone
        subnet_id = yandex_vpc_subnet.public-subnet-c.id
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

  service_account_id      = yandex_iam_service_account.instances-editor.id
  node_service_account_id = yandex_iam_service_account.docker-registry.id

  labels = {
    my_key       = "test_labels"
    my_other_key = "test_key"
  }

  release_channel = "STABLE"
}

resource "yandex_kubernetes_node_group" "my_node_group" {
  cluster_id  = yandex_kubernetes_cluster.test-kuber.id
  name        = "test-group"
  description = "description"
  version     = "1.21"


  labels = {
    "group_name" = "test-name"
  }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      subnet_ids = [yandex_vpc_subnet.public-subnet-a.id]
      nat = true
    }

    resources {
      core_fraction = 5
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 34
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

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