## Answer
- The revenue drop is REAL, not a data problem.
- Revenue fell from ₹18.09 lakh (Aug) to ₹11.37 lakh (Sep). That is 37% less.
- This is based only on trusted rows (197 good orders).

## What we found
- Laptop 16 sales fell the most (₹7.92 lakh less). It sold 13 units in Aug and only 2 in Sep.
- Laptop 14 went up (₹2.5 lakh more), which reduced the drop a little.
- Fewer orders in September (113 to 84).
- Average order value was lower in September (₹16.0k to ₹13.5k).
- Rows we removed are too small to change the result (about ₹66k).

## How we found it
- Checked the data for errors (duplicates, bad dates, missing customers).
- Cleaned it in Python (Google Colab).
- Removed bad rows and saved them in rejected_orders.csv.
- Used SQL to calculate revenue by month and by product.
- Checked if the removed rows could change the answer. They cannot.

## Limits
- We do not know WHY Laptop 16 sales fell.
- New vs repeat customers uses only Aug-Sep data.
