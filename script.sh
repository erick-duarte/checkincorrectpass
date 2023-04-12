PAYLOAD='enter. INCORRECT password'
PUSHOVER_TOKEN='TOKEN'
PUSHOVER_USER='USER'
PUSHOVER_TITULO='Tentativa de desbloqueio MacBook!'

while true
do
    incorrectPass=`log show --style syslog --predicate 'process == "loginwindow"' --debug --info --last 1m | grep "$PAYLOAD" | wc -l`
    if [ $incorrectPass -gt 0 ]
    then
        namePhoto="image_$(date +"%d%m%Y-%H%M")"
        /usr/local/bin/imagesnap -w 1 $namePhoto.png
        date=`date +"%d/%m/%Y %H:%M"`
        curl -s \
            --form-string "token=$PUSHOVER_TOKEN" \
            --form-string "user=$PUSHOVER_USER" \
            --form-string "title=$PUSHOVER_TITULO" \
            --form-string "message=Horario: $date" \
            -F "attachment=@$namePhoto.png" \
            https://api.pushover.net/1/messages.json
        sleep 50
    fi
    sleep 5
done
