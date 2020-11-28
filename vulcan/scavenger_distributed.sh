#!/bin/bash

#SBATCH --time=3-00:00:00
#SBATCH --account=scavenger
#SBATCH --partition=scavenger
#SBATCH --gres=gpu:4
#SBATCH --cpus-per-task=16
#SBATCH --mem=100gb

set -x

module add cuda gcc/6.3.0

export WORK_DIR="/scratch0/slurm_${SLURM_JOBID}"
export PYTHONPATH=".:$PYTHONPATH"

srun bash -c "mkdir ${WORK_DIR}"
srun rsync -a --exclude="*.out" $WORK_DIR
srun bash -c "cd ${WORK_DIR}"
srun python -m torch.distributed.launch --nproc_per_node=4 "$@"
srun bash -c "rm -rf ${WORK_DIR}"
