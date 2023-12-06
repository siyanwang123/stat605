#!/bin/bash                                                                     

# Input file path                                                               
input_file="/u/x/l/xli2484/amazon/amazon_reviews_us_Sports_v1_00.tsv"

# Output file path                                                              
output_file="/u/x/l/xli2484/amazon/book.tsv"

# Extracting relevant columns and calculating helpfulness_ratio                 
awk -F'\t' 'BEGIN {OFS=FS} NR>1 {
    if ($10 > 0) {
        helpfulness_ratio=$9/$10
    } else {
        helpfulness_ratio="null"
    };
    print $8, $9, $10, length($14), helpfulness_ratio
}' "$input_file" > "$output_file"

# Output star_rating distribution
echo "Star Rating Distribution:"
awk '{rating_count[$1]++} END {for (rating in rating_count) print rating, rating_count[rating]}' "$output_file" | sort -n

# Output helpfulness_ratio distribution
echo -e "\nHelpfulness Ratio Distribution:"
awk '{if ($5 == "null") null_count++; else if ($5 < 0.1) less_than_01_count++; else if ($5 <= 0.5) between_01_05_count++; else if ($5 <= 0.9) between_05_09_count++; else greater_than_09_count++} 
    END {
        print "<0.1 (Not Helpful):", less_than_01_count;
        print "0.1 to 0.5 (Somewhat Helpful):", between_01_05_count;
        print "0.5 to 0.9 (Helpful):", between_05_09_count;
        print ">0.9 (Very Helpful):", greater_than_09_count;
        print "null:", null_count;
    }' "$output_file"

# Output review_body length distribution
echo -e "\nReview Body Length Distribution:"
awk '{if ($4 < 10) less_than_10_count++; else if ($4 <= 100) between_10_100_count++; else greater_than_100_count++} 
    END {
        print "<10:", less_than_10_count;
        print "10-100:", between_10_100_count;
        print ">100:", greater_than_100_count;
        print "null:", null_count;
    }' "$output_file"

# Output Total Votes Distribution
echo -e "\nTotal Votes Distribution:"
awk '{if ($3 == 0) null_count++; else if ($3 <= 10) between_0_10_count++;  else greater_than_10_count++} 
    END {
        print "0:", null_count;
        print "1-10:", between_0_10_count;
        print ">10:", greater_than_10_count;
    }' "$output_file"
