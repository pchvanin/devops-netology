# Домашнее задание к занятию "09-04 Jenkins" 

## Основная часть

>1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
>2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
>3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
>4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.
>5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
>6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True), по умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
>7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
>8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.

[Ссылка на FreestyleJob](https://github.com/pchvanin/devops-netology/blob/main/09-ci-04-jenkins-main/FreestyleJob)


[Ссылка на Declarative Pipeline](https://github.com/pchvanin/devops-netology/blob/main/09-ci-04-jenkins-main/Jenkinsfile)


[Ссылка на Scripted Pipeline](https://github.com/pchvanin/devops-netology/blob/main/09-ci-04-jenkins-main/ScriptedJenkinsfile)

---