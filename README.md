# AtomSkills 2020. IT Solution for business

## Состав репозитария

* readme.md -- текущая инструкция
* Diagram.png -- ER-диаграмма;
* Diagram.pgd -- ER-диаграмма;
* script.sql -- скрипт на создание базы данных и таблиц;
* папка DronTaxi_Demo -- исполняемый файл приложения;
* папка DronTaxi -- исходный код.
* pgAdmin_instal.txt -- файл с ссылкой на google диск на установочник postgresql-12.3-2-windows-x64.exe.


## Настройка сервера

Установите pgAdmin 4:
- перейдите по ссылке в pgAdmin_instal.txt и скачайте postgresql-12.3-2-windows-x64.exe;
- установите postgresql-12.3-2-windows-x64.exe;
- логин (по умолчанию): postgres;
- пароль: admin;

Запустите pgAdmin 4: 
- создайте базу данных atom;
- пароль: admin;
- выполните скрипт script.sql. Результатом выполнения указанных скриптов является база данных atom с таблицами, приведенными на диаграмме (файл Diagram). А также набор функций, необходимых для работы приложения.

## Запуск приложения
- откройте DronTaxi_Demo;
- запустите DronTaxi.exe;
- логин для авторизации в приложении: admin@mail.ru
- пароль для авторизации в приложении: Admin3

