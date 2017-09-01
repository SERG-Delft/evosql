
-----------------------------------
Query: suitecrm-process0, query 87
Path 6/10 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "EAPM".* 
    FROM
        "EAPM" 
    WHERE
        NOT ("DELETED" = '0') 
        AND (
            "ASSIGNED_USER_ID" = ''
        ) 
        AND (
            "APPLICATION" = ''
        ) 
        AND (
            "VALIDATED" = '1'
        ) 
        AND (
            "DELETED" = 0
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process0, query 87
Path 10/10 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "EAPM".* 
    FROM
        "EAPM" 
    WHERE
        NOT ("DELETED" = 0) 
        AND (
            "ASSIGNED_USER_ID" = ''
        ) 
        AND (
            "APPLICATION" = ''
        ) 
        AND (
            "DELETED" = '0'
        ) 
        AND (
            "VALIDATED" = '1'
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process0, query 93
Path 12/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "ACCOUNTS".*,
        "ACCOUNTS_CSTM".* 
    FROM
        "ACCOUNTS" 
    INNER JOIN
        "ACCOUNTS_CSTM" 
            ON "ACCOUNTS"."ID" = "ACCOUNTS_CSTM"."ID_C" 
    WHERE
        (
            "ACCOUNTS_CSTM"."JJWG_MAPS_LAT_C" IS NULL
        ) 
        AND (
            (
                "ACCOUNTS_CSTM"."JJWG_MAPS_LNG_C" IS NULL
            )
        ) 
        AND NOT (("ACCOUNTS_CSTM"."JJWG_MAPS_LNG_C" = 0)) 
        AND (
            "ACCOUNTS"."DELETED" = 0
        ) 
        AND (
            (
                "ACCOUNTS_CSTM"."JJWG_MAPS_GEOCODE_STATUS_C" = '' 
                OR (
                    "ACCOUNTS_CSTM"."JJWG_MAPS_GEOCODE_STATUS_C" IS NULL
                )
            )
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process1, query 12
Path 1/3 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0

    SELECT
        "ID",
        "FIRST_NAME",
        "LAST_NAME",
        "USER_NAME" 
    FROM
        "USERS" 
    WHERE
        (
            1 = 2
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process1, query 12
Path 3/3 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0 | Has no output, distance is 0.0

    SELECT
        "ID",
        "FIRST_NAME",
        "LAST_NAME",
        "USER_NAME" 
    FROM
        "USERS" 
    WHERE
        (
            1 = 0
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process1, query 92
Path 15/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        COUNT("SECURITYGROUPS"."ID") AS "RESULTS" 
    FROM
        "SECURITYGROUPS" 
    INNER JOIN
        "SECURITYGROUPS_USERS" 
            ON "SECURITYGROUPS"."ID" = "SECURITYGROUPS_USERS"."SECURITYGROUP_ID" 
            AND "SECURITYGROUPS_USERS"."DELETED" = 0 
    WHERE
        "SECURITYGROUPS"."DELETED" = 0 
        AND "SECURITYGROUPS_USERS"."USER_ID" = '' 
        AND (
            (
                "SECURITYGROUPS"."NONINHERITABLE" IS NULL
            ) 
            OR "SECURITYGROUPS"."NONINHERITABLE" <> 1
        ) 
        AND (
            (
                "SECURITYGROUPS_USERS"."NONINHERITABLE" IS NULL
            ) 
            OR "SECURITYGROUPS_USERS"."NONINHERITABLE" <> 1
        ) 
    HAVING
        COUNT("SECURITYGROUPS"."ID") > COUNT(DISTINCT "SECURITYGROUPS"."ID") 
        AND COUNT(DISTINCT "SECURITYGROUPS"."ID") > 1
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 80
Path 6/8 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "EAPM".* 
    FROM
        "EAPM" 
    WHERE
        NOT ("DELETED" = '0') 
        AND (
            "ASSIGNED_USER_ID" = ''
        ) 
        AND (
            "APPLICATION" = ''
        ) 
        AND (
            "DELETED" = 0
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 80
Path 8/8 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "EAPM".* 
    FROM
        "EAPM" 
    WHERE
        NOT ("DELETED" = 0) 
        AND (
            "ASSIGNED_USER_ID" = ''
        ) 
        AND (
            "APPLICATION" = ''
        ) 
        AND (
            "DELETED" = '0'
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 87
Path 10/10 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        COUNT("SECURITYGROUPS"."ID") AS "RESULTS" 
    FROM
        "SECURITYGROUPS" 
    INNER JOIN
        "SECURITYGROUPS_USERS" 
            ON "SECURITYGROUPS"."ID" = "SECURITYGROUPS_USERS"."SECURITYGROUP_ID" 
            AND "SECURITYGROUPS_USERS"."DELETED" = 0 
            AND "SECURITYGROUPS_USERS"."USER_ID" = '' 
    INNER JOIN
        "SECURITYGROUPS_RECORDS" 
            ON "SECURITYGROUPS"."ID" = "SECURITYGROUPS_RECORDS"."SECURITYGROUP_ID" 
            AND "SECURITYGROUPS_RECORDS"."DELETED" = 0 
            AND "SECURITYGROUPS_RECORDS"."RECORD_ID" = 'abcde-12345' 
            AND "SECURITYGROUPS_RECORDS"."MODULE" = 'Documents' 
    WHERE
        "SECURITYGROUPS"."DELETED" = 0 
    HAVING
        COUNT("SECURITYGROUPS"."ID") > COUNT(DISTINCT "SECURITYGROUPS"."ID") 
        AND COUNT(DISTINCT "SECURITYGROUPS"."ID") > 1
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 88
Path 3/10 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "USERS".* 
    FROM
        "USERS_SIGNATURES" 
    INNER JOIN
        "USERS" 
            ON "USERS_SIGNATURES"."USER_ID" = "USERS"."ID" 
    WHERE
        (
            "USERS_SIGNATURES"."USER_ID" IS NULL
        ) 
        AND (
            "USERS"."DELETED" = 0
        ) 
        AND (
            "USERS_SIGNATURES"."DELETED" = 0
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 92
Path 1/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 10.156627998450842 | Has no output, distance is 12.070606314978923 | Has no output, distance is 5.592567017341422 | Has no output, distance is 7.692148957140753 | Has no output, distance is 1.0 | Has no output, distance is 1.4473684210526314 | Has no output, distance is 2.9497171590194844 | Has no output, distance is 1.4714285714285715 | Has no output, distance is 1.1666666666666665 | Has no output, distance is 2.4722222222222223

    SELECT
        "PROSPECT_LISTS_PROSPECTS"."ID" "ID",
        "PROSPECTS"."FIRST_NAME" 
    FROM
        "PROSPECTS" 
    INNER JOIN
        "PROSPECT_LISTS_PROSPECTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."RELATED_ID" = "PROSPECTS"."ID" 
    INNER JOIN
        "PROSPECT_LISTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "PROSPECT_LIST_CAMPAIGNS" 
            ON "PROSPECT_LIST_CAMPAIGNS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "CAMPAIGNS" 
            ON "CAMPAIGNS"."ID" = "PROSPECT_LIST_CAMPAIGNS"."CAMPAIGN_ID" 
    WHERE
        (
            "PROSPECT_LIST_CAMPAIGNS"."DELETED" = 0
        ) 
        AND (
            "PROSPECT_LISTS_PROSPECTS"."DELETED" = 0
        ) 
        AND (
            "PROSPECT_LISTS"."DELETED" = 0
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 92
Path 2/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 2.654166666666667 | Has no output, distance is 1.0 | Has no output, distance is 1.4795918367346939 | Has no output, distance is 1.0 | Has no output, distance is 4.425690401552471 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 7.0491702220813375 | Has no output, distance is 9.207938013915243 | Has no output, distance is 1.9861111111111112

    SELECT
        "PROSPECT_LISTS_PROSPECTS"."ID" "ID",
        "PROSPECTS"."FIRST_NAME" 
    FROM
        "PROSPECTS" 
    INNER JOIN
        "PROSPECT_LISTS_PROSPECTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."RELATED_ID" = "PROSPECTS"."ID" 
    INNER JOIN
        "PROSPECT_LISTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "PROSPECT_LIST_CAMPAIGNS" 
            ON "PROSPECT_LIST_CAMPAIGNS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "CAMPAIGNS" 
            ON "CAMPAIGNS"."ID" = "PROSPECT_LIST_CAMPAIGNS"."CAMPAIGN_ID" 
    WHERE
        NOT ("PROSPECT_LIST_CAMPAIGNS"."DELETED" = 0) 
        AND (
            "PROSPECT_LISTS_PROSPECTS"."DELETED" = 0
        ) 
        AND (
            "PROSPECT_LISTS"."DELETED" = 0
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 92
Path 5/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 3.454187192118227 | Has no output, distance is 1.0 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 6.329460714634112 | Has no output, distance is 1.1666666666666665 | Has no output, distance is 7.850361619638729 | Has no output, distance is 5.094913126073973 | Has no output, distance is 13.963761345549964 | Has no output, distance is 1.45

    SELECT
        "PROSPECT_LISTS_PROSPECTS"."ID" "ID",
        "PROSPECTS"."FIRST_NAME" 
    FROM
        "PROSPECTS" 
    INNER JOIN
        "PROSPECT_LISTS_PROSPECTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."RELATED_ID" = "PROSPECTS"."ID" 
    INNER JOIN
        "PROSPECT_LISTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "PROSPECT_LIST_CAMPAIGNS" 
            ON "PROSPECT_LIST_CAMPAIGNS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "CAMPAIGNS" 
            ON "CAMPAIGNS"."ID" = "PROSPECT_LIST_CAMPAIGNS"."CAMPAIGN_ID" 
    WHERE
        (
            "PROSPECT_LISTS_PROSPECTS"."DELETED" IS NULL
        ) 
        AND (
            "PROSPECT_LIST_CAMPAIGNS"."DELETED" = 0
        ) 
        AND (
            "PROSPECT_LISTS"."DELETED" = 0
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 92
Path 6/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 4.433463203463203 | Has no output, distance is 0.5 | Has no output, distance is 2.4642857142857144 | Has no output, distance is 2.9230769230769234 | Has no output, distance is 1.4444444444444444 | Has no output, distance is 3.465552178318136 | Has no output, distance is 1.6666666666666665 | Has no output, distance is 1.0 | Has no output, distance is 2.4696969696969697 | Has no output, distance is 4.937387711103126

    SELECT
        "PROSPECT_LISTS_PROSPECTS"."ID" "ID",
        "PROSPECTS"."FIRST_NAME" 
    FROM
        "PROSPECTS" 
    INNER JOIN
        "PROSPECT_LISTS_PROSPECTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."RELATED_ID" = "PROSPECTS"."ID" 
    INNER JOIN
        "PROSPECT_LISTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "PROSPECT_LIST_CAMPAIGNS" 
            ON "PROSPECT_LIST_CAMPAIGNS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "CAMPAIGNS" 
            ON "CAMPAIGNS"."ID" = "PROSPECT_LIST_CAMPAIGNS"."CAMPAIGN_ID" 
    WHERE
        NOT ("PROSPECT_LISTS"."DELETED" = 0) 
        AND (
            "PROSPECT_LIST_CAMPAIGNS"."DELETED" = 0
        ) 
        AND (
            "PROSPECT_LISTS_PROSPECTS"."DELETED" = 0
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 92
Path 7/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.4629629629629628 | Has no output, distance is 1.473684210526316 | Has no output, distance is 1.4833333333333334 | Has no output, distance is 4.336561643171191 | Has no output, distance is 2.4615384615384617 | Has no output, distance is 0.5 | Has no output, distance is 4.114901960784314 | Has no output, distance is 0.5 | Has no output, distance is 1.833333333333333 | Has no output, distance is 12.25211051005048

    SELECT
        "PROSPECT_LISTS_PROSPECTS"."ID" "ID",
        "PROSPECTS"."FIRST_NAME" 
    FROM
        "PROSPECTS" 
    INNER JOIN
        "PROSPECT_LISTS_PROSPECTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."RELATED_ID" = "PROSPECTS"."ID" 
    INNER JOIN
        "PROSPECT_LISTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "PROSPECT_LIST_CAMPAIGNS" 
            ON "PROSPECT_LIST_CAMPAIGNS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "CAMPAIGNS" 
            ON "CAMPAIGNS"."ID" = "PROSPECT_LIST_CAMPAIGNS"."CAMPAIGN_ID" 
    WHERE
        (
            "PROSPECT_LISTS"."DELETED" IS NULL
        ) 
        AND (
            "PROSPECT_LIST_CAMPAIGNS"."DELETED" = 0
        ) 
        AND (
            "PROSPECT_LISTS_PROSPECTS"."DELETED" = 0
        )
-----------------------------------

-----------------------------------
Query: suitecrm-process2, query 92
Path 10/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 1.0 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 1.0 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 1.6666666666666665 | Has no output, distance is 0.5

    SELECT
        "PROSPECT_LISTS_PROSPECTS"."ID" "ID",
        "PROSPECTS"."FIRST_NAME" 
    FROM
        "PROSPECTS" 
    RIGHT JOIN
        "PROSPECT_LISTS_PROSPECTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."RELATED_ID" = "PROSPECTS"."ID" 
    INNER JOIN
        "PROSPECT_LISTS" 
            ON "PROSPECT_LISTS_PROSPECTS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "PROSPECT_LIST_CAMPAIGNS" 
            ON "PROSPECT_LIST_CAMPAIGNS"."PROSPECT_LIST_ID" = "PROSPECT_LISTS"."ID" 
    INNER JOIN
        "CAMPAIGNS" 
            ON "CAMPAIGNS"."ID" = "PROSPECT_LIST_CAMPAIGNS"."CAMPAIGN_ID" 
    WHERE
        (
            (
                "PROSPECTS"."ID" IS NULL
            ) 
            AND (
                "PROSPECT_LISTS_PROSPECTS"."RELATED_ID" IS NULL
            )
        ) 
        AND (
            "PROSPECT_LIST_CAMPAIGNS"."DELETED" = 0 
            AND "PROSPECT_LISTS_PROSPECTS"."DELETED" = 0 
            AND "PROSPECT_LISTS"."DELETED" = 0
        )
-----------------------------------
