#!/bin/awk
# Given a set of datafiles, output a record per file of averages for each field
# We can redefine skip from the command line
BEGIN { skip=1 }
FNR > skip {
  for(i=1; i<=NF; i++) fields[i] += $i;
  _nf = NF
  _fnr = FNR
  _skip = skip
}
FNR == 1 && NR != 1 {
  for(i=1; i<=_nf; i++) printf("%.2f%s", fields[i] / (_fnr - _skip), (i!=_nf) ? OFS : ORS);
  for(i=1; i<=_nf; i++) fields[i] = 0;
}
END {
  for(i=1; i<=_nf; i++) printf("%.2f%s", fields[i] / (FNR - skip), (i!=_nf) ? OFS : ORS);
}
