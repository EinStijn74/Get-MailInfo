# Get-MailInfo
Exchange powershell cmdlet for Mail Properties (Mailbox, CASMailbox, MailboxStatistics)

The last couple of years I have been working with Exchange (Powershell) in a corporate environment. Exchange is moving to
run everything on one box, but the different commendlets are still used for different services. I Combined get-casmailbox,
get-casmailbox and get-mailboxstatistics into one commendlet and added the pipeline input property samaccountname so you can
pipe Active Directiry commendlets. (get-aduser, get-adobject)

you can add code for more properties from one of the three commendlets (or request) if you like. 

EXAMPLES

get-mailinfo first.lastnam@mail.com
get-mailinfo "first lastname"
get-mailinfo samaccountname

get-aduser filter * -searchbase "OU=OFFICE01.....) | get-mailinfo | fl *quota*, *size*
get-mailboxdatabase dag01* | get-mailinfo
get-mailboxdatabaseserver exchange01 | get-mailinfo


QUESTIONS / FEEDBACK

Please let me know...
