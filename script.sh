#!/bin/bash
if [ -z "$K8S_READY" ];then
    export K8S_READY="no"
    echo "not equal"
fi
