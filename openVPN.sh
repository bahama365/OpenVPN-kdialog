#!/bin/bash
#
#
temp1=$(mktemp -t temp1.XXXXX)
temp2=$(mktemp -t temp2.XXXXXX)
temp3=$(mktemp -t temp3.XXXXXX)
temp4=$(mktemp -t temp4.XXXXXX)
date=$(date +%Y-%m-%d)
#
# Functions
#
menu () {
#
while [ 1 ]
do
dialog --nocancel --menu "OpenVPN Admin Console" 20 50 10 1 "Create a new user" 2 "Change a password" 3 "List all accounts" 0 "Exit" 2>$temp1
  if [ $? -eq 1 ]
  then
    break
  fi
#
selection=$(cat $temp1)
#
case $selection in
1)
  makeUser ;;
2)
  changePassword ;;
3)
  listAllAccounts ;;
0)
  exit ;;
*)
  dialog --title "OpenVPN Admin Console" --msgbox "Sorry, invalid selection" 20 40
esac
done
#
rm -f $temp1 2> /dev/null
rm -f $temp2 2> /dev/null
rm -f $temp3 2> /dev/null
rm -f $temp4 2> /dev/null
#
}
#
makeUser () {
#
pass=$(cat /dev/urandom | base64 | head -c 8)
#
dialog --title "OpenVPN Admin Console" --nocancel --inputbox "Enter the ID for the new account" 20 30 2>$temp3
local id=$(cat $temp3)
dialog --title "OpenVPN Admin Console" --nocancel --inputbox  "Enter the department for ID: $id " 20 30 2>$temp4
local dept=$(cat $temp4)
dialog --title "OpenVPN Admin Console" --infobox "Creating a new account for ID: $id in department: $dept..." 20 30; sleep 1
dialog --title "OpenVPN Admin Console" --infobox "...Done!" 20 30; sleep 1
dialog --title "OpenVPN Admin Console" --msgbox "OpenVPN account created, please copy details from below:

********************************

 Username:  $id

 Department:  $dept

 Password:  $pass

******************************** " 25 40
#
unset $id
unset $pass
unset $dept
rm -f $temp1 2> /dev/null
rm -f $temp2 2> /dev/null
rm -f $temp3 2> /dev/null
rm -f $temp4 2> /dev/null
#
menu
}
#
changePassword () {
#
dialog --title "OpenVPN Admin Console" --nocancel --inputbox  "Enter the ID of the account you wish to change... " 20 30 2>$temp1
local id=$(cat $temp1)
dialog --title "OpenVPN Admin Console" --infobox "Creating a new password for ID: $id" 20 30; sleep 1
pass=$(cat /dev/urandom | base64 | head -c 8)
dialog --title "OpenVPN Admin Console" --infobox "...Done!" 20 30; sleep 1
dialog --title "OpenVPN Admin Console" --msgbox "New password assigned, please copy details from below:

********************************

 Username:   $id

 Password:   $pass

******************************** " 25 40
#
unset $id
unset $pass
rm -f $temp1 2> /dev/null
rm -f $temp2 2> /dev/null
rm -f $temp3 2> /dev/null
rm -f $temp4 2> /dev/null
#
menu
}
#
listAllAccounts () {
#
dialog --title "OpenVPN Admin Console" --infobox "Listing all OpenVPN accounts..." 20 30; sleep 1
dialog --title "OpenVPN Admin Console" --msgbox "
9869266,dcs
7288372,dcs
8272889,cso
8363728,cio " 25 40
#
rm -f $temp1 2> /dev/null
rm -f $temp2 2> /dev/null
rm -f $temp3 2> /dev/null
rm -f $temp4 2> /dev/null
#
menu
}
#
# End of Functions...now to run the application
dialog --title "OpenVPN Admin Console" --infobox "Welcome to the OpenVPN Admin Console" 10 40; sleep 1
#
menu
