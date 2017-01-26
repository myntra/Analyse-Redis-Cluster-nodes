# Analyse-Redis-Cluster-nodes

Tired of analysing redis cluster using `cluster nodes` command. Try using this simple shell script. 

## Getting Started

Copy attached script `fetchRedisClusterInfo.sh` to any machine and make it executable.

### Prerequisites

redis-cli should be present.

```
https://redis.io/topics/quickstart
```

## Running the script

$ ./fetchRedisClusterInfo.sh -p \<port number\> -h \<hostname\>

hostname is `localhost` by default

## Result

![](https://github.com/sidd081/Analyse-Redis-Cluster-nodes/blob/master/Screen%20Shot%202017-01-26%20at%2011.40.40.png)

Red Color denotes `master` and `slave` both are present on same machine, which should not happen ideally.
