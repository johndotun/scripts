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
set PATH = /home/alaooj/grp94/grp94-2020-04-16/

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


foreach i (closing opening)
foreach j (`seq 1 10`)

if ($i == closing && $j == 1) then
mpiexec -n $NPROCS $chmexe orient=$i frame=$j trajno=$trajno move=$move comp=tmd-grp94-del-$i-frame$j stepref=13333334 trjout=$j -i grp94-closing.strt.inp>& grp94-$i-$j.traj$trajno.move$move.out & 

wait

cp tmd-pep-grp94-$i-$j.traj$trajno.move$move.cor tmd-pep-grp94.crd 
cp tmd-pep-grp94-$i-$j.traj$trajno.move$move.res tmd-pep-grp94.rea  

else

mpiexec -n $NPROCS $chmexe orient=$i frame=$j trajno=$trajno move=$move comp=tmd-grp94-del-$i-frame$j stepref=13333334 trjout=$j -i grp94-closing.restrt.inp>& grp94-$i-$j.traj$trajno.move$move.out &

wait

cp tmd-pep-grp94-$i-$j.traj$trajno.move$move.cor tmd-pep-grp94.crd
cp tmd-pep-grp94-$i-$j.traj$trajno.move$move.res tmd-pep-grp94.rea

endif
end
end


