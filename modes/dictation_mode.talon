mode: dictation
-
<phrase>:
    user.system_command('notify-send.sh -t 3000 -f -u low "Dictation Mode"')
    dictate.natural(phrase)
    insert(" ")
enter: key(enter)
period: key(backspace . space)
comma: key(backspace , space)
question [mark]: key(backspace ? space)
(bang | exclamation [mark]): key(backspace ! space)
