#!/bin/bash
# align-star-se.sh

script_name="align-star-se.sh"
script_ver="1.0.0"


#Help function
usage() {
  echo "-h Help documentation for $script_name"
  echo "-f  --Path to fastq files a comma-separated list"
  echo "-i  --Path to STAR directory of genome index"
  echo "-a  --Path to the annotation file"
  echo "-o  --Path to output directory"
  echo "-v  --Version of script"
  echo "Example: $script_name -f 'foo_1.fastq.gz' -i '/path/to/star/index'  -a '/path/to/genome.gtf' [-o '/path/to/output/dir/']"
  exit 1
}

# Version function
version(){
    echo "$script_name $script_ver"
    exit 1a
}

main(){

    # Load required modules
    module load samtools/intel/1.3
    module load iGenomes/2013-03-25
    module load bedtools/2.17.0
    module load python/2.7.x-anaconda
    module load star/2.7.2b
    
    # Parsing options
    OPTIND=1 # Reset OPTIND
    while getopts :f:i:a:o:vh opt
        do
            case $opt in
                f) raw_file=$OPTARG;;
                i) genome=$OPTARG;;
                a) annotation=$OPTARG;;
                o) out=$OPTARG;;
                v) version;;
                h) usage;;
            esac
        done

    shift $(($OPTIND -1))

    # Check for mandatory options
    if [[ -z $raw_file ]] || [[ -z $annotation ]] || [[ -z $genome ]]; then
        usage
    fi

    # Define the output directory, if none defined make the location relative to first file
    if [ -z $out ]; then
        parent_dir=$(dirname "${raw_file}")
        out_dir=$(dirname "${parent_dir}")\/$script_name-$script_ver/
    else
        out_dir=$out\/$script_name-$script_ver
    fi

    if [ ! -d $out_dir ]; then
        mkdir $out_dir
    fi

    echo "* Value of reads: '$raw_file'"
    echo "* Value of star index : '$annotation'"

    # Align if file doesn't exist
    aln_fn=$(basename "${raw_file}")
    if [ ! -e $out_dir/$aln_fn.Aligned.sortedByCoord.out.bam ]; then

        echo "* Map reads..."
        
                   STAR --runThreadN 8 \
                        --genomeDir $genome\
                        --readFilesIn $raw_file\
                        --readFilesCommand zcat\
                        --outFileNamePrefix $out_dir/$aln_fn.\
                        --sjdbGTFfile $annotation\
                        --outSAMtype BAM SortedByCoordinate


        #sort 
        samtools index $out_dir\/$aln_fn\.Aligned.sortedByCoord.out.bam


        # Get input and output files and then print out metadata.json file
        input_files=("$annotation" "${raw_file_array[@]}")
        printf -v input "\"%s\"," "${input_files[@]}"
        input=${input%,}
        output_file=($out_dir\/$aln_fn*)
        printf -v output "\"%s\"," "${output_file[@]}"
        output=${output%,}
        printf '{"script name":"%s","script version":"%s", "input files": [%s], "output files": [%s]}' "$script_name" "$script_ver" "$input" "$output"  | python -m json.tool > $out_dir/$aln_fn.metadata.json
        echo "* Finished."
    else
        echo "* $aln_fn has already been aligned"
    fi
}

main "$@"
