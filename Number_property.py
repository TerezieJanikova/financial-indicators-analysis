import pandas as pd

# Načtení dat
df = pd.read_csv('nem_pomer.csv')


# # # chci zjistit všechny sloupce
# print(df.columns)


sloupce_k_analýze = ['Unit of measure',
                     'Geopolitical entity (reporting)', 'TIME_PERIOD', 'OBS_VALUE']
df = df[sloupce_k_analýze]

# # přejemenování sloupců
df = df.rename(columns={
    'Unit of measure': 'Unit_of_measure',
    'Geopolitical entity (reporting)': 'Country',
    'TIME_PERIOD': 'Year',
    'OBS_VALUE': 'Value',
})


# print(df[''].unique())

# # uprava hodnot
df['Type_of_property'] = df['Type_of_property'].replace({
    'Purchases of existing dwellings': 'Existing property',
    'Purchases of newly built dwellings': 'New property',
    'Total': 'All property'
})

# # print(df['Unit_of_measure'].unique())

# Zjistí počet NaN v každém sloupci
nan_count = df.isnull().sum()

# Vypíše jen ty sloupce, kde je aspoň jeden NaN
print(nan_count[nan_count > 0])


# # smazání řádků s nan hodnotami
df = df.dropna(subset=['Value'])

# kontrola smazání
print(df[df['Value'].isna()])

# Počet duplicitních řádků - výsledek byl 0, talže bych neměla mít žádné duplicity
print(df.duplicated().sum())

# # Kontrola datových typů - vše sedí
print(df.dtypes)

df.to_csv('house_price_to_income_final.csv', index=False, encoding='utf-8')
