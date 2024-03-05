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
    script pour créer le répertoire DIGIT et son arborescence d'un nouveau projet
    S'il existe déja, permet d'ajouter simplement un utilisateur.
    il initialise également les dépots git.
    NB : les dépots git doivent dans un premier temps avoir été créés dans GitLab

Use with option :
    -h|--help                           show this help text
    -g|--group <gitlab_project_group>   (mandatory) set the name of the project group for GitLab
    -n|--name  <project_name>           (mandatory) set the name of the project name or Hard IP  ( \"hiphop\" generates ddg_hiphop_lib )
    -t|--type_proj|--type  <type_proj>  (mandatory) set the type_proj of project :
                                           -> (default) top project    (top_proj | top) : create DIGIT directory
                                           ->           sub project    (sub_proj | sub) : create DIGIT_<project_name> directory
                                           ->           HardIp project (hip_proj | hip) : create DIGIT_<project_name> directory (pas de différence pour le moment avec type_proj = sub)
    -au|--adduser <username>            add an user to an existing Project folder"

debug=1 # Well.... used for debugging...

# if 0 argument supplied, display usage 
[[ $# -eq 0 ]] && { echo "Error : Missing argument"; echo "$usage"; exit 1; }

# check whether user had supplied -h or --help . If yes display usage 
if [[  $1 == "--help" ||  $1 == "-h" ]]  ;
then 
    echo "$usage"
    exit 0
fi 

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

if [ $debug -eq 1 ] ;
then
    echo "project Gitlab group set is : $group"
    echo "project name         set is : $name"
    echo "type_proj            set is : $type_proj"
    echo "Folder               set is : $digit_folder"
    echo "adduser              set is : $adduser"
    echo "username             set is : $username"
fi

# Setting basic default variables : 

arr_default_tools_list=(
bin
ddg_newproject_lib
generator
ncsim
perl_extensions
structure
git_config
)


arr_default_soft_list=(
cct_lib
ddg_template_c_model
ddg_template_soft
include
mat_lib
template_CPP_model
)

arr_default_sv_list=(
common
global
image
io
register
TESTBENCH_SV
)

arr_default_reuse_list=(
ddg_anabus_slave
ddg_and21
ddg_clock_gater
ddg_clock_gen
ddg_hamming32266_dec
ddg_hamming32266_enc
ddg_hamming844_32b_dec
ddg_hamming844_32b_enc
ddg_hamming844_dec
ddg_hamming844_enc
ddg_irq_resync
ddg_majority_voter
ddg_mux21
ddg_muxana
ddg_or21
ddg_pulse2pulse
ddg_pulse2tog
ddg_resynch_filter
ddg_tog2pulse
ddg_tog_gater
)

arr_default_utils_list=(
ddg_alu_modules
ddg_global_func
ddg_global_mixte
gro_iopads
)

# https://git-scm.com/docs/git-sparse-checkout/2.28.0
# This says "include everything in root, but nothing two levels below root."
arr_default_global_list=(
)

arr_default_ip_list=(
)

# arr_item_list=("${arr_default_reuse_list[*]}")
# for item in ${arr_item_list[@]}; do
#   echo "library item ${item}"
# done
# exit

# Start asking questions now. I want to know anything about you :3
in_loop=1
while [ $in_loop -ne 0 ] ;
do
    if [[ ${adduser} -eq 0  || -z ${username} ]]
    then
      username=`whoami`
      echo -e "\033[34mWhich username would you like to use ? Default is : [$username]\033[0m"
      read username
    fi
    pattern=" |'"$'|\t'
    if [[ -z "$username" ]] ;
    then
    username=`whoami`
    in_loop=0
    elif [[ $username =~ $pattern ]]
    then
    echo -e "\033[31m >_< Blank spaces are not allowed in usernames ! \033[0m"
    in_loop=1
    else
    in_loop=0
    fi
done
if [ $debug -eq 1 ]
then
    echo "Username set is : $username"
fi

echo -e "\033[34mOK ! I'll start creating folders now. I hope you did'nt use me to do bad things !"
echo -e "...\033[0m"
sleep 1
if [ $debug -eq 1 ]
then
    echo "adduser is set to $adduser"
fi
if [ $adduser -eq 0 ] ;
then
    if [ -d $digit_folder ]
    then
        echo -e "\033[31mOH ! Naughty you ! You tried to make me overwrite an existing DIGIT folder !"
        echo -e "$digit_folder already exists. Chose an other project name !"
        echo -e "If you wanted to add an other user to the project folder, please call me again with the option -au or --adduser. \033[0m"
        exit 1
    else
        mkdir $digit_folder
        # We are sure we are in a brand new folder so we don't need to overcheck things here ;)
        mkdir $digit_folder/USERS
        mkdir $digit_folder/DEV
        chmod -R g+w $digit_folder
        chmod    g+s $digit_folder/DEV
        mkdir $digit_folder/USERS/$username

        if [ $debug -eq 1 ]
        then
            echo "OK ! $digit_folder created, boss."
        fi
    fi
else # We are adding an user to an existing HIP proj
    if [ ! -d $digit_folder ]
    then
        echo -e  "\033[31m404, folder not found. The folder $digit_folder does not exist. I can't add an user to it :/"
        echo -e  "If instead you wanted to create an project, call me again without using the -au option ;) \033[0;0m"
        exit 1
    else
        if [ -d "$digit_folder/USERS/$username" ];
        then
            echo -e "\033[31mHow dare you !!??! You tried to make me overwrite an existing USER folder !"
            echo -e "$digit_folder/USERS/$username already exists. Choose an other username !\033[0m"
            exit 1
        else
            mkdir -p $digit_folder/USERS/$username
            if [ $debug -eq 1 ]
            then
                echo "OK ! username folder created, boss."
            fi
        fi
    fi
fi

########################################
#   Now we can populate the folders    #
########################################
DIGIT_PATH=$(pwd)/${digit_folder}
USER_PATH=${DIGIT_PATH}/USERS/${username}
cd ${USER_PATH}


project_lib_name="ddg_${name}_lib"
repository_path="git@v-pyxutils:projects-root/${group}/digital-design/${project_lib_name}.git"

git ls-remote ${repository_path}
[[ $? != 0 ]] && { echo "ERROR : repository_path ${repository_path} not found."; exit 1; }

git clone ${repository_path}
cd ${USER_PATH}/${project_lib_name}
git flow init --defaults
cd ${USER_PATH}


[[ ${adduser} -eq 0 ]] && { mkdir ${USER_PATH}/${project_lib_name}/config_proj; }

################################################################################
#        get default item from libraries
# (ddg_tools_lib, ddg_sv_lib, ddg_soft_lib, ddg_reuse_lib)
################################################################################
function git_sparse_checkout(){
  repository=$1
  repository_path="git@v-pyxutils:digital-team/libraries/${repository}.git"

  echo ""
  echo "################################################################################"
  echo "##   Clone and config ${repository} repository"
  echo "###############################################"

  git ls-remote ${repository_path}
  [[ $? != 0 ]] && { echo "ERROR : repository_path ${repository_path} not found."; exit 1; }

  if [ ${adduser} -eq 1 ] ;
  then
    git clone --no-checkout ${repository_path}
    cd ${USER_PATH}/${repository}
    git config core.sparseCheckout true
    git checkout master

    # La règle Pyxalis veut qu'on ne fasse pas de développement d'une librairie (tools_lib, reuse_lib, ...) dans l'environnement d'un projet
    # on doit donc avoir uniquement la branche master d'une librairie dans l'environnement d'un proejt
    #git checkout develop
    #git flow init --defaults
  else
    git clone --no-checkout ${repository_path}
    cd ${USER_PATH}/${repository}
    case ${repository} in
      ddg_tools_lib)
        arr_item_list=("${arr_default_tools_list[*]}")
        ;;
      ddg_soft_lib)
        arr_item_list=("${arr_default_soft_list[*]}")
        ;;
      ddg_sv_lib)
        arr_item_list=("${arr_default_sv_list[*]}")
        ;;
      ddg_reuse_lib)
        arr_item_list=("${arr_default_reuse_list[*]}")
        ;;
      ddg_utils_lib)
        arr_item_list=("${arr_default_utils_list[*]}")
        ;;
      ddg_global_lib)
        arr_item_list=("${arr_default_global_list[*]}")
        ;;
      ddg_ip_lib)
        arr_item_list=("${arr_default_ip_list[*]}")
        ;;
      *)
        arr_item_list=""
        ;;
    esac 

    echo "/*"    > .git/info/sparse-checkout; #vide le fichier s'il existe, créé le fichier s'il n'existe pas.
    echo "!/*/" >> .git/info/sparse-checkout;
    for item in ${arr_item_list[*]}; do
      echo "    library item ${item}"
      echo ${item} >> .git/info/sparse-checkout
    done
    git config core.sparseCheckout true
    git checkout master
    # La règle Pyxalis veut qu'on ne fasse pas de développement d'une librairie (tools_lib, reuse_lib, ...) dans l'environnement d'un projet
    # on doit donc avoir uniquement la branche master d'une librairie dans l'environnement d'un proejt
    #git checkout develop
    #git flow init --defaults
    
    list_item_file_name="list_item_${repository}.txt"
    cp .git/info/sparse-checkout ${USER_PATH}/${project_lib_name}/config_proj/${list_item_file_name}
  fi

  echo "################################################################################"
  echo ""
}


git_sparse_checkout "ddg_tools_lib"  ; cd ${USER_PATH}
git_sparse_checkout "ddg_soft_lib"   ; cd ${USER_PATH}
git_sparse_checkout "ddg_sv_lib"     ; cd ${USER_PATH}
git_sparse_checkout "ddg_reuse_lib"  ; cd ${USER_PATH}
git_sparse_checkout "ddg_utils_lib"  ; cd ${USER_PATH}
git_sparse_checkout "ddg_global_lib" ; cd ${USER_PATH}
git_sparse_checkout "ddg_ip_lib"     ; cd ${USER_PATH}

################################################################################


cd ${USER_PATH}/${project_lib_name}

if [ ${adduser} -eq 0 ] ;
then 
  
  cp ${USER_PATH}/ddg_tools_lib/ddg_newproject_lib/ddg_newproject_lib.cshrc ./${project_lib_name}.cshrc
  
  sed -i "s/@@PROJECT_NAME@@/${name^^}/" ${project_lib_name}.cshrc; # ${name^^} permet de convertir la variable name en majuscule.
  cp ${USER_PATH}/ddg_tools_lib/ddg_newproject_lib/ddg_techno_lib.cshrc ${USER_PATH}/${project_lib_name}/config_proj/ddg_techno_lib.cshrc
  
fi

# il n'est pas conseillé de sourcer le xxx.cshrc dans ce script car : 
#    - le .usernamecshrc n'est peut être pas encore créé. => manque les variables USER_NAME et DIGIT_PATH
#    - même si le .usernamecshrc existe, il n'est pas encore mis à jour suite à l'ajout du nouveau DIGIT (ou DIGIT_xxx)
#exec csh -c "source ./${project_lib_name}.cshrc"

echo -e "\033[1;34mHey !!! You need first exit and return to the project (pyxcaxxx).
    Then Don't forget to modify your brand new ${project_lib_name}.cshrc file before sourcing it.
    It is located here : ${USER_PATH}/${project_lib_name}/${project_lib_name}.cshrc .
    Then you can call the create_block.pl script and name your new blocks ddg_<blocname> ;)\033[0;0m"       
