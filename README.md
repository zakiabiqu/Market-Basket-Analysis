# Market Basket Analysis using Association Rules

**Author:** Zaki Abiqu  
**Tools:** R (arules, arulesViz)  
**Goal:** Discover product associations from transaction data to support cross-selling and promotional strategies.

---

## Project Overview

This project applies **Apriori algorithm** to find frequent itemsets and association rules from a small transaction dataset (10 transactions, 4 products). The analysis demonstrates how to:

- Load and inspect transaction data
- Generate frequent itemsets with minimum support
- Extract association rules with various confidence thresholds
- Filter rules by lift, antecedent, and consequent
- Visualize rules as a graph

**Key Business Insight:**  
Customers who buy **Gula** and **Pet Food** together are highly likely (100% confidence) to also buy **Sirup**. This rule has a lift of 1.67, indicating a strong positive association.

---

## Dataset

The dataset contains **10 transactions** from a retail store. Each transaction records which items were purchased together.

### Items (4 products)

| Item Name |
|-----------|
| Gula |
| Pet Food |
| Sirup |
| Teh Celup |

### Transaction List (raw)

| Transaction ID | Items Purchased |
|----------------|-----------------|
| #01 | Pet Food, Sirup, Teh Celup |
| #02 | Gula, Teh Celup |
| #03 | Pet Food, Sirup |
| #04 | Sirup, Teh Celup |
| #05 | Gula, Sirup, Teh Celup |
| #06 | Pet Food, Teh Celup |
| #07 | Pet Food, Sirup, Teh Celup |
| #08 | Teh Celup |
| #09 | Gula, Teh Celup |
| #10 | Gula, Pet Food, Sirup |

> **Note:** The original data file (`data_transaksi.txt`) is not included in this repository. See [`data/README.md`](data/README.md) for details on how to obtain or reproduce the data.

---

## Key Results

### Item Frequency (Absolute)

| Item | Frequency (out of 10) |
|------|----------------------|
| Teh Celup | 8 |
| Sirup | 6 |
| Pet Food | 5 |
| Gula | 4 |

### Top 3 Frequent Itemsets (support ≥ 0.1, minlen=2)

| Itemset | Support | Count |
|---------|---------|-------|
| {Pet Food, Sirup} | 0.4 | 4 |
| {Sirup, Teh Celup} | 0.4 | 4 |
| {Pet Food, Teh Celup} | 0.3 | 3 |

### Selected Association Rules (confidence ≥ 0.5, support ≥ 0.1)

| Rule (LHS → RHS) | Support | Confidence | Lift | Count |
|------------------|---------|------------|------|-------|
| {Pet Food} → {Sirup} | 0.4 | 0.80 | 1.33 | 4 |
| {Gula, Pet Food} → {Sirup} | 0.1 | **1.00** | **1.67** | 1 |
| {Pet Food, Teh Celup} → {Sirup} | 0.2 | 0.67 | 1.11 | 2 |

### Best Recommendation Rule

- **If a customer buys Gula and Pet Food, then recommend Sirup**  
  - Confidence = 100%  
  - Lift = 1.67 (meaningful association)

---

## How to Run the Code

1. Clone this repository.

2. Place the transaction data file (data_transaksi.txt) in the data/ folder.
(See data/README.md for file format.)

3. Run the R script:
