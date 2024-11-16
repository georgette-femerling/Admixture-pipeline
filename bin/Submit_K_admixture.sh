#!/bin/bash
#SBATCH --time=00:5:00
#SBATCH --account=def-sgravel
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100MB
#SBATCH --job-name=Admixture
#SBATCH -o Admixture_%A-%a.out

module load admixture
plink=$1
runs=$2

BIN=$3

#threads=$SLURM_CPUS_PER_TASK
K=$SLURM_ARRAY_TASK_ID

array=1-$runs
echo " Running admixture for K${K} "

sbatch --parsable --array=${array} ${BIN}/Run_admixture.sh ${plink} $runs $K

