function precmd {
  # Put the string "hostname::/full/directory/path" in the title bar:
  echo -ne "\e]2;$PWD\a"

  # Put the parentdir/currentdir in the tab
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

function set_running_app {
  printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- | tr '%' '%%' ) \a" 2> /dev/null
}

function preexec {
  set_running_app
}

function postexec {
  set_running_app
}
