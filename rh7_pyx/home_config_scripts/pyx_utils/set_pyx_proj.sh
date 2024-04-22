#! /bin/bash

projet=$1
user=$2
workdir0="/isona1/${projet}/${projet}/FrontEnd"
export PROJET=$projet
cd ${workdir0}
source .${user}cshrc
