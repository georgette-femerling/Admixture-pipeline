#!/bin/bash
#SBATCH --time=00:10
#SBATCH --account=def-sgravel
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1G
#SBATCH --job-name=Distruct
#SBATCH -o Distruct_%A-%a.out

distruct=~/projects/ctb-sgravel/software/distruct/distruct1.1/distructLinux1.1
drawparams=~/projects/ctb-sgravel/software/distruct/distruct1.1/drawparams

cp $drawparams $PWD

plink=$1
K=$SLURM_ARRAY_TASK_ID
c=$2 #number of populations
inds=$3 #number of individuals

plinkbase=$(echo $plink | cut -f1 -d"_")

echo " Running distruct for K${K} "

ln -s ${plink}.${K}.clumpp.indfile K${K}.clumpp.tmp.indfile
ln -s ${plink}.${K}.clumpp.popfile K${K}.clumpp.tmp.popfile
ln -s ${plink}.names K${K}.tmp.names

$distruct -K $K -M $c -N $inds -i K${K}.clumpp.tmp.indfile -p K${K}.clumpp.tmp.popfile -b K${K}.tmp.names -a K${K}.tmp.names -o ${plinkbase}.K${K}.distruct.ps

rm K${K}.*.tmp.*

echo " Finished running distruct for K${K} "
