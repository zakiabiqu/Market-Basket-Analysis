# Using arules library
library(arules)
library(arulesViz)

# Reading transactions from data_transaksi.txt file
transaksi <- read.transactions(
  file = "E:/Curriculum Vitae/Project/R 2/data_transaksi.txt",
  format = "single",
  sep = "\t",
  cols = c(1, 2),
  skip = 1
)

# Display frequent itemsets with lower support to gain more insights
inspect(
  apriori(
    transaksi,
    parameter = list(
      support = 0.05,
      minlen = 2,
      maxlen = 3,
      target = "frequent itemsets"
    )
  )
)

# Display list of transaction items
transaksi@itemInfo

# Display list of transaction codes
transaksi@itemsetInfo

# Display transactions in matrix form
transaksi@data

# Inspect transactions
inspect(transaksi)

# Display item frequency
itemFrequency(transaksi, type = "absolute")
itemFrequency(transaksi)

# Save item frequency
data_item <- itemFrequency(transaksi, type = "absolute")

# Sort descending
data_item <- sort(data_item, decreasing = TRUE)

# Take top 5 best-selling items
data_item <- data_item[1:5]

# Convert to data frame
data_item <- data.frame(
  "Product Name" = names(data_item),
  "Quantity" = data_item,
  row.names = NULL
)

print(data_item)

# Visualize item frequency
itemFrequencyPlot(
  transaksi,
  topN = 8,
  type = "absolute",
  col = rainbow(8),
  main = "Top 8 Best-Selling Products"
)

# Form association rules
mba <- apriori(
  transaksi,
  parameter = list(
    supp = 0.08,
    conf = 0.6,
    minlen = 2,
    maxlen = 3
  )
)

# Display rules
mba

# Inspect rules by highest lift
inspect(sort(mba, by = "lift"))

# Filter RHS with item "Susu"
inspect(subset(mba, rhs %in% "Susu"))

# Filter LHS with item "Kopi"
inspect(subset(mba, lhs %in% "Kopi"))

# Filter combination Mie Instan -> Snack
inspect(
  subset(
    mba,
    lhs %in% "Mie Instan" &
      rhs %in% "Snack"
  )
)

# Filter based on LHS and RHS with item Kopi
inspect(
  subset(
    mba,
    lhs %in% "Kopi" |
      rhs %in% "Kopi"
  )
)

# Filter based on lift > 1.2
inspect(
  subset(
    mba,
    (lhs %in% "Kopi" | rhs %in% "Kopi") &
      lift > 1.2
  )
)

# Product recommendations based on Snack and Susu
inspect(
  subset(
    mba,
    lhs %ain% c("Snack", "Susu")
  )
)

# Visualize rules with scatter plot
plot(
  mba,
  method = "scatterplot",
  measure = c("support", "confidence"),
  shading = "lift"
)

# Visualize graph rules with high lift
plot(
  subset(mba, lift > 1.3),
  method = "graph",
  engine = "htmlwidget"
)

# View top 10 rules by lift
inspect(head(sort(mba, by = "lift"), 10))
