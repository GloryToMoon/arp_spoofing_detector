#<== var interface ==>
interface="wlan0"

gateway=$(ip r | sed -n 1p | awk '{print $3}')

enum_arp() {
file="$(mktemp)"
echo "[+] Sending arp requests"
arp-scan -I "$1" --localnet > "$file"
mac_pool=$(grep -w "$2" "$file" | awk '{print $2}' | sort | uniq)
suspects=$(
for i in $mac_pool
do
	grep "$i" "$file" | awk '{print $1}'
done | sort | uniq
)
for suspect in $suspects
do
	if [[ "$suspect" != "$2" ]]
	then
		python3 telegram_notify.py "$suspect" $(grep -w "$suspect" "$file" | sed -n 1p | awk '{print $2'})
	fi
done
rm "$file" &> /dev/null
}

enum_arp "$interface" "$gateway"
