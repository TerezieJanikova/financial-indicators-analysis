import pandas as pd

# # Nahraď 'soubor.xlsx' názvem svého souboru

df = pd.read_excel('CEN10.xlsx', header=0)


# # odstranení slova prosinec ze sloupců
df['Rok'] = df['Rok'].str.replace('prosinec', '', regex=False).str.strip('_ ')


# # přejmenování sloupce
df = df.rename(columns={'Unnamed: 0': 'Potraviny'})

# # # odstatranení mezer
df.columns = df.columns.str.lstrip()

# # # chci zjistit všechny sloupce
# print(df.columns)

# # # vypsaní řádku s nan hodnotami
# print(df[df['Year'].isna()])

# # # # # Zjistí počet NaN v každém sloupci
# # nan_count = df.isnull().sum()


df = df.astype(float)

# # # Kontrola datových typů - vše sedí
print(df.dtypes)


df = df.drop(df.columns[[2, 5, 7, 9, 13, 21, 23, 27, 34, 38, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
             55, 56, 57, 58, 60, 62, 63, 64, 68, 59, 70, 71, 72, 73, 74, 75, 79, 80, 82, 84, 85, 86, 87, 88, 95, 97, 98]], axis=1)

print(df.columns)

df.to_csv('vyvoj_cen_final.csv', index=False, encoding='utf-8', sep=';')
