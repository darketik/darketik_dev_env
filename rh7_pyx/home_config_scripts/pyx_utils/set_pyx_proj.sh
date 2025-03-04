#! /bin/bash

project_id=$1
user_id=$2
workdir0="/isona1/${project_id}/${project_id}/FrontEnd"
# export PROJECT_ID=$project_id
cd ${workdir0}
source .${user_id}cshrc
