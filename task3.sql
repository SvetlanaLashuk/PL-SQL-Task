﻿CREATE OR REPLACE TYPE abon_type AS OBJECT(
    MSISDN NUMBER,
    PAN NUMBER,
    EXPIRE_DATE DATE
);

CREATE OR REPLACE TYPE abon_data AS TABLE OF abon_type;

CREATE OR REPLACE FUNCTION CardAbonData
(MSISDN_IN NUMBER)
RETURN abon_data
IS
table_param abon_data;
BEGIN
SELECT CAST( 
MULTISET(SELECT ABONENT.MSISDN, CARD.PAN, CARD.EXPIRE_DATE 
FROM CARD 
INNER JOIN ABONENT
ON CARD.ID_ABON=ABONENT.ID_ABON 
WHERE ABONENT.MSISDN=MSISDN_IN) 
AS abon_data)
INTO table_param
FROM DUAL;
RETURN table_param;
END CardAbonData;