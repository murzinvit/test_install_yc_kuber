### Yandex Cloud kubernetes test

https://habr.com/ru/post/574514/

https://github.com/sport24ru

https://github.com/netology-code/devops-diplom-yandexcloud

https://cloud.yandex.ru/docs/managed-kubernetes/solutions/ingress-cert-manager

#### Get yandex cloud image list: </br>
- `yc compute image list --folder-id standard-images` </br>

#### Connect kubernetes: </br>
- `yc managed-kubernetes cluster get-credentials --id cathrdhj5qe2pnvo1742 --external` </br>
- `kubectl get pods` </br>
- `kubectl exec deploy/db -it -- bash` </br>
