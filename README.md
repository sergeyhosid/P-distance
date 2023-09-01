# P-distance
calculation of polimorphism matrix (P-distance)

Distance matrix procedure: distance_matrix_P-dist.awk
Average distance matrix procedure: P-dist_av.awk
Example aligned sequences: sequences.aln
Output matrix: sequences_P-dist.mtr

Execute procedure of distance matrix (gawk should be installed):

gawk -f distance_matrix_P-dist.awk name_1=NG37 size=14 sequences.aln > sequences_P-dist.mtr

Parameters: name_1 - referal genome
            size - minimal number alined sequences


Calulation of average mean of each matrix:
Parameters: mingene=N (minimal number of genes)

gawk -f P-dist_av.awk sequences_P-dist.mtr > sequences_P-dist.tab
