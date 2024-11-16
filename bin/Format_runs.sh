#!/bin/bash
#SBATCH --time=1:00:00
#SBATCH --account=def-sgravel
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=200MB
#SBATCH --job-name=Format
#SBATCH -o Format.out

module load r

plink=$1
fam=$2
BIN=$3

K=$SLURM_ARRAY_TASK_ID

echo $K;
rm ${plink}.$K.indfile
rm ${plink}.$K.popfile
for file in $(ls *.$K.*.Q); 
do
    ( paste <(cut -f1 -d" " $fam | awk 'BEGIN{nind=1;popn=1} NR==1 {pop=$1;} {if (pop!=$1) {popn+=1; pop=$1} print nind"\t"nind"\t(x)\t"popn"\t:\t"; nind+=1;}' ) $file; ) >> ${plink}.$K.indfile
    Rscript ${BIN}/get_popq.r $file $fam ${plink}.$K.popfile
done

echo "Finished formating all runs"