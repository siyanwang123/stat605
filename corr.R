library(data.table)
data <- fread("amazon_reviews_us_PC_v1_00.tsv")

head(data)
data$helpfulness_ratio <- ifelse(data$total_votes > 0, data$helpful_votes / data$total_votes, NA)

print(nrow(data))
data1=data1[complete.cases(data1$review_body), ]
print(nrow(data1))

print(aggregate(total_votes ~ star_rating, data = data, FUN = mean))
print(aggregate(helpfulness_ratio ~ star_rating, data = data, FUN = mean))

print(cor(data1$star_rating, data1$helpfulness_ratio, method = "spearman"))
print(cor.test(data1$star_rating, data1$helpfulness_ratio, method = "spearman"))

print(cor(data$star_rating, data$helpful_votes, method = "spearman"))
print(cor.test(data$star_rating, data$helpful_votes, method = "spearman"))

print(cor(nchar(as.character(data1$review_body)), data1$total_votes, method = "spearman"))
print(cor.test(nchar(as.character(data1$review_body)), data1$total_votes, method = "spearman"))
