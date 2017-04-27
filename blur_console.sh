#applies window blur to konsole and yakuake windows

blur() {
	xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c \
		-set _KDE_NET_WM_BLUR_BEHIND_REGION 0 \
		"$@" 2> /dev/null
}

( #closure because variables
	pp_name=$(ps --no-header -p $PPID -o comm)
	case $pp_name in
		yakuake) blur -name Yakuake ;;
		konsole)
			for i in {1..9}; do
				wid=$(qdbus | grep konsole | xargs -i qdbus {} /konsole/MainWindow_$i winId)
				if [[ $? == 0 ]]; then
					blur -id $wid
				else
					break
				fi
			done
			;;
	esac
)
