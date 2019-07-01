#! /bin/bash

# clear screen and spacing
clear
echo ''

# Functions:
# ----------

# ask()
# -----
ask() {
    local prompt default reply

    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -e -n "\e[38;5;15m$1 [$prompt] \e[0m"

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}


# checksshconfig()
# ----------------
checksshconfig() {
  echo ''
  echo -e '\e[38;5;15m==============| \e[38;5;39mSSH (\e[38;5;15mcontinued\e[38;5;39m) \e[38;5;15m|===============\e[0m'
  echo -e '\e[38;5;68m------------------------------------------------\e[0m'
  echo -e '\e[38;5;68m|                                              |\e[0m'
  echo -e '\e[38;5;68m|   | \e[38;5;15mPlease verify \e[38;5;162m/etc/ssh/sshd_config \e[38;5;15mto \e[38;5;68m|  |\e[0m'
  echo -e '\e[38;5;68m|   | \e[38;5;15msee if your choice was properly made. \e[38;5;68m|  |\e[0m'
  echo -e '\e[38;5;68m|                                              |\e[0m'
  echo -e '\e[38;5;68m|       ( \e[38;5;214mNOTE:\e[38;5;15m Press \e[38;5;46mQ \e[38;5;15mwhen finished \e[38;5;68m)        |\e[0m'
  echo -e '\e[38;5;68m------------------------------------------------\e[0m'
  echo ''
  read -r -s -p $'[ Press ENTER to continue ]'
  echo ''
  cat /etc/ssh/sshd_config | less
  clear
}

# BEGIN SCRIPT:
#--------------

# Introduction
echo -e "\e[38;5;15m==| \e[38;5;39mWelcome to Jacques' Linux Install Script! \e[38;5;15m|==\e[0m"
echo -e '\e[38;5;68m-------------------------------------------------\e[0m'
echo -e '\e[38;5;68m|                                       \e[38;5;15mv 0.3.2 \e[38;5;68m|\e[0m'
echo -e '\e[38;5;68m-------------------------------------------------\e[0m'
echo ''
read -r -s -p '[ Press ENTER to continue ]'
clear

# System Update
echo ''
echo -e '\e[38;5;15m==============| \e[38;5;39mSYSTEM UPDATE \e[38;5;15m|==============\e[0m'
echo -e '\e[38;5;68m---------------------------------------------\e[0m'
echo ''
if ask "Do you want to update the system?: " Y; then
  echo -e '\e[38;5;15m-----------------------------------------\e[0m'
  echo ''
  yum -y update && yum clean all
  echo ''
  read -r -s -p '[ Press ENTER to continue ]'
  clear
else
  echo ''
  echo -e '\e[38;5;68m ---------------------------------------\e[0m'
  echo -e '\e[38;5;68m| \e[38;5;15mSystem Updates: \e[38;5;68m|| \e[38;5;160mSYSTEM NOT UPDATED \e[38;5;68m|\e[0m'
  echo -e '\e[38;5;68m ---------------------------------------\e[0m'
  echo ''


  read -r -s -p '[ Press ENTER to continue ]'
  clear
fi

# Useful Packages Installation
echo ''
echo -e '\e[38;5;15m==============| \e[38;5;39mUSEFUL PACKAGES \e[38;5;15m|==============\e[0m'
echo -e '\e[38;5;68m-----------------------------------------------\e[0m'
echo ''
if ask "Do you want to install Useful Packages on the system?: "; then
  echo -e '\e[38;5;68m-------------------------------------------------------------\e[0m'
  echo ''
  clear
  echo -e '\e[38;5;162m<< \e[38;5;15mThe following packages will be installed \e[38;5;162m>>\e[0m'
  echo -e '   \e[38;5;68m----------------------------------------\e[0m'
  echo -e '   \e[38;5;121mepel-release\e[38;5;15m, \e[38;5;121mnano\e[38;5;15m, \e[38;5;121mwget\e[38;5;15m, \e[38;5;121mcurl\e[38;5;15m, \e[38;5;121mnet-tools\e[38;5;15m,\e[0m'
  echo -e '   \e[38;5;121mlsof\e[38;5;15m, \e[38;5;121mbash-completion\e[38;5;15m, \e[38;5;121mpsmisc\e[38;5;15m, \e[38;5;121munzip\e[38;5;15m, \e[38;5;121mhtop\e[38;5;15m,\e[0m'
  echo -e '   \e[38;5;121mtmux\e[38;5;15m, \e[38;5;121mgit\e[0m'
  echo ''
  read -r -s -p '[ Press ENTER to continue ]'
  clear
  yum -y install epel-release
  yum -y update
  yum -y install nano wget curl net-tools lsof bash-completion psmisc unzip htop tmux git
  echo ''
  echo -e '\e[38;5;68m -------------------------------\e[0m'
  echo -e '\e[38;5;68m| \e[38;5;15mUseful Packages: \e[38;5;68m|| \e[38;5;46mINSTALLED \e[38;5;68m|\e[0m'
  echo -e '\e[38;5;68m -------------------------------\e[0m'
  echo ''
  read -r -s -p '[ Press ENTER to continue ]'
  clear
else
  echo ''
  echo -e '\e[38;5;68m -----------------------------------\e[0m'
  echo -e '\e[38;5;68m| \e[38;5;15mUseful Packages: \e[38;5;68m|| \e[38;5;160mNOT INSTALLED \e[38;5;68m|\e[0m'
  echo -e '\e[38;5;68m -----------------------------------\e[0m'
  echo ''
  read -r -s -p '[ Press ENTER to continue ]'
  clear
fi

# SELINUX
echo ''
echo -e '\e[38;5;15m==============| \e[38;5;39mSELINUX \e[38;5;15m|==============\e[0m'
echo -e '\e[38;5;68m---------------------------------------\e[0m'
echo ''
PS3=$'\n'"How would you like SELINUX to function?: "
options=("Enabled" "Disabled" "Permissive Mode")
select opt in "${options[@]}"
do
    case $opt in
        "Enabled")
            sed -i -e 's/SELINUX=disabled/SELINUX=enforcing/g' /etc/selinux/config
            sed -i -e 's/SELINUX=permissive/SELINUX=enforcing/g' /etc/selinux/config
            echo ''
            echo -e ' \e[38;5;68m------------------------------\e[0m'
            echo -e '\e[38;5;68m| \e[38;5;15mSELINUX: \e[38;5;68m|| \e[38;5;15mSet to \e[38;5;46mENFORCING \e[38;5;68m|\e[0m'
            echo -e ' \e[38;5;68m------------------------------\e[0m'
            echo ''
            read -r -s -p '[ Press ENTER to continue ]'
            break
            ;;
        "Disabled")
            sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
            sed -i -e 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
            echo ''
            echo -e ' \e[38;5;68m-----------------------------\e[0m'
            echo -e '\e[38;5;68m| \e[38;5;15mSELINUX: \e[38;5;68m|| \e[38;5;15mSet to \e[38;5;160mDISABLED \e[38;5;68m|\e[0m'
            echo -e ' \e[38;5;68m-----------------------------\e[0m'
            echo ''
            read -r -s -p '[ Press ENTER to continue ]'
            break
            ;;
        "Permissive Mode")
            sed -i -e 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
            sed -i -e 's/SELINUX=disabled/SELINUX=permissive/g' /etc/selinux/config
            echo ''
            echo -e ' \e[38;5;68m-------------------------------\e[0m'
            echo -e '\e[38;5;68m| \e[38;5;15mSELINUX: \e[38;5;68m|| \e[38;5;15mSet to \e[38;5;208mPERMISSIVE \e[38;5;68m|\e[0m'
            echo -e ' \e[38;5;68m-------------------------------\e[0m'
            echo ''
            read -r -s -p '[ Press ENTER to continue ]'
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done



echo ''
clear
echo -e '\e[38;5;15m==============| \e[38;5;39mSELINUX (\e[38;5;15mcontinued\e[38;5;39m) \e[38;5;15m|===============\e[0m'
echo -e '\e[38;5;68m----------------------------------------------------\e[0m'
echo -e '\e[38;5;68m|                                                  |\e[0m'
echo -e '\e[38;5;68m|     | \e[38;5;15mPlease verify \e[38;5;162m/etc/selinux/config \e[38;5;15mto \e[38;5;68m|     |\e[0m'
echo -e '\e[38;5;68m|     | \e[38;5;15msee if your choice was properly made \e[38;5;68m|     |\e[0m'
echo -e '\e[38;5;68m|                                                  |\e[0m'
echo -e '\e[38;5;68m|         ( \e[38;5;214mNOTE\e[38;5;15m: Press \e[38;5;46mQ\e[38;5;15m when finished \e[38;5;68m)          |\e[0m'
echo -e '\e[38;5;68m----------------------------------------------------\e[0m'
echo ''
read -r -s -p $'[ Press ENTER to continue ]'
echo ''
cat /etc/selinux/config | less
clear

# firewalld
echo ''
echo -e '\e[38;5;15m==============| \e[38;5;39mFirewall \e[38;5;15m|==============\e[0m'
echo -e '\e[38;5;68m----------------------------------------\e[0m'
echo ''
PS3=$'\n'"Would you like to Enable or Disable the Firewall?: "
options=("Enable" "Disable")
select opt in "${options[@]}"
do
    case $opt in
        "Enable")
            echo ''
            systemctl enable firewalld
            echo ''
            echo -e ' \e[38;5;68m-----------------------------\e[0m'
            echo -e '\e[38;5;68m| \e[38;5;15mFirewall: \e[38;5;68m|| \e[38;5;15mSet to \e[38;5;46mENABLED \e[38;5;68m|\e[0m'
            echo -e ' \e[38;5;68m-----------------------------\e[0m'
            echo ''
            read -r -s -p '[ Press ENTER to continue ]'
            clear
            break
            ;;
        "Disable")
            echo ''
            systemctl disable firewalld
            echo ''
            echo -e ' \e[38;5;68m-----------------------------\e[0m'
            echo -e '\e[38;5;68m| \e[38;5;15mSELINUX: \e[38;5;68m|| \e[38;5;15mSet to \e[38;5;160mDISABLED \e[38;5;68m|\e[0m'
            echo -e ' \e[38;5;68m-----------------------------\e[0m'
            echo ''
            read -r -s -p '[ Press ENTER to continue ]'
            clear
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# SSH
echo ''
echo -e '\e[38;5;15m==============| \e[38;5;39mSSH \e[38;5;15m|==============\e[0m'
echo -e '\e[38;5;68m-----------------------------------\e[0m'
echo ''
PS3=$'\n'"Would you like to configure SSH? "
options=("Install, Enable and Configure" "Disable")
select opt in "${options[@]}"
do
    case $opt in
        "Install, Enable and Configure")
            echo ''
            yum -y install openssh && yum -y install openssh-server
            systemctl enable sshd
            echo ''
            echo -e ' \e[38;5;68m--------------------------------------\e[0m'
            echo -e '\e[38;5;68m| \e[38;5;15mSSH: \e[38;5;68m|| \e[38;5;15mINSTALLED and set to \e[38;5;46mENABLED \e[38;5;68m|\e[0m'
            echo -e ' \e[38;5;68m--------------------------------------\e[0m'
            echo ''
            read -r -s -p '[ Press ENTER to continue ]'
            clear

            echo -e '\e[38;5;15m==============| \e[38;5;39mSSH (\e[38;5;15mcontinued\e[38;5;39m) \e[38;5;15m|==============\e[0m'
            echo -e '\e[38;5;68m-----------------------------------------------\e[0m'
            echo ''
            PS3=$'\n'"Would you like to use Port 22 or another Port? "
            extraoptions=("Use Port 22" "Use Alternate Port")
            select xopt in "${extraoptions[@]}"
            do
                case $xopt in
                    "Use Port 22")
                        echo ''
                        sed -i 's/^Port .*/Port 22/g' /etc/ssh/sshd_config
                        checksshconfig
                        break
                        ;;
                    "Use Alternate Port")
                        echo ''

                        while :; do
                          read -p "Enter port number between 1024 and 65535: " portnum
                          [[ $portnum =~ ^[0-9]+$ ]] || { echo -e '\e[38;5;68m[ \e[38;5;160mInvalid Port: \e[38;5;15mPlease enter a port number between \e[38;5;87m1024 \e[38;5;15mand \e[38;5;87m65535 \e[38;5;68m]\e[0m\n'; continue; }
                          if ((portnum >= 1024 && portnum <= 65535)); then
                            sed -i -r 's/^#?Port .*/'"Port $portnum"'/g' /etc/ssh/sshd_config
                            checksshconfig
                            break
                          else
                            echo -e '\e[38;5;68m[ \e[38;5;160mInvalid Port: \e[38;5;15mPlease enter a port number between \e[38;5;87m1024 \e[38;5;15mand \e[38;5;87m65535 \e[38;5;68m]\e[0m\n'
                          fi
                        done

                        break
                        ;;
                    *) echo "invalid option $REPLY";;
                esac
            done

          break
          ;;
        "Disable")
            echo ''
            systemctl disable sshd
            echo ''
            echo -e ' \e[38;5;68m-------------------------\e[0m'
            echo -e '\e[38;5;68m| \e[38;5;15mSSH: \e[38;5;68m|| \e[38;5;15mSet to \e[38;5;160mDISABLED \e[38;5;68m|\e[0m'
            echo -e ' \e[38;5;68m-------------------------\e[0m'
            echo ''
            read -r -s -p '[ Press ENTER to continue ]'
            clear
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

# Upcoming Section:
#------------------
# SNMP


# END SCRIPT:
#------------
clear
echo -e "\e[38;5;15m==============| \e[38;5;39mScript Execution Complete! \e[38;5;15m|==============\e[0m"
echo -e '\e[38;5;68m----------------------------------------------------------\e[0m'
echo -e "\e[38;5;68m|   \e[38;5;15mThank you for using Jacques' Linux Install Script!   \e[38;5;68m|\e[0m"
echo -e '\e[38;5;68m----------------------------------------------------------\e[0m'
echo ''
read -r -s -p '[ Press ENTER to continue ]'
clear
