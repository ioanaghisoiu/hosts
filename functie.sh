                                                                      
#!/bin/bash


verifică_ip() {
    local host=$1
    local ip=$2
    local dns=$3
    real_ip=$(nslookup "$host" "$dns" 2>/dev/null | awk '/Address: / {print $2; exit}')
  if [ "$real_ip" != "$ip" ]; then
        echo "Bogus IP for $host in /etc/hosts!"
    fi
}

cat /etc/hosts | while read ip host extra; do

        if [[ -z "$ip" || "$ip" == \#* || $host == *" localhost"* ]]; then
                continue
        fi
        if [[ -n "$host" ]]; then

        verifică_ip "$host" "$ip" "8.8.8.8"
    fi
        
done

