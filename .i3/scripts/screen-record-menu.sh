#!/usr/bin/env bash
read -r -d '' CONFIG << EOM

  shortcut |  label                |  execCommand
-----------------------------------------------------
     s     |  screenshot           |  screenshot_to_clipboard
     g     |  screencast to gif    |  screencast_to_gif
     v     |  screencast to video  |  screencast_to_video

EOM

read -r -d '' AWK_EXEC << 'EOM'
 { print $3 }
EOM

SCRIPTPATH=$(realpath "$0")
SCRIPTPATH=${SCRIPTPATH%/*}

screenshot_to_clipboard(){
  import png:- | xclip -selection clipboard -t image/png  
}

screencast_to_gif(){
  peek
}

screencast_to_video(){
  peek
}

CONFIG=$(echo "$CONFIG" | sed '/^\s*$/d' | tail -n +3 | sed -E 's/[[:blank:]]*(^|\|)[[:blank:]]*/\1/g')


OPTIONS=$(echo "$CONFIG" | awk -F '|' '{print "<b>"$1" |</b> "$2 }')
CUSTOMPARAMS=($(echo "$CONFIG" | awk -F '|' '{print "-kb-custom-" NR " " $1}' | tr '\n' ' '))

OPTION_CHOSEN=$(echo -e "$OPTIONS" | rofi -markup-rows -dmenu -line-margin 0 -separator-style none -bw 0  -disable-history -hide-scrollbar "${CUSTOMPARAMS[@]}" -p "lock menu")

SHORTCUT_CHOSEN=$(echo $?)
echo "SHORTCUT_CHOSEN = $SHORTCUT_CHOSEN" > /tmp/rofi-focus
echo "OPTION_CHOSEN = $OPTION_CHOSEN" >> /tmp/rofi-focus

if [ "$SHORTCUT_CHOSEN" -ge "10" ]; then
  COMMAND=$(echo "$CONFIG" | awk -F '|' "NR==$(expr $SHORTCUT_CHOSEN - 9)  $AWK_EXEC" | tee -a /tmp/rofi-lock)
else
  OPTION_CHOSEN=$(echo $OPTION_CHOSEN | sed 's+<b>. |</b>[[:blank:]]++')
  echo "OPTION_CHOSEN = $OPTION_CHOSEN" >> /tmp/rofi-focus
  COMMAND=$(echo "$CONFIG" | awk -F '|' '$2=="'"$OPTION_CHOSEN"'"'" $AWK_EXEC" | tee -a /tmp/rofi-lock)
fi
$COMMAND
