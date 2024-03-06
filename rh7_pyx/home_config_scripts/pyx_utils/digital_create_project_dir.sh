#!/bin/bash
#-------------------------------------------------------------------------
#--                   Copyright 2022 (C) PYXALIS
#--                           ALL RIGHTS RESERVED
#--
#-- This document and the information contained therein are
#-- Pyxalis's exclusive property.
#-- Any copy and/or disclosure thereof are subject to
#-- Pyxalis's prior written consent. 
#-------------------------------------------------------------------------
#-- Project : all
#-- Library : 
#-------------------------------------------------------------------------
#-- Description :  
#--   script pour créer le répertoire DIGIT et son arborescence d'un nouveau projet
#--   S'il existe déja, permet d'ajouter simplement un utilisateur.
#--   il initialise également les dépots git.
#--   NB : les dépots git doivent dans un premier temps avoir été créés dans GitLab
#--
#-------------------------------------------------------------------------
#-- AUTHOR        : AF_img140
#-- CREATION DATE : 24/02/2022
#-------------------------------------------------------------------------

usage="
$(basename "$0") [-h|--help] -g|--group gitlab_project_group -n|--name project_name -t|--type_proj|--type <type_proj> [-au|--adduser [<username>]]

  Description :  
    Sans l'option -au: script pour créer le répertoire DIGIT et son arborescence d'un nouveau projet. 
    Avec l'option -au: Ajoute un utilisateur au projet qui doit déjjà avoir été créé auparavant (sans l'option -au)
    
    Il initialise également les dépots git.
    NB : les dépots git doivent dans un premier temps avoir été créés dans GitLab

Use with option :
    -h|--help                           show this help text
    -g|--group <gitlab_project_group>   (mandatory) set the name of the project group for GitLab
    -n|--name  <project_name>           (mandatory) set the name of the project name, Soft IP or Hard IP
    -t|--type_proj|--type  <type_proj>  (mandatory) set the type_proj of project :
                                           -> (default) top project    (top_proj | top) : create DIGIT directory
                                           ->           sub project    (sub_proj | sub) : create DIGIT_<project_name> directory
                                           ->           HardIp project (hip_proj | hip) : create DIGIT_<project_name> directory (pas de différence pour le moment avec type_proj = sub)
    -au|--adduser <username>            add an user to an existing Project folder"

##########################################################################################################
# if 0 argument supplied, display usage 
##########################################################################################################
[[ $# -eq 0 ]] && { echo "Error : Missing argument"; echo "$usage"; exit 1; }

##########################################################################################################
# check whether user had supplied -h or --help . If yes display usage 
##########################################################################################################
if [[  $1 == "--help" ||  $1 == "-h" ]]  ;
then 
    echo "$usage"
    exit 0
fi 

##########################################################################################################
# get cmd arguments
##########################################################################################################
group=""
name=""
type_proj="top"
adduser=0
 # parse arguments
for i in "$@"
do
    case $i in
    -g|--group)
        group="$2"
        shift # past argument
        shift # past value
        ;;
    -n|--name)
        name="$2"
        shift # past argument
        shift # past value
        ;;
    -t|--type_proj|--type)
        type_proj="$2"
        shift # past argument
        shift # past value
        ;;
    -au|--adduser)
        adduser=1
        username="$2"
        shift # past argument
        shift # past argument
        ;;
    *)
    # Do nothing
        ;;
    esac
done

if [[ -z "$group" ]] ;
then 
    echo "No project GitLab group provided"
    echo ""
    echo "$usage"
    exit 1
fi 

if [[ -z "$name" ]] ;
then 
    echo "No project name provided"
    echo ""
    echo "$usage"
    exit 1
fi 

case ${type_proj} in
  "sub"|"sub_proj")
    digit_folder="DIGIT_${name}"
    ;;
  "hip"|"hip_proj")
    digit_folder="DIGIT_${name}"
    ;;
  *|"top"|"top_proj")
    digit_folder="DIGIT"
    ;;
esac

if [[ -z "$username" ]]
then 
  username=`whoami`
fi 

echo -e "#####################################################"
echo "project Gitlab group set is : $group"
echo "project name         set is : $name"
echo "type_proj            set is : $type_proj"
echo "Folder               set is : $digit_folder"
echo "adduser              set is : $adduser"
echo "username             set is : $username"
echo -e "#####################################################"

##########################################################################################################
## creation des repertoires du projet selon la presence ou non de l'option -au à l'appel de la commande
##########################################################################################################
if [[ $adduser -eq 0 ]]
then
    if [[ -d $digit_folder ]]
    then
        echo -e "ERROR: $digit_folder already exists."
        echo -e "If you wanted to add an other user to the project folder, please call me again with the option -au or --adduser. \[0m"
        exit 1
    else
        echo ""
        echo "#####################################################"
        echo "INFO: Create new $digit_folder folder for $name project."
        echo "#####################################################"
        mkdir $digit_folder
        # We are sure we are in a brand new folder so we don't need to overcheck things here ;)
        mkdir $digit_folder/USERS
        mkdir $digit_folder/DEV
        chmod -R g+w $digit_folder
        chmod    g+s $digit_folder/DEV
        mkdir $digit_folder/USERS/$username
    fi
else # We are adding an user to an existing proj
    if [[ ! -d $digit_folder ]]
    then
        echo -e  "ERROR: The folder $digit_folder does not exist."
        echo -e  "If you wanted to create an project, call me again without using the -au option."
        exit 1
    else
        if [[ -d "$digit_folder/USERS/$username" ]]
        then
            echo -e "ERROR: $digit_folder/USERS/$username already exists."
            exit 1
        else
            echo ""
            echo "#####################################################"
            echo -e "INFO: Create new user working $digit_folder/USERS/$username folder for project $digit_folder/.../$name"
            echo "#####################################################"
            mkdir -p $digit_folder/USERS/$username
        fi
    fi
fi

########################################
#   Now we can populate the folders    #
########################################
DIGIT_PATH=$(pwd)/${digit_folder}
USER_PATH=${DIGIT_PATH}/USERS/${username}
cd ${USER_PATH}

project_lib_name="${name}"
repository_path="git@gitlab.pyxalis.local:projects-root/${group}/digital-design/${project_lib_name}.git"

echo ""
echo -e "INFO: Cloning ${repository_path} git repository."
git clone ${repository_path}

echo ""
echo -e "INFO: Initialising git flow workflow."
cd ${USER_PATH}/${project_lib_name}
git flow init --defaults

# in case its a new/first project creation, need to populate config_proj
cd ${USER_PATH}
if [[ $adduser -eq 0 ]]
then
  if [[ ! -d "${USER_PATH}/${project_lib_name}/config_proj" ]]
  then
    echo ""
    echo -e "INFO: Create ${USER_PATH}/${project_lib_name}/config_proj folder."
    mkdir ${USER_PATH}/${project_lib_name}/config_proj
  fi
fi

################################################################################
#        get default item from libraries
# (ddg_tools_lib, ddg_sv_lib, ddg_soft_lib, ddg_reuse_lib)
################################################################################
function git_clone_default_repo(){
  repository=$1
  repository_path="git@gitlab.pyxalis.local:digital-team/libraries/${repository}.git"

  echo ""
  echo "INFO: Cloning ${repository} git repository."
  git clone ${repository_path}
  cd ${USER_PATH}/${repository}
  git checkout master
  
  list_item_file_name="list_item_${repository}.txt"
  ## FIXME: what is this syntax ?
  echo "/*"    > $list_item_file_name
  echo "!/*/" >> $list_item_file_name
  ## FIXME: check how to update this.
  mv $list_item_file_name ${USER_PATH}/${project_lib_name}/config_proj/${list_item_file_name}
  echo "INFO: Create $list_item_file_name into ${project_lib_name}/config_proj for ${repository} git repository"
}

#TODO Add a list of default git repos to clone for the creation of a project. It should be a manifest file related to the project. So located into the git repo $repository_path
cd ${USER_PATH}
default_git_repo_list=(
ddg_tools_lib
ddg_soft_lib
ddg_sv_lib
ddg_reuse_lib
ddg_utils_lib
ddg_global_lib
ddg_ip_lib
)
for item in ${default_git_repo_list[*]}; do
  git_clone_default_repo "${item}" ${project_lib_name}
  cd ${USER_PATH}
done

cd ${USER_PATH}/${project_lib_name} 
if [[ ${adduser} -eq 0 ]]
then 
  echo ""
  ## FIXME: THIS SCRIPT IS WEIRD AND CONTAINS TOO MUCH UNRELATED THINGS
  echo "#####################################################"
  echo "INFO: Copy template ${project_lib_name}.cshrc from ddg_tools_lib/ddg_newproject_lib git repo."
  echo "INFO: PLEASE CUSTOMIZE ${project_lib_name}.cshrc FOR THE NEW PROJECT"
  echo "#####################################################"
  cp ${USER_PATH}/ddg_tools_lib/ddg_newproject_lib/ddg_newproject_lib.cshrc ./${project_lib_name}.cshrc
  # ${name^^} permet de convertir la variable name en majuscule.
  sed -i "s/@@PROJECT_NAME@@/${name^^}/" ${project_lib_name}.cshrc; 

  ## FIXME: what do it corresponds too ?
  echo "#####################################################"
  echo "INFO: Copy template ddg_techno_lib.cshrc from ddg_tools_lib/ddg_newproject_lib git repo."
  echo "INFO: PLEASE CUSTOMIZE ddg_techno_lib.cshrc FOR THE NEW PROJECT"
  echo "#####################################################"
  cp ${USER_PATH}/ddg_tools_lib/ddg_newproject_lib/ddg_techno_lib.cshrc ${USER_PATH}/${project_lib_name}/config_proj/ddg_techno_lib.cshrc  
fi

##FIXME: why ??????? this is insane.
# echo -e "\033[1;34mHey !!! You need first exit and return to the project (pyxcaxxx).
#     Then Don't forget to modify your brand new ${project_lib_name}.cshrc file before sourcing it.
#     It is located here : ${USER_PATH}/${project_lib_name}/${project_lib_name}.cshrc .
#     Then you can call the create_block.pl script and name your new blocks ddg_<blocname> ;)\033[0;0m"       

echo ""
echo -e "INFO: Move into ${USER_PATH}/${project_lib_name} working folder"
cd ${USER_PATH}/${project_lib_name}
