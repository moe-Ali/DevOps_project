#!/bin/bash
if [ -f k8s_ready ];then
    echo "ready"
else
    echo "not ready"
    touch k8s_ready
fi
