#!/usr/bin/env bash

read -r -d '' CONFIG << EOM

  shortcut |  label                |   Window Class             |  execCommand
-------------------------------------------------------------------------
     f     |  Firefox              |  firefox                   |  firefox
     g     |  Chromium             |  Chromium                  |  chromium
     e     |  Caja file manager    |  Caja                      |  caja
     v     |  Visual Studio Code   |  Code                      |  code
     i     |  Intellij IDEA        |  jetbrains-idea            |  ~/apps/idea-IU-203.6682.168/bin/idea.sh
     u     |  Sublime Text         |  Subl                      |  subl
     t     |  Teams                |  Microsoft Teams - Preview |  teams
     p     |  Postman              |  Postman                   |  ~/apps/Postman/Postman
     r     |  Rocket Chat          |  Rocket.Chat               |  rocketchat-desktop
     m     |  Robo Mongo 3T        |  robo3t                    |  ~/apps/robo3t-1.2.1-linux-x86_64-3e50a65/bin/robo3t
     S     |  Spectacle            |  spectacle                 |  spectacle

EOM

read -r -d '' AWK_FOCUS_OR_CREATE << 'EOM'
 { print "i3-msg '[class=\""$3"\"]' focus | grep '\"success\":true' || "$4 }
EOM


CONFIG=$(echo "$CONFIG" | sed '/^\s*$/d' | tail -n +3 | sed -E 's/[[:blank:]]*(^|\|)[[:blank:]]*/\1/g')


OPTIONS=$(echo "$CONFIG" | awk -F '|' '{print "<b>"$1" |</b> "$2 }')
CUSTOMPARAMS=($(echo "$CONFIG" | awk -F '|' '{print "-kb-custom-" NR " " $1}' | tr '\n' ' '))

OPTION_CHOSEN=$(echo -e "$OPTIONS" | rofi -markup-rows -dmenu -width 50 -line-margin 0 -separator-style none -bw 0  -disable-history -hide-scrollbar "${CUSTOMPARAMS[@]}" -p "focus or launch")

SHORTCUT_CHOSEN=$(echo $?)
echo "SHORTCUT_CHOSEN = $SHORTCUT_CHOSEN" > /tmp/rofi-focus
echo "OPTION_CHOSEN = $OPTION_CHOSEN" >> /tmp/rofi-focus

if [ "$SHORTCUT_CHOSEN" -ge "10" ]; then
  echo "$CONFIG" | awk -F '|' "NR==$(expr $SHORTCUT_CHOSEN - 9)  $AWK_FOCUS_OR_CREATE" | tee -a /tmp/rofi-focus | sh
else
  OPTION_CHOSEN=$(echo $OPTION_CHOSEN | sed 's+<b>. |</b>[[:blank:]]++')
  echo "OPTION_CHOSEN = $OPTION_CHOSEN" >> /tmp/rofi-focus
  echo "$CONFIG" | awk -F '|' '$2=="'"$OPTION_CHOSEN"'"'" $AWK_FOCUS_OR_CREATE" | tee -a /tmp/rofi-focus | sh
fi

