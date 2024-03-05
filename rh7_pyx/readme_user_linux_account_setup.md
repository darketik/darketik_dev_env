
# TODO

- transfer pyx /cmd useful scripts into bash env to become tcsh agnostic
- align cshrc_tools to bashrc_tools
- finish install of
  - gtkwave
  - wavedrom
  - gtkwave

# BUGS

- No more man tool available in tcsh ?
- conda force python to 3.11
  - trying 'conda install python=3.12' to fix it

# Install user linux account

## Root

Installation demandée à David pour tous les utilisateurs sur le serveur PyxDig. 

- devtoolset-8 et devtoolset-12  
- yum
  - help2man

## Local

Installation uniquement sur mon user account. (pour l'instant)

- systemc 2.3.4
  - src location:
  - compilation path /isona1/rotenberg/work/opt/systemc/systemc-2.3.4/objdir
  - ins tall path work/users/rotenberg/opt/systemc-2.3.4
  - Directory setup (based on classic layout):
        Installation prefix (aka SYSTEMC_HOME):
            /isona1/rotenberg/work/opt/systemc-2.3.4
        Header files  : <SYSTEMC_HOME>/include
        Libraries     : <SYSTEMC_HOME>/lib-linux64
        Documentation : <SYSTEMC_HOME>/docs
        Examples      : <SYSTEMC_HOME>/examples

- Verilator https://verilator.org/guide/latest/install.html 
  - src location:
  - path: /isona1/rotenberg/work/opt/verilator/verilator_src
  - install: /isona1/rotenberg/work/opt/verilator/install
  - procedure to compile
      Needed to use devtoolset-12 and some env variables for systemC in .cshrc

      git checkout stable
      autoconf
      export VERILATOR_ROOT=`pwd`
      export SYSTEMC_INCLUDE
      export SYSTEMC_LIBDIR
      ./configure --prefix=/isona1/rotenberg/work/opt/verilator/install
      make
      make install

- corev-openhw-gcc-centos7-20230905
  - src location:
  - bin path: /isona1/rotenberg/work/opt/corev-openhw-gcc-centos7-20230905

- verible
  - src location:
  - bin path: /isona1/rotenberg/work/opt/verible-v0.0-3416-g470e0b95

- openssl 1.1.1w
  - src location:
  - bin path: /work/users/rotenberg/opt/openssl-1.1.1w
  - https://computingforgeeks.com/how-to-install-openssl-1-1-on-centos-rhel-7/

- python 3.12
  - bin path: /isona2/rotenberg/work/opt/python-3.12.0
  - https://computingforgeeks.com/install-python-3-on-centos-rhel-7/

- conda via miniforge
  - I DONT REMEMBER WHY I NEEDED IT ???
  - https://github.com/conda-forge/miniforge/#download
  - curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
  - chmod +x Miniforge3-Linux-x86_64.sh
  - ./Miniforge3-Linux-x86_64.sh
  - conda update -n base conda
  - conda install -n base conda-libmamba-solver
  - conda config --set solver libmamba
  - conda install -n base conda-lock=1.4
  - conda activate base
  - conda install python=3.12

- Anaconda
  https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
  > ./Anaconda3-2023.09-0-Linux-x86_64.sh
  - to enbale or not conda by default in your shell:
    Do you wish to update your shell profile to automatically initialize conda?
    This will activate conda on startup and change the command prompt when activated.
    If you'd prefer that conda's base environment not be activated on startup,
      run the following command when conda is activated:
    conda config --set auto_activate_base false
    You can undo this by running `conda init --reverse $SHELL`? [yes|no]
  - if any libmaba or libarchive issue run below cmd
    > conda install --solver=classic conda-forge::conda-libmamba-solver conda-forge::libmamba conda-forge::libmambapy conda-forge::libarchive
    > conda config --set solver libmamba

  - gtkwave-3.3.117
    - bin path: /work/users/rotenberg/opt/
    
  - kactus2-3.12.0
    - bin path: /work/users/rotenberg/opt/
    
  - wavedrom-editor-v2.9.1-linux-x64
    - bin path: /work/users/rotenberg/opt/

### Shell Csh

- link git repo home config scripts into user home folder  
  > cd $HOME
  > set USER_LNX_ENV_PATH=$HOME/work/perso/linux_env/rh7_pyx/home_config_scripts
  > rm $HOME/.cshrc && ln -s $USER_LNX_ENV_PATH/.cshrc
  > rm $HOME/.login && ln -s $USER_LNX_ENV_PATH/.login
  > rm $HOME/.logout && ln -s $USER_LNX_ENV_PATH/.logout
  > rm $HOME/.mycshrc && ln -s $USER_LNX_ENV_PATH/.mycshrc
  > rm $HOME/.mycshrc_tools && ln -s $USER_LNX_ENV_PATH/.mycshrc_tools
  > rm $HOME/.mycshrc_aliases && ln -s $USER_LNX_ENV_PATH/.mycshrc_aliases
  > rm $HOME/.git-completion.bash && ln -s $USER_LNX_ENV_PATH/.git-completion.bash
  > rm $HOME/.gitconfig && ln -s $USER_LNX_ENV_PATH/.gitconfig
  > ln -s $USER_LNX_ENV_PATH/pyx_utils

- git completion:
  - link script
  > ln -s /usr/share/git-core/contrib/completion/git-completion.tcsh $HOME/.git-completion.tcsh
  - source it in .mycshrc
  > source ~/.git-completion.tcsh

- set things to use devtoolset-12 instead of rhel7 old gcc version. It works only in bash but must be set in mycshrc to jump into bash shell instead of bullshit tcsh
  >set DEVTOOL12_BIN=/opt/rh/devtoolset-12/root/usr/bin
  >set DEVTOOL12_LIB=/opt/rh/devtoolset-12/root/usr/lib64:/opt/rh/devtoolset-12/root/usr/lib:/opt/rh/devtoolset-12/root/usr/lib64/dyninst:/opt/rh/devtoolset-12/root/usr/lib/dyninst
  >set path = ($DEVTOOL12_BIN $path $HOME/.local/bin)
  >setenv LD_LIBRARY_PATH $DEVTOOL12_LIB\:$LD_LIBRARY_PATH
  >scl enable devtoolset-12 bash

### Shell Bash

- link git repo home config scripts into user home folder
  > cd $HOME
  > set USER_LNX_ENV_PATH=$HOME/work/perso/linux_env/rh7_pyx/home_config_scripts
  > rm $HOME/.bash_aliases && ln -s $USER_LNX_ENV_PATH/.bash_aliases
  > rm $HOME/.bash_functions && ln -s $USER_LNX_ENV_PATH/.bash_functions
  > rm $HOME/.bash_profile && ln -s $USER_LNX_ENV_PATH/.bash_profile
  > rm $HOME/.bashrc && ln -s $USER_LNX_ENV_PATH/.bashrc
  > rm $HOME/.bash_tools && ln -s $USER_LNX_ENV_PATH/.bash_tools

- install git aware prompt:
  > mkdir ~/.bash
  > cd ~/.bash
  > git clone https://github.com/jimeh/git-aware-prompt.git
  
  Edit your ~/.bash_profile or ~/.profile or ~/.bashrc (for Ubuntu) and add the following to the top:
  > export GITAWAREPROMPT=~/.bash/git-aware-prompt
  > source "${GITAWAREPROMPT}/main.sh"

### Installed Python packages

See file *python_requirements_local.txt* file.
It is generated using command:
> pip3 freeze --path $HOME/.local/lib/python3.12/site-packages > python_requirements_local.txt

To install them on a new user account:
> pip3 install -r python_requirements_local.txt