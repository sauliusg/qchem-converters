#!/bin/sh
# Prints the ESM summary data (charge and potentials) to stdout
# Usage: esm_data.sh {pw output filename}
#
# Original version by Brandon Wood and Minoru Otani
#

echo '#   z (A)      rho (e)      Avg v_hartree        Avg v_local  Avg v_hart+v_loc'
echo '#                                  (eV/A)             (eV/A)            (eV/A)'
ngrid=`grep 'FFT grid: (' $1 | awk -F ',' '{print $3}' | sed 's/)//'`
let ngrid=$ngrid+5
grep -A${ngrid} 'ESM Charge and Potential' $1 | tail -n${ngrid} | tail -n+6
