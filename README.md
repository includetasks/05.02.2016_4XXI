Yahoo Finance Task
==================

> Реализация простого Web-приложения, реализующего работу с абстрактным портфелем акций вместе с возможностью получению данных о стоимости этого портфеля за последние 2 года.

##### Содержание

- [Описание](#Регистрация-и-вход)
- [Установка и запуск](#Установка и запуск)
- [Нюансы реализации](#Нюансы-реализации)
- [Временные затраты](#Временные-затраты)

Описание
========

Приложение реализует работу с абстрактным портфелем акций. Позволяет проследить стоимость портфеля в зависимости от времени в периоде опследних двух лет.

Вы можете добавлять акции в ваш портфель и анализировать стоимость портфеля в разрезе финансовой информации об акциях за последних двух лет. Данные отражают 4 ценовые характеристики акций:

- open;
- closed;
- low;
- high.

Для расчета стоимости портфеля используется следующая формула:
- **сумма портфеля** = сумма стоимостей всех акций (**акция** * **количество** * **стоимость_акции**)

#### Регистрация и вход

![alt-text](https://github.com/includetasks/05.02.2016_4XXI/blob/master/1-motion-reg-log.gif)

#### Создание портфеля

![alt-text](https://github.com/includetasks/05.02.2016_4XXI/blob/master/2-motion-portf-creation.gif)

#### Наполнение портфеля акциями и генерирование графика

![alt-text](https://github.com/includetasks/05.02.2016_4XXI/blob/master/3-motion-stocks-charts.gif)

#### Удаление акций и портфеля

![alt-text](https://github.com/includetasks/05.02.2016_4XXI/blob/master/5-motion-portfolio-editing.gif)

Установка и запуск
======

**Внимание!** Предварительно необходимо сконфугируровать ActionMailer (для перехвата сообщений от Devise Mailer'а). Для удобства работы я воспользовался MailCatcher'ом. В текущей реализации dev-режим использует настройки mailcatcher'а (можно было отключить настройку необходимости подтверждения регистрации юзеров, но мне захотелось оставить это для бизости к функционалу настоящего приложения):

```ruby
/config/environments/development.rb

config.action_mailer.default_url_options = { host: '127.0.0.1', port: 3000 }
config.action_mailer.delivery_method     = :smtp
config.action_mailer.smtp_settings       = { host: '127.0.0.1', port: 1025 }
```

Для установки приложения:
- склонируйте репозиторий;
- установите необходимые гемы;
- сконфигурируйте базу данных (в данном случае используется SQLite3);
- [custom option] сконфигурируйте action mailer / установите mailcatcher (и запустите командой mailcatcher)
- запустите Rails-приложение. 

```bash
git clone git://github.com/includetasks/05.02.2016_4XXI.git
bundle install
rake db:migrate
mailcatcher
rails server
```

Под капотом используется SQLite3, адрес тестового приложения - стандартный http://localhost:3000.

Нюансы реализации
=================

- тестами покрыл только модели, т.к. на написание остальных тестов могло уйти слишком много времени;
- история стоимости портфеля акций расчитывается до 2015.07.01 (YahooFinance API restriction);
- авторизация пользователей: **Devise gem**;
- генерирование графиков: **HighChartsJS / jQuery**;
- API-запросы: **jQuery.when().then()**;
- frontend UI framework: **Material Design Lite**;
- проброс данных моделей во frontend: **через GON**;
- реализован набор сущностей для работы с Yahoo Finance API.

Для удобной работы со списком акций во Frontend'е используется маппинг данных моделей в GON-контейнер.

Для удобной работы с Flash-сообщениями контроллеров используется маппинг Flash в GON-контейнер.

Flash-сообщения выводятся в Toast-блок.

#### Нюансы некоторых контроллеров:

- **stocks_controller**
    - create: создает новую акцию или увеличивает count у выбранной акции по Symbol и PortfolioID;
    - destroy: удаляет акцию или уменьшает count у выбранной акции;

#### Нюансы некторых моделей:

- **user**
    - аггрегирует акции и портфели акций;
- **stock**
    - сущность акции;
    - имеет поля count и symbol;
    - count отвечает за количество акций с текущим symbol в пакете акций;
- **portfolio**
    - сущность портфеля акций;
    - аггрегирует в себе акции;
    - возвращает общее количество акций;
    - возвращает массив символов акций.

#### Frontend Application Facade (CoffeeScript):

```bash
./app/assets/javascripts
├── application.coffee
└── lib
    ├── application_facade.coffee
    ├── draw_chart.coffee
    ├── portfolio.coffee
    ├── yfapi_data_converter.coffee
    ├── yfapi_data_fetcher.coffee
    └── yfapi_request_builder.coffee
```

- **[ApplicationFacade (class)](https://github.com/includetasks/05.02.2016_4XXI/blob/master/app/assets/javascripts/lib/application_facade.coffee)** - инициализирует все необходимые сущности для получения данных от YahooFinance API, сущности для отрисовки графиков и выполняет биндинг callback-функций на View;
- **[YFAPIRequestBuilder (class)](https://github.com/includetasks/05.02.2016_4XXI/blob/master/app/assets/javascripts/lib/yfapi_request_builder.coffee)** - специализированный Request Builder, возвращающий Memo-функцию, которая генерирует различные (по датам startDate/endDate) YQL-запросы;
- **[YFAPIDataFetcher (class)](https://github.com/includetasks/05.02.2016_4XXI/blob/master/app/assets/javascripts/lib/yfapi_data_fetcher.coffee)** - регистрирует request builder и выполняет запросы в API на основе сгенерированных Yahoo-Specified URIs;
- **[ConvertYFAPIDataToHistory (function)](https://github.com/includetasks/05.02.2016_4XXI/blob/master/app/assets/javascripts/lib/yfapi_data_converter.coffee)** - конвертирует данные, полученные от Yahoo, в формат { date: { symbol : { coast_story } }, ... }
- **[Portfolio (class)](https://github.com/includetasks/05.02.2016_4XXI/blob/master/app/assets/javascripts/lib/portfolio.coffee)** - отражение данных портфеля акций; способен возвращать историю своей стоимости на основе полученных данных от YFAPIDataConverter; хранит в себе набор символов с их count-характеристикой;
- **[drawChart (function)](https://github.com/includetasks/05.02.2016_4XXI/blob/master/app/assets/javascripts/lib/draw_chart.coffee)** - отрисовывает график на основе истории стоимости Portfolio.

Временные затраты
=================

# Этап 1. Review задачи (~3-4 часа)

Много времени ушло на изучение предметной области, разбирательства с различными Charts/Toast-библиотеками и тем, как работать с Yahoo Finance API.

1. изучение предметной области (финансовые данные, пакеты акций, торги):
    - ask / bid / spread / volume
    - high / low
    - open / closed
    - YahooFinance API / YQL / yahoo.finance.historicaldata
2. Выбор необходимых библиотек:
    - frontend:
        - языки: **Slim**, **SASS**, **CoffeeScript**;
        - design-framework: **Material Design Lite**, **Material Icons**;
        - toast-сообщения: **ToastJS**;
        - async API requests: **jQuery.when().then()**;
        - работа с датами в API-запросах: **MomentJS**;
        - charts: **HighCharts / HighStock**;
        - для удобства работы с коллекциями: **UnderscoreJS**.
    - backend:
        - framework: **Ruby on Rails**;
        - пробросс данных **back => front** (в JS): **GON gem**;
        - регистрация юзеров: **Devise gem**
        - для минимального покрытия комментариями: **annotate gem**
        - specs: **RSpec/FactoryGirl/ShouldaMatchers/Capybara/DatabaseCleaner/BetterErrors** (на самом деле, тесты написал только для моделей, т.к. full test coverage занял бы много времени и решение задачи затянулось бы);

3. Продумывание некоторых нюансов архитектуры, dataflow и связности сущностей
    - User владеет портфелями акций;
    - Портфель аггрегирует в себе акции;
    - Акция принадлежит и юзеру, и портфелю;
    - Удаление портфеля порождает удаление акций;
    - Для удобства работы с акциями из JS используется след. маппинг: **backend => GON => frontend JS**
    - Возможные действия юзера: 
        - **SignUp => SignIn => LogOut**
        - **Create Portfolio => Add Stocks**
        - **Select stocks => Generate charts**
        - **Сan drop stocks**
        - **Сan drop portfolios**
    - Действия генератора графиков (JS): **collect selected stocks => make API request => draw charts**

# Этап 2. Разработка (~7-8 часов)

Как ни странно, все проблемы были только на стороне Frontend'а. Большая часть времени ушла на изучение и реализацию следующих моментов:
- как работает библиотека HighCharts (какие опции принимает, в каком виде принимает данные) (поигрался с ней немного);
- как получить данные от YahooFinance (YQL, REST API) (делал разные запросы, смотрел данные, которые вовзращаются);
- как полученные данные сконвертировать в форму, понятную для HighCharts-библиотеки;
- вёрстка всех деталей в контексте фреймворка UI Material Design Lite;
- решение проблем, возникающих в процессе работы с YahooFinance API.

В итоге, основное время отняли написание и рефакторинг следующих классов и сущностей:
- **YahooFinance Request Builder** (CoffeeScript);
- **YahooFinance DataConverter** (CoffeeScript);
- **YahooFinance ASYNC DataFetcher** (CoffeeScript);
- **Portfolio Entity** (CoffeeScript);
- **ApplicationFacade** (CoffeeScript) (аггрегирует в себе описанные сущности и связывает их);
- **UI (Slim, CoffeeScript, MaterialDesignFramework)**.

Помимо этого, в процессе разработки выявились ограничения, которые заставляли несколько раз переписывать код:

1. Yahoo Finance API иногда не может вернуть данные для 2х и более типов акций за период в год (внутренние ограничения платформы, связанных толи с временем генерирования ответа, толи с объемом получаемых данных)
    - **пришлось разделять запросы на множество подзапросов**
2. Yahoo Finance API иногда не мог вернуть данные в период за 2 года, но мог за период в 1 год
    - **пришлось реализовать генератор запросов (замыкание с замкнутой дельтой даты, coffeescript), который при каждом вызове генерировал бы url'ку для запроса в API с уменьшенными на 1 год значениями startDate и endDate**;
2. Yaho Finance API возвращал мне данные только до **2015.07.01** (не стал рабзираться в ограничении, решил сделать вывод данных в графиках, ограничиваясь именно этой датой);

В виду того, что решение задачи затягивалось, принял решение реализовать только минимальные unit-тесты (для моделей).