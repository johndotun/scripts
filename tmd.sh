#!/bin/csh -f
## Jobname shows in the queue
## change nprocs here and where you request a node
## chmexe is charmm on the cluster and charmm-mpi on your desktop
## move in the incrementer
## iseed is your random number - should be different for each trajno
## i_max is how many times to open/close

set NPROCS = 2
set chmexe = charmm
set trajno = 3
#set move = 0
set ISEED = 17954
set PATH = /home/alaooj/Downloads/grp94/apo_grp94/capture-traj3
set i_max = 50
# CHANGE TO SUBMISSION SUBDIR
##cd $PATH
mkdir open_closed_dynamics$trajno
cd open_closed_dynamics$trajno

## make sure to copy all of your input files
## param_eef1, top_eef1, solvpar
## psf and cor from capture

#this .cor file needs to be changed for each trajectory
cp $PATH/grp94-close.restrt.inp .
cp $PATH/grp94-pep-apo-capture_3-norest.cor .
cp $PATH/grp94-dimer-bound-apo-eef1.psf .
cp $PATH/grp94-dimer-close-eef1-min-norest.cor .
cp $PATH/grp94-dimer-close-eef1.psf .
cp $PATH/param19_eef1.inp .
cp $PATH/toph19_eef1.inp .
cp $PATH/solvpar.inp .
cp $PATH/grp94-close.strt.inp .
cp $PATH/grp94-open.inp .


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
mpiexec -n $NPROCS move=$i trajno=$trajno seed=$ISEED <grp94-close.strt.inp > grp94-close.traj$trajno.move$i.out &
wait
cp tmd-pep-grp94-close.traj$trajno.move$i.cor tmd-pep-grp94-close.crd
cp tmd-pep-grp94-close.traj$trajno.move$i.res tmd-pep-grp94-close.rea

mpiexec -n $NPROCS $chmexe move=$i trajno=$trajno <grp94-open.inp> grp94-open.traj$trajno.move$i.out &
wait
cp tmd-pep-grp94-open.traj$trajno.move$i.cor tmd-pep-grp94-open.crd
cp tmd-pep-grp94-open.traj$trajno.move$i.res tmd-pep-grp94-open.rea


else
mpiexec -n $NPROCS $chmexe move=$i trajno=$trajno seed=$ISEED <grp94-close.restrt.inp> grp94-close.traj$trajno.move$i.out &
wait
cp tmd-pep-grp94-close.traj$trajno.move$i.cor tmd-pep-grp94-close.crd
cp tmd-pep-grp94-close.traj$trajno.move$i.res tmd-pep-grp94-close.rea

mpieexec -n $NPROCS $chmexe move=$i trajno=$trajno <grp94-open.inp> grp94-open.traj$trajno.move$i.out &
wait
cp tmd-pep-grp94-open.traj$trajno.move$i.cor tmd-pep-grp94-open.crd
cp tmd-pep-grp94-open.traj$trajno.move$i.res tmd-pep-grp94-open.rea

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
## echo "$chmexe move=$i trajno=$trajno seed=$ISEED <grp94-close.traj$trajno.move$i.out" >> debug
## debugging the sh script will not run charmm - you may also need to debug there, too based on the filenames that are read and written

end
