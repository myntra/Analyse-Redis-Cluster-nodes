# Analyse-Redis-Cluster-nodes

Ever tried using `cluster nodes` command on your redis cluster? If not, please try runnning this command on your cluster. Basically, the output of the command is just a space-separated CSV string, where each line represents a node in the cluster. Through this one can analyse the current state of Redis Cluster e.g. which all nodes are currently active, which node is slave of which master node, which node is master etc.

Sometimes while setting up cluster, it might happen that slave of any master node resides on same machine as of master, which doesn't make any sense. Such anomalies can be analysed using `cluster nodes` command.

In case of small cluster(lets say cluster of size <20 nodes), its easy to analyse through `cluster nodes` command that whether cluster is setup properly or not. 
![](https://github.com/myntra/Analyse-Redis-Cluster-nodes/blob/master/six_node_cluster.png)

But in case of large cluster, it becomes cumbersome to read through its output and to check cluster status as you can see below
![](https://github.com/myntra/Analyse-Redis-Cluster-nodes/blob/master/large_cluster.png)

In such cases, this scripts comes handy

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

>Red Color denotes `master` and `slave` both are present on same machine, which should not happen ideally.

>Green Color denotes OK
