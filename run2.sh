#!/bin/bash
#SBATCH -n 8
#SBATCH -o outfile.txt
#SBATCH -e errfile.txt
#SBATCH --partition=HaswellPriority
#SBATCH --account=rajasek

srun -l --multi-prog run2.conf
