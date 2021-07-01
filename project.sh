#blacklist of banned IPs
Blacklist="
#insert IP address list here
"
ERROR(){
echo $0 ERROR:$1 >$2
exit 2
}

[ $# -ne 1 ] && ERROR 'Single IP address not specified'

reverse=$(echo $1 |
sed -ne "s~^\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.([0-9]\{1,3\}\)$~\4.\3.\2.\1~p")

if [ "x${reverse}" = "x" ] ; then
ERROR "'$1' is not a valid IP adress"
exit 1
fi

REVERSE_DNS=$(dig +short -x $1)

echo IP $1 NAME ${REVERSE_DNS:----}

for BL in ${Blacklist} ; do
printf "%-60s" " ${reverse}.${BL}."
LISTED="$(dig +short -t a ${reverse}.${BL}.)"
echo ${LISTED:----}
$ echo "'$1' has tried to connect to your site." | mail -s "unauthorized connection warning" name@email.com
done