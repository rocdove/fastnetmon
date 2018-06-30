#!/usr/bin/env bash

#
# Hello, lovely FastNetMon customer! I'm really happy to see you here!
#  Pavel Odintsov, author 
#

# This script will get following params:
#  $1 action (ban or unban)
#  $2 client_ip_as_string
#  $3 data_direction
#  $4 protocol_as_string
#  $5 in_pps_as_string
#  $6 out_pps_as_string
#  $7 in_mbps_as_string
#  $8 out_mbps_as_string

email_notify="root,please_fix_this_email@domain.ru"

#
# Please be carefult! You should not remove cat > 
#

if [ "$1" = "unban" ]; then
    # No details arrived to stdin here

    # Unban actions if used
    exit 0
fi

#
# For ban and attack_details actions we will receive attack details to stdin
# if option notify_script_pass_details enabled in FastNetMon's configuration file
# 
# If you do not need this details, please set option notify_script_pass_details to "no".
#
# Please do not remove "cat" command if you have notify_script_pass_details enabled, because
# FastNetMon will crash in this case (it expect read of data from script side).
#

if [ "$1" = "ban" ]; then
    cat | mail -s "FastNetMon Guard: IP $2 blocked because $3 attack with in $5 pps, out $6 pps, in $7 mbps, out $8 mbps Using $4" $email_notify;
    # You can add ban code here!
    exit 0
fi

if [ "$1" == "attack_details" ]; then
    cat | mail -s "FastNetMon Guard: IP $2 blocked because $3 attack with in $5 pps, out $6 pps, in $7 mbps, out $8 mbps Using $4" $email_notify;
    
    exit 0
fi
