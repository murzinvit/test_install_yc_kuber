resource "yandex_compute_instance" "vm-1" {
  name     = "vm-1"
  zone     = "ru-central1-a"
  hostname = "vm-1"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oi1lrp7ifmcuriep9"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.internal-a.id
    ip_address = "10.10.0.100"
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name     = "vm-2"
  zone     = "ru-central1-b"
  hostname = "vm-2"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oi1lrp7ifmcuriep9"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.internal-b.id
    ip_address = "10.11.0.100"
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm-3" {
  name     = "vm-3"
  zone     = "ru-central1-c"
  hostname = "vm-3"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8oi1lrp7ifmcuriep9"
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.internal-c.id
    ip_address = "10.12.0.100"
  }

  metadata = {
    user-data = "${file("meta.txt")}"
  }
}