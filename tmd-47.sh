#!/bin/csh -f
## Jobname shows in the queue
## change nprocs here and where you request a node
## chmexe is charmm on the cluster and charmm-mpi on your desktop
## move in the incrementer
## iseed is your random number - should be different for each trajno
## i_max is how many times to open/close

set NPROCS = 24
set chmexe = charmm
set trajno = 47
#set move = 0
set ISEED = 312
set PATH = /home/reitendw/2-hsp90/multi-test
set i_max = 50
# CHANGE TO SUBMISSION SUBDIR
##cd $PATH
mkdir open_closed_dynamics$trajno
cd open_closed_dynamics$trajno

## make sure to copy all of your input files
## param_eef1, top_eef1, solvpar
## psf and cor from capture

#this .cor file needs to be changed for each trajectory
cp $PATH/start-hsp90-close.inp .
cp $PATH/hsp90-close-25to50.inp .
cp $PATH/hsp90-close-50to75.inp .
cp $PATH/hsp90-close-75to100.inp .

cp $PATH/hsp90-open-1to25.inp .
cp $PATH/hsp90-open-25to50.inp .
cp $PATH/hsp90-open-50to75.inp .
cp $PATH/hsp90-open-75to100.inp .
cp $PATH/restart-hsp90-close.inp .

cp $PATH/tmd-pep-hsp90-otc-frame25.cor .
cp $PATH/tmd-pep-hsp90-otc-frame50.cor .
cp $PATH/tmd-pep-hsp90-otc-frame75.cor .
cp $PATH/tmd-pep-hsp90-open-otc-frame25.cor .
cp $PATH/tmd-pep-hsp90-open-otc-frame50.cor .
cp $PATH/tmd-pep-hsp90-open-otc-frame75.cor .

cp $PATH/hsp90-dimer-close-eef1-norest.cor .
cp $PATH/hsp90-dimer-open-nb-eef1.psf .
cp $PATH/hsp90-pep-apo-capture_47.cor .
cp $PATH/param19_eef1.inp .
cp $PATH/toph19_eef1.inp .
cp $PATH/solvpar.inp .
cp $PATH/start-hsp90-close.inp .

##module load charmm-c43b1-intel-mpi

if ( -e next.seqno ) then
@ i = `cat next.seqno`
else
@ i = 1
endif
# check the parameters passed
#echo " has passed i initialization" >> debug
#echo " jobname is" $JOBNAME >> debug
#echo " nprocs is " $NPROCS >> debug
#echo " chmexe is " $CHMEXE >> debug
#echo " ntraj is " $NTRAJ >> debug
#echo " iseed is " $ISEED >> debug
#echo " pbs_o_workdir is " $PBS_O_WORKDIR >> debug

while($i <= $i_max)


if ($i == 1) then

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno seed=$ISEED -i start-hsp90-close.inp>& hsp90-close-1to25.traj$trajno.move$i.out &
wait
cp tmd-hsp90-close-1to25.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-close-1to25.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-close-25to50.inp>& hsp90-close-25to50.traj$trajno.move$i.out &
wait
cp tmd-hsp90-close-25to50.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-close-25to50.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-close-50to75.inp>& hsp90-close-50to75.traj$trajno.move$i.out &
wait
cp tmd-hsp90-close-50to75.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-close-50to75.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-close-75to100.inp>& hsp90-close-75to100.traj$trajno.move$i.out &
wait
cp tmd-hsp90-close-75to100.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-close-75to100.traj$trajno.move$i.res tmd-hsp90.rea
wait



mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-open-1to25.inp>& hsp90-open-1to25.traj$trajno.move$i.out &
wait
cp tmd-hsp90-open-1to25.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-open-1to25.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-open-25to50.inp>& hsp90-open-25to50.traj$trajno.move$i.out &
wait
cp tmd-hsp90-open-25to50.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-open-25to50.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-open-50to75.inp>& hsp90-open-50to75.traj$trajno.move$i.out &
wait
cp tmd-hsp90-open-50to75.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-open-50to75.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-open-75to100.inp>& hsp90-open-75to100.traj$trajno.move$i.out &
wait
cp tmd-hsp90-open-75to100.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-open-75to100.traj$trajno.move$i.res tmd-hsp90.rea
wait



else
mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i restart-hsp90-close.inp>& hsp90-close-1to25.traj$trajno.move$i.out &
wait
cp tmd-hsp90-close-1to25.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-close-1to25.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-close-25to50.inp>& hsp90-close-25to50.traj$trajno.move$i.out &
wait
cp tmd-hsp90-close-25to50.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-close-25to50.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-close-50to75.inp>& hsp90-close-50to75.traj$trajno.move$i.out &
wait
cp tmd-hsp90-close-50to75.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-close-50to75.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-close-75to100.inp>& hsp90-close-75to100.traj$trajno.move$i.out &
wait
cp tmd-hsp90-close-75to100.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-close-75to100.traj$trajno.move$i.res tmd-hsp90.rea
wait



mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-open-1to25.inp>& hsp90-open-1to25.traj$trajno.move$i.out &
wait
cp tmd-hsp90-open-1to25.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-open-1to25.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-open-25to50.inp>& hsp90-open-25to50.traj$trajno.move$i.out &
wait
cp tmd-hsp90-open-25to50.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-open-25to50.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-open-50to75.inp>& hsp90-open-50to75.traj$trajno.move$i.out &
wait
cp tmd-hsp90-open-50to75.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-open-50to75.traj$trajno.move$i.res tmd-hsp90.rea
wait

mpirun -n $NPROCS $chmexe move=$i trajno=$trajno -i hsp90-open-75to100.inp>& hsp90-open-75to100.traj$trajno.move$i.out &
wait
cp tmd-hsp90-open-75to100.traj$trajno.move$i.cor tmd-hsp90.crd
cp tmd-hsp90-open-75to100.traj$trajno.move$i.res tmd-hsp90.rea
wait


endif

## need to increremnt 1 by 1 - double check the language for variables in csh

#@i++
@ i += 1 
echo $i > next.seqno

#@ i +=  1

## you may also need to do some debugging - if this is the case comment all of the
## charmm commands and then give commands to echo that line starting with charmm
## and write everything to a debug script ( see the commented lines above)
## ie
## echo "$chmexe move=$i trajno=$trajno seed=$ISEED <hsp90-close.traj$trajno.move$i.out" >> debug
## debugging the sh script will not run charmm - you may also need to debug there, too based on the filenames that are read and written

end
