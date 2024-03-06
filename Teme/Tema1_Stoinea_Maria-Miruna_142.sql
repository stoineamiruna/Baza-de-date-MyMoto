--Exercitiul 1

SELECT
    M.DENUMIRE
FROM STOC S
JOIN MAGAZIN M ON S.COD_MAGAZIN=M.ID_MAGAZIN
WHERE S.CANTITATE>0 AND S.COD_PRODUS=(
    SELECT
        P.ID_PRODUS
    FROM PRODUS P
    WHERE UPPER(P.DENUMIRE) LIKE 'NEXUS 7'
    ) AND  S.PRET<= ALL(
    SELECT
        S2.PRET
    FROM STOC S2
    WHERE S2.COD_PRODUS=(
    SELECT
        P2.ID_PRODUS
    FROM PRODUS P2
    WHERE UPPER(P2.DENUMIRE) LIKE 'NEXUS 7'
    )
    );

--Exercitiul 2

SELECT
    C.DENUMIRE, P.DENUMIRE
FROM PRODUS P
JOIN CATEGORIE C ON C.ID_CATEGORIE=P.COD_CATEGORIE
JOIN PRODUCATOR PR ON PR.ID_PRODUCATOR=P.COD_PRODUCATOR
WHERE PR.SERVICE IS NOT NULL;

--Exercitiul 3

SELECT DISTINCT
    PR.NUME
FROM PRODUCATOR PR
JOIN PRODUS P ON P.COD_PRODUCATOR=PR.ID_PRODUCATOR
JOIN STOC S ON S.COD_PRODUS=P.ID_PRODUS
JOIN MAGAZIN M ON M.ID_MAGAZIN=S.COD_MAGAZIN
WHERE UPPER(M.ORAS) = 'BUCURESTI' AND PR.NUME NOT IN(
    SELECT
        PR1.NUME
    FROM PRODUCATOR PR1
    JOIN PRODUS P1 ON P1.COD_PRODUCATOR=PR1.ID_PRODUCATOR
    JOIN STOC S1 ON S1.COD_PRODUS=P1.ID_PRODUS
    JOIN MAGAZIN M1 ON M1.ID_MAGAZIN=S1.COD_MAGAZIN
    WHERE UPPER(M1.ORAS) ='IASI');


--Exercitiul 4

SELECT DISTINCT
    M.DENUMIRE,P.DENUMIRE, S.CANTITATE
FROM STOC S
JOIN MAGAZIN M ON M.ID_MAGAZIN=S.COD_MAGAZIN
JOIN PRODUS P ON P.ID_PRODUS=S.COD_PRODUS
WHERE S.CANTITATE>=ALL(
    SELECT
        S1.CANTITATE
    FROM STOC S1
    WHERE S1.COD_MAGAZIN=M.ID_MAGAZIN
    );