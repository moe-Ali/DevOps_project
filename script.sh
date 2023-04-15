#!/bin/bash
if [ -e k8s_ready ];then
    echo "not ready"
    touch k8s_ready
else
    echo "ready"
fi
