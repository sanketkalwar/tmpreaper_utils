#!/usr/bin/bash

# Load config params or periodic cleanup of scratch dir
. scratch_reaper.conf

TMPREAPER_HEAD="tmpreaper --all $DURATION"
while IFS=$'\n' read -a config
do
  TMPREAPER_PROTECT+=' --protect '$config' '
done < mask_directory.conf

echo '@@@@@@@@@@@@@@@@@@@@@@Config@@@@@@@@@@@@@@@@@@@@@@@@'
echo 'DURATION: '$DURATION
echo 'TARGET PATH: '$TARGET_PATH
echo 'PROTECT PATH: '$TMPREAPER_PROTECT
echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'

SEC_NANO_SEC=$(($(date +%s%N)/1000000))


# Uncomment this for simulating the deletion of the files and folders
#TMPREAPER_TEST_TAIL="-t $TARGET_PATH >> 'logs/'$SEC_NANO_SEC'.log'"
#cmd=$TMPREAPER_HEAD$TMPREAPER_PROTECT$TMPREAPER_TEST_TAIL
#eval $cmd

# Uncomment this for simulating the deletion of the files and folders
TMPREAPER_TAIL=" $TARGET_PATH >> 'logs/'$SEC_NANO_SEC'.log'"
cmd=$TMPREAPER_HEAD$TMPREAPER_PROTECT$TMPREAPER_TAIL
eval $cmd
