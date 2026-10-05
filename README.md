# devops-netology

Репозиторий для домашних заданий курса DevOps.

## Игнорируемые файлы

Благодаря добавленным .gitignore будут игнорироваться:
- каталоги .terraform (локальные кэши провайдеров Terraform);
- файлы состояния *.tfstate и *.tfstate.* (содержат чувствительные данные);
- файлы логов crash.log;
- файлы переменных *.tfvars (могут содержать секреты);
- файлы override.tf и конфигурации CLI (.terraformrc, terraform.rc).

## PyCharm

Этот коммит сделан через визуальный редактор PyCharm.

Задания 1–4 выполнены.

    В GitHub и GitLab создан публичный репозиторий devops-netology. Оба добавлены как remote: origin (GitHub) и gitlab (GitLab). Ветка main синхронизирована в обоих репозиториях.

    Созданы теги: лёгкий v0.0 и аннотированный v0.1, запушены в оба репозитория.

    Ветка fix создана от коммита Prepare to delete and move, изменения в README.md закоммичены и отправлены на GitHub.

    В PyCharm Community Edition открыт проект, через GUI сделаны два коммита (Commit from PyCharm #1, Commit from PyCharm #2) и отправлены в оба репозитория.

    В корневой .gitignore добавлено игнорирование каталога .idea/ (настройки IDE). В terraform/.gitignore настроен набор правил для Terraform (игнор .terraform/, *.tfstate, *.tfvars, crash.log, override-файлов, .terraformrc).

Задание со звёздочкой (Bitbucket) не выполнялось.
