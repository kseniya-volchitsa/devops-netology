# Домашнее задание к занятию «IaC. Ansible»

## Цель задания

Освоить подход Infrastructure as Code: собрать кастомный образ Debian 12
с Docker, htop и tmux с помощью Packer и Yandex Cloud, проверить образ
и создать из него виртуальную машину.

## Структура задания

- [1. Установка Packer](#1-установка-packer)
- [2. Сборка образа](#2-сборка-образа)
- [3. Проверка образа](#3-проверка-образа)
- [4. ВМ из образа](#4-вм-из-образа)

## 1. Установка Packer

Packer установлен в home-каталог, бинарник доступен в PATH:

```bash
packer --version
```

## 2. Сборка образа

Файлы:

- [mydebian.json.pkr.hcl](./mydebian.json.pkr.hcl) — шаблон Packer: источник образа, параметры ВМ и provisioner;
- [install-docker.sh](./install-docker.sh) — shell-скрипт установки Docker, htop и tmux.

Шаблон использует плагин github.com/hashicorp/yandex (>= 1.1.2), исходный образ — семейство debian-12 из стандартного каталога Yandex Cloud. Токен передаётся через переменную окружения YC_TOKEN, ID каталога — b1gj0t5ngn83u02ifv9a.

Перед сборкой конфигурация проверена валидатором:

```bash
packer validate mydebian.json.pkr.hcl
# The configuration is valid.
```

Запуск сборки:
```bash
packer build mydebian.json.pkr.hcl
```

Сборка завершилась успешно за 2 минуты 41 секунду:

```bash
Build 'yandex.debian-docker' finished after 2 minutes 41 seconds.
==> Builds finished. The artifacts of successful builds are:
--> yandex.debian-docker: A disk image was created:
    debian-12-docker-htop-tmux (id: fd8tqtut99bba20hmter)
```
## 3. Проверка образа

Образ появился в каталоге со статусом READY:

```bash
yc compute image list
+----------------------+----------------------------+--------+--------+
|          ID          |            NAME            | FAMILY | STATUS |
+----------------------+----------------------------+--------+--------+
| fd8tqtut99bba20hmter | debian-12-docker-htop-tmux |        | READY  |
+----------------------+----------------------------+--------+--------+
```

## 4. ВМ из образа

```bash
yc compute instance create \
  --name debian-docker \
  --zone ru-central1-a \
  --create-boot-disk image-id=fd8tqtut99bba20hmter \
  --network-interface subnet-name=mysubnet,nat-ip-version=ipv4 \
  --ssh-key ~/.ssh/id_rsa.pub
```

Проверка установленных компонентов на ВМ:

```bash
ssh yc-user@51.250.80.8 'docker --version && htop --version && tmux -V'
# Docker version 29.10.0, build fdd4b8e
# htop 3.2.2
# tmux 3.3a
```

Контрольный запуск Docker:
```bash
ssh yc-user@51.250.80.8 'sudo docker run hello-world'
# Hello from Docker!
```

# Выводы

С помощью Packer воспроизведён процесс сборки кастомного образа: одна команда создаёт временные сеть, подсеть, диск и ВМ, выполняет provisioner-скрипт и превращает диск в готовый образ. Из образа развёрнута ВМ, на которой подтверждена работа Docker, htop и tmux.

# Правила приема

Домашнее задание выполнено в файле readme.md в GitHub- и GitLab-репозиториях. 
Ссылка на GitHub: https://github.com/kseniya-volchitsa/devops-netology 
Ссылка на GitLab: https://gitlab.com/vol4ica13131313/devops-netology
