#!/bin/bash
./2 1023061 100 > ../out_tmp.5/res.2.1.txt 2>&1 &
pid1=$!
./2 1019471 100 > ../out_tmp.5/res.2.2.txt 2>&1 &
pid2=$!
./2 1000872 100 > ../out_tmp.5/res.2.3.txt 2>&1 &
pid3=$!
./2 1019561 100 > ../out_tmp.5/res.2.4.txt 2>&1 &
pid4=$!
./2 1012560 100 > ../out_tmp.5/res.2.5.txt 2>&1 &
pid5=$!
bash 2.sh $pid1'|'$pid2'|'$pid3'|'$pid4'|'$pid5 8000000 60 5 > ../out.5/res.out.txt 2> ../out.5/res.err.txt &
pid_main=$!
sleep 120
touch stop_it.txt
sleep 6
rm -f ../out.5/res.main.txt
if [ $(ps -p $pid_main | wc -l | awk '{print $1}') -ne 1 ]; then echo Error: 2.sh still executing after stop_it.txt >> ../out.5/res.main.txt; fi
if [ $(ps -p $pid1 | wc -l | awk '{print $1}') -ne 1 ]
then
  echo Error: PID $pid1 still executing >> ../out.5/res.main.txt
else
  cat ../out_tmp.5/res.2.1.txt | awk -v pid=$pid1 -v limit_walltime=60 -v limit_bytes=8000000 '{if ($3 < limit_walltime && $7*1024 < limit_bytes) print "Error: PID", pid, "wrongly killed. Limit for RAM was", limit_bytes ", limit for time was", limit_walltime ", result is", $0;}' >> ../out.5/res.main.txt
fi
if [ $(ps -p $pid2 | wc -l | awk '{print $1}') -ne 1 ]
then
  echo Error: PID $pid2 still executing >> ../out.5/res.main.txt
else
  cat ../out_tmp.5/res.2.2.txt | awk -v pid=$pid2 -v limit_walltime=60 -v limit_bytes=8000000 '{if ($3 < limit_walltime && $7*1024 < limit_bytes) print "Error: PID", pid, "wrongly killed. Limit for RAM was", limit_bytes ", limit for time was", limit_walltime ", result is", $0;}' >> ../out.5/res.main.txt
fi
if [ $(ps -p $pid3 | wc -l | awk '{print $1}') -ne 1 ]
then
  echo Error: PID $pid3 still executing >> ../out.5/res.main.txt
else
  cat ../out_tmp.5/res.2.3.txt | awk -v pid=$pid3 -v limit_walltime=60 -v limit_bytes=8000000 '{if ($3 < limit_walltime && $7*1024 < limit_bytes) print "Error: PID", pid, "wrongly killed. Limit for RAM was", limit_bytes ", limit for time was", limit_walltime ", result is", $0;}' >> ../out.5/res.main.txt
fi
if [ $(ps -p $pid4 | wc -l | awk '{print $1}') -ne 1 ]
then
  echo Error: PID $pid4 still executing >> ../out.5/res.main.txt
else
  cat ../out_tmp.5/res.2.4.txt | awk -v pid=$pid4 -v limit_walltime=60 -v limit_bytes=8000000 '{if ($3 < limit_walltime && $7*1024 < limit_bytes) print "Error: PID", pid, "wrongly killed. Limit for RAM was", limit_bytes ", limit for time was", limit_walltime ", result is", $0;}' >> ../out.5/res.main.txt
fi
if [ $(ps -p $pid5 | wc -l | awk '{print $1}') -ne 1 ]
then
  echo Error: PID $pid5 still executing >> ../out.5/res.main.txt
else
  cat ../out_tmp.5/res.2.5.txt | awk -v pid=$pid5 -v limit_walltime=60 -v limit_bytes=8000000 '{if ($3 < limit_walltime && $7*1024 < limit_bytes) print "Error: PID", pid, "wrongly killed. Limit for RAM was", limit_bytes ", limit for time was", limit_walltime ", result is", $0;}' >> ../out.5/res.main.txt
fi
kill -9 $pid1
kill -9 $pid2
kill -9 $pid3
kill -9 $pid4
kill -9 $pid5
kill -9 $pid_main
rm stop_it.txt
