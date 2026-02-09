# Apple Music - Hi-fi стрийминг музикална платформа
## Информация за студента
* `Факултетен номер`: 2001321056
* `Проект`: Apple Music
* `Дисциплина`: Софтуерно моделиране и анализ

## Описание на проекта
---
Apple Music Clone е платформа за музикален стрийминг, която позволява на потребителите да достъпват, организират и слушат музикално съдържание. Системата е проектирана да управлява взаимовръзките между изпълнители, албуми и песни, както и да предоставя персонализирано изживяване чрез абонаментни планове. Платформата позволява на потребителите да:

* Слушат песни и албуми от глобален каталог (Streaming).
* Създават и управляват лични Playlists (колекции от песни).
* Избират между различни абонаментни планове (Individual, Family).
* Търсят музика по изпълнител, албум или жанр.
* Генерират история на слушане за аналитични цели.

## Структура на проекта
---
``` Software-modelling-analysis-se/
├── README.md                                     # Този файл
├── Diagrams/
│   ├── Chens_Database_Diagram_Apple_Music.png    # Концептуален модел (Chen's notation)
│   ├── Crows_Diagram_Apple_Music.png             # Логически модел (Crow's Foot notation)
│   └── Data_Warehouse_Diagram_Apple_Music.png    # Data Warehouse модел (UML notation)
├── SQDLDatabase/
│   ├── 01_Schema_DDL.sql                         # CREATE TABLE statements
│   ├── 02_Programmability.sql                    # Stored procedures, functions, triggers
│   └── 03_Data_Seeding_DML.sql                   # Sample data insertion
├── DataWarehouse/
    └── dw-schema.sql                             # Data Warehouse schema (Fact & Dimensions)
```

## Технологии
---
* `База данни`: MS SQL Server
* `Диаграми`: Mermaid.js
## Инсталация и стартиране
---
### Предварителни изисквания
* MS SQL Server (2019 или по-нова версия)
* SQL Server Management Studio (SSMS)

### Стъпки за инсталация
1. Клониране на репозиторито

```
git clone https://github.com/[username]/software-modeling-and-analysis-se.git
cd software-modeling-and-analysis-se/course-work/Implementations/Software-modelling-analysis-se
```
2. Създаване на базата данни

Отворете SSMS и изпълнете скриптовете от папката SQLDatabase/ в следната последователност:
```
SQLDatabase/01-Schema.sql (Създава таблиците и връзките)
SQLDatabase/02-Programmability.sql (Добавя тригери, функции и процедури)
SQLDatabase/03-Data.sql (Зарежда тестови данни)
```
3. Създаване на Data Warehouse

```Изпълнете скриптовете за създаване на Fact и Dimension таблиците```

## Модели на данни
---
### Основни обекти (Entities)
1. `Users` - Регистрирани потребители на платформата.
1. `Artists` - Изпълнители и групи.
1. `Albums` - Колекции от песни, издадени от артисти.
1. `Songs` - Основната единица музикално съдържание.
1. `Playlists` - Потребителски колекции от песни.
1. `Subscriptions` - Информация за абонаментния статус и плащания.
1. `StreamHistory` - Логове за активността (кой, какво и кога е слушал).

### Връзки (Relationships)
1. `Artists → Albums `(Един артист има много албуми).
1. `Albums → Songs `(Един албум съдържа много песни).
1. `Users → Playlists `(Един потребител създава много плейлисти).
1. `Users → Subscriptions `(Един потребител има един активен абонамент).

### Връзки много-към-много (M:N)
1. `Playlists ↔ Songs` (Реализирано чрез таблица PlaylistSongs: Една песен може да е в много плейлисти, един плейлист има много песни).
1. `Users ↔ Songs` (Реализирано чрез StreamHistory: Потребителите слушат много песни, една песен се слуша от много потребители).
