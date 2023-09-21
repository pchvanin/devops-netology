# Домашнее задание к занятию 5. «Оркестрация кластером Docker контейнеров на примере Docker Swarm»
## Задача 1

Дайте письменые ответы на вопросы:

- В чём отличие режимов работы сервисов в Docker Swarm-кластере: replication и global?
- Какой алгоритм выбора лидера используется в Docker Swarm-кластере?
- Что такое Overlay Network?
1. В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?

Режим replication запускает сервис на указанном количестве нод. Количество задается командой `update --replicas=N`. Режим global запускает сервис на всех нодах кластера. [Источник](https://docs.docker.com/engine/swarm/how-swarm-mode-works/services/).

2. Какой алгоритм выбора лидера используется в Docker Swarm кластере?

Алгоритм Raft — лидером становится та нода, которая получила больше всего голосов.

3. Что такое Overlay Network?

Overlay Network — распределённая виртуальная сеть для обмена данными между контейнерами Docker Swarm.

## Задача 2

Создайте ваш первый Docker Swarm-кластер в Яндекс Облаке.

Чтобы получить зачёт, предоставьте скриншот из терминала (консоли) с выводом команды:
```
docker node ls
```
Будем использовать image из предыдущего занятия:
```bash
yc compute image list
+----------------------+---------------+--------+----------------------+--------+
|          ID          |     NAME      | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+---------------+--------+----------------------+--------+
| fd8njfjogfu9uqgvmm7b | centos-7-base | centos | f2ecrlmsarobl83b08mf | READY  |
+----------------------+---------------+--------+----------------------+--------+
```
```bash
terraform init
terraform plan
terraform apply
null_resource.monitoring (local-exec): PLAY RECAP *********************************************************************
null_resource.monitoring (local-exec): node01.netology.yc         : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
null_resource.monitoring (local-exec): node02.netology.yc         : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
null_resource.monitoring (local-exec): node03.netology.yc         : ok=2    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
[root@node01 ~]# docker node ls
ID                            HOSTNAME             STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
cbuw8fevbjkk7ac8opeb2lhqy *   node01.netology.yc   Ready     Active         Leader           24.0.6
u9y6kn5ir7f06fnd0luqrgzfr     node02.netology.yc   Ready     Active         Reachable        24.0.6
b1gynzbyk3xstgl1rx5cl2hdi     node03.netology.yc   Ready     Active         Reachable        24.0.6
nwjkpjditc51tlidwjuxlkcqk     node04.netology.yc   Ready     Active                          24.0.6
t0c90akihloqrx3bfbfkj3lsy     node05.netology.yc   Ready     Active                          24.0.6
lrggmdh7rtvou03h9l6cgtxir     node06.netology.yc   Ready     Active                          24.0.6

```

## Задача 3

Создайте ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Чтобы получить зачёт, предоставьте скриншот из терминала (консоли), с выводом команды:
```
docker service ls
```
```bash
[root@node01 ~]# docker service ls
ID             NAME                                MODE         REPLICAS   IMAGE                                          PORTS
bupr6psphygw   swarm_monitoring_alertmanager       replicated   1/1        stefanprodan/swarmprom-alertmanager:v0.14.0    
kaebrqduh76e   swarm_monitoring_caddy              replicated   1/1        stefanprodan/caddy:latest                      *:3000->3000/tcp, *:9090->9090/tcp, *:9093-9094->9093-9094/tcp
8m9hz09n4e86   swarm_monitoring_cadvisor           global       6/6        google/cadvisor:latest                         
ar68eq50934h   swarm_monitoring_dockerd-exporter   global       6/6        stefanprodan/caddy:latest                      
oj3y342gmls6   swarm_monitoring_grafana            replicated   1/1        stefanprodan/swarmprom-grafana:5.3.4           
m5tj6bkys386   swarm_monitoring_node-exporter      global       6/6        stefanprodan/swarmprom-node-exporter:v0.16.0   
0tun04tcztz5   swarm_monitoring_prometheus         replicated   1/1        stefanprodan/swarmprom-prometheus:v2.5.0       
qh62hsfiss42   swarm_monitoring_unsee              replicated   1/1        cloudflare/unsee:v0.8.0
```




## Задача 4 (*)

Выполните на лидере Docker Swarm-кластера команду, указанную ниже, и дайте письменное описание её функционала — что она делает и зачем нужна:
```
# см.документацию: https://docs.docker.com/engine/swarm/swarm_manager_locking/
docker swarm update --autolock=true
```
```bash
docker swarm update --autolock=true
Swarm updated.
To unlock a swarm manager after it restarts, run the `docker swarm unlock`
command and provide the following key:

    SWMKEY-1-Eiayg9f6ur8PUX/5vVCOG2TomWDUQr6O3nH8pqMv3/Q

Please remember to store this key in a password manager, since without it you
will not be able to restart the manager.
```
Команда docker swarm update --autolock=true создаёт ключ для шифрования/дешифрования логов Raft.

Выполним `terraform destroy` для удаления созданного кластера.
Destroy complete! Resources: 13 destroyed.
