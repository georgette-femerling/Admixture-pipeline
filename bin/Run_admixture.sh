#!/bin/bash
#SBATCH --time=1-00:00
#SBATCH --account=def-sgravel
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=200MB
#SBATCH --job-name=Admixture
#SBATCH -o Admixture_%A-%a.out

module load admixture
plink=$1
runs=$2
K=$3

plinkb=$(basename $plink .bed)

threads=$SLURM_CPUS_PER_TASK
#K=$SLURM_ARRAY_TASK_ID

R=$SLURM_ARRAY_TASK_ID

echo " Running admixture for K${K} "

#for R in $(seq 1 $runs);
#do
seed=$(cut -d" " -f4 <(date)|sed 's/://g')$K$R
echo "K${K} , Run${R}/${runs}, seed:${seed}"
admixture --cv -s $seed -j${threads} $plink $K
mv ${plinkb}.${K}.Q ${plinkb}.${K}.${R}.Q 
mv ${plinkb}.${K}.P ${plinkb}.${K}.${R}.P 
#done

echo " Finished running admixture for K${K} "