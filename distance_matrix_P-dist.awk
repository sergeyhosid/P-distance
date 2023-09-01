########################################################################################
# create distance matrix
# parameters: size=N (N=13)
#             name_1=chrom (name of referal genome)
#             type=Z (1 - matrix without referal genome/0 - matrix with referal genome)
#########################################################################################
{
  if($2!=num_gen)
  {
		if(FNR>1&&size_set>=size)
		{
# check gaps and undetected nucleotides [N]; count gene length [reference genome] and effective alignment lenght
      print num_gen, "check gap" > "matrix.log"
      for(i=1;i<=length(arr[num_ref]);i++)
        arr_gap[i]=arr_gap_r[i]=1;
      for(i=1;i<=size_set;i++)
        for(j=1;j<=length(arr[i]);j++)
        {
          chr=substr(arr[i],j,1);
          chr_r=substr(arr[num_ref],j,1);
          arr_gap[j]=(chr=="A"||chr=="a"||chr=="T"||chr=="t"||chr=="G"||chr=="g"||chr=="C"||chr=="c") ? arr_gap[j] : 0;
          arr_gap_r[j]=(chr_r=="A"||chr_r=="a"||chr_r=="T"||chr_r=="t"||chr_r=="G"||chr_r=="g"||chr_r=="C"||chr_r=="c") ? arr_gap_r[j] : 0;
          len_seq+=(i==num_ref) ? arr_gap_r[j] : 0;
          len_seq_eff+=(i==size_set) ? arr_gap_r[j]*arr_gap[j] : 0;
				}
# count matrix elements
      print num_gen > "matrix.log"
			for(i=(type==0) ? 1 : 2;i<=size_set;i++)
			  for(j=(type==0) ? 1 : 2;j<=size_set;j++)
			  {
					sum=0;
			    for(k=1;k<=length(arr[i]);k++)
			      sum+=(substr(arr[i],k,1)==substr(arr[j],k,1)) ? 0 : 1*arr_gap[k];
#			    print "len", i,j,length(arr[i]);
			    arr_matrix[i,j]=(len_seq_eff>0) ? sum/len_seq_eff : 0;
			  }
			arr_name[1]=(name_1!="") ? name_1 : arr_name[1]; 
			print "#", num_gen, name_gen, (type==0) ? size_set : size_set-1, len_seq, len_seq_eff, length(arr[num_ref]);
			for(i=(type==0) ? 1 : 2;i<=size_set;i++)
			{
			  printf("%7s ",arr_name[i]);
				for(j=(type==0) ? 1 : 2;j<=size_set;j++)
					printf("%7.5f ",arr_matrix[i,j]);
				printf("\n");
			}
#			exit;
		}
#		print num_gen, name_gen, size_set, name_1;
		num_ref=1;
    num_gen=$2;
    name_gen=$5;
    size_set=0;
    len_seq=len_seq_eff=0;
	}
  size_set++;
	num_ref=(name==$3) ? size_set : num_ref;
	arr[size_set]=(name==$3) ? $9 : $10;
	arr_name[size_set]=$3;
}
