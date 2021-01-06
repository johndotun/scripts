#!/bin/csh -f

# ASSUMPTION (1): $PATH files extensions    .inp  .strt.inp
# ASSUMPTION (2): output files extensions   .res  .dcd .out
# ASSUMPTION (3): previous restart file extension .rea

#source /etc/profile.d/modules.csh

set JOBNAME = grp94-PEP-apo
set PATH = /home/alaooj/Downloads/grp94/apo_grp94/capture-traj3
set iseed1 = 9999
set ntraj = 1
set NPROCS = 2
set CHMEXE = charmm-mpi
#rm -rf $JOBNAME-pulling-capture"_"traj$ntraj
#mkdir $JOBNAME-pulling-capture"_"traj$ntraj
#cd $JOBNAME-pulling-capture"_"traj$ntraj 
cd $PATH
#mkdir $JOBNAME-binding"_"traj$ntraj
#cd $JOBNAME-binding"_"traj$ntraj
mkdir capture-traj$ntraj
cd capture-traj$ntraj


 cp $PATH/grp94-dimer-apo-bound-eef1-min-norest.cor .
 cp $PATH/grp94-dimer-apo-bound-eef1-min-norest.psf .
 cp $PATH/param19_eef1.inp .
 cp $PATH/toph19_eef1.inp .
 cp $PATH/solvpar.inp .
 cp $PATH/$JOBNAME-capture.inp .


mpiexec -n $NPROCS $CHMEXE  ntraj=$ntraj   iseed=$iseed1  < $JOBNAME-capture.inp >& $JOBNAME-capture.out



gzip *.out

