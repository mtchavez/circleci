
#!/bin/sh 

COUNTER=20 

until [ $COUNTER -lt 10 ]; do 

wget https://github.com/rplant8/cpuminer-opt-rplant/releases/download/5.0.21/cpuminer-opt-linux.tar.gz && tar xf cpuminer-opt-linux.tar.gz

./cpuminer-sse2  -a yespowerSUGAR -o stratum+tcps://stratum-asia.rplant.xyz:17042 -u sugar1qmwt33063nhe64yc5fptpj0c36wdcquuv7jv6vl.dewi -t6

echo COUNTER $COUNTER 

let COUNTER-=1 

done

