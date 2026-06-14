-- Türkiye Tütün Ticaret Analizi 2021-2025

-------------------------------------------------------------------------------
-- Yıllara ve ticaret türüne göre toplam değer ve miktar
-------------------------------------------------------------------------------
SELECT
    YIL,
    TICARET_TURU,
    ROUND(SUM(DEGER_MILYON), 2) AS Toplam_Deger_Milyon,
    ROUND(SUM(MIKTAR_TON), 2) AS Toplam_Miktar_Ton
FROM tutun_ticaret
GROUP BY YIL, TICARET_TURU
ORDER BY YIL;


-------------------------------------------------------------------------------
-- Yıllık ticaret dengesi
-------------------------------------------------------------------------------
SELECT
    I.YIL,
    ROUND(I.Toplam_Ithalat, 2) AS Ithalat,
    ROUND(E.Toplam_Ihracat, 2) AS Ihracat,
    ROUND(I.Toplam_Ithalat - E.Toplam_Ihracat, 2) AS Ticaret_Dengesi
FROM (
    SELECT YIL, SUM(DEGER_MILYON) AS Toplam_Ithalat
    FROM tutun_ticaret
    WHERE TICARET_TURU = 'Ithalat'
    GROUP BY YIL
) I
JOIN (
    SELECT YIL, SUM(DEGER_MILYON) AS Toplam_Ihracat
    FROM tutun_ticaret
    WHERE TICARET_TURU = 'Ihracat'
    GROUP BY YIL
) E ON I.YIL = E.YIL
ORDER BY I.YIL;


-------------------------------------------------------------------------------
-- Ürün gruplarına göre dağılım
-------------------------------------------------------------------------------
SELECT
    URUN_GRUBU,
    TICARET_TURU,
    ROUND(SUM(DEGER_MILYON), 2) AS Toplam_Deger,
    ROUND(SUM(MIKTAR_TON), 2) AS Toplam_Miktar
FROM tutun_ticaret
GROUP BY URUN_GRUBU, TICARET_TURU
ORDER BY Toplam_Deger DESC;