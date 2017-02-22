#!/bin/sh


host='localhost'
echo $#
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

redis-cli -c -h $host -p $port cluster nodes | awk  -F: '{print $1 " " $2}' | awk  ' {if ($4 ~ /master/){freq[$2, "master"]++; machine[$2]++} else if($4 ~ /slave/){freq [$2,"slave"]++;machine[$2]++} else{freq [$2, $4]++;machine[$2]++} } END{printf("%-15s %8s %8s \n" ,"machine", "master", "slave"); for (var in machine) { if (freq[var, "master"] !=  freq[var, "slave"]) {printf("\033[1;31m%-15s %8.2f %8.2f \033[0m\n", var, freq[var, "master"], freq[var, "slave"])} else { printf("\033[1;32m%-15s %8.2f %8.2f \033[0m\n", var, freq[var, "master"], freq[var, "slave"])}}}'
echo -e "\n\nMASTER SLAVE INFO"
#redis-cli  -c -p 7001 cluster nodes | awk '{printf "%-25s  %-15s %s\n", $2, $3, $8}' | sort
#echo -e " \n\n\n"
redis-cli  -c -h $host -p $port cluster nodes | awk '{if ($4 != "-" ){$1 = $4} hash[$1]++; if($3 ~ /master/){freq[$1, "master"]=$2; hashSlot[$1] = $9} else if($3 ~ /slave/){freq[$1, "slave"]=$2 "," freq[$1, "slave"] } else{freq [$1, $3]=$2}} END{printf("%-40s %-20s %-20s %-20s\n" ,"hashCode", "master", "slave", "hashSlot"); for (var in hash) {split(freq[var, "master"], master, ":"); master_ip = master[1] ;  split(freq[var, "slave"], slave, ":") ;slave_ip = slave[1] ;  if (master_ip == slave_ip) { printf("\033[1;31m%-40s %-20s %-20s %-20s \033[0m\n", var, freq[var, "master"], freq[var, "slave"], hashSlot[var]) } else { printf("\033[1;32m%-40s %-20s %-20s %-20s \033[0m\n", var, freq[var, "master"], freq[var, "slave"], hashSlot[var])}}}'
