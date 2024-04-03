# Домашнее задание к занятию 1 «Введение в Ansible»
## Основная часть
1 -
```shell
TASK [Print fact] ***************************************************************************************************************************************************************************************
ok: [localhost] => {
"msg": 12
}
```
some_fact имеет значение 12

2 -
```shell
TASK [Print fact] ***************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
```
some_fact имеет значение all default fact

3 -
```shell
pchvanin@MacBook-Air-Pavel playbook % docker ps -a
CONTAINER ID   IMAGE                      COMMAND           CREATED         STATUS         PORTS     NAMES
d63901a4e167   pycontribs/ubuntu:latest   "sleep 6000000"   9 seconds ago   Up 8 seconds             ubuntu
93c001c7f83d   pycontribs/centos:7        "sleep 6000000"   4 minutes ago   Up 4 minutes             centos7

```
4 -

```shell
pchvanin@MacBook-Air-Pavel playbook % ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ***********************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *****************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP **********************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
Значение some_fact для managed host "ubuntu" deb. Значение some_fact для managed host "centos7" el.

5,6 -
```shell
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
```
7 -
```shell
pchvanin@MacBook-Air-Pavel playbook % ansible-vault encrypt group_vars/deb/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
pchvanin@MacBook-Air-Pavel playbook % ansible-vault encrypt group_vars/el/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
pchvanin@MacBook-Air-Pavel playbook % cat group_vars/deb/examp.yml 
$ANSIBLE_VAULT;1.1;AES256
66303065376439653134323133383134633165643830353064303865323037383834633739636232
3735613930633063613461373765313430306361393135640a623434346434336638313031626634
63323461346436393265323738373066386238336263663061646431633433656562353333666364
6263386231366665640a303964303134313464393239323937373163353561396237663030316135
36613034396364346634383933303764356237393439663563373532663934386132383264623334
6134313131323663666139623236313937393164666365636634
pchvanin@MacBook-Air-Pavel playbook % cat group_vars/el/examp.yml 
$ANSIBLE_VAULT;1.1;AES256
32343731333164333231663166316131633330663137363266386337666532323965316662333464
3539306638666138363065616666666639313266613532360a373365393836656630643736346638
39353161336138396362646238663934333437363266316665666238333639376635333334303438
3261366434613438330a626433333862333937626333353033396366393363346666666339353636
38666236343035316666663832323332353037336131613338s613366316638636166636236613862
3234373761356139306563663939386635666339333231316134
```
8 -
```shell
pchvanin@MacBook-Air-Pavel playbook % ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password: 

PLAY [Print os facts] ***********************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *****************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP **********************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
9 -
```shell
pchvanin@MacBook-Air-Pavel playbook % ansible-doc -t connection --list | grep control
ansible.builtin.local          execute on controller                       
community.docker.nsenter       execute on host running controller container
```
Подходящий для работы на control node -  ansible.builtin.local 

10 - 
```shell
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
```
11 -
```shell
pchvanin@MacBook-Air-Pavel playbook % ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password: 

PLAY [Print os facts] ***********************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************
[WARNING]: Platform darwin on host localhost is using the discovered Python interpreter at /opt/homebrew/bin/python3.12, but future installation of another Python interpreter could change the meaning
of that path. See https://docs.ansible.com/ansible-core/2.16/reference_appendices/interpreter_discovery.html for more information.
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *****************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "MacOSX"
}

TASK [Print fact] ***************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP **********************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```

