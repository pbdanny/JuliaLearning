import pandas as pd

df = pd.read_csv('20220512_salesreport_promowk.csv')

print(df['PROMOWEEK_ID'].sort_values().unique())

(df
# .loc[df['PROMOWEEK_ID']==202216, :]
.loc[df['SKU_ID']==70817944,:]
)

print(df[(df['SKU_ID']==27164063) & (df['PROMOWEEK_ID']==202213)].groupby('STORE_FORMAT')['UNITS'].sum())
print(df[(df['SKU_ID']==27164063) & (df['PROMOWEEK_ID']==202213)][['DIVISION','STORE_FORMAT', 'UNITS']])