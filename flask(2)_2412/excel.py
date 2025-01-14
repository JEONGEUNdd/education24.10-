import pandas as pd
df=pd.read_excel(r'C:\Users\enjoy\Flask_202412\file.xlsx')

for i, row in df.iterrows():
    if i==0:
        continue
    print(tuple(row))
    