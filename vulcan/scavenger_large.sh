#!/bin/bash

#SBATCH --time=3-00:00:00
#SBATCH --account=scavenger
#SBATCH --partition=scavenger
#SBATCH --qos=scavenger
#SBATCH --gres=gpu:4
#SBATCH --cpus-per-task=4

set -x

module add cuda gcc/6.3.0

export WORK_DIR="/scratch0/slurm_${SLURM_JOBID}"
export PYTHONPATH=".:$PYTHONPATH"

srun bash -c "mkdir ${WORK_DIR}"
srun rsync -a --exclude="*.out" $WORK_DIR
srun bash -c "cd ${WORK_DIR}"
srun python -u "$@"
srun bash -c "rm -rf ${WORK_DIR}"