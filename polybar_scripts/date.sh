t=0
sleep_pid=0
reset_at=0
LENGTH=5

toggle() {
    delta=$1
    t=$(((t + LENGTH + delta) % LENGTH))
    settimezone

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
    reset_at=$(($(date +%s) + 5))
}

trap "toggle 1" USR1
trap "toggle -1" USR2

export TZ="America/Buenos_Aires"
export TZALIAS="BUE"
settimezone() {
    case $t in
        0)
            export TZ="America/Buenos_Aires"
            export TZALIAS="BUE"
            ;;
        1)
            export TZ="Europe/London"
            export TZALIAS="LON"
            ;;
        2)
            export TZ="Europe/Madrid"
            export TZALIAS="MAD"
            ;;
        3)
            export TZ="America/Los_Angeles"
            export TZALIAS="PDT"
            ;;
        4)
            export TZ="America/New_York"
            export TZALIAS="BOS"
            ;;
    esac

}

while true; do
    echo -n "$TZALIAS "
    TZ=$TZ date +%T
    sleep 1 &
    sleep_pid=$!
    wait
    if [ "$reset_at" -ne 0 ] && [ "$reset_at" -lt "$(date +%s)" ]; then
        # timeout
        t=0
        settimezone
        reset_at=0
    fi
done
