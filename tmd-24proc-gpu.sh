#! /bin/csh -f
#PBS -N 94-t2
#PBS -l walltime=400:00:00
#PBS -l nodes=1:ppn=24


## Jobname shows in the queue
## change nprocs here and where you request a node
## chmexe is charmm on the cluster and charmm-mpi on your desktop
## move in the incrementer
## iseed is your random number - should be different for each trajno
## i_max is how many times to open/close
source /etc/profile.d/modules.csh
set NPROCS = 24
set chmexe = charmm
set trajno = 1
#set move = 0
set PATH = /home/alaooj/grp94/proinsulin/capture5
# CHANGE TO SUBMISSION SUBDIR
cd $PATH

#module load charmm-c43b1-intel-mpi-tmd
#module load charmm-c43b1-intel-mpi-tmd

# check the parameters passed
#echo " has passed i initialization" >> debug
#echo " jobname is" $JOBNAME >> debug
#echo " nprocs is " $NPROCS >> debug
#echo " chmexe is " $CHMEXE >> debug
#echo " ntraj is " $NTRAJ >> debug
#echo " iseed is " $ISEED >> debug
#echo " pbs_o_workdir is " $PBS_O_WORKDIR >> debug
module load openmpi-intel
module load charmm-c43b1-intel-mpi-tmd

set move = 1

mpiexec -n $NPROCS $chmexe  trajno=$trajno move=$move comp=tmd-hsp90-70closed-frame18 stepref=13333334 trjout=1to25 -i grp94-closing.strt.inp>& hsp90-close-a.traj$trajno.move$move.out &
wait
cp tmd-pep-grp94-close-1to25.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-close-1to25.traj$trajno.move$move.res tmd-pep-grp94.rea
mpiexec -n $NPROCS $chmexe  trajno=$trajno move=$move comp=tmd-hsp90-70closed-frame45 stepref=13333334 trjout=25to50 -i grp94-closing.restrt.inp>& hsp90-close-b.traj$trajno.move$move.out &
wait
cp tmd-pep-grp94-close-25to50.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-close-25to50.traj$trajno.move$move.res tmd-pep-grp94.rea
mpiexec -n $NPROCS $chmexe  trajno=$trajno move=$move comp=tmd-hsp90-70closed-frame70 stepref=13333334 trjout=50to75 -i grp94-closing.restrt.inp>& hsp90-close-c.traj$trajno.move$move.out &
wait
cp tmd-pep-grp94-close-50to75.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-close-50to75.traj$trajno.move$move.res tmd-pep-grp94.rea
mpiexec -n $NPROCS $chmexe  trajno=$trajno move=$move comp=closedgrp94-dimer-eef1-min stepref=13333334 trjout=75to100 -i grp94-closing.restrt.inp>& hsp90-close-d.traj$trajno.move$move.out &
wait
cp tmd-pep-grp94-close-75to100.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-close-75to100.traj$trajno.move$move.res tmd-pep-grp94.rea


mpiexec -n $NPROCS $chmexe  trajno=$trajno move=$move comp=tmd-hsp90-70open-frame17 stepref=13333334 trjout=1to25 -i grp94-opening.inp>& hsp90-open-a.traj$trajno.move$move.out &
wait
cp tmd-pep-grp94-open-1to25.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-open-1to25.traj$trajno.move$move.res tmd-pep-grp94.rea
mpiexec -n $NPROCS $chmexe  trajno=$trajno move=$move comp=tmd-hsp90-70open-frame52 stepref=13333334 trjout=25to50 -i grp94-opening.inp>& hsp90-open-b.traj$trajno.move$move.out &
wait
cp tmd-pep-grp94-open-25to50.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-open-25to50.traj$trajno.move$move.res tmd-pep-grp94.rea
mpiexec -n $NPROCS $chmexe  trajno=$trajno move=$move comp=tmd-hsp90-70open-frame78 stepref=13333334 trjout=50to75 -i grp94-opening.inp>& hsp90-open-c.traj$trajno.move$move.out &
wait
cp tmd-pep-grp94-open-50to75.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-open-50to75.traj$trajno.move$move.res tmd-pep-grp94.rea
mpiexec -n $NPROCS $chmexe  trajno=$trajno move=$move comp=apogrp94-dimer-eef1-min stepref=13333334 trjout=75to100 -i grp94-opening.inp>& hsp90-open-d.traj$trajno.move$move.out &
wait
cp tmd-pep-grp94-open-75to100.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-open-75to100.traj$trajno.move$move.res tmd-pep-grp94.rea




## need to increremnt 1 by 1 - double check the language for variables in csh



## you may also need to do some debugging - if this is the case comment all of the
## charmm commands and then give commands to echo that line starting with charmm
## and write everything to a debug script ( see the commented lines above)
## ie
## echo "$chmexe move=$i trajno=$trajno seed=$ISEED <hsp90-close.traj$trajno.move$i.out" >> debug
## debugging the sh script will not run charmm - you may also need to debug there, too based on the filenames that are read and written
