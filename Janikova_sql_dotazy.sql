-- přejmenování sloupců
ALTER TABLE income_age_final
ADD Edu_field VARCHAR(255);

begin tran 

UPDATE income_age_final
SET Edu_field = CASE
    WHEN Industry_sector = 'Accommodation and food service activities' THEN 'Služby'
    WHEN Industry_sector = 'Administrative and support service activities' THEN 'Obchod, administrativa a právo'
    WHEN Industry_sector = 'Arts, entertainment and recreation' THEN 'Umění a humanitní vědy'
    WHEN Industry_sector = 'Construction' THEN 'Technika, výroba a stavebnictví'
    WHEN Industry_sector = 'Education' THEN 'Vzdělávání a výchova'
    WHEN Industry_sector = 'Electricity, gas, steam and air conditioning supply' THEN 'Technika, výroba a stavebnictví'
    WHEN Industry_sector = 'Financial and insurance activities' THEN 'Obchod, administrativa a právo'
    WHEN Industry_sector = 'Human health and social work activities' THEN 'Zdravotní a sociální péče, péče o příznivé životní podmínky'
    WHEN Industry_sector = 'Information and communication' THEN 'Informační a komunikační technologie'
    WHEN Industry_sector = 'Manufacturing' THEN 'Technika, výroba a stavebnictví'
    WHEN Industry_sector = 'Mining and quarrying' THEN 'Technika, výroba a stavebnictví'
    WHEN Industry_sector = 'Other service activities' THEN 'Služby'
    WHEN Industry_sector = 'Professional, scientific and technical activities' THEN 'Přírodní vědy, matematika a statistika'
    WHEN Industry_sector = 'Public administration and defence; compulsory social security' THEN 'Obchod, administrativa a právo'
    WHEN Industry_sector = 'Real estate activities' THEN 'Obchod, administrativa a právo'
    WHEN Industry_sector = 'Transportation and storage' THEN 'Technika, výroba a stavebnictví'
    WHEN Industry_sector = 'Water supply; sewerage, waste management and remediation activities' THEN 'Technika, výroba a stavebnictví'
    WHEN Industry_sector = 'Wholesale and retail trade; repair of motor vehicles and motorcycles' THEN 'Obchod, administrativa a právo'
    ELSE NULL
END;

COMMIT

SELECT DISTINCT Edu_field
INTO Dim_Edu_field
FROM income_age_final

ALTER TABLE [Dim_Edu_field] ALTER COLUMN [Edu_field] nvarchar(100) NOT NULL

ALTER TABLE [Dim_Edu_field]
ADD CONSTRAINT [PK_DimEdu_field]
PRIMARY KEY ([Edu_field])

ALTER TABLE income_age_final ALTER COLUMN Edu_field nvarchar(100) NOT NULL

ALTER TABLE [income_edu_final_all] 
ADD CONSTRAINT [FK_Edu_field_field_income_edu_final_all]
FOREIGN KEY ([Edu_field]) REFERENCES [Dim_Edu_field] ([Edu_field])

--  Doplnění dimenze z různých tabulek
;WITH T AS (
    SELECT DISTINCT [Entity] as Country FROM Births_by_age_final
    UNION
    SELECT DISTINCT [Country] FROM income_age_final
    UNION
    SELECT DISTINCT [Country] FROM income_edu_final
    UNION
    SELECT DISTINCT [Country] FROM house_price_final
    UNION
    SELECT DISTINCT [Country] FROM consumer_price_final
    UNION
    SELECT DISTINCT [Country] FROM house_price_to_income_final
)
INSERT INTO [Dim_Country] (Country)
SELECT T.Country
FROM T
LEFT JOIN [Dim_Country] D ON T.Country = D.Country
WHERE D.Country IS NULL;

;WITH T AS (
    SELECT DISTINCT [Industry_sector] FROM income_age_final
    UNION
    SELECT DISTINCT [Industry_sector] FROM income_edu_final
)
INSERT INTO [Dim_Industry_sector] (Industry_sector)
SELECT T.Industry_sector
FROM T
LEFT JOIN [Dim_Industry_sector] D ON T.Industry_sector = D.Industry_sector
WHERE D.Industry_sector IS NULL;

-- přeformátování sloupců
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [rýže_dlouhozrnná] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [mouka_hladká] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [chléb_kmínový ] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [těstoviny_vaječné] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [maso_hovězí_zadní] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [maso_vepřové_pečeně] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [kuře_celé] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [párky] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [šunka_vepřová] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [filé_mražené] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [mléko_polotučné] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [Sušené_mléko] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [Eidam] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [vejce] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [máslo] FLOAT NULL;

UPDATE dbo.Vyvoj_cen_final
SET [olej_slunečnicový] = NULL
WHERE TRY_CAST([olej_slunečnicový] AS FLOAT) IS NULL
  AND [olej_slunečnicový] IS NOT NULL

ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [olej_slunečnicový] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [jablka] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [pomeranče] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [banány] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [cibule] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [brambory] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [cukr] FLOAT NULL;

UPDATE dbo.Vyvoj_cen_final
SET [káva_mletá_100_g] = NULL
WHERE TRY_CAST([káva_mletá_100_g] AS FLOAT) IS NULL
  AND [káva_mletá_100_g] IS NOT NULL

ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [káva_mletá_100_g] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [káva_rozpustná_100_g] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [čokoláda] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [pivo_lahvové] FLOAT NULL;

UPDATE dbo.Vyvoj_cen_final
SET [šumivé_víno_0_7_l] = NULL
WHERE TRY_CAST([šumivé_víno_0_7_l] AS FLOAT) IS NULL
  AND [šumivé_víno_0_7_l] IS NOT NULL

ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [šumivé_víno_0_7_l] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [Tuzemák] FLOAT NULL;

UPDATE dbo.Vyvoj_cen_final
SET [Marlboro_krabička] = NULL
WHERE TRY_CAST([Marlboro_krabička] AS FLOAT) IS NULL
  AND [Marlboro_krabička] IS NOT NULL

ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [Marlboro_krabička] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [dětská_obuv] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [teplo_pro_otop_a_přípravu_teplé_vody_1_GJ] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [pračka] FLOAT NULL;

UPDATE dbo.Vyvoj_cen_final
SET [lednice] = NULL
WHERE TRY_CAST([lednice] AS FLOAT) IS NULL
  AND [lednice] IS NOT NULL

ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [lednice] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [vysavač] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [smažící_pánev_teflonová_1_kus] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [benzin_95_1_l] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [nafta_1_l] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [řidičský_kurz] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [televizní_přijímač_barevný_stolní_1_kus] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [vstup_do_divadla] FLOAT NULL;

UPDATE dbo.Vyvoj_cen_final
SET [černá_káva] = NULL
WHERE TRY_CAST([černá_káva] AS FLOAT) IS NULL
  AND [černá_káva] IS NOT NULL

ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [černá_káva] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [pivo_sudové_0_5_l] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [víno_0_2_l] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [oběd_v_závodní_jídelně] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [oběd_ve_školní_jídelně] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [oběd_VŠ_menze_1_menu] FLOAT NULL;
ALTER TABLE dbo.Vyvoj_cen_final ALTER COLUMN [pánský_kadeřník] FLOAT NULL;

--uprava názvů
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'price_trends_final';

SELECT * FROM price_trends_final
begin TRAN

EXEC sp_rename N'dbo.Price_trends_final.[těstoviny_vaječné]', N'Pasta_egg', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[maso_hovězí_zadní]', N'Beef_rear', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[maso_vepřové_pečeně]', N'Pork_roast', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[kuře_celé]', N'Chicken_whole', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[šunka_vepřová]', N'Ham_pork', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[mléko_polotučné]', N'Milk_semi_skimmed', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[olej_slunečnicový]', N'Oil_sunflower', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[pomeranče]', N'Oranges', 'COLUMN';

EXEC sp_rename N'dbo.Price_trends_final.[čokoláda]', N'Chocolate', 'COLUMN';

EXEC sp_rename N'dbo.Price_trends_final.[Tuzemák]', N'Tuzemak', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[Marlboro_krabička]', N'Marlboro_pack', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[dětská_obuv]', N'Children_shoes', 'COLUMN';

EXEC sp_rename N'dbo.Price_trends_final.[teplo_pro_otop_a_přípravu_teplé_vody_1_GJ]', N'Heating_and_hot_water_1GJ', 'COLUMN';

EXEC sp_rename N'dbo.Price_trends_final.[lednice]', N'Fridge', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[vysavač]', N'Vacuum_cleaner', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[řidičský_kurz]', N'Driving_course', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[televizní_přijímač_barevný_stolní_1_kus]', N'Tv_color_table', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[černá_káva]', N'Coffee_black', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[oběd_v_závodní_jídelně]', N'Lunch_canteen', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[oběd_ve_školní_jídelně]', N'Lunch_school_canteen', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[oběd_VŠ_menze_1_menu]', N'Lunch_university_canteen', 'COLUMN';
EXEC sp_rename N'dbo.Price_trends_final.[pánský_kadeřník]', N'Mens_hairdresser', 'COLUMN';
ROLLBACK TRAN

ALTER TABLE Price_trends_final
DROP COLUMN pračka;

--přejmenování sloupců

SELECT distinct Edu_field from Dim_Edu_field

ALTER TABLE income_age_final
DROP CONSTRAINT FK_Industry_income_age_final

drop

Begin TRAN

UPDATE Dim_Industry_sector
SET Industry_sector = CASE
    WHEN Industry_sector = 'Accommodation and food service activities' THEN 'Hospitality'
    WHEN Industry_sector = 'Administrative and support service activities' THEN 'Business Support'
    WHEN Industry_sector = 'Arts, entertainment and recreation' THEN 'Arts, Entertainment & Leisure'
    WHEN Industry_sector = 'Electricity, gas, steam and air conditioning supply' THEN 'Energy Supply'
    WHEN Industry_sector = 'Financial and insurance activities' THEN 'Finance & Insurance'
    WHEN Industry_sector = 'Human health and social work activities' THEN 'Healthcare & Social Services'
    WHEN Industry_sector = 'Information and communication' THEN 'IT & Media'
    WHEN Industry_sector = 'Mining and quarrying' THEN 'Resources & Mining'
    WHEN Industry_sector = 'Other service activities' THEN 'Other Services'
    WHEN Industry_sector = 'Professional, scientific and technical activities' THEN 'Scientific & Technical Work'
    WHEN Industry_sector = 'Public administration and defence; compulsory social security' THEN 'Government & Defence'
    WHEN Industry_sector = 'Real estate activities' THEN 'Real Estate'
    WHEN Industry_sector = 'Transportation and storage' THEN 'Logistics & Transport'
    WHEN Industry_sector = 'Water supply; sewerage, waste management and remediation activities' THEN 'Environmental Services'
    WHEN Industry_sector = 'Wholesale and retail trade; repair of motor vehicles and motorcycles' THEN 'Retail & Automotive'
    ELSE Industry_sector 
END;


COMMIT

ALTER TABLE [income_edu_final] 
ADD CONSTRAINT [FK_FK_Industry_income_edu_final]
FOREIGN KEY ([Industry_sector]) REFERENCES [Dim_Industry_sector] ([Industry_sector])

ALTER TABLE income_age_final
DROP CONSTRAINT FK_Edu_field_income_age_final

ALTER TABLE income_edu_final
DROP CONSTRAINT FK_Edu_field_income_edu_final
COMMIT
drop

Begin TRAN

UPDATE Dim_Edu_field
SET Edu_field = CASE
    WHEN Edu_field = 'Zdravotní a sociální péče, péče o příznivé životní podmínky' THEN 'Health and Welfare, Enviromental Protection'
    WHEN Edu_field = 'Technika, výroba a stavebnictví' THEN 'Engineering, Production and Construction'
    WHEN Edu_field = 'Obchod, administrativa a právo' THEN 'Business, Administration and Law'
    WHEN Edu_field = 'Vzdělávání a výchova' THEN 'Education'
    WHEN Edu_field = 'Služby' THEN 'Services'
    WHEN Edu_field = 'Přírodní vědy, matematika a statistika' THEN 'Natural Sciences, Mathematics and Statistics'
    WHEN Edu_field = 'Umění a humanitní vědy' THEN 'Arts and liberal arts'
    WHEN Edu_field = 'Informační a komunikační technologie' THEN 'Information technologies'
    WHEN Edu_field = 'Zemědělství, lesnictví, rybářství a veterinářství' THEN 'Agriculture, Forestry, Fisheries and Veterinary'
    ELSE Edu_field
END;


--Tvorba potravinového koše
ALTER TABLE Price_trends_final
ADD Basket_price NUMERIC;

UPDATE Price_trends_final
SET Basket_price =
    Rice_long_grain * 0.5 +
    Flour_plain * 1 +
    Bread_caraway * 1 +
    Pasta_egg * 0.5 +
    Beef_rear * 0.3 +
    Pork_roast * 0.3 +
    Chicken_whole * 1 +
    Ham_pork * 0.2 +
    Milk_semi_skimmed * 4 +
    Butter * 1 +
    Eidam_cheese * 0.2 +
    Eggs * 10 +
    Apples * 1.5 +
    Oranges * 1 +
    Bananas * 1 +
    Onions * 0.5 +
    Potatoes * 2.5 +
    Sugar * 0.25 +
    Coffee_instant_100g * 1 +
    Chocolate * 1 +
    Beer_bottled * 2 +
    Wine_0_2l * 5;

    select * from Price_trends_final
UPDATE Price_trends_final
SET Basket_price = (
    (
        Rice_long_grain * 0.5 +
        Flour_plain * 1 +
        Bread_caraway * 1 +
        Pasta_egg * 0.5 +
        Beef_rear * 0.3 +
        Pork_roast * 0.3 +
        Chicken_whole * 1 +
        Ham_pork * 0.2 +
        Milk_semi_skimmed * 4 +
        Butter * 1 +
        Eidam_cheese * 0.2 +
        Eggs * 10 +
        Apples * 1.5 +
        Oranges * 1 +
        Bananas * 1 +
        Onions * 0.5 +
        Potatoes * 2.5 +
        Sugar * 0.25 +
        Coffee_instant_100g * 1 +
        Chocolate * 1 +
        Beer_bottled * 2 +
        Wine_0_2l * 5
    ) * 4
);

ALTER TABLE income_age_final_all
ADD Basket_percent NUMERIC;

UPDATE i
SET i.Basket_percent = 100.0 * p.Basket_price / i.Value_czk
FROM income_age_final_all i
JOIN Price_trends_final p ON i.Year = p.Year;

select * from income_age_final_all where country like N'Czechia' and [Year] = 2022

ALTER TABLE pension_paid_final
ADD Basket_percent NUMERIC;

UPDATE p
SET p.Basket_percent = 100.0 * pf.Basket_price / p.Pension_paid
FROM pension_paid_final p
JOIN Price_trends_final pf ON p.Year = pf.Year;

select * from Pension_paid_final
drop table Year_Fun_Facts_final

--Vytvoření tabulky pro Fun facts

CREATE TABLE Year_Fun_Facts (
    Year INT PRIMARY KEY,
    Fun_Fact NVARCHAR(255)
);

INSERT INTO Year_Fun_Facts (Year, Fun_Fact) VALUES
(2000, N'Lidé se báli, že počítače zkolabují kvůli Y2K, ale místo toho přišlo The Sims a Nokia 3310.'),
(2001, N'První film Shrek ukázal, že i zlobři mají city, a že „All Star“ od Smash Mouth nikdy nezmizí z hlavy.'),
(2002, N'Všichni jsme si mysleli, že mít Tamagotchi je vrchol dospělosti.'),
(2003, N'„Nejspíš bude zítra pršet“ – začal fenomén předpovědi počasí na Seznamu a všichni jsme si zakládali blogy na Lidé.cz.'),
(2004, N'Vznikl Facebook - konečně jsme mohli šmírovat spolužáky a ICQ statusy byly důležitější než domácí úkoly.'),
(2005, N'YouTube startuje a první video je o slonech v zoo – podstata internetu se tím zásedně mění.'),
(2006, N'Každý měl na mobilu vyzvánění Crazy Frog a všichni jsme si posílali „řetězové e-maily“ pro štěstí.'),
(2007, N'První iPhone – a najednou jsme mohli předstírat, že máme spoustu práce, když jsme koukali do mobilu.'),
(2008, N'Všichni jsme tančili na „Single Ladies“ od Beyoncé, i když jsme nevěděli, co s rukama.'),
(2009, N'FarmVille na Facebooku – místo práce jsme sklízeli digitální mrkev a posílali si krávy.'),
(2010, N'Vzniká Instagram a všichni fotíme jídlo, kafe a nohy na pláži.'),
(2011, N'„Planking“ – ležet jako prkno na nejdivnějších místech byl sport roku.'),
(2012, N'Gangnam Style – celý svět tančil jako by jel na neviditelném koni.'),
(2013, N'„Selfie“ se stalo slovem roku a všichni jsme se snažili najít svůj nejlepší úhel.'),
(2014, N'Ice Bucket Challenge – polovina internetu se polila ledovou vodou, druhá polovina to natáčela.'),
(2015, N'„Ty šaty jsou modré a černé! Ne, jsou bílé a zlaté!“ – internet se hádal o barvě šatů.'),
(2016, N'Pokémon GO – lidé vylézali z domů a naráželi do lamp při chytání Pikachu.'),
(2017, N'Fidget spinnery – hračka, která měla pomáhat s pozorností, ale nakonec rozptýlila úplně všechny.'),
(2018, N'„Laurel nebo Yanny?“ – další internetová hádka, tentokrát o to, co vlastně slyšíme.'),
(2019, N'Baby Yoda (Grogu) ovládl internet a stal se nejroztomilejším memem roku.'),
(2020, N'Všichni jsme pekli banánový chléb, kváskovali, nosili tepláky a objevili Zoom meetingy (a jejich „mute“ tlačítko).'),
(2021, N'„Squid Game“ – všichni jsme se báli dětských her a zelených tepláků.'),
(2022, N'Lidé se naučili, že „home office“ znamená pracovat odkudkoliv – včetně postele, gauče nebo pláže (to se ale nesměl dozvědět šéf).'),
(2023, N'ChatGPT napsal tolik seminárek, že by mohl dostat vlastní diplom, a ještě stíhá odpovídat na všechny zprávy.'),
(2024, N'Češi po 14 letech slavili zlato z domácího mistrovství světa v hokeji a v ulicích se pilo, objímalo a zpívalo, jako by máslo zase stálo dvacku');
