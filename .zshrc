function ssh(){                                       
  command ssh "$@";
  printf '\x1b]10;%s\a\x1b]11;%s\a\x1b]708;%2$s\a' $(grep -oP 'foreground:\s+\K\S+' ~/.Xresources | head -1) $(grep -oP 'background:\s+\K\S+' ~/.Xresources | head -1)
}

