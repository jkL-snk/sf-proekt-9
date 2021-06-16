Практические задания после вебинара
Цель практики: научиться поднимать конвейер для автоматизации деплоймента в два рабочих окружения проекта.

Задание 12.1
Разверните сервер с Jenkins CI и две дополнительные машины, которые будут эмулировать production и stating окружения.

Задание 12.2
Используйте Ansible для создания деплоймента: все три машины должны разворачиваться на основе ansible playbook.

Задание 12.3
На все машины установите Docker. На машине с Jenkins настройте Docker, чтобы контейнеры могли запускаться от имени пользователя Jenkins.

Задание 12.4
Машина Jenkins CI должна уметь «ходить» по ssh от имени Jenkins на машины production и staging. Идеально, если добавление ключей к целевым машинам настроено уже в ansible playbook.

Задание 12.5
Когда будут развернуты все три машины, настройте в Jenkins 5 джоб (job):

Запуск контейнера с WordPress на staging-машине.
Запуск контейнера с WordPress на production-машине.
Джоба с использованием планировщика, где раз в 5 минут скрипт проверяет, пингуются ли production и staging серверы.
Джоба, которая выполняет получение данных uptime с production и staging.
Джоба, которая выполняет перезагрузку production и staging с возможность выбора одной из них или всех сразу (build with params). 
*Задания повышенной сложности
Выполните задания 12.6 и 12.7 и отправьте решения на проверку.

Задание 12.6
Настройку Job вынести в Jenkinsfile и сформировать как Pipeline.

Задание 12.7
Каждую Job хранить в репозитории и целевую Job вытаскивать с помощью клонирования конкретного git branch.

Выполнение:

Вам потребуется заменить публичный ключ в terraform/meta.yml на свой и иметь закрытую часть ключа.

git clone https://github.com/jkL-snk/sf-pract-12-webinar.git

cd ./sf-pract-12-webinar/terraform

terraform init

terraform apply

Полученные IP-адреса хостов прописать в ansible/inventory.ini

cd ..

cd ansible

ssh-agent bash
ssh-add ~/.ssh/id_rsa

ansible-playbook ssh.yaml -i inventory.ini
ansible-playbook docker.yaml -i inventory.ini
ansible-playbook jenkins.yaml -i inventory.ini

Использовать полученный пароль для входа в веб-интерфейс Jenkins

