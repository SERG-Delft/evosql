
-----------------------------------
Query: espocrm-process0, query 2
Path 5/5 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        COUNT("ROLE"."ID") AS "AGGREGATEVALUE" 
    FROM
        "ROLE" 
    WHERE
        "ROLE"."ID" = '589dd9e072d8768c3' 
        AND "ROLE"."DELETED" = '0' 
    HAVING
        COUNT("ROLE"."ID") > COUNT(DISTINCT "ROLE"."ID") 
        AND COUNT(DISTINCT "ROLE"."ID") > 1
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 1/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 12.487850963282352 | Has no output, distance is 1.3888888888888888 | Has no output, distance is 1.25 | Has no output, distance is 159.6220427163198 | Has no output, distance is 3.0171870072532325 | Has no output, distance is 0.5 | Has no output, distance is 1.0 | Has no output, distance is 54.780292955126704 | Has no output, distance is 208.54603124420572

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            "USER"."ID" = '589dd906b0d0d1105'
        ) 
        AND (
            "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 3/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 11.6919276517742 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 21.010963092826987 | Has no output, distance is 31.371921942239155 | Has no output, distance is 0.5 | Has no output, distance is 15.796877499171039 | Has no output, distance is 8.228096140184704 | Has no output, distance is 7.904623310269414 | Has no output, distance is 16.0

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        NOT ("USER"."DELETED" = '0') 
        AND (
            "USER"."ID" = '589dd906b0d0d1105'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 4/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 28.834743999928723 | Has no output, distance is 0.5 | Has no output, distance is 3.7839204174820615 | Has no output, distance is 15.5 | Has no output, distance is 6.249296324520486 | Has no output, distance is 28.828797456775334 | Has no output, distance is 1.0 | Has no output, distance is 30.927734032384713 | Has no output, distance is 30.61685591221672

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            "USER"."DELETED" IS NULL
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 5/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 7.621770121770123 | Has no output, distance is 32.0 | Has no output, distance is 30.196169610254117 | Has no output, distance is 24.736009861330373 | Has no output, distance is 4.904761904761905 | Has no output, distance is 32.0 | Has no output, distance is 2.0 | Has no output, distance is 28.83157253124022 | Has no output, distance is 55.22209754212473 | Has no output, distance is 319.62845349246555

    SELECT
        * 
    FROM
        "USER" 
    LEFT JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "CONTACT"."ID" IS NULL
            ) 
            AND (
                "USER"."CONTACT_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 6/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.4375 | Has no output, distance is 30.834273182957393 | Has no output, distance is 8.24490843096001 | Has no output, distance is 32.0 | Has no output, distance is 62.296100646487545 | Has no output, distance is 13.325841954655514 | Has no output, distance is 32.0 | Has no output, distance is 28.118271227268078 | Has no output, distance is 5.927383367139959 | Has no output, distance is 25.743766414173365

    SELECT
        * 
    FROM
        "USER" 
    LEFT JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "CONTACT"."ID" IS NULL
            ) 
            AND (
                "USER"."CONTACT_ID" IS NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 8/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 2.0 | Has no output, distance is 7.822564102564103 | Has no output, distance is 1213.0383838383837 | Has no output, distance is 55.5516005272374 | Has no output, distance is 20.368180135303426 | Has no output, distance is 96.80420528471058 | Has no output, distance is 649.0625 | Has no output, distance is 59.0727186227979 | Has no output, distance is 4.933083645443196 | Has no output, distance is 25.56954849537081

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    LEFT JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "DEFAULTTEAM"."ID" IS NULL
            ) 
            AND (
                "USER"."DEFAULT_TEAM_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 11/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 112.33874052634224 | Has no output, distance is 27.107342889103997 | Has no output, distance is 10.12603263604102 | Has no output, distance is 2.0 | Has no output, distance is 32.0 | Has no output, distance is 32.96008500415781 | Has no output, distance is 16.839285714285715 | Has no output, distance is 11.800514086633422 | Has no output, distance is 9.864824350438385 | Has no output, distance is 10.48309663046505

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    LEFT JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "AVATAR"."ID" IS NULL
            ) 
            AND (
                "USER"."AVATAR_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 12/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 34.89238206903705 | Has no output, distance is 24.097160023884157 | Has no output, distance is 29.80106548944603 | Has no output, distance is 46.57774828537228 | Has no output, distance is 12.813338859164631 | Has no output, distance is 53.181168888883654 | Has no output, distance is 97.0 | Has no output, distance is 168.25870646766168 | Has no output, distance is 29.33084326522503 | Has no output, distance is 63.66395770655406

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    LEFT JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "AVATAR"."ID" IS NULL
            ) 
            AND (
                "USER"."AVATAR_ID" IS NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 14/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 10.820158102766799 | Has no output, distance is 29.17659060992133 | Has no output, distance is 4.8878648233486945 | Has no output, distance is 13.378068879290344 | Has no output, distance is 12.57075127814693 | Has no output, distance is 30.97686787799068 | Has no output, distance is 14.167742006421252 | Has no output, distance is 14.895536996638835 | Has no output, distance is 288.0 | Has no output, distance is 13.301416077491751

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    LEFT JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "EMAILADDRESSESMIDDLE"."ENTITY_ID" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."DELETED" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."PRIMARY" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" IS NULL
            ) 
            AND (
                "USER"."ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 17/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 289.0 | Has no output, distance is 1021.8151616360518 | Has no output, distance is 83.96666666666667 | Has no output, distance is 16.0 | Has no output, distance is 83.77435897435896 | Has no output, distance is 289.0 | Has no output, distance is 289.0 | Has no output, distance is 539.1887571365831 | Has no output, distance is 67.2 | Has no output, distance is 9.68733403522057

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "EMAILADDRESSES"."ID" IS NULL
            ) 
            AND (
                "EMAILADDRESSES"."DELETED" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 18/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 84.16666666666666 | Has no output, distance is 1021.8151616360518 | Has no output, distance is 2.8194444444444446 | Has no output, distance is 289.0 | Has no output, distance is 252.9023319601925 | Has no output, distance is 289.0 | Has no output, distance is 0.5 | Has no output, distance is 289.0 | Has no output, distance is 267.72549019607845 | Has no output, distance is 289.0

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "EMAILADDRESSES"."ID" IS NULL
            ) 
            AND (
                "EMAILADDRESSES"."DELETED" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" IS NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 21/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 289.0 | Has no output, distance is 1.4 | Has no output, distance is 1021.8151616360518 | Has no output, distance is 1.1666666666666665 | Has no output, distance is 289.0 | Has no output, distance is 289.0 | Has no output, distance is 7.5909162914761446 | Has no output, distance is 289.0 | Has no output, distance is 16.0 | Has no output, distance is 1964.841126194067

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    LEFT JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERSMIDDLE"."ENTITY_ID" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PRIMARY" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."ENTITY_TYPE" IS NULL
            ) 
            AND (
                "USER"."ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 24/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.6666666666666665 | Has no output, distance is 0.5 | Has no output, distance is 3.204584040747029 | Has no output, distance is 289.0 | Has no output, distance is 1.0 | Has no output, distance is 3.1016666666666666 | Has no output, distance is 84.16666666666666 | Has no output, distance is 7.124420828498172 | Has no output, distance is 289.0 | Has no output, distance is 2.583333333333333

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERS"."ID" IS NULL
            ) 
            AND (
                "PHONENUMBERS"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 25/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 5.531666666666666 | Has no output, distance is 290.0 | Has no output, distance is 84.16666666666666 | Has no output, distance is 1.0 | Has no output, distance is 0.5 | Has no output, distance is 85.16666666666666 | Has no output, distance is 84.85416666666669 | Has no output, distance is 0.5 | Has no output, distance is 289.0

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERS"."ID" IS NULL
            ) 
            AND (
                "PHONENUMBERS"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" IS NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 28/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 289.0 | Has no output, distance is 67.2 | Has no output, distance is 289.0 | Has no output, distance is 8.847082483845716 | Has no output, distance is 2.9679260133805587 | Has no output, distance is 3.6207386363636362 | Has no output, distance is 289.0 | Has no output, distance is 0.5 | Has no output, distance is 1.8 | Has no output, distance is 289.0

    SELECT
        * 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    LEFT JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        (
            (
                "PORTAL_USER"."USER_ID" IS NULL
            ) 
            AND (
                "PORTAL_USER"."PORTAL_ID" IS NULL
            ) 
            AND (
                "PORTAL_USER"."DELETED" IS NULL
            ) 
            AND (
                "USER"."ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = '589dd906b0d0d1105' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 11
Path 31/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 3.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        COUNT("USER"."ID") AS "AGGREGATEVALUE" 
    FROM
        "USER" 
    LEFT JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    LEFT JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    LEFT JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    LEFT JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    LEFT JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    INNER JOIN
        "PORTAL_USER" 
            ON "USER"."ID" = "PORTAL_USER"."USER_ID" 
            AND "PORTAL_USER"."PORTAL_ID" = 'testPortalId' 
            AND "PORTAL_USER"."DELETED" = '0' 
    WHERE
        "USER"."ID" = '589dd906b0d0d1105' 
        AND "USER"."DELETED" = '0' 
    HAVING
        COUNT("USER"."ID") > COUNT(DISTINCT "USER"."ID") 
        AND COUNT(DISTINCT "USER"."ID") > 1
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 3/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 16.0 | Has no output, distance is 1.0 | Has no output, distance is 5.095982676224612 | Has no output, distance is 0.5 | Has no output, distance is 17.656199677938808 | Has no output, distance is 1.467741935483871 | Has no output, distance is 3.965433854907539 | Has no output, distance is 3.136100386100386 | Has no output, distance is 7.825094334350519 | Has no output, distance is 5.061730029298598

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            "USER"."USER_NAME" IS NULL
        ) 
        AND (
            "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/'
        ) 
        AND (
            "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 8/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 3.9555555555555557 | Has no output, distance is 1.0 | Has no output, distance is 7.0 | Has no output, distance is 32.0 | Has no output, distance is 7.021329048747421 | Has no output, distance is 2.0 | Has no output, distance is 21.870905735437304 | Has no output, distance is 2.4615384615384617 | Has no output, distance is 7.4424561403508775 | Has no output, distance is 35.9624584717608

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    LEFT JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "CONTACT"."ID" IS NULL
            ) 
            AND (
                "USER"."CONTACT_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 9/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 9.577238550922763 | Has no output, distance is 1.6666666666666665 | Has no output, distance is 0.5 | Has no output, distance is 2.9130434782608696 | Has no output, distance is 51.953372012195544 | Has no output, distance is 399.0090043976387 | Has no output, distance is 5.976470588235294 | Has no output, distance is 1.0 | Has no output, distance is 32.0 | Has no output, distance is 53.41071737414118

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    LEFT JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "CONTACT"."ID" IS NULL
            ) 
            AND (
                "USER"."CONTACT_ID" IS NULL
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 11/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 7.938927738927738 | Has no output, distance is 3.738095238095238 | Has no output, distance is 55.35743795821095 | Has no output, distance is 3.0 | Has no output, distance is 450.57617398614997 | Has no output, distance is 1.46 | Has no output, distance is 25.0 | Has no output, distance is 5.37145613007682 | Has no output, distance is 79.8453886728503 | Has no output, distance is 6.437315952021835

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    LEFT JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "DEFAULTTEAM"."ID" IS NULL
            ) 
            AND (
                "USER"."DEFAULT_TEAM_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 15/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 85.40631693748757 | Has no output, distance is 83.02274083614071 | Has no output, distance is 2.0 | Has no output, distance is 775.5090708651751 | Has no output, distance is 81.11960955013917 | Has no output, distance is 158.73567390934042 | Has no output, distance is 83.65722493516769 | Has no output, distance is 25.0 | Has no output, distance is 81.72502195662763

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    LEFT JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "AVATAR"."ID" IS NULL
            ) 
            AND (
                "USER"."AVATAR_ID" IS NULL
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 17/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 82.20337036657139 | Has no output, distance is 106.07047710320676 | Has no output, distance is 86.57428752856637 | Has no output, distance is 107.49819283942998 | Has no output, distance is 104.32033645758231 | Has no output, distance is 32.0 | Has no output, distance is 25.0 | Has no output, distance is 85.7461003276118 | Has no output, distance is 18.569805256192097 | Has no output, distance is 25.0

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    LEFT JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "EMAILADDRESSESMIDDLE"."ENTITY_ID" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."DELETED" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."PRIMARY" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" IS NULL
            ) 
            AND (
                "USER"."ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 20/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 1.0 | Has no output, distance is 25.0 | Has no output, distance is 168.3219596791481 | Has no output, distance is 85.43275388744178 | Has no output, distance is 4.629738336780591 | Has no output, distance is 3155.5316951475497 | Has no output, distance is 82.50162777496753 | Has no output, distance is 3.4366020601789105 | Has no output, distance is 106.9691586509029

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "EMAILADDRESSES"."ID" IS NULL
            ) 
            AND (
                "EMAILADDRESSES"."DELETED" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 27/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.1666666666666665 | Has no output, distance is 1.4473684210526314 | Has no output, distance is 1.0 | Has no output, distance is 261.52519490812665 | Has no output, distance is 3.455958581620594 | Has no output, distance is 54.757763975155285 | Has no output, distance is 6.066738816738816 | Has no output, distance is 250.45940400923627 | Has no output, distance is 85.35844139484965 | Has no output, distance is 430.5657792146701

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERS"."ID" IS NULL
            ) 
            AND (
                "PHONENUMBERS"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 28/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 3.2296969696969695 | Has no output, distance is 102.35364593712718 | Has no output, distance is 9.0 | Has no output, distance is 2.8382749326145555 | Has no output, distance is 1.0 | Has no output, distance is 83.44610653001334 | Has no output, distance is 191.85103115166686 | Has no output, distance is 4.601190476190476 | Has no output, distance is 359.6860949395658 | Has no output, distance is 1.4629629629629628

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERS"."ID" IS NULL
            ) 
            AND (
                "PHONENUMBERS"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" IS NULL
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 31/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 7.9168373905255205 | Has no output, distance is 36.0 | Has no output, distance is 2.953846153846154 | Has no output, distance is 16.0 | Has no output, distance is 4.0 | Has no output, distance is 47.166860256195584 | Has no output, distance is 0.5 | Has no output, distance is 17.97827325067133 | Has no output, distance is 2.75 | Has no output, distance is 1.0

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                (
                    "USER"."FIRST_NAME" IS NOT NULL
                )
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process0, query 13
Path 33/34 - 0 successes, 10 failures
Failure messages: Has no output, distance is 2.0 | Has no output, distance is 13.016961312813002 | Has no output, distance is 1.9795918367346939 | Has no output, distance is 5.071447558289663 | Has no output, distance is 1.4411764705882353 | Has no output, distance is 12.235545875709352 | Has no output, distance is 4.0 | Has no output, distance is 10.405490210778533 | Has no output, distance is 4.730952380952381 | Has no output, distance is 1.9833333333333334

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                (
                    "USER"."LAST_NAME" IS NOT NULL
                )
            )
        ) 
        AND (
            "USER"."USER_NAME" = 'admin' 
            AND "USER"."PASSWORD" = 'LHVP/3TpyWLV8pGmARkuo8wpX.5Jl3HCJylZt372.xnBg09jBKPDlB5xz8QcgjbIJ4rQXDt/f7028bAmtEhpY/' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 2
Path 5/5 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        COUNT("PHONE_NUMBER"."ID") AS "AGGREGATEVALUE" 
    FROM
        "PHONE_NUMBER" 
    WHERE
        "PHONE_NUMBER"."ID" = '589dd55bbbd9af02f' 
        AND "PHONE_NUMBER"."DELETED" = '0' 
    HAVING
        COUNT("PHONE_NUMBER"."ID") > COUNT(DISTINCT "PHONE_NUMBER"."ID") 
        AND COUNT(DISTINCT "PHONE_NUMBER"."ID") > 1
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 10
Path 17/27 - 0 successes, 10 failures
Failure messages: Has no output, distance is 169.0 | Has no output, distance is 51.0 | Has no output, distance is 169.0 | Has no output, distance is 169.0 | Has no output, distance is 169.0 | Has no output, distance is 64.09203980099502 | Has no output, distance is 63.65350877192982 | Has no output, distance is 3.848888888888889 | Has no output, distance is 51.0 | Has no output, distance is 169.0

    SELECT
        "ACCOUNT"."ID" AS "ID",
        "ACCOUNT"."NAME" AS "NAME",
        "ACCOUNT"."DELETED" AS "DELETED",
        "ACCOUNT"."WEBSITE" AS "WEBSITE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "ACCOUNT"."TYPE" AS "TYPE",
        "ACCOUNT"."INDUSTRY" AS "INDUSTRY",
        "ACCOUNT"."SIC_CODE" AS "SICCODE",
        "ACCOUNT"."BILLING_ADDRESS_STREET" AS "BILLINGADDRESSSTREET",
        "ACCOUNT"."BILLING_ADDRESS_CITY" AS "BILLINGADDRESSCITY",
        "ACCOUNT"."BILLING_ADDRESS_STATE" AS "BILLINGADDRESSSTATE",
        "ACCOUNT"."BILLING_ADDRESS_COUNTRY" AS "BILLINGADDRESSCOUNTRY",
        "ACCOUNT"."BILLING_ADDRESS_POSTAL_CODE" AS "BILLINGADDRESSPOSTALCODE",
        "ACCOUNT"."SHIPPING_ADDRESS_STREET" AS "SHIPPINGADDRESSSTREET",
        "ACCOUNT"."SHIPPING_ADDRESS_CITY" AS "SHIPPINGADDRESSCITY",
        "ACCOUNT"."SHIPPING_ADDRESS_STATE" AS "SHIPPINGADDRESSSTATE",
        "ACCOUNT"."SHIPPING_ADDRESS_COUNTRY" AS "SHIPPINGADDRESSCOUNTRY",
        "ACCOUNT"."SHIPPING_ADDRESS_POSTAL_CODE" AS "SHIPPINGADDRESSPOSTALCODE",
        "ACCOUNT"."DESCRIPTION" AS "DESCRIPTION",
        "ACCOUNT"."CREATED_AT" AS "CREATEDAT",
        "ACCOUNT"."MODIFIED_AT" AS "MODIFIEDAT",
        "ACCOUNT"."CAMPAIGN_ID" AS "CAMPAIGNID",
        "ACCOUNT"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "ACCOUNT"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "ACCOUNT"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME" 
    FROM
        "ACCOUNT" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "ACCOUNT"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "ACCOUNT"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "ACCOUNT"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "ACCOUNT"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'Account' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "ACCOUNT"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'Account' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "EMAILADDRESSES"."ID" IS NULL
            ) 
            AND (
                "EMAILADDRESSES"."DELETED" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" IS NOT NULL
            )
        ) 
        AND (
            "ACCOUNT"."ID" = '53203b942850b' 
            AND "ACCOUNT"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 10
Path 18/27 - 0 successes, 10 failures
Failure messages: Has no output, distance is 63.109391124870996 | Has no output, distance is 51.2 | Has no output, distance is 169.0 | Has no output, distance is 193.79464285714286 | Has no output, distance is 63.65350877192982 | Has no output, distance is 169.0 | Has no output, distance is 169.0 | Has no output, distance is 153.10234371705053 | Has no output, distance is 0.5 | Has no output, distance is 63.65350877192982

    SELECT
        "ACCOUNT"."ID" AS "ID",
        "ACCOUNT"."NAME" AS "NAME",
        "ACCOUNT"."DELETED" AS "DELETED",
        "ACCOUNT"."WEBSITE" AS "WEBSITE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "ACCOUNT"."TYPE" AS "TYPE",
        "ACCOUNT"."INDUSTRY" AS "INDUSTRY",
        "ACCOUNT"."SIC_CODE" AS "SICCODE",
        "ACCOUNT"."BILLING_ADDRESS_STREET" AS "BILLINGADDRESSSTREET",
        "ACCOUNT"."BILLING_ADDRESS_CITY" AS "BILLINGADDRESSCITY",
        "ACCOUNT"."BILLING_ADDRESS_STATE" AS "BILLINGADDRESSSTATE",
        "ACCOUNT"."BILLING_ADDRESS_COUNTRY" AS "BILLINGADDRESSCOUNTRY",
        "ACCOUNT"."BILLING_ADDRESS_POSTAL_CODE" AS "BILLINGADDRESSPOSTALCODE",
        "ACCOUNT"."SHIPPING_ADDRESS_STREET" AS "SHIPPINGADDRESSSTREET",
        "ACCOUNT"."SHIPPING_ADDRESS_CITY" AS "SHIPPINGADDRESSCITY",
        "ACCOUNT"."SHIPPING_ADDRESS_STATE" AS "SHIPPINGADDRESSSTATE",
        "ACCOUNT"."SHIPPING_ADDRESS_COUNTRY" AS "SHIPPINGADDRESSCOUNTRY",
        "ACCOUNT"."SHIPPING_ADDRESS_POSTAL_CODE" AS "SHIPPINGADDRESSPOSTALCODE",
        "ACCOUNT"."DESCRIPTION" AS "DESCRIPTION",
        "ACCOUNT"."CREATED_AT" AS "CREATEDAT",
        "ACCOUNT"."MODIFIED_AT" AS "MODIFIEDAT",
        "ACCOUNT"."CAMPAIGN_ID" AS "CAMPAIGNID",
        "ACCOUNT"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "ACCOUNT"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "ACCOUNT"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME" 
    FROM
        "ACCOUNT" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "ACCOUNT"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "ACCOUNT"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "ACCOUNT"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "ACCOUNT"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'Account' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "ACCOUNT"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'Account' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "EMAILADDRESSES"."ID" IS NULL
            ) 
            AND (
                "EMAILADDRESSES"."DELETED" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" IS NULL
            )
        ) 
        AND (
            "ACCOUNT"."ID" = '53203b942850b' 
            AND "ACCOUNT"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 10
Path 21/27 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1725.750834902898 | Has no output, distance is 169.0 | Has no output, distance is 169.0 | Has no output, distance is 63.916666666666664 | Has no output, distance is 169.0 | Has no output, distance is 63.65350877192982 | Has no output, distance is 153.10234371705053 | Has no output, distance is 1.1666666666666665 | Has no output, distance is 4.952381380948952 | Has no output, distance is 64.16666666666667

    SELECT
        "ACCOUNT"."ID" AS "ID",
        "ACCOUNT"."NAME" AS "NAME",
        "ACCOUNT"."DELETED" AS "DELETED",
        "ACCOUNT"."WEBSITE" AS "WEBSITE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "ACCOUNT"."TYPE" AS "TYPE",
        "ACCOUNT"."INDUSTRY" AS "INDUSTRY",
        "ACCOUNT"."SIC_CODE" AS "SICCODE",
        "ACCOUNT"."BILLING_ADDRESS_STREET" AS "BILLINGADDRESSSTREET",
        "ACCOUNT"."BILLING_ADDRESS_CITY" AS "BILLINGADDRESSCITY",
        "ACCOUNT"."BILLING_ADDRESS_STATE" AS "BILLINGADDRESSSTATE",
        "ACCOUNT"."BILLING_ADDRESS_COUNTRY" AS "BILLINGADDRESSCOUNTRY",
        "ACCOUNT"."BILLING_ADDRESS_POSTAL_CODE" AS "BILLINGADDRESSPOSTALCODE",
        "ACCOUNT"."SHIPPING_ADDRESS_STREET" AS "SHIPPINGADDRESSSTREET",
        "ACCOUNT"."SHIPPING_ADDRESS_CITY" AS "SHIPPINGADDRESSCITY",
        "ACCOUNT"."SHIPPING_ADDRESS_STATE" AS "SHIPPINGADDRESSSTATE",
        "ACCOUNT"."SHIPPING_ADDRESS_COUNTRY" AS "SHIPPINGADDRESSCOUNTRY",
        "ACCOUNT"."SHIPPING_ADDRESS_POSTAL_CODE" AS "SHIPPINGADDRESSPOSTALCODE",
        "ACCOUNT"."DESCRIPTION" AS "DESCRIPTION",
        "ACCOUNT"."CREATED_AT" AS "CREATEDAT",
        "ACCOUNT"."MODIFIED_AT" AS "MODIFIEDAT",
        "ACCOUNT"."CAMPAIGN_ID" AS "CAMPAIGNID",
        "ACCOUNT"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "ACCOUNT"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "ACCOUNT"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME" 
    FROM
        "ACCOUNT" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "ACCOUNT"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "ACCOUNT"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "ACCOUNT"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "ACCOUNT"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'Account' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    LEFT JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "ACCOUNT"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'Account' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERSMIDDLE"."ENTITY_ID" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PRIMARY" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."ENTITY_TYPE" IS NULL
            ) 
            AND (
                "ACCOUNT"."ID" IS NOT NULL
            )
        ) 
        AND (
            "ACCOUNT"."ID" = '53203b942850b' 
            AND "ACCOUNT"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 10
Path 24/27 - 0 successes, 10 failures
Failure messages: Has no output, distance is 153.10234371705053 | Has no output, distance is 169.0 | Has no output, distance is 169.0 | Has no output, distance is 1.0 | Has no output, distance is 63.916666666666664 | Has no output, distance is 169.0 | Has no output, distance is 63.916666666666664 | Has no output, distance is 63.916666666666664 | Has no output, distance is 169.0 | Has no output, distance is 153.10234371705053

    SELECT
        "ACCOUNT"."ID" AS "ID",
        "ACCOUNT"."NAME" AS "NAME",
        "ACCOUNT"."DELETED" AS "DELETED",
        "ACCOUNT"."WEBSITE" AS "WEBSITE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "ACCOUNT"."TYPE" AS "TYPE",
        "ACCOUNT"."INDUSTRY" AS "INDUSTRY",
        "ACCOUNT"."SIC_CODE" AS "SICCODE",
        "ACCOUNT"."BILLING_ADDRESS_STREET" AS "BILLINGADDRESSSTREET",
        "ACCOUNT"."BILLING_ADDRESS_CITY" AS "BILLINGADDRESSCITY",
        "ACCOUNT"."BILLING_ADDRESS_STATE" AS "BILLINGADDRESSSTATE",
        "ACCOUNT"."BILLING_ADDRESS_COUNTRY" AS "BILLINGADDRESSCOUNTRY",
        "ACCOUNT"."BILLING_ADDRESS_POSTAL_CODE" AS "BILLINGADDRESSPOSTALCODE",
        "ACCOUNT"."SHIPPING_ADDRESS_STREET" AS "SHIPPINGADDRESSSTREET",
        "ACCOUNT"."SHIPPING_ADDRESS_CITY" AS "SHIPPINGADDRESSCITY",
        "ACCOUNT"."SHIPPING_ADDRESS_STATE" AS "SHIPPINGADDRESSSTATE",
        "ACCOUNT"."SHIPPING_ADDRESS_COUNTRY" AS "SHIPPINGADDRESSCOUNTRY",
        "ACCOUNT"."SHIPPING_ADDRESS_POSTAL_CODE" AS "SHIPPINGADDRESSPOSTALCODE",
        "ACCOUNT"."DESCRIPTION" AS "DESCRIPTION",
        "ACCOUNT"."CREATED_AT" AS "CREATEDAT",
        "ACCOUNT"."MODIFIED_AT" AS "MODIFIEDAT",
        "ACCOUNT"."CAMPAIGN_ID" AS "CAMPAIGNID",
        "ACCOUNT"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "ACCOUNT"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "ACCOUNT"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME" 
    FROM
        "ACCOUNT" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "ACCOUNT"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "ACCOUNT"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "ACCOUNT"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "ACCOUNT"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'Account' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "ACCOUNT"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'Account' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERS"."ID" IS NULL
            ) 
            AND (
                "PHONENUMBERS"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" IS NOT NULL
            )
        ) 
        AND (
            "ACCOUNT"."ID" = '53203b942850b' 
            AND "ACCOUNT"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 10
Path 25/27 - 0 successes, 10 failures
Failure messages: Has no output, distance is 64.16666666666667 | Has no output, distance is 63.916666666666664 | Has no output, distance is 51.0 | Has no output, distance is 14.943776848906047 | Has no output, distance is 63.916666666666664 | Has no output, distance is 1.988888888888889 | Has no output, distance is 169.0 | Has no output, distance is 63.916666666666664 | Has no output, distance is 169.0 | Has no output, distance is 5.4217600452744765

    SELECT
        "ACCOUNT"."ID" AS "ID",
        "ACCOUNT"."NAME" AS "NAME",
        "ACCOUNT"."DELETED" AS "DELETED",
        "ACCOUNT"."WEBSITE" AS "WEBSITE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "ACCOUNT"."TYPE" AS "TYPE",
        "ACCOUNT"."INDUSTRY" AS "INDUSTRY",
        "ACCOUNT"."SIC_CODE" AS "SICCODE",
        "ACCOUNT"."BILLING_ADDRESS_STREET" AS "BILLINGADDRESSSTREET",
        "ACCOUNT"."BILLING_ADDRESS_CITY" AS "BILLINGADDRESSCITY",
        "ACCOUNT"."BILLING_ADDRESS_STATE" AS "BILLINGADDRESSSTATE",
        "ACCOUNT"."BILLING_ADDRESS_COUNTRY" AS "BILLINGADDRESSCOUNTRY",
        "ACCOUNT"."BILLING_ADDRESS_POSTAL_CODE" AS "BILLINGADDRESSPOSTALCODE",
        "ACCOUNT"."SHIPPING_ADDRESS_STREET" AS "SHIPPINGADDRESSSTREET",
        "ACCOUNT"."SHIPPING_ADDRESS_CITY" AS "SHIPPINGADDRESSCITY",
        "ACCOUNT"."SHIPPING_ADDRESS_STATE" AS "SHIPPINGADDRESSSTATE",
        "ACCOUNT"."SHIPPING_ADDRESS_COUNTRY" AS "SHIPPINGADDRESSCOUNTRY",
        "ACCOUNT"."SHIPPING_ADDRESS_POSTAL_CODE" AS "SHIPPINGADDRESSPOSTALCODE",
        "ACCOUNT"."DESCRIPTION" AS "DESCRIPTION",
        "ACCOUNT"."CREATED_AT" AS "CREATEDAT",
        "ACCOUNT"."MODIFIED_AT" AS "MODIFIEDAT",
        "ACCOUNT"."CAMPAIGN_ID" AS "CAMPAIGNID",
        "ACCOUNT"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "ACCOUNT"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "ACCOUNT"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME" 
    FROM
        "ACCOUNT" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "ACCOUNT"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "ACCOUNT"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "ACCOUNT"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "ACCOUNT"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'Account' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "ACCOUNT"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'Account' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERS"."ID" IS NULL
            ) 
            AND (
                "PHONENUMBERS"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" IS NULL
            )
        ) 
        AND (
            "ACCOUNT"."ID" = '53203b942850b' 
            AND "ACCOUNT"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 11
Path 12/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 8.436667781866845 | Has no output, distance is 8.150501672240802 | Has no output, distance is 2.630952380952381 | Has no output, distance is 41.72835627004425 | Has no output, distance is 2.9622641509433962 | Has no output, distance is 1.75 | Has no output, distance is 8.90034965034965 | Has no output, distance is 32.0 | Has no output, distance is 1.9852941176470589 | Has no output, distance is 37.870279146141215

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    LEFT JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "AVATAR"."ID" IS NULL
            ) 
            AND (
                "USER"."AVATAR_ID" IS NULL
            )
        ) 
        AND (
            "USER"."ID" = 'system' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 11
Path 17/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 36.0 | Has no output, distance is 132.55119047619047 | Has no output, distance is 36.0 | Has no output, distance is 3.297619047619048 | Has no output, distance is 36.0 | Has no output, distance is 2.083333333333333 | Has no output, distance is 1.96875 | Has no output, distance is 36.0 | Has no output, distance is 36.0 | Has no output, distance is 36.0

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "EMAILADDRESSES"."ID" IS NULL
            ) 
            AND (
                "EMAILADDRESSES"."DELETED" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = 'system' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 11
Path 18/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.975609756097561 | Has no output, distance is 46.73075583420411 | Has no output, distance is 36.0 | Has no output, distance is 400.2702614379085 | Has no output, distance is 2.960769230769231 | Has no output, distance is 57.07692307692308 | Has no output, distance is 798.3954832881662 | Has no output, distance is 36.0 | Has no output, distance is 401.0147058823529 | Has no output, distance is 36.0

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "EMAILADDRESSES"."ID" IS NULL
            ) 
            AND (
                "EMAILADDRESSES"."DELETED" IS NULL
            ) 
            AND (
                "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" IS NULL
            )
        ) 
        AND (
            "USER"."ID" = 'system' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 11
Path 21/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 36.0 | Has no output, distance is 28.52036701799099 | Has no output, distance is 36.0 | Has no output, distance is 36.0 | Has no output, distance is 36.0 | Has no output, distance is 3.1572327044025155 | Has no output, distance is 36.0 | Has no output, distance is 36.0 | Has no output, distance is 36.0 | Has no output, distance is 0.5

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    LEFT JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERSMIDDLE"."ENTITY_ID" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PRIMARY" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."ENTITY_TYPE" IS NULL
            ) 
            AND (
                "USER"."ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = 'system' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 11
Path 24/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 36.0 | Has no output, distance is 9.239981083785747 | Has no output, distance is 2.4237179487179485 | Has no output, distance is 36.0 | Has no output, distance is 162.74654377880185 | Has no output, distance is 36.0 | Has no output, distance is 36.0 | Has no output, distance is 36.0 | Has no output, distance is 400.2702614379085

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERS"."ID" IS NULL
            ) 
            AND (
                "PHONENUMBERS"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" IS NOT NULL
            )
        ) 
        AND (
            "USER"."ID" = 'system' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 11
Path 25/31 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1202.0488407463106 | Has no output, distance is 36.0 | Has no output, distance is 36.0 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 162.74654377880185 | Has no output, distance is 1.1666666666666665 | Has no output, distance is 4.305147058823529 | Has no output, distance is 1.0 | Has no output, distance is 402.0147058823529

    SELECT
        "USER"."ID" AS "ID",
        TRIM(CONCAT(IFNULL("USER"."FIRST_NAME",
        ''),
        ' ',
        IFNULL("USER"."LAST_NAME",
        ''))) AS "NAME",
        "USER"."DELETED" AS "DELETED",
        "USER"."IS_ADMIN" AS "ISADMIN",
        "USER"."USER_NAME" AS "USERNAME",
        "USER"."PASSWORD" AS "PASSWORD",
        "USER"."SALUTATION_NAME" AS "SALUTATIONNAME",
        "USER"."FIRST_NAME" AS "FIRSTNAME",
        "USER"."LAST_NAME" AS "LASTNAME",
        "USER"."IS_ACTIVE" AS "ISACTIVE",
        "USER"."IS_PORTAL_USER" AS "ISPORTALUSER",
        "USER"."IS_SUPER_ADMIN" AS "ISSUPERADMIN",
        "USER"."TITLE" AS "TITLE",
        "EMAILADDRESSES"."NAME" AS "EMAILADDRESS",
        "PHONENUMBERS"."NAME" AS "PHONENUMBER",
        "USER"."GENDER" AS "GENDER",
        "USER"."CREATED_AT" AS "CREATEDAT",
        "USER"."DEFAULT_TEAM_ID" AS "DEFAULTTEAMID",
        "DEFAULTTEAM"."NAME" AS "DEFAULTTEAMNAME",
        "USER"."CONTACT_ID" AS "CONTACTID",
        TRIM(CONCAT("CONTACT"."FIRST_NAME",
        ' ',
        "CONTACT"."LAST_NAME")) AS "CONTACTNAME",
        "AVATAR"."NAME" AS "AVATARNAME",
        "USER"."AVATAR_ID" AS "AVATARID" 
    FROM
        "USER" 
    INNER JOIN
        "CONTACT" AS "CONTACT" 
            ON "USER"."CONTACT_ID" = "CONTACT"."ID" 
    INNER JOIN
        "TEAM" AS "DEFAULTTEAM" 
            ON "USER"."DEFAULT_TEAM_ID" = "DEFAULTTEAM"."ID" 
    INNER JOIN
        "ATTACHMENT" AS "AVATAR" 
            ON "USER"."AVATAR_ID" = "AVATAR"."ID" 
    INNER JOIN
        "ENTITY_EMAIL_ADDRESS" AS "EMAILADDRESSESMIDDLE" 
            ON "USER"."ID" = "EMAILADDRESSESMIDDLE"."ENTITY_ID" 
            AND "EMAILADDRESSESMIDDLE"."DELETED" = '0' 
            AND "EMAILADDRESSESMIDDLE"."PRIMARY" = '1' 
            AND "EMAILADDRESSESMIDDLE"."ENTITY_TYPE" = 'User' 
    INNER JOIN
        "EMAIL_ADDRESS" AS "EMAILADDRESSES" 
            ON "EMAILADDRESSES"."ID" = "EMAILADDRESSESMIDDLE"."EMAIL_ADDRESS_ID" 
            AND "EMAILADDRESSES"."DELETED" = '0' 
    INNER JOIN
        "ENTITY_PHONE_NUMBER" AS "PHONENUMBERSMIDDLE" 
            ON "USER"."ID" = "PHONENUMBERSMIDDLE"."ENTITY_ID" 
            AND "PHONENUMBERSMIDDLE"."DELETED" = '0' 
            AND "PHONENUMBERSMIDDLE"."PRIMARY" = '1' 
            AND "PHONENUMBERSMIDDLE"."ENTITY_TYPE" = 'User' 
    LEFT JOIN
        "PHONE_NUMBER" AS "PHONENUMBERS" 
            ON "PHONENUMBERS"."ID" = "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" 
            AND "PHONENUMBERS"."DELETED" = '0' 
    WHERE
        (
            (
                "PHONENUMBERS"."ID" IS NULL
            ) 
            AND (
                "PHONENUMBERS"."DELETED" IS NULL
            ) 
            AND (
                "PHONENUMBERSMIDDLE"."PHONE_NUMBER_ID" IS NULL
            )
        ) 
        AND (
            "USER"."ID" = 'system' 
            AND "USER"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 13
Path 7/39 - 0 successes, 10 failures
Failure messages: Has no output, distance is 3.9206751054852322 | Has no output, distance is 36.0 | Has no output, distance is 2.272222222222222 | Has no output, distance is 3.2787234042553193 | Has no output, distance is 1.467741935483871 | Has no output, distance is 16.260926077570165 | Has no output, distance is 1.4722222222222223 | Has no output, distance is 2.9570912375790424 | Has no output, distance is 6.506353800101277 | Has no output, distance is 7.557838094717607

    SELECT
        "EMAIL"."ID" AS "ID",
        "EMAIL"."NAME" AS "NAME",
        "EMAIL"."DELETED" AS "DELETED",
        "EMAIL"."FROM_NAME" AS "FROMNAME",
        "EMAIL"."FROM_STRING" AS "FROMSTRING",
        "EMAIL"."REPLY_TO_STRING" AS "REPLYTOSTRING",
        "EMAIL"."IS_REPLIED" AS "ISREPLIED",
        "EMAIL"."MESSAGE_ID" AS "MESSAGEID",
        "EMAIL"."MESSAGE_ID_INTERNAL" AS "MESSAGEIDINTERNAL",
        "EMAIL"."BODY_PLAIN" AS "BODYPLAIN",
        "EMAIL"."BODY" AS "BODY",
        "EMAIL"."IS_HTML" AS "ISHTML",
        "EMAIL"."STATUS" AS "STATUS",
        "EMAIL"."HAS_ATTACHMENT" AS "HASATTACHMENT",
        "EMAIL"."DATE_SENT" AS "DATESENT",
        "EMAIL"."DELIVERY_DATE" AS "DELIVERYDATE",
        "EMAIL"."CREATED_AT" AS "CREATEDAT",
        "EMAIL"."MODIFIED_AT" AS "MODIFIEDAT",
        "EMAIL"."IS_SYSTEM" AS "ISSYSTEM",
        "EMAIL"."FROM_EMAIL_ADDRESS_ID" AS "FROMEMAILADDRESSID",
        "FROMEMAILADDRESS"."NAME" AS "FROMEMAILADDRESSNAME",
        "EMAIL"."PARENT_ID" AS "PARENTID",
        "EMAIL"."PARENT_TYPE" AS "PARENTTYPE",
        "EMAIL"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "EMAIL"."SENT_BY_ID" AS "SENTBYID",
        TRIM(CONCAT("SENTBY"."FIRST_NAME",
        ' ',
        "SENTBY"."LAST_NAME")) AS "SENTBYNAME",
        "EMAIL"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "EMAIL"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME",
        "EMAIL"."REPLIED_ID" AS "REPLIEDID",
        "REPLIED"."NAME" AS "REPLIEDNAME",
        "EMAIL"."ACCOUNT_ID" AS "ACCOUNTID",
        "ACCOUNT"."NAME" AS "ACCOUNTNAME",
        "USERSMIDDLE"."IS_READ" AS "ISREAD",
        "USERSMIDDLE"."IS_IMPORTANT" AS "ISIMPORTANT",
        "USERSMIDDLE"."IN_TRASH" AS "INTRASH",
        "USERSMIDDLE"."FOLDER_ID" AS "FOLDERID" 
    FROM
        "EMAIL" 
    INNER JOIN
        "ACCOUNT" AS "ACCOUNT" 
            ON "EMAIL"."ACCOUNT_ID" = "ACCOUNT"."ID" 
    INNER JOIN
        "EMAIL_ADDRESS" AS "FROMEMAILADDRESS" 
            ON "EMAIL"."FROM_EMAIL_ADDRESS_ID" = "FROMEMAILADDRESS"."ID" 
    INNER JOIN
        "EMAIL" AS "REPLIED" 
            ON "EMAIL"."REPLIED_ID" = "REPLIED"."ID" 
    INNER JOIN
        "USER" AS "SENTBY" 
            ON "EMAIL"."SENT_BY_ID" = "SENTBY"."ID" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "EMAIL"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "EMAIL"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "EMAIL"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "EMAIL_USER" AS "USERSMIDDLE" 
            ON "EMAIL"."ID" = "USERSMIDDLE"."EMAIL_ID" 
            AND "USERSMIDDLE"."DELETED" = '0' 
            AND "USERSMIDDLE"."USER_ID" = 'system' 
    INNER JOIN
        "USER" AS "USERS" 
            ON "USERS"."ID" = "USERSMIDDLE"."USER_ID" 
            AND "USERS"."DELETED" = '0' 
    INNER JOIN
        "EMAIL_EMAIL_ADDRESS" AS "EMAILEMAILADDRESS" 
            ON "EMAILEMAILADDRESS"."EMAIL_ID" = "EMAIL"."ID" 
            AND "EMAILEMAILADDRESS"."DELETED" = 0 
    WHERE
        NOT ("EMAIL"."DELETED" = '0') 
        AND (
            (
                "EMAIL"."FROM_EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf' 
                OR "EMAILEMAILADDRESS"."EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf'
            )
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 13
Path 8/39 - 0 successes, 10 failures
Failure messages: Has no output, distance is 10.265762093694594 | Has no output, distance is 0.5 | Has no output, distance is 1.0 | Has no output, distance is 17.43244047619048 | Has no output, distance is 19.060889172102932 | Has no output, distance is 10.388822677652819 | Has no output, distance is 15.18890439604189 | Has no output, distance is 36.0 | Has no output, distance is 0.5 | Has no output, distance is 3.894061302681992

    SELECT
        "EMAIL"."ID" AS "ID",
        "EMAIL"."NAME" AS "NAME",
        "EMAIL"."DELETED" AS "DELETED",
        "EMAIL"."FROM_NAME" AS "FROMNAME",
        "EMAIL"."FROM_STRING" AS "FROMSTRING",
        "EMAIL"."REPLY_TO_STRING" AS "REPLYTOSTRING",
        "EMAIL"."IS_REPLIED" AS "ISREPLIED",
        "EMAIL"."MESSAGE_ID" AS "MESSAGEID",
        "EMAIL"."MESSAGE_ID_INTERNAL" AS "MESSAGEIDINTERNAL",
        "EMAIL"."BODY_PLAIN" AS "BODYPLAIN",
        "EMAIL"."BODY" AS "BODY",
        "EMAIL"."IS_HTML" AS "ISHTML",
        "EMAIL"."STATUS" AS "STATUS",
        "EMAIL"."HAS_ATTACHMENT" AS "HASATTACHMENT",
        "EMAIL"."DATE_SENT" AS "DATESENT",
        "EMAIL"."DELIVERY_DATE" AS "DELIVERYDATE",
        "EMAIL"."CREATED_AT" AS "CREATEDAT",
        "EMAIL"."MODIFIED_AT" AS "MODIFIEDAT",
        "EMAIL"."IS_SYSTEM" AS "ISSYSTEM",
        "EMAIL"."FROM_EMAIL_ADDRESS_ID" AS "FROMEMAILADDRESSID",
        "FROMEMAILADDRESS"."NAME" AS "FROMEMAILADDRESSNAME",
        "EMAIL"."PARENT_ID" AS "PARENTID",
        "EMAIL"."PARENT_TYPE" AS "PARENTTYPE",
        "EMAIL"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "EMAIL"."SENT_BY_ID" AS "SENTBYID",
        TRIM(CONCAT("SENTBY"."FIRST_NAME",
        ' ',
        "SENTBY"."LAST_NAME")) AS "SENTBYNAME",
        "EMAIL"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "EMAIL"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME",
        "EMAIL"."REPLIED_ID" AS "REPLIEDID",
        "REPLIED"."NAME" AS "REPLIEDNAME",
        "EMAIL"."ACCOUNT_ID" AS "ACCOUNTID",
        "ACCOUNT"."NAME" AS "ACCOUNTNAME",
        "USERSMIDDLE"."IS_READ" AS "ISREAD",
        "USERSMIDDLE"."IS_IMPORTANT" AS "ISIMPORTANT",
        "USERSMIDDLE"."IN_TRASH" AS "INTRASH",
        "USERSMIDDLE"."FOLDER_ID" AS "FOLDERID" 
    FROM
        "EMAIL" 
    INNER JOIN
        "ACCOUNT" AS "ACCOUNT" 
            ON "EMAIL"."ACCOUNT_ID" = "ACCOUNT"."ID" 
    INNER JOIN
        "EMAIL_ADDRESS" AS "FROMEMAILADDRESS" 
            ON "EMAIL"."FROM_EMAIL_ADDRESS_ID" = "FROMEMAILADDRESS"."ID" 
    INNER JOIN
        "EMAIL" AS "REPLIED" 
            ON "EMAIL"."REPLIED_ID" = "REPLIED"."ID" 
    INNER JOIN
        "USER" AS "SENTBY" 
            ON "EMAIL"."SENT_BY_ID" = "SENTBY"."ID" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "EMAIL"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "EMAIL"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "EMAIL"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "EMAIL_USER" AS "USERSMIDDLE" 
            ON "EMAIL"."ID" = "USERSMIDDLE"."EMAIL_ID" 
            AND "USERSMIDDLE"."DELETED" = '0' 
            AND "USERSMIDDLE"."USER_ID" = 'system' 
    INNER JOIN
        "USER" AS "USERS" 
            ON "USERS"."ID" = "USERSMIDDLE"."USER_ID" 
            AND "USERS"."DELETED" = '0' 
    INNER JOIN
        "EMAIL_EMAIL_ADDRESS" AS "EMAILEMAILADDRESS" 
            ON "EMAILEMAILADDRESS"."EMAIL_ID" = "EMAIL"."ID" 
            AND "EMAILEMAILADDRESS"."DELETED" = 0 
    WHERE
        (
            "EMAIL"."DELETED" IS NULL
        ) 
        AND (
            (
                "EMAIL"."FROM_EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf' 
                OR "EMAILEMAILADDRESS"."EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf'
            )
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 13
Path 16/39 - 0 successes, 10 failures
Failure messages: Has no output, distance is 24.406173430300182 | Has no output, distance is 8.963636363636363 | Has no output, distance is 8.734415584415585 | Has no output, distance is 3.4704924704924704 | Has no output, distance is 2.0 | Has no output, distance is 1.0 | Has no output, distance is 2.0 | Has no output, distance is 2.0 | Has no output, distance is 8.0 | Has no output, distance is 2.0

    SELECT
        "EMAIL"."ID" AS "ID",
        "EMAIL"."NAME" AS "NAME",
        "EMAIL"."DELETED" AS "DELETED",
        "EMAIL"."FROM_NAME" AS "FROMNAME",
        "EMAIL"."FROM_STRING" AS "FROMSTRING",
        "EMAIL"."REPLY_TO_STRING" AS "REPLYTOSTRING",
        "EMAIL"."IS_REPLIED" AS "ISREPLIED",
        "EMAIL"."MESSAGE_ID" AS "MESSAGEID",
        "EMAIL"."MESSAGE_ID_INTERNAL" AS "MESSAGEIDINTERNAL",
        "EMAIL"."BODY_PLAIN" AS "BODYPLAIN",
        "EMAIL"."BODY" AS "BODY",
        "EMAIL"."IS_HTML" AS "ISHTML",
        "EMAIL"."STATUS" AS "STATUS",
        "EMAIL"."HAS_ATTACHMENT" AS "HASATTACHMENT",
        "EMAIL"."DATE_SENT" AS "DATESENT",
        "EMAIL"."DELIVERY_DATE" AS "DELIVERYDATE",
        "EMAIL"."CREATED_AT" AS "CREATEDAT",
        "EMAIL"."MODIFIED_AT" AS "MODIFIEDAT",
        "EMAIL"."IS_SYSTEM" AS "ISSYSTEM",
        "EMAIL"."FROM_EMAIL_ADDRESS_ID" AS "FROMEMAILADDRESSID",
        "FROMEMAILADDRESS"."NAME" AS "FROMEMAILADDRESSNAME",
        "EMAIL"."PARENT_ID" AS "PARENTID",
        "EMAIL"."PARENT_TYPE" AS "PARENTTYPE",
        "EMAIL"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "EMAIL"."SENT_BY_ID" AS "SENTBYID",
        TRIM(CONCAT("SENTBY"."FIRST_NAME",
        ' ',
        "SENTBY"."LAST_NAME")) AS "SENTBYNAME",
        "EMAIL"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "EMAIL"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME",
        "EMAIL"."REPLIED_ID" AS "REPLIEDID",
        "REPLIED"."NAME" AS "REPLIEDNAME",
        "EMAIL"."ACCOUNT_ID" AS "ACCOUNTID",
        "ACCOUNT"."NAME" AS "ACCOUNTNAME",
        "USERSMIDDLE"."IS_READ" AS "ISREAD",
        "USERSMIDDLE"."IS_IMPORTANT" AS "ISIMPORTANT",
        "USERSMIDDLE"."IN_TRASH" AS "INTRASH",
        "USERSMIDDLE"."FOLDER_ID" AS "FOLDERID" 
    FROM
        "EMAIL" 
    INNER JOIN
        "ACCOUNT" AS "ACCOUNT" 
            ON "EMAIL"."ACCOUNT_ID" = "ACCOUNT"."ID" 
    INNER JOIN
        "EMAIL_ADDRESS" AS "FROMEMAILADDRESS" 
            ON "EMAIL"."FROM_EMAIL_ADDRESS_ID" = "FROMEMAILADDRESS"."ID" 
    LEFT JOIN
        "EMAIL" AS "REPLIED" 
            ON "EMAIL"."REPLIED_ID" = "REPLIED"."ID" 
    INNER JOIN
        "USER" AS "SENTBY" 
            ON "EMAIL"."SENT_BY_ID" = "SENTBY"."ID" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "EMAIL"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "EMAIL"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "EMAIL"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "EMAIL_USER" AS "USERSMIDDLE" 
            ON "EMAIL"."ID" = "USERSMIDDLE"."EMAIL_ID" 
            AND "USERSMIDDLE"."DELETED" = '0' 
            AND "USERSMIDDLE"."USER_ID" = 'system' 
    INNER JOIN
        "USER" AS "USERS" 
            ON "USERS"."ID" = "USERSMIDDLE"."USER_ID" 
            AND "USERS"."DELETED" = '0' 
    INNER JOIN
        "EMAIL_EMAIL_ADDRESS" AS "EMAILEMAILADDRESS" 
            ON "EMAILEMAILADDRESS"."EMAIL_ID" = "EMAIL"."ID" 
            AND "EMAILEMAILADDRESS"."DELETED" = 0 
    WHERE
        (
            (
                "REPLIED"."ID" IS NULL
            ) 
            AND (
                "EMAIL"."REPLIED_ID" IS NULL
            )
        ) 
        AND (
            (
                "EMAIL"."FROM_EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf' 
                OR "EMAILEMAILADDRESS"."EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf'
            ) 
            AND "EMAIL"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 13
Path 19/39 - 0 successes, 10 failures
Failure messages: Has no output, distance is 2.0 | Has no output, distance is 14.069430575908052 | Has no output, distance is 2.0 | Has no output, distance is 2.0 | Has no output, distance is 4.787092731829574 | Has no output, distance is 4.37149313011382 | Has no output, distance is 14.220319076560816 | Has no output, distance is 10.098694768869764 | Has no output, distance is 4.0 | Has no output, distance is 6.612612612612613

    SELECT
        "EMAIL"."ID" AS "ID",
        "EMAIL"."NAME" AS "NAME",
        "EMAIL"."DELETED" AS "DELETED",
        "EMAIL"."FROM_NAME" AS "FROMNAME",
        "EMAIL"."FROM_STRING" AS "FROMSTRING",
        "EMAIL"."REPLY_TO_STRING" AS "REPLYTOSTRING",
        "EMAIL"."IS_REPLIED" AS "ISREPLIED",
        "EMAIL"."MESSAGE_ID" AS "MESSAGEID",
        "EMAIL"."MESSAGE_ID_INTERNAL" AS "MESSAGEIDINTERNAL",
        "EMAIL"."BODY_PLAIN" AS "BODYPLAIN",
        "EMAIL"."BODY" AS "BODY",
        "EMAIL"."IS_HTML" AS "ISHTML",
        "EMAIL"."STATUS" AS "STATUS",
        "EMAIL"."HAS_ATTACHMENT" AS "HASATTACHMENT",
        "EMAIL"."DATE_SENT" AS "DATESENT",
        "EMAIL"."DELIVERY_DATE" AS "DELIVERYDATE",
        "EMAIL"."CREATED_AT" AS "CREATEDAT",
        "EMAIL"."MODIFIED_AT" AS "MODIFIEDAT",
        "EMAIL"."IS_SYSTEM" AS "ISSYSTEM",
        "EMAIL"."FROM_EMAIL_ADDRESS_ID" AS "FROMEMAILADDRESSID",
        "FROMEMAILADDRESS"."NAME" AS "FROMEMAILADDRESSNAME",
        "EMAIL"."PARENT_ID" AS "PARENTID",
        "EMAIL"."PARENT_TYPE" AS "PARENTTYPE",
        "EMAIL"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "EMAIL"."SENT_BY_ID" AS "SENTBYID",
        TRIM(CONCAT("SENTBY"."FIRST_NAME",
        ' ',
        "SENTBY"."LAST_NAME")) AS "SENTBYNAME",
        "EMAIL"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "EMAIL"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME",
        "EMAIL"."REPLIED_ID" AS "REPLIEDID",
        "REPLIED"."NAME" AS "REPLIEDNAME",
        "EMAIL"."ACCOUNT_ID" AS "ACCOUNTID",
        "ACCOUNT"."NAME" AS "ACCOUNTNAME",
        "USERSMIDDLE"."IS_READ" AS "ISREAD",
        "USERSMIDDLE"."IS_IMPORTANT" AS "ISIMPORTANT",
        "USERSMIDDLE"."IN_TRASH" AS "INTRASH",
        "USERSMIDDLE"."FOLDER_ID" AS "FOLDERID" 
    FROM
        "EMAIL" 
    INNER JOIN
        "ACCOUNT" AS "ACCOUNT" 
            ON "EMAIL"."ACCOUNT_ID" = "ACCOUNT"."ID" 
    INNER JOIN
        "EMAIL_ADDRESS" AS "FROMEMAILADDRESS" 
            ON "EMAIL"."FROM_EMAIL_ADDRESS_ID" = "FROMEMAILADDRESS"."ID" 
    INNER JOIN
        "EMAIL" AS "REPLIED" 
            ON "EMAIL"."REPLIED_ID" = "REPLIED"."ID" 
    LEFT JOIN
        "USER" AS "SENTBY" 
            ON "EMAIL"."SENT_BY_ID" = "SENTBY"."ID" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "EMAIL"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "EMAIL"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "EMAIL"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "EMAIL_USER" AS "USERSMIDDLE" 
            ON "EMAIL"."ID" = "USERSMIDDLE"."EMAIL_ID" 
            AND "USERSMIDDLE"."DELETED" = '0' 
            AND "USERSMIDDLE"."USER_ID" = 'system' 
    INNER JOIN
        "USER" AS "USERS" 
            ON "USERS"."ID" = "USERSMIDDLE"."USER_ID" 
            AND "USERS"."DELETED" = '0' 
    INNER JOIN
        "EMAIL_EMAIL_ADDRESS" AS "EMAILEMAILADDRESS" 
            ON "EMAILEMAILADDRESS"."EMAIL_ID" = "EMAIL"."ID" 
            AND "EMAILEMAILADDRESS"."DELETED" = 0 
    WHERE
        (
            (
                "SENTBY"."ID" IS NULL
            ) 
            AND (
                "EMAIL"."SENT_BY_ID" IS NULL
            )
        ) 
        AND (
            (
                "EMAIL"."FROM_EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf' 
                OR "EMAILEMAILADDRESS"."EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf'
            ) 
            AND "EMAIL"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 13
Path 28/39 - 0 successes, 10 failures
Failure messages: Has no output, distance is 9.809725747568097 | Has no output, distance is 74.0 | Has no output, distance is 18.804688393367638 | Has no output, distance is 2.0 | Has no output, distance is 1.0 | Has no output, distance is 156.82765670180626 | Has no output, distance is 3.469098277608916 | Has no output, distance is 2.0 | Has no output, distance is 32.17858985314086 | Has no output, distance is 0.5

    SELECT
        "EMAIL"."ID" AS "ID",
        "EMAIL"."NAME" AS "NAME",
        "EMAIL"."DELETED" AS "DELETED",
        "EMAIL"."FROM_NAME" AS "FROMNAME",
        "EMAIL"."FROM_STRING" AS "FROMSTRING",
        "EMAIL"."REPLY_TO_STRING" AS "REPLYTOSTRING",
        "EMAIL"."IS_REPLIED" AS "ISREPLIED",
        "EMAIL"."MESSAGE_ID" AS "MESSAGEID",
        "EMAIL"."MESSAGE_ID_INTERNAL" AS "MESSAGEIDINTERNAL",
        "EMAIL"."BODY_PLAIN" AS "BODYPLAIN",
        "EMAIL"."BODY" AS "BODY",
        "EMAIL"."IS_HTML" AS "ISHTML",
        "EMAIL"."STATUS" AS "STATUS",
        "EMAIL"."HAS_ATTACHMENT" AS "HASATTACHMENT",
        "EMAIL"."DATE_SENT" AS "DATESENT",
        "EMAIL"."DELIVERY_DATE" AS "DELIVERYDATE",
        "EMAIL"."CREATED_AT" AS "CREATEDAT",
        "EMAIL"."MODIFIED_AT" AS "MODIFIEDAT",
        "EMAIL"."IS_SYSTEM" AS "ISSYSTEM",
        "EMAIL"."FROM_EMAIL_ADDRESS_ID" AS "FROMEMAILADDRESSID",
        "FROMEMAILADDRESS"."NAME" AS "FROMEMAILADDRESSNAME",
        "EMAIL"."PARENT_ID" AS "PARENTID",
        "EMAIL"."PARENT_TYPE" AS "PARENTTYPE",
        "EMAIL"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "EMAIL"."SENT_BY_ID" AS "SENTBYID",
        TRIM(CONCAT("SENTBY"."FIRST_NAME",
        ' ',
        "SENTBY"."LAST_NAME")) AS "SENTBYNAME",
        "EMAIL"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "EMAIL"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME",
        "EMAIL"."REPLIED_ID" AS "REPLIEDID",
        "REPLIED"."NAME" AS "REPLIEDNAME",
        "EMAIL"."ACCOUNT_ID" AS "ACCOUNTID",
        "ACCOUNT"."NAME" AS "ACCOUNTNAME",
        "USERSMIDDLE"."IS_READ" AS "ISREAD",
        "USERSMIDDLE"."IS_IMPORTANT" AS "ISIMPORTANT",
        "USERSMIDDLE"."IN_TRASH" AS "INTRASH",
        "USERSMIDDLE"."FOLDER_ID" AS "FOLDERID" 
    FROM
        "EMAIL" 
    INNER JOIN
        "ACCOUNT" AS "ACCOUNT" 
            ON "EMAIL"."ACCOUNT_ID" = "ACCOUNT"."ID" 
    INNER JOIN
        "EMAIL_ADDRESS" AS "FROMEMAILADDRESS" 
            ON "EMAIL"."FROM_EMAIL_ADDRESS_ID" = "FROMEMAILADDRESS"."ID" 
    INNER JOIN
        "EMAIL" AS "REPLIED" 
            ON "EMAIL"."REPLIED_ID" = "REPLIED"."ID" 
    INNER JOIN
        "USER" AS "SENTBY" 
            ON "EMAIL"."SENT_BY_ID" = "SENTBY"."ID" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "EMAIL"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "EMAIL"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    LEFT JOIN
        "USER" AS "CREATEDBY" 
            ON "EMAIL"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "EMAIL_USER" AS "USERSMIDDLE" 
            ON "EMAIL"."ID" = "USERSMIDDLE"."EMAIL_ID" 
            AND "USERSMIDDLE"."DELETED" = '0' 
            AND "USERSMIDDLE"."USER_ID" = 'system' 
    INNER JOIN
        "USER" AS "USERS" 
            ON "USERS"."ID" = "USERSMIDDLE"."USER_ID" 
            AND "USERS"."DELETED" = '0' 
    INNER JOIN
        "EMAIL_EMAIL_ADDRESS" AS "EMAILEMAILADDRESS" 
            ON "EMAILEMAILADDRESS"."EMAIL_ID" = "EMAIL"."ID" 
            AND "EMAILEMAILADDRESS"."DELETED" = 0 
    WHERE
        (
            (
                "CREATEDBY"."ID" IS NULL
            ) 
            AND (
                "EMAIL"."CREATED_BY_ID" IS NULL
            )
        ) 
        AND (
            (
                "EMAIL"."FROM_EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf' 
                OR "EMAILEMAILADDRESS"."EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf'
            ) 
            AND "EMAIL"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 13
Path 32/39 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "EMAIL"."ID" AS "ID",
        "EMAIL"."NAME" AS "NAME",
        "EMAIL"."DELETED" AS "DELETED",
        "EMAIL"."FROM_NAME" AS "FROMNAME",
        "EMAIL"."FROM_STRING" AS "FROMSTRING",
        "EMAIL"."REPLY_TO_STRING" AS "REPLYTOSTRING",
        "EMAIL"."IS_REPLIED" AS "ISREPLIED",
        "EMAIL"."MESSAGE_ID" AS "MESSAGEID",
        "EMAIL"."MESSAGE_ID_INTERNAL" AS "MESSAGEIDINTERNAL",
        "EMAIL"."BODY_PLAIN" AS "BODYPLAIN",
        "EMAIL"."BODY" AS "BODY",
        "EMAIL"."IS_HTML" AS "ISHTML",
        "EMAIL"."STATUS" AS "STATUS",
        "EMAIL"."HAS_ATTACHMENT" AS "HASATTACHMENT",
        "EMAIL"."DATE_SENT" AS "DATESENT",
        "EMAIL"."DELIVERY_DATE" AS "DELIVERYDATE",
        "EMAIL"."CREATED_AT" AS "CREATEDAT",
        "EMAIL"."MODIFIED_AT" AS "MODIFIEDAT",
        "EMAIL"."IS_SYSTEM" AS "ISSYSTEM",
        "EMAIL"."FROM_EMAIL_ADDRESS_ID" AS "FROMEMAILADDRESSID",
        "FROMEMAILADDRESS"."NAME" AS "FROMEMAILADDRESSNAME",
        "EMAIL"."PARENT_ID" AS "PARENTID",
        "EMAIL"."PARENT_TYPE" AS "PARENTTYPE",
        "EMAIL"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "EMAIL"."SENT_BY_ID" AS "SENTBYID",
        TRIM(CONCAT("SENTBY"."FIRST_NAME",
        ' ',
        "SENTBY"."LAST_NAME")) AS "SENTBYNAME",
        "EMAIL"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "EMAIL"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME",
        "EMAIL"."REPLIED_ID" AS "REPLIEDID",
        "REPLIED"."NAME" AS "REPLIEDNAME",
        "EMAIL"."ACCOUNT_ID" AS "ACCOUNTID",
        "ACCOUNT"."NAME" AS "ACCOUNTNAME",
        "USERSMIDDLE"."IS_READ" AS "ISREAD",
        "USERSMIDDLE"."IS_IMPORTANT" AS "ISIMPORTANT",
        "USERSMIDDLE"."IN_TRASH" AS "INTRASH",
        "USERSMIDDLE"."FOLDER_ID" AS "FOLDERID" 
    FROM
        "EMAIL" 
    LEFT JOIN
        "ACCOUNT" AS "ACCOUNT" 
            ON "EMAIL"."ACCOUNT_ID" = "ACCOUNT"."ID" 
    LEFT JOIN
        "EMAIL_ADDRESS" AS "FROMEMAILADDRESS" 
            ON "EMAIL"."FROM_EMAIL_ADDRESS_ID" = "FROMEMAILADDRESS"."ID" 
    LEFT JOIN
        "EMAIL" AS "REPLIED" 
            ON "EMAIL"."REPLIED_ID" = "REPLIED"."ID" 
    LEFT JOIN
        "USER" AS "SENTBY" 
            ON "EMAIL"."SENT_BY_ID" = "SENTBY"."ID" 
    LEFT JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "EMAIL"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    LEFT JOIN
        "USER" AS "MODIFIEDBY" 
            ON "EMAIL"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    LEFT JOIN
        "USER" AS "CREATEDBY" 
            ON "EMAIL"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    RIGHT JOIN
        "EMAIL_USER" AS "USERSMIDDLE" 
            ON "EMAIL"."ID" = "USERSMIDDLE"."EMAIL_ID" 
            AND "USERSMIDDLE"."DELETED" = '0' 
            AND "USERSMIDDLE"."USER_ID" = 'system' 
    INNER JOIN
        "USER" AS "USERS" 
            ON "USERS"."ID" = "USERSMIDDLE"."USER_ID" 
            AND "USERS"."DELETED" = '0' 
    LEFT JOIN
        "EMAIL_EMAIL_ADDRESS" AS "EMAILEMAILADDRESS" 
            ON "EMAILEMAILADDRESS"."EMAIL_ID" = "EMAIL"."ID" 
            AND "EMAILEMAILADDRESS"."DELETED" = 0 
    WHERE
        (
            "EMAIL"."ID" IS NULL
        ) 
        AND (
            "USERSMIDDLE"."EMAIL_ID" IS NULL
        ) 
        AND (
            "USERSMIDDLE"."DELETED" IS NULL
        ) 
        AND (
            "USERSMIDDLE"."USER_ID" IS NULL
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 13
Path 34/39 - 0 successes, 10 failures
Failure messages: Has no output, distance is 5.355311355311356 | Has no output, distance is 2.0 | Has no output, distance is 1.0 | Has no output, distance is 36.0 | Has no output, distance is 7.701228131714171 | Has no output, distance is 7.222784609860241 | Has no output, distance is 5.615993265993266 | Has no output, distance is 1.0 | Has no output, distance is 3.3493589743589745 | Has no output, distance is 1.0

    SELECT
        "EMAIL"."ID" AS "ID",
        "EMAIL"."NAME" AS "NAME",
        "EMAIL"."DELETED" AS "DELETED",
        "EMAIL"."FROM_NAME" AS "FROMNAME",
        "EMAIL"."FROM_STRING" AS "FROMSTRING",
        "EMAIL"."REPLY_TO_STRING" AS "REPLYTOSTRING",
        "EMAIL"."IS_REPLIED" AS "ISREPLIED",
        "EMAIL"."MESSAGE_ID" AS "MESSAGEID",
        "EMAIL"."MESSAGE_ID_INTERNAL" AS "MESSAGEIDINTERNAL",
        "EMAIL"."BODY_PLAIN" AS "BODYPLAIN",
        "EMAIL"."BODY" AS "BODY",
        "EMAIL"."IS_HTML" AS "ISHTML",
        "EMAIL"."STATUS" AS "STATUS",
        "EMAIL"."HAS_ATTACHMENT" AS "HASATTACHMENT",
        "EMAIL"."DATE_SENT" AS "DATESENT",
        "EMAIL"."DELIVERY_DATE" AS "DELIVERYDATE",
        "EMAIL"."CREATED_AT" AS "CREATEDAT",
        "EMAIL"."MODIFIED_AT" AS "MODIFIEDAT",
        "EMAIL"."IS_SYSTEM" AS "ISSYSTEM",
        "EMAIL"."FROM_EMAIL_ADDRESS_ID" AS "FROMEMAILADDRESSID",
        "FROMEMAILADDRESS"."NAME" AS "FROMEMAILADDRESSNAME",
        "EMAIL"."PARENT_ID" AS "PARENTID",
        "EMAIL"."PARENT_TYPE" AS "PARENTTYPE",
        "EMAIL"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "EMAIL"."SENT_BY_ID" AS "SENTBYID",
        TRIM(CONCAT("SENTBY"."FIRST_NAME",
        ' ',
        "SENTBY"."LAST_NAME")) AS "SENTBYNAME",
        "EMAIL"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "EMAIL"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME",
        "EMAIL"."REPLIED_ID" AS "REPLIEDID",
        "REPLIED"."NAME" AS "REPLIEDNAME",
        "EMAIL"."ACCOUNT_ID" AS "ACCOUNTID",
        "ACCOUNT"."NAME" AS "ACCOUNTNAME",
        "USERSMIDDLE"."IS_READ" AS "ISREAD",
        "USERSMIDDLE"."IS_IMPORTANT" AS "ISIMPORTANT",
        "USERSMIDDLE"."IN_TRASH" AS "INTRASH",
        "USERSMIDDLE"."FOLDER_ID" AS "FOLDERID" 
    FROM
        "EMAIL" 
    INNER JOIN
        "ACCOUNT" AS "ACCOUNT" 
            ON "EMAIL"."ACCOUNT_ID" = "ACCOUNT"."ID" 
    INNER JOIN
        "EMAIL_ADDRESS" AS "FROMEMAILADDRESS" 
            ON "EMAIL"."FROM_EMAIL_ADDRESS_ID" = "FROMEMAILADDRESS"."ID" 
    INNER JOIN
        "EMAIL" AS "REPLIED" 
            ON "EMAIL"."REPLIED_ID" = "REPLIED"."ID" 
    INNER JOIN
        "USER" AS "SENTBY" 
            ON "EMAIL"."SENT_BY_ID" = "SENTBY"."ID" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "EMAIL"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "EMAIL"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "EMAIL"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "EMAIL_USER" AS "USERSMIDDLE" 
            ON "EMAIL"."ID" = "USERSMIDDLE"."EMAIL_ID" 
            AND "USERSMIDDLE"."DELETED" = '0' 
            AND "USERSMIDDLE"."USER_ID" = 'system' 
    LEFT JOIN
        "USER" AS "USERS" 
            ON "USERS"."ID" = "USERSMIDDLE"."USER_ID" 
            AND "USERS"."DELETED" = '0' 
    INNER JOIN
        "EMAIL_EMAIL_ADDRESS" AS "EMAILEMAILADDRESS" 
            ON "EMAILEMAILADDRESS"."EMAIL_ID" = "EMAIL"."ID" 
            AND "EMAILEMAILADDRESS"."DELETED" = 0 
    WHERE
        (
            (
                "USERS"."ID" IS NULL
            ) 
            AND (
                "USERS"."DELETED" IS NULL
            ) 
            AND (
                "USERSMIDDLE"."USER_ID" IS NULL
            )
        ) 
        AND (
            (
                "EMAIL"."FROM_EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf' 
                OR "EMAILEMAILADDRESS"."EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf'
            ) 
            AND "EMAIL"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process1, query 13
Path 37/39 - 0 successes, 10 failures
Failure messages: Has no output, distance is 3.223365231259968 | Has no output, distance is 84.16666666666666 | Has no output, distance is 1.375 | Has no output, distance is 41.821261298041485 | Has no output, distance is 83.96666666666667 | Has no output, distance is 289.0 | Has no output, distance is 0.5 | Has no output, distance is 11.05400681693785 | Has no output, distance is 84.16666666666666 | Has no output, distance is 0.5

    SELECT
        "EMAIL"."ID" AS "ID",
        "EMAIL"."NAME" AS "NAME",
        "EMAIL"."DELETED" AS "DELETED",
        "EMAIL"."FROM_NAME" AS "FROMNAME",
        "EMAIL"."FROM_STRING" AS "FROMSTRING",
        "EMAIL"."REPLY_TO_STRING" AS "REPLYTOSTRING",
        "EMAIL"."IS_REPLIED" AS "ISREPLIED",
        "EMAIL"."MESSAGE_ID" AS "MESSAGEID",
        "EMAIL"."MESSAGE_ID_INTERNAL" AS "MESSAGEIDINTERNAL",
        "EMAIL"."BODY_PLAIN" AS "BODYPLAIN",
        "EMAIL"."BODY" AS "BODY",
        "EMAIL"."IS_HTML" AS "ISHTML",
        "EMAIL"."STATUS" AS "STATUS",
        "EMAIL"."HAS_ATTACHMENT" AS "HASATTACHMENT",
        "EMAIL"."DATE_SENT" AS "DATESENT",
        "EMAIL"."DELIVERY_DATE" AS "DELIVERYDATE",
        "EMAIL"."CREATED_AT" AS "CREATEDAT",
        "EMAIL"."MODIFIED_AT" AS "MODIFIEDAT",
        "EMAIL"."IS_SYSTEM" AS "ISSYSTEM",
        "EMAIL"."FROM_EMAIL_ADDRESS_ID" AS "FROMEMAILADDRESSID",
        "FROMEMAILADDRESS"."NAME" AS "FROMEMAILADDRESSNAME",
        "EMAIL"."PARENT_ID" AS "PARENTID",
        "EMAIL"."PARENT_TYPE" AS "PARENTTYPE",
        "EMAIL"."CREATED_BY_ID" AS "CREATEDBYID",
        TRIM(CONCAT("CREATEDBY"."FIRST_NAME",
        ' ',
        "CREATEDBY"."LAST_NAME")) AS "CREATEDBYNAME",
        "EMAIL"."SENT_BY_ID" AS "SENTBYID",
        TRIM(CONCAT("SENTBY"."FIRST_NAME",
        ' ',
        "SENTBY"."LAST_NAME")) AS "SENTBYNAME",
        "EMAIL"."MODIFIED_BY_ID" AS "MODIFIEDBYID",
        TRIM(CONCAT("MODIFIEDBY"."FIRST_NAME",
        ' ',
        "MODIFIEDBY"."LAST_NAME")) AS "MODIFIEDBYNAME",
        "EMAIL"."ASSIGNED_USER_ID" AS "ASSIGNEDUSERID",
        TRIM(CONCAT("ASSIGNEDUSER"."FIRST_NAME",
        ' ',
        "ASSIGNEDUSER"."LAST_NAME")) AS "ASSIGNEDUSERNAME",
        "EMAIL"."REPLIED_ID" AS "REPLIEDID",
        "REPLIED"."NAME" AS "REPLIEDNAME",
        "EMAIL"."ACCOUNT_ID" AS "ACCOUNTID",
        "ACCOUNT"."NAME" AS "ACCOUNTNAME",
        "USERSMIDDLE"."IS_READ" AS "ISREAD",
        "USERSMIDDLE"."IS_IMPORTANT" AS "ISIMPORTANT",
        "USERSMIDDLE"."IN_TRASH" AS "INTRASH",
        "USERSMIDDLE"."FOLDER_ID" AS "FOLDERID" 
    FROM
        "EMAIL" 
    INNER JOIN
        "ACCOUNT" AS "ACCOUNT" 
            ON "EMAIL"."ACCOUNT_ID" = "ACCOUNT"."ID" 
    INNER JOIN
        "EMAIL_ADDRESS" AS "FROMEMAILADDRESS" 
            ON "EMAIL"."FROM_EMAIL_ADDRESS_ID" = "FROMEMAILADDRESS"."ID" 
    INNER JOIN
        "EMAIL" AS "REPLIED" 
            ON "EMAIL"."REPLIED_ID" = "REPLIED"."ID" 
    INNER JOIN
        "USER" AS "SENTBY" 
            ON "EMAIL"."SENT_BY_ID" = "SENTBY"."ID" 
    INNER JOIN
        "USER" AS "ASSIGNEDUSER" 
            ON "EMAIL"."ASSIGNED_USER_ID" = "ASSIGNEDUSER"."ID" 
    INNER JOIN
        "USER" AS "MODIFIEDBY" 
            ON "EMAIL"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    INNER JOIN
        "USER" AS "CREATEDBY" 
            ON "EMAIL"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    INNER JOIN
        "EMAIL_USER" AS "USERSMIDDLE" 
            ON "EMAIL"."ID" = "USERSMIDDLE"."EMAIL_ID" 
            AND "USERSMIDDLE"."DELETED" = '0' 
            AND "USERSMIDDLE"."USER_ID" = 'system' 
    INNER JOIN
        "USER" AS "USERS" 
            ON "USERS"."ID" = "USERSMIDDLE"."USER_ID" 
            AND "USERS"."DELETED" = '0' 
    LEFT JOIN
        "EMAIL_EMAIL_ADDRESS" AS "EMAILEMAILADDRESS" 
            ON "EMAILEMAILADDRESS"."EMAIL_ID" = "EMAIL"."ID" 
            AND "EMAILEMAILADDRESS"."DELETED" = 0 
    WHERE
        (
            (
                "EMAILEMAILADDRESS"."EMAIL_ID" IS NULL
            ) 
            AND (
                "EMAILEMAILADDRESS"."DELETED" IS NULL
            ) 
            AND (
                "EMAIL"."ID" IS NOT NULL
            )
        ) 
        AND (
            (
                "EMAIL"."FROM_EMAIL_ADDRESS_ID" = '589dd5ebb54b7ceaf'
            ) 
            AND "EMAIL"."DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: espocrm-process2, query 3
Path 5/5 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        COUNT("EMAIL_ADDRESS"."ID") AS "AGGREGATEVALUE" 
    FROM
        "EMAIL_ADDRESS" 
    WHERE
        "EMAIL_ADDRESS"."ID" = '589dd5156fc6837f1' 
        AND "EMAIL_ADDRESS"."DELETED" = '0' 
    HAVING
        COUNT("EMAIL_ADDRESS"."ID") > COUNT(DISTINCT "EMAIL_ADDRESS"."ID") 
        AND COUNT(DISTINCT "EMAIL_ADDRESS"."ID") > 1
-----------------------------------

-----------------------------------
Query: espocrm-process2, query 4
Path 5/5 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        COUNT("PORTAL_ROLE"."ID") AS "AGGREGATEVALUE" 
    FROM
        "PORTAL_ROLE" 
    WHERE
        "PORTAL_ROLE"."ID" = '589dda28693a32d4a' 
        AND "PORTAL_ROLE"."DELETED" = '0' 
    HAVING
        COUNT("PORTAL_ROLE"."ID") > COUNT(DISTINCT "PORTAL_ROLE"."ID") 
        AND COUNT(DISTINCT "PORTAL_ROLE"."ID") > 1
-----------------------------------

-----------------------------------
Query: espocrm-process2, query 9
Path 17/17 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        COUNT("PORTAL"."ID") AS "AGGREGATEVALUE" 
    FROM
        "PORTAL" 
    LEFT JOIN
        "USER" AS "MODIFIEDBY" 
            ON "PORTAL"."MODIFIED_BY_ID" = "MODIFIEDBY"."ID" 
    LEFT JOIN
        "USER" AS "CREATEDBY" 
            ON "PORTAL"."CREATED_BY_ID" = "CREATEDBY"."ID" 
    LEFT JOIN
        "ATTACHMENT" AS "LOGO" 
            ON "PORTAL"."LOGO_ID" = "LOGO"."ID" 
    LEFT JOIN
        "ATTACHMENT" AS "COMPANYLOGO" 
            ON "PORTAL"."COMPANY_LOGO_ID" = "COMPANYLOGO"."ID" 
    WHERE
        "PORTAL"."ID" = 'testPortalId' 
        AND "PORTAL"."DELETED" = '0' 
    HAVING
        COUNT("PORTAL"."ID") > COUNT(DISTINCT "PORTAL"."ID") 
        AND COUNT(DISTINCT "PORTAL"."ID") > 1
-----------------------------------
