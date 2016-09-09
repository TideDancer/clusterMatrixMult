#!/bin/bash
#SBATCH -n 12
#SBATCH -o outfile.txt
#SBATCH -e errfile.txt

srun -l --multi-prog run4.conf
