# Market Basket Analysis – Association Rules for Retail Data

**Author:** Zaki Abiyu Aqilah   
**Tools:** R (`arules`, `arulesViz`)  
**Goal:** Discover product associations and bundling opportunities from 100 transaction records

---

## Project Overview

This project applies **Market Basket Analysis (MBA)** using the Apriori algorithm to uncover frequently bought‑together items from a real‑world minimarket dataset. By identifying strong association rules, the analysis provides actionable insights for store layout, product bundling, and cross‑selling strategies.

**Key Results:**
- **Top product** (most frequent): Snack (44/100 transactions)
- **Strongest rule:** {Gula, Sirup} → {Teh Celup} (confidence = 100%, lift = 2.94)
- **Most popular pair:** Kopi → Susu (support = 20%, count = 20 transactions)

---

## Dataset

The data consists of **100 transactions** covering **8 product categories**. The raw file (`data_transaksi.txt`) is **not included** in this repository — see [`data/README.md`](data/README.md) for the expected file format.

| Product          | Frequency (absolute) |
|------------------|----------------------|
| Snack            | 44                   |
| Susu             | 37                   |
| Gula             | 36                   |
| Teh Celup        | 34                   |
| Kopi             | 33                   |
| Mie Instan       | 24                   |
| Sirup            | 24                   |
| Pet Food         | 16                   |

> **Note:** `Teh Celup` appears in 34 transactions, making it the most common component of the strongest rules.

---

## Frequent Itemsets (support ≥ 0.05, minlen = 2, maxlen = 3)

The Apriori algorithm discovered **20 frequent itemsets**. Below are the most notable ones:

| Itemset                              | Support | Count |
|--------------------------------------|---------|-------|
| {Kopi, Susu}                         | 0.20    | 20    |
| {Gula, Teh Celup}                    | 0.19    | 19    |
| {Sirup, Teh Celup}                   | 0.17    | 17    |
| {Mie Instan, Snack}                  | 0.14    | 14    |
| {Gula, Sirup, Teh Celup}             | 0.09    |  9    |
| {Gula, Kopi, Susu}                   | 0.07    |  7    |
| {Gula, Kopi, Snack}                  | 0.06    |  6    |
| {Pet Food, Snack}                    | 0.06    |  6    |
| {Gula, Snack, Teh Celup}             | 0.06    |  6    |

---

## Association Rules (support ≥ 0.08, confidence ≥ 0.6, maxlen = 3)

Five rules were generated. The table below shows rules sorted by **lift** (strongest relationship first).

| LHS                      | RHS        | Support | Confidence | Lift   | Count |
|--------------------------|------------|---------|------------|--------|-------|
| {Gula, Sirup}            | → Teh Celup | 0.09    | 1.000      | **2.94** | 9     |
| {Snack, Teh Celup}       | → Sirup     | 0.08    | 0.667      | **2.78** | 8     |
| {Sirup}                  | → Teh Celup | 0.17    | 0.708      | **2.08** | 17    |
| {Sirup, Snack}           | → Teh Celup | 0.08    | 0.667      | **1.96** | 8     |
| {Kopi}                   | → Susu      | 0.20    | 0.606      | **1.64** | 20    |

### Variable Importance (Product Frequency)

A simple frequency analysis shows the most important items in the dataset (based on absolute count):

| Product      | Frequency | Importance (%) |
|--------------|-----------|----------------|
| Snack        | 44        | 100.0          |
| Susu         | 37        |  84.1          |
| Gula         | 36        |  81.8          |
| Teh Celup    | 34        |  77.3          |
| Kopi         | 33        |  75.0          |

> **Insight:** While Snack is the most frequent item, the strongest rules are driven by **Teh Celup**, **Sirup**, and **Gula** combinations.

---

## Decision Rules (Business‑Friendly)

### If a customer buys **Gula and Sirup**, they almost always buy **Teh Celup** (confidence 100%).
- This triplet appears in 9 transactions.
- **Action:** Place these three items together and offer a bundle discount.

### If a customer buys **Snack and Teh Celup**, they often buy **Sirup** (confidence 67%).
- This rule has very high lift (2.78), indicating a strong association.
- **Action:** Cross‑promote Snack + Teh Celup with Sirup at the checkout.

### If a customer buys **Kopi**, they are likely to buy **Susu** (confidence 61%, lift 1.64).
- This is the most frequent rule (20 transactions).
- **Action:** Create a “Coffee Corner” with Kopi and Susu displayed side by side.

### If a customer buys **Sirup**, they are likely to buy **Teh Celup** (lift 2.08).
- This pair appears in 17 transactions.
- **Action:** Offer a “Teh Segar Bundle” (Sirup + Teh Celup) at a promotional price.

---

## Predictions on New Transactions (Example)

Three hypothetical new transactions were evaluated against the discovered rules:

| Transaction | Items Purchased                         | Recommended Add‑on (RHS) | Rule Used                      |
|-------------|-----------------------------------------|---------------------------|--------------------------------|
| New #1      | {Gula, Sirup}                           | Teh Celup                 | {Gula, Sirup} → Teh Celup      |
| New #2      | {Snack, Teh Celup}                      | Sirup                     | {Snack, Teh Celup} → Sirup     |
| New #3      | {Kopi}                                  | Susu                      | {Kopi} → Susu                  |

> **How to use:** In a real‑time recommendation system, when a cashier scans these items, the system can suggest the matching RHS product to increase basket size.

---

## Visualizations

- **Top 8 Items by Frequency** – Bar chart showing the most frequently purchased products.
- **Scatter Plot** – Support vs. Confidence, shaded by Lift (identifies high‑quality rules).
- **Graph‑based Visualization** – Interactive network of rules with lift > 1.3 (HTML widget).

> 📁 All visual outputs are saved in the [`output/`](output/) folder.

---

## How to Run the Code

1. **Clone this repository**  
   `git clone https://github.com/yourusername/Market-Basket-Analysis.git`

2. **Place your data file**  
   Copy your transaction file (e.g., `data_transaksi.txt`) into the `data/` folder.

3. **Run the R script**  
   Open `analysis/market_basket.R` in RStudio and execute it line by line, or run:
   ```r
   source("analysis/market_basket.R")
