#!/bin/sh
docker-compose up -d
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --kiosk --app="http://localhost:8020" --user-data-dir="$(pwd)/app_window"
