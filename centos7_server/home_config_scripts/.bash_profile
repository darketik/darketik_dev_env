# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/.local/bin:$HOME/bin:$PATH

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/opt/bin" ] ; then
    PATH="$HOME/opt/bin:$PATH"
    PATH="$HOME/opt/bin/gcc-arm-none-eabi/bin:$PATH"
    PATH="$HOME/opt/bin/eclipse:$PATH"
    PATH="$HOME/opt/arduino-1.8.2:$PATH"
    PATH="$HOME/opt/scilab-6.0.0/bin:$PATH"
 #   PATH="$HOME/opt/bin/thunderbird:$PATH"
 #   PATH="$HOME/opt/bin/arduino-0100-Z:$PATH" # zpuino official ide
 #   PATH="$HOME/opt/bin/papilio-zap-ide:$PATH" # zpuino for papilio ide
 #   PATH="$HOME/opt/bin/zpu-toolchain-linux-1.0/bin:$PATH"
fi


if [ -d "/opt/Xilinx/DocNav" ] ; then
    PATH="/opt/Xilinx/DocNav:$PATH"
fi


export PATH
