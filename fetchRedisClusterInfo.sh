#!/bin/sh

host='localhost'
while [[ $# -gt 1 ]]
do
  key="$1"
  
  case $key in
    -p|--port)
      port="$2"
      shift # past argument
    ;;
    -h|--host)
      host="$2"
      shift # past argument
    ;;
    *)
      # unknown option
    ;;
  esac
  shift # past argument or value
done

echo "HOST: " $host  " PORT: " $port

redis-cli -c -h $host -p $port cluster nodes | awk  -F: '{print $1 " " $2}' | awk  ' {if ($4 ~ /master/){freq[$2, "master"]++; machine[$2]++} else if($4 ~ /slave/){freq [$2,"slave"]++;machine[$2]++} else{freq [$2, $4]++;machine[$2]++} } END{printf("%-15s %8s %8s \n" ,"machine", "master", "slave"); for (var in machine) {printf("%-15s %8.2f %8.2f \n", var, freq[var, "master"], freq[var, "slave"])}}'
echo -e "\n\nMASTER SLAVE INFO"
#redis-cli  -c -p 7001 cluster nodes | awk '{printf "%-25s  %-15s %s\n", $2, $3, $8}' | sort
#echo -e " \n\n\n"
redis-cli  -c -h $host -p $port cluster nodes | awk '{if ($4 != "-" ){$1 = $4} hash[$1]++; if($3 ~ /master/){freq[$1, "master"]=$2; hashSlot[$1] = $9} else if($3 ~ /slave/){freq[$1, "slave"]=$2 "," freq[$1, "slave"] } else{freq [$1, $3]=$2}} END{printf("%-40s %-20s %-20s %-20s\n" ,"hashCode", "master", "slave", "hashSlot"); for (var in hash) {IFS=":" read -ra master <<< freq[var, "master"] ;master_ip = master[0]}}'   