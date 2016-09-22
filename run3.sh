#!/bin/bash
#SBATCH -n 16
#SBATCH -o outfile.txt
#SBATCH -e errfile.txt
#SBATCH --partition=HaswellPriority
#SBATCH --account=rajasek

srun -l --multi-prog run3.conf
