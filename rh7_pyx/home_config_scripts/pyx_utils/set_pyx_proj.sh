#! /bin/bash

project_id=$1
user=$2
workdir0="/isona1/${project_id}/${project_id}/FrontEnd"
# export PROJECT_ID=$project_id
cd ${workdir0}
source .${user}cshrc
