#! /bin/bash




move=1

cp polarhcomp.675.del.cor  tmd-pep-grp94.crd

for i in closing opening ;

do

 for j in `seq 1 10` ;

do

charmm orient=$i frame=$j trajno=$trajno move=$move comp=tmd-grp94-del-$i-frame$j stepref=13333334 trjout=$j < grp94-closing.restrt.inp>& grp94-$i-$j.traj$trajno.move$move.out &

wait

cp tmd-pep-grp94-$i-$j.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-$i-$jtraj$trajno.move$move.res tmd-pep-grp94.rea
                                                                     

