#########################################################
# average P-distance
# parameter: mingene=N (minimal number of genes)
#########################################################
{
	if($1=="#")
	{
		if(FNR>1&&numgene>=mingene)
		{
			sum=num=0
			for(i=1;i<=pos;i++)
				for(j=2;j<=i;j++)
				{
					sum+=arr[i,j];
					num++;
				}
			print gene, sum/num, name, leneff, lenref, numgene;
		}
		gene=$2;
		name=$3
		numgene=$4
		leneff=$6;
		lenref=$7;
		pos=0;
	}
	if($1!="#")
	{
		pos++;
		for(i=1;i<=NF;i++)
			arr[pos,i]=$i;
	}
}
