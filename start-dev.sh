#!/bin/sh
exec erl \
    -pa ebin deps/*/ebin \
    -boot start_sasl \
    -sname http_to_mqtt_dev \
    -s http_to_mqtt \
    -s reloader
