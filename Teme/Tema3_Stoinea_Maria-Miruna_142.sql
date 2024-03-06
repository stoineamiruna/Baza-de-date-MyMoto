--1
SELECT
    *
FROM CUSTOMERS C
WHERE C.CUSTOMER_ID IN(
    SELECT
        C1.CUSTOMER_ID
    FROM ORDERS O1
    JOIN EVENTS E1 ON E1.EVENT_ID=O1.EVENT_ID
    JOIN CUSTOMERS C1 ON C1.CUSTOMER_ID=O1.CUSTOMER_ID
    WHERE TO_CHAR(E1.EVENT_DATE) LIKE '%-DEC-21'
    );

--2

SELECT
    P.TITLE, COUNT(PA.ACTOR_ID)
FROM PLAYS_ACTORS PA
JOIN PLAYS P ON PA.PLAY_ID=P.PLAY_ID
WHERE UPPER(P.GENRE)='DRAMA' AND 0<(
    SELECT
        COUNT(PA1.ACTOR_ID)
    FROM PLAYS_ACTORS PA1
    JOIN ACTORS A1 ON A1.ACTOR_ID=PA1.ACTOR_ID
    WHERE PA1.PLAY_ID=PA.PLAY_ID AND UPPER(A1.PLACE_OF_BIRTH)<>'BUCURESTI'
    )
GROUP BY PA.PLAY_ID,P.TITLE;

--3
SELECT 
    P.PLAY_ID,P.TITLE, 
    (
     SELECT
        NVL(SUM(SUM(O1.NUM_SEATS))/NVL(COUNT(O1.EVENT_ID),0),0)
     FROM ORDERS O1
     JOIN EVENTS E1 ON E1.EVENT_ID=O1.EVENT_ID
     WHERE E1.PLAY_ID=P.PLAY_ID
     GROUP BY O1.EVENT_ID
        ) NR_SPECTATORI
FROM PLAYS P;

--4
SELECT
    P.TITLE, 
    (
    SELECT
        COUNT(PA.ACTOR_ID)
    FROM PLAYS_ACTORS PA
    WHERE PA.PLAY_ID=E.PLAY_ID
    ) NR_ACTORI
    ,COUNT(E.EVENT_ID) NR_EVENIMENTE
FROM EVENTS E
JOIN PLAYS P ON P.PLAY_ID=E.PLAY_ID
WHERE E.PLAY_ID IN (
    SELECT
        E1.PLAY_ID
    FROM EVENTS E1
    WHERE TO_CHAR(E1.EVENT_DATE,'YY')=21
    GROUP BY E1.PLAY_ID
    HAVING COUNT(E1.EVENT_ID)=(
        SELECT
            MAX(COUNT(E2.EVENT_ID))
        FROM EVENTS E2
        WHERE TO_CHAR(E2.EVENT_DATE,'YY')=21
        GROUP BY E2.PLAY_ID
        )
    )
GROUP BY E.PLAY_ID,P.TITLE;


