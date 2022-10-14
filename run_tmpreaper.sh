#!/usr/bin/bash

# Load config params or periodic cleanup of scratch dir
. rrc_scratch_reaper.conf

TMPREAPER_HEAD="tmpreaper $DURATION"
while IFS=$'\n' read -a config
do
  TMPREAPER_PROTECT+=' --protect '$config' '
done < mask_directory.conf

# Load all the directories from config to mask
. mask_directory.conf

echo '@@@@@@@@@@@@@@@@@@@@@@Config@@@@@@@@@@@@@@@@@@@@@@@@'
echo 'DURATION: '$DURATION
echo 'TARGET PATH: '$TARGET_PATH
echo 'PROTECT PATH: '$TMPREAPER_PATH
echo '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'

SEC_NANO_SEC=$(($(date +%s%N)/1000000))

#access values
echo "$PROTECT_STRING"

TMPREAPER_TAIL="-t $TARGET_PATH >> 'logs/'$SEC_NANO_SEC'.log'"

cmd=$TMPREAPER_HEAD$TMPREAPER_PROTECT$TMPREAPER_TAIL
eval $cmd
