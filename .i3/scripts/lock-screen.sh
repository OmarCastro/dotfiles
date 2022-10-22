#!/bin/sh
# locks the screen, requires i3lock-color instead of the default one

GREETER_TEXT="🔒"

print_usage(){
  OPTIONS="Options:
    -h, --help              This help menu.
    -s, --sleep-icon        Use sleep icon.
    -o, --turn-off-screen   turn off screen."

  printf "Usage: $(basename $0) [options]\n\n$OPTIONS\n\n"
}
while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help) print_usage; exit 1 ;;
        -s|--sleep-icon) GREETER_TEXT="💤"; shift ;;
        -o|--turn-off-screen) (sleep 3 ;xset dpms force off) & shift ;;
        --) shift ; break ;;
        *) echo "error unkown parameter $1" ; print_usage;  exit 1 ;;
    esac
done

i3lock -n\
       --time-font "Roboto" --time-color=ffffff9c --time-str="%H | %M"\
       --date-font "Roboto" --date-color=ffffff9c \
       --lock-text="locking…" \
       --greeter-font "EmojiOne, Roboto Mono" --greeter-text="$GREETER_TEXT" --greeter-pos="ix:iy-50" \
       --inside-color=3333339c --ring-color=ffffff3e -k --indicator -B=2  \
       --line-color=dddddd9c --keyhl-color=00000080 --ringver-color=00ff0033 \
       --separator-color=22222260 --insidever-color=3344339c --verif-color=ffffff9c \
       --ringwrong-color=dd333395 --insidewrong-color=4433339c --wrong-color=ffffff9c > /dev/null 2>&1
