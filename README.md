# Docker run puppeteer with VNC

В репозитории представлен пример запуска puppeteer в docker с доступом через VNC.

## 1. Сборка Docker

Команды для запуска докер сборки находятся в скрипте `sh start.sh`.

Для запуска браузера с графическим интерфейсом в docker помимо самих зависимостей puppeteer, используются следующие пакеты:

- x11vnc - популярный VNC сервер, пароль для которого задаётся в переменной окружения `X11VNC_PASSWORD`.
- Xvfb (X virtual framebuffer) — виртуальный X-сервер, который для вывода использует не видеокарту, а оперативную память.
- fluxbox - минималистичный оконный менеджер для X11, который будет отвечать за отрисовку браузера.

В скрипте `entrypoint.sh` описываеся основная логика.

Запуск виртуального X-сервера с номером X-сервера по умолчанию :99.
```
Xvfb :99 -ac -listen tcp -screen 0 1024x800x24 &
```
Запуск fluxbox на виртуальном X-сервере с номером :99.
```
/usr/bin/fluxbox -display :99 -screen 0 &
```
Запуск VNC-сервера x11vnc на виртуальном X-сервере с номером :99.
```
x11vnc -display :99.0 -forever -passwd ${X11VNC_PASSWORD:-password} &
```
Старт скрипта, запускающий puppeteer.
```
DISPLAY=:99.0 node src/index.js
```

## 2. Доступ к vnc

Пароль задаётся в Dockerfile. В переменной окружения `X11VNC_PASSWORD` и запускается на порту `5900`.
```
ENV \
  DEBIAN_FRONTEND="nonintractive" \
  X11VNC_PASSWORD="password"
```

По умолчанию доступы для VNC на локалхосте такие:

- Хост: 0.0.0.0:5900
- Пароль: password

Теперь для логина через VNC в Docker можно использовать `tigervnc`.

Для Ubuntu можно установить так:
```
sudo apt-get update -y
sudo apt-get install -y tigervnc-viewer
```

![Docker run puppeteer with VNC](https://github.com/BaryshevRS/docker-vnc-puppeteer/raw/main/assets/ubuntu.png)


