import random
import pandas as pd
from datetime import datetime, timedelta
import os

base_path = r"C:\Users\balav\OneDrive\Pictures\Documents\New folder"

file1 = os.path.join(base_path, "records1.txt")
file2 = os.path.join(base_path, "records2.txt")
output = os.path.join(base_path, "merged_unique.txt")

# -----------------------------
# STEP 1: Generate 1000 records
# -----------------------------
print("🛠 Generating records1.txt...")

rows = []

cities = ["Chennai", "Bangalore", "Hyderabad", "Mumbai", "Delhi"]
states = ["TN", "KA", "TS", "MH", "DL"]
types = ["Savings", "Current"]
status_list = ["Active", "Inactive"]
regions = ["South", "North", "West"]
categories = ["A", "B", "C"]

start_date = datetime(2023, 1, 1)

for i in range(1000):
    acc_id = 1000 + i
    name = f"User{i}"
    email = f"user{i}@example.com"
    phone = str(9000000000 + i)
    city = random.choice(cities)
    state = random.choice(states)
    country = "India"
    zip_code = str(600000 + i)
    status = random.choice(status_list)
    balance = random.randint(1000, 20000)
    acc_type = random.choice(types)
    created = start_date + timedelta(days=random.randint(0, 365))
    updated = created + timedelta(days=random.randint(0, 100))
    region = random.choice(regions)
    category = random.choice(categories)

    rows.append([
        acc_id, name, email, phone, city, state, country, zip_code,
        status, balance, acc_type,
        created.strftime("%Y-%m-%d"),
        updated.strftime("%Y-%m-%d"),
        region, category
    ])

columns = [
    "AccountId","Name","Email","Phone","City","State","Country","Zip",
    "Status","Balance","Type","CreatedDate","UpdatedDate","Region","Category"
]

df1 = pd.DataFrame(rows, columns=columns)
df1.to_csv(file1, sep='\t', index=False)

print(f"✅ Created: {file1}")

# ----------------------------------------
# STEP 2: Create second file with duplicates
# ----------------------------------------
print("🛠 Generating records2.txt with duplicates...")

df2 = pd.concat([
    df1.sample(200),  # duplicates
    df1.sample(800).assign(AccountId=lambda x: x["AccountId"] + 5000)  # new
], ignore_index=True)

df2.to_csv(file2, sep='\t', index=False)

print(f"✅ Created: {file2}")

# -----------------------------
# STEP 3: Read both files
# -----------------------------
print("🔄 Reading files...")

df1 = pd.read_csv(file1, delimiter='\t')
df2 = pd.read_csv(file2, delimiter='\t')

# Clean headers
df1.columns = df1.columns.str.strip()
df2.columns = df2.columns.str.strip()

print(f"📊 File1 records: {len(df1)}")
print(f"📊 File2 records: {len(df2)}")

# -----------------------------
# STEP 4: Merge
# -----------------------------
merged = pd.concat([df1, df2], ignore_index=True)
print(f"🔀 Total merged: {len(merged)}")

# -----------------------------
# STEP 5: Deduplicate
# -----------------------------
merged['AccountId'] = merged['AccountId'].astype(str).str.strip().str.lower()

unique = merged.drop_duplicates(subset=['AccountId'])

print(f"✨ Unique records: {len(unique)}")

# -----------------------------
# STEP 6: Save final output
# -----------------------------
unique.to_csv(output, sep='\t', index=False)

print(f"✅ Final output saved: {output}")