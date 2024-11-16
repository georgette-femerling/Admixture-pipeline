#!/bin/bash
#SBATCH --time=5-00:00
#SBATCH --account=def-sgravel
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50G
#SBATCH --job-name=CLUMPP-%a
#SBATCH -o clumpp_%A-%a.out

CLUMPP=~/projects/ctb-sgravel/software/CLUMPP/CLUMPP_Linux64.1.1.2/CLUMPP
#Default paramfile just because it is required
paramfile1=~/projects/ctb-sgravel/software/CLUMPP/CLUMPP_Linux64.1.1.2/paramfile #DATATYPE=0
paramfile2=~/projects/ctb-sgravel/software/CLUMPP/CLUMPP_Linux64.1.1.2/paramfile2 #DATATYPE=1

plink=$1
K=$SLURM_ARRAY_TASK_ID
c=$2 #number of populations
inds=$3 #number of individuals
runs=$4 #number of runs

# First run to get indfile DATATYPE=0
echo " Running CLUMPP for K${K} 1/2"
$CLUMPP $paramfile1 -i ${plink}.$K.indfile -p ${plink}.$K.popfile -o ${plink}.$K.clumpp.indfile -j ${plink}.$K.miscfile -k $K -c $inds -r $runs
# Second run to get popfile DATATYPE=1
echo " Running CLUMPP for K${K} 2/2"
$CLUMPP $paramfile2 -i ${plink}.$K.indfile -p ${plink}.$K.popfile -o ${plink}.$K.clumpp.popfile -j ${plink}.$K.miscfile -k $K -c $c -r $runs

echo " Finished running CLUMPP for K${K} "