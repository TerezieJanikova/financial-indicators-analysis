import pandas as pd
#  načtení a spojení tabulek
df1 = pd.read_csv('income_age.csv')
df2 = pd.read_csv('income_age1.csv')
df3 = pd.read_csv('income_age2.csv')
df4 = pd.read_csv('income_age_2.csv')
df5 = pd.read_csv('income_age_6.csv')
df6 = pd.read_csv('income_age_10.csv')

df_prijmy = pd.concat([df1, df2, df3, df4, df5, df6], ignore_index=True)


# chci zjistit všechny sloupce
print(df_prijmy.columns)

# tvorba databáze jen s několika sloupci
sloupce_k_analýze = ['Sex', 'Statistical classification of economic activities in the European Community (NACE Rev. 2)',
                     'Statistical classification of economic activities in the European Community (NACE Rev. 1.1)', 'Age class', 'Unit of measure', 'Geopolitical entity (reporting)', 'TIME_PERIOD', 'OBS_VALUE']
df_prijmy = df_prijmy[sloupce_k_analýze]


# Vytvoření nového sloupce 'Industry_sector' z dvou sloupců
df_prijmy['Industry_sector'] = df_prijmy['Statistical classification of economic activities in the European Community (NACE Rev. 1.1)'].combine_first(
    df_prijmy['Statistical classification of economic activities in the European Community (NACE Rev. 2)'])

# tvorba databáze jen s několika sloupci
sloupce_k_analýze = ['Sex', 'Industry_sector', 'Age class', 'Unit of measure',
                     'Geopolitical entity (reporting)', 'TIME_PERIOD', 'OBS_VALUE']
df_prijmy = df_prijmy[sloupce_k_analýze]


# přejemenování sloupců
df_prijmy = df_prijmy.rename(columns={
    'Sex': 'Gender',
    'Structure of earnings indicator': 'Type_of_income',
    'Age class': 'Age_class',
    'Unit of measure': 'Currency',
    'Geopolitical entity (reporting)': 'Country',
    'TIME_PERIOD': 'Year',
    'OBS_VALUE': 'Value'
})


df_prijmy['Currency'] = df_prijmy['Currency'].fillna('Euro')
df_prijmy = df_prijmy.dropna(subset=['Value'])


# # Zjistí počet NaN v každém sloupci
# nan_count = df_prijmy.isnull().sum()


df_prijmy['Gender'] = df_prijmy['Gender'].replace({
    'Females': 'Female',
    'Males': 'Male',
    'Total': 'All'
})


df_prijmy['Size_of_company'] = df_prijmy['Size_of_company'].replace({
    '10 employees or more': 'Total'
})

df_prijmy = df_prijmy.drop('Time_frequency', axis=1)


# # Počet duplicitních řádků - výsledek byl 0, talže bych neměla mít žádné duplicity
# print(df_prijmy.duplicated().sum())

# odstranuji duplicty
# df_prijmy = df_prijmy.drop_duplicates()

# # Kontrola datových typů - vše sedí
# print(df_prijmy.dtypes)

# # Záporné hodnoty ve sloupci 'value'
# print(df_prijmy[df_prijmy['Value'] < 0])

# # # print(df_prijmy['gender'].unique())
df_prijmy.to_csv('income_age_final.csv', index=False, encoding='utf-8')
