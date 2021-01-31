FROM node:14

ENV \
  DEBIAN_FRONTEND="nonintractive" \
  X11VNC_PASSWORD="password"

# update and add all the steps for running with xvfb
RUN apt-get update &&\
apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget \
xvfb x11vnc x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps \
fluxbox

# add 80 port open for express
# RUN apt-get install -yq libcap2-bin
# RUN setcap cap_net_bind_service=+ep /usr/local/bin/node
# EXPOSE 80 80

# copy all sourse dir
WORKDIR /app

EXPOSE 5900 5900

ADD ./entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT /opt/entrypoint.sh
