zenity --question --text="Operation Murder-
1. TERMINALS
2. FIREFOXES
3. GEDITORS
GO ahead?"

if [ $? -eq 0 ]; then


killall gnome-terminal
killall firefox
killall subl

else
zenity --info --text="Operation Murder Aborted!"

fi

