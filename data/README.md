# Data Folder – Market Basket Analysis

This folder contains the raw transaction data used for the Market Basket Analysis.

## File Description

### `data_transaksi.txt`

- **Format:** Tab‑separated values (TSV) with two columns:  
  `Kode Transaksi` (transaction ID) and `Item` (product name)
- **Number of transactions:** 100 unique transaction IDs (`#001` to `#100`)
- **Number of items (unique products):** 8
- **Encoding:** UTF‑8 (plain text)

#### Column Details

| Column             | Description                                      | Example |
|--------------------|--------------------------------------------------|---------|
| `Kode Transaksi`   | Transaction identifier (character, starts with #) | `#001`  |
| `Item`             | Product name (character)                         | `Teh Celup` |

#### Products Included

1. Gula  
2. Kopi  
3. Mie Instan  
4. Pet Food  
5. Sirup  
6. Snack  
7. Susu  
8. Teh Celup  

## Data Source

The data was collected from point‑of‑sale (POS) records of a minimarket. No personally identifiable information is included.  

## Preprocessing Notes

- The raw file already follows the **single‑format** expected by `arules::read.transactions()`.
- No missing values or duplicates are present.
- Transaction IDs are unique; one row corresponds to one item in a transaction.
- The file has a header row (`Kode Transaksi` `Item`), which is skipped during reading with `skip = 1`.

## How to Use This Data in the R Script

From the root of the repository, run:

```r
library(arules)

transaksi <- read.transactions(
  file = "data/data_transaksi.txt",
  format = "single",
  sep = "\t",
  cols = c(1, 2),
  skip = 1
)
