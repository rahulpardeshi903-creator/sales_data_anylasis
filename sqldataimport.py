import pandas as pd
from sqlalchemy import create_engine

# ---------- MySQL connection ----------
engine = create_engine(
    "mysql+pymysql://root:rahul251103@localhost/bigbasket",
    echo=False
)

# ---------- Table name : CSV file mapping ----------
files = {
    "customers": r"C:\Users\Admin\Documents\bigbasket dataset\big_basket_customers.csv",
    "delivery_performance": r"C:\Users\Admin\Documents\bigbasket dataset\big_basket_delivery_performance.csv",
    "inventory": r"C:\Users\Admin\Documents\bigbasket dataset\big_basket_inventory.csv",
    "inventory_new": r"C:\Users\Admin\Documents\bigbasket dataset\big_basket_inventoryNew.csv",
    "marketing_performance": r"C:\Users\Admin\Documents\bigbasket dataset\big_basket_marketing_performance.csv",
    "order_items": r"C:\Users\Admin\Documents\bigbasket dataset\big_basket_order_items.csv",
    "orders": r"C:\Users\Admin\Documents\bigbasket dataset\big_basket_orders.csv",
    "products": r"C:\Users\Admin\Documents\bigbasket dataset\big_basket_products.csv",
    "customer_feedback": r"C:\Users\Admin\Documents\bigbasket dataset\big_basket_customer_feedback.csv"
}

# ---------- Import loop ----------
for table, file_path in files.items():
    print(f"Importing {table}...")
    
    df = pd.read_csv(file_path)
    
    df.to_sql(
        name=table,
        con=engine,
        if_exists="replace",  # safer for first load
        index=False
    )

print("✅ All tables imported successfully!")
