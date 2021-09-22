get-wav() {
	PHRASE="$@"
	STRIPPED="$(echo "$PHRASE" | sed "s/[^[:alpha:].-]/_/g")"
	FILENAME="${STRIPPED}.wav"

	echo Saving \"$PHRASE\" to $FILENAME

	curl -L --retry 30 --get --fail \
		--data-urlencode "text=$PHRASE" \
		-o "$FILENAME" \
		"https://glados.c-net.org/generate"
}

rebuild-config() {
	for i in *.wav
	do
		echo "[gcode_shell_command glados_$(basename -s .wav "$i")]"
		echo "command: aplay /home/pi/GLaDOS/$i"
		echo "verbose: False"
		echo ""
	done | tee /home/pi/printer/config.d/audio.cfg
}

if [[ "$#" -gt 0 ]]; then 
	get-wav "${@}"
fi
rebuild-config
