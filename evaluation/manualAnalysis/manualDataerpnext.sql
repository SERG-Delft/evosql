
-----------------------------------
Query: erpnext-process0, query 86
Path 11/21 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "B"."COST_CENTER",
        "BA"."BUDGET_AMOUNT",
        "B"."MONTHLY_DISTRIBUTION",
        "B"."ACTION_IF_ANNUAL_BUDGET_EXCEEDED",
        "B"."ACTION_IF_ACCUMULATED_MONTHLY_BUDGET_EXCEEDED" 
    FROM
        "TABBUDGET" "B" 
    RIGHT JOIN
        "TABBUDGET ACCOUNT" "BA" 
            ON "B"."NAME" = "BA"."PARENT" 
    WHERE
        (
            (
                "B"."NAME" IS NULL
            ) 
            AND (
                "BA"."PARENT" IS NOT NULL
            )
        ) 
        AND (
            "BA"."ACCOUNT" = 'Cost of Goods Sold - _TC' 
            AND EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABCOST CENTER" 
                WHERE
                    "LFT" <= 8 
                    AND "RGT" >= 9 
                    AND "NAME" = "B"."COST_CENTER"
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process0, query 86
Path 12/21 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "B"."COST_CENTER",
        "BA"."BUDGET_AMOUNT",
        "B"."MONTHLY_DISTRIBUTION",
        "B"."ACTION_IF_ANNUAL_BUDGET_EXCEEDED",
        "B"."ACTION_IF_ACCUMULATED_MONTHLY_BUDGET_EXCEEDED" 
    FROM
        "TABBUDGET" "B" 
    RIGHT JOIN
        "TABBUDGET ACCOUNT" "BA" 
            ON "B"."NAME" = "BA"."PARENT" 
    WHERE
        (
            (
                "B"."NAME" IS NULL
            ) 
            AND (
                "BA"."PARENT" IS NULL
            )
        ) 
        AND (
            "BA"."ACCOUNT" = 'Cost of Goods Sold - _TC' 
            AND EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABCOST CENTER" 
                WHERE
                    "LFT" <= 8 
                    AND "RGT" >= 9 
                    AND "NAME" = "B"."COST_CENTER"
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process0, query 87
Path 6/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TS"."NAME" AS "NAME",
        "TSD"."FROM_TIME" AS "FROM_TIME",
        "TSD"."TO_TIME" AS "TO_TIME" 
    FROM
        "TABTIMESHEET DETAIL" "TSD" 
    INNER JOIN
        "TABTIMESHEET" "TS" 
            ON "TSD"."PARENT" = "TS"."NAME" 
    WHERE
        (
            "TSD"."FROM_TIME" IS NULL
        ) 
        AND (
            '2017-02-09 12:25:52.554795' < "TSD"."TO_TIME"
        ) 
        AND NOT (('2017-02-09 13:25:52.554795' < "TSD"."TO_TIME")) 
        AND NOT (('2017-02-09 13:25:52.554795' >= "TSD"."TO_TIME")) 
        AND (
            "TSD"."WORKSTATION" = '_Test Workstation 1'
        ) 
        AND (
            "TSD"."NAME" <> 'No Name'
        ) 
        AND (
            "TS"."NAME" <> 'No Name'
        ) 
        AND (
            "TS"."DOCSTATUS" < 2
        )
-----------------------------------

-----------------------------------
Query: erpnext-process0, query 87
Path 8/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TS"."NAME" AS "NAME",
        "TSD"."FROM_TIME" AS "FROM_TIME",
        "TSD"."TO_TIME" AS "TO_TIME" 
    FROM
        "TABTIMESHEET DETAIL" "TSD" 
    INNER JOIN
        "TABTIMESHEET" "TS" 
            ON "TSD"."PARENT" = "TS"."NAME" 
    WHERE
        (
            "TSD"."TO_TIME" IS NULL
        ) 
        AND (
            '2017-02-09 12:25:52.554795' > "TSD"."FROM_TIME"
        ) 
        AND NOT (('2017-02-09 13:25:52.554795' > "TSD"."FROM_TIME")) 
        AND NOT (('2017-02-09 12:25:52.554795' <= "TSD"."FROM_TIME")) 
        AND (
            "TSD"."WORKSTATION" = '_Test Workstation 1'
        ) 
        AND (
            "TSD"."NAME" <> 'No Name'
        ) 
        AND (
            "TS"."NAME" <> 'No Name'
        ) 
        AND (
            "TS"."DOCSTATUS" < 2
        )
-----------------------------------

-----------------------------------
Query: erpnext-process0, query 87
Path 11/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 2.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TS"."NAME" AS "NAME",
        "TSD"."FROM_TIME" AS "FROM_TIME",
        "TSD"."TO_TIME" AS "TO_TIME" 
    FROM
        "TABTIMESHEET DETAIL" "TSD" 
    INNER JOIN
        "TABTIMESHEET" "TS" 
            ON "TSD"."PARENT" = "TS"."NAME" 
    WHERE
        (
            "TSD"."FROM_TIME" IS NULL
        ) 
        AND (
            '2017-02-09 13:25:52.554795' < "TSD"."TO_TIME"
        ) 
        AND NOT (('2017-02-09 12:25:52.554795' < "TSD"."TO_TIME")) 
        AND NOT (('2017-02-09 13:25:52.554795' >= "TSD"."TO_TIME")) 
        AND (
            "TSD"."WORKSTATION" = '_Test Workstation 1'
        ) 
        AND (
            "TSD"."NAME" <> 'No Name'
        ) 
        AND (
            "TS"."NAME" <> 'No Name'
        ) 
        AND (
            "TS"."DOCSTATUS" < 2
        )
-----------------------------------

-----------------------------------
Query: erpnext-process0, query 87
Path 13/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TS"."NAME" AS "NAME",
        "TSD"."FROM_TIME" AS "FROM_TIME",
        "TSD"."TO_TIME" AS "TO_TIME" 
    FROM
        "TABTIMESHEET DETAIL" "TSD" 
    INNER JOIN
        "TABTIMESHEET" "TS" 
            ON "TSD"."PARENT" = "TS"."NAME" 
    WHERE
        (
            "TSD"."TO_TIME" IS NULL
        ) 
        AND (
            '2017-02-09 13:25:52.554795' > "TSD"."FROM_TIME"
        ) 
        AND NOT (('2017-02-09 12:25:52.554795' > "TSD"."FROM_TIME")) 
        AND NOT (('2017-02-09 12:25:52.554795' <= "TSD"."FROM_TIME")) 
        AND (
            "TSD"."WORKSTATION" = '_Test Workstation 1'
        ) 
        AND (
            "TSD"."NAME" <> 'No Name'
        ) 
        AND (
            "TS"."NAME" <> 'No Name'
        ) 
        AND (
            "TS"."DOCSTATUS" < 2
        )
-----------------------------------

-----------------------------------
Query: erpnext-process1, query 71
Path 8/8 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABQUOTATION" 
    WHERE
        (
            (
                "TABQUOTATION"."DOCSTATUS" IS NULL
            )
        ) 
        AND (
            "TABQUOTATION"."CUSTOMER" = '_Test Customer 1'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process1, query 82
Path 11/11 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE RECEIPT" 
    WHERE
        (
            (
                "TABPURCHASE RECEIPT"."DOCSTATUS" IS NULL
            )
        ) 
        AND (
            IFNULL("TABPURCHASE RECEIPT"."STATUS", '') NOT IN (
                'Completed', 'Closed'
            ) 
            AND "TABPURCHASE RECEIPT"."SUPPLIER" = '_Test Supplier'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process1, query 86
Path 18/21 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5

    SELECT
        "NAME",
        "COMMUNICATION_TYPE",
        "COMMUNICATION_MEDIUM",
        "COMMENT_TYPE",
        "CONTENT",
        "SENDER",
        "SENDER_FULL_NAME",
        "CREATION",
        "SUBJECT",
        "DELIVERY_STATUS",
        "_LIKED_BY",
        "TIMELINE_DOCTYPE",
        "TIMELINE_NAME",
        "REFERENCE_DOCTYPE",
        "REFERENCE_NAME",
        "LINK_DOCTYPE",
        "LINK_NAME",
        'Communication' AS "DOCTYPE" 
    FROM
        "TABCOMMUNICATION" 
    WHERE
        NOT ("COMMUNICATION_TYPE" = 'Comment') 
        AND (
            "COMMENT_TYPE" IN (
                'Created', 'Updated', 'Submitted', 'Cancelled', 'Deleted'
            )
        ) 
        AND NOT ("COMMUNICATION_TYPE" = 'Communication') 
        AND (
            (
                "TIMELINE_DOCTYPE" = 'Task' 
                AND "TIMELINE_NAME" = 'TASK00009'
            )
        ) 
        AND NOT (("REFERENCE_DOCTYPE" = 'Task' 
        AND "REFERENCE_NAME" = 'TASK00009')) 
        AND (
            "COMMUNICATION_TYPE" IN (
                'Communication', 'Comment'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 82
Path 2/11 - 0 successes, 10 failures
Failure messages: Has no output, distance is 35.04573560919288 | Has no output, distance is 34.895104178975146 | Has no output, distance is 34.895104178975146 | Has no output, distance is 34.895104178975146 | Has no output, distance is 34.895104178975146 | Has no output, distance is 34.895104178975146 | Has no output, distance is 34.895104178975146 | Has no output, distance is 34.895104178975146 | Has no output, distance is 34.895104178975146 | Has no output, distance is 34.895104178975146

    SELECT
        "NAME",
        "PARENT",
        "DEFKEY",
        "DEFVALUE" 
    FROM
        "TABDEFAULTVALUE" 
    WHERE
        (
            "PARENT" IN (
                '__default', '__global'
            )
        ) 
        AND (
            SUBSTR("DEFKEY", 1, 1) <> '_'
        ) 
        AND (
            "PARENTTYPE" = 'User Permission'
        ) 
        AND (
            "DEFKEY" = 'Blog Post'
        ) 
        AND (
            "DEFVALUE" = '-test-blog-post'
        ) 
        AND (
            "PARENT" = 'test2@example.com'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 82
Path 4/11 - 0 successes, 10 failures
Failure messages: Has no output, distance is 27.129166666666666 | Has no output, distance is 27.129166666666666 | Has no output, distance is 27.129166666666666 | Has no output, distance is 27.129166666666666 | Has no output, distance is 27.129166666666666 | Has no output, distance is 27.129166666666666 | Has no output, distance is 27.129166666666666 | Has no output, distance is 27.129166666666666 | Has no output, distance is 27.129166666666666 | Has no output, distance is 27.129166666666666

    SELECT
        "NAME",
        "PARENT",
        "DEFKEY",
        "DEFVALUE" 
    FROM
        "TABDEFAULTVALUE" 
    WHERE
        NOT (SUBSTR("DEFKEY", 1, 1) <> '_') 
        AND (
            "PARENT" NOT IN (
                '__default', '__global'
            )
        ) 
        AND (
            "PARENTTYPE" = 'User Permission'
        ) 
        AND (
            "DEFKEY" = 'Blog Post'
        ) 
        AND (
            "DEFVALUE" = '-test-blog-post'
        ) 
        AND (
            "PARENT" = 'test2@example.com'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 85
Path 4/17 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5

    SELECT
        "TABEVENT"."SUBJECT",
        "TABEVENT"."EVENT_TYPE",
        "TABEVENT"."NAME",
        "TABEVENT"."MODIFIED",
        "TABEVENT"."DOCSTATUS" 
    FROM
        "TABEVENT" 
    INNER JOIN
        "TABEVENT ROLE" 
            ON (
                "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME"
            ) 
    WHERE
        NOT ("TABEVENT"."EVENT_TYPE" = 'Public') 
        AND NOT ("TABEVENT"."OWNER" = 'Administrator') 
        AND (
            NOT EXISTS (
                SELECT
                    * 
                FROM
                    "TABEVENT ROLE" 
                WHERE
                    "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                    AND "TABEVENT ROLE"."ROLE" IN (
                        'Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'
                    )
            )
        ) 
        AND (
            "TABEVENT ROLE"."ROLE" = 'System Manager'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 85
Path 5/17 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5

    SELECT
        "TABEVENT"."SUBJECT",
        "TABEVENT"."EVENT_TYPE",
        "TABEVENT"."NAME",
        "TABEVENT"."MODIFIED",
        "TABEVENT"."DOCSTATUS" 
    FROM
        "TABEVENT" 
    INNER JOIN
        "TABEVENT ROLE" 
            ON (
                "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME"
            ) 
    WHERE
        (
            "TABEVENT"."EVENT_TYPE" = 'Public'
        ) 
        AND NOT ("TABEVENT"."OWNER" = 'Administrator') 
        AND (
            NOT EXISTS (
                SELECT
                    * 
                FROM
                    "TABEVENT ROLE" 
                WHERE
                    "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                    AND "TABEVENT ROLE"."ROLE" IN (
                        'Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'
                    )
            )
        ) 
        AND (
            "TABEVENT ROLE"."ROLE" = 'System Manager'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 85
Path 6/17 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5

    SELECT
        "TABEVENT"."SUBJECT",
        "TABEVENT"."EVENT_TYPE",
        "TABEVENT"."NAME",
        "TABEVENT"."MODIFIED",
        "TABEVENT"."DOCSTATUS" 
    FROM
        "TABEVENT" 
    INNER JOIN
        "TABEVENT ROLE" 
            ON (
                "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME"
            ) 
    WHERE
        (
            "TABEVENT"."EVENT_TYPE" IS NULL
        ) 
        AND NOT ("TABEVENT"."OWNER" = 'Administrator') 
        AND (
            NOT EXISTS (
                SELECT
                    * 
                FROM
                    "TABEVENT ROLE" 
                WHERE
                    "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                    AND "TABEVENT ROLE"."ROLE" IN (
                        'Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'
                    )
            )
        ) 
        AND (
            "TABEVENT ROLE"."ROLE" = 'System Manager'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 85
Path 7/17 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5

    SELECT
        "TABEVENT"."SUBJECT",
        "TABEVENT"."EVENT_TYPE",
        "TABEVENT"."NAME",
        "TABEVENT"."MODIFIED",
        "TABEVENT"."DOCSTATUS" 
    FROM
        "TABEVENT" 
    INNER JOIN
        "TABEVENT ROLE" 
            ON (
                "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME"
            ) 
    WHERE
        (
            "TABEVENT"."OWNER" = 'Administrator'
        ) 
        AND NOT ("TABEVENT"."EVENT_TYPE" = 'Public') 
        AND (
            NOT EXISTS (
                SELECT
                    * 
                FROM
                    "TABEVENT ROLE" 
                WHERE
                    "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                    AND "TABEVENT ROLE"."ROLE" IN (
                        'Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'
                    )
            )
        ) 
        AND (
            "TABEVENT ROLE"."ROLE" = 'System Manager'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 85
Path 8/17 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5 | Has no output, distance is 0.5

    SELECT
        "TABEVENT"."SUBJECT",
        "TABEVENT"."EVENT_TYPE",
        "TABEVENT"."NAME",
        "TABEVENT"."MODIFIED",
        "TABEVENT"."DOCSTATUS" 
    FROM
        "TABEVENT" 
    INNER JOIN
        "TABEVENT ROLE" 
            ON (
                "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME"
            ) 
    WHERE
        (
            "TABEVENT"."OWNER" IS NULL
        ) 
        AND NOT ("TABEVENT"."EVENT_TYPE" = 'Public') 
        AND (
            NOT EXISTS (
                SELECT
                    * 
                FROM
                    "TABEVENT ROLE" 
                WHERE
                    "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                    AND "TABEVENT ROLE"."ROLE" IN (
                        'Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'
                    )
            )
        ) 
        AND (
            "TABEVENT ROLE"."ROLE" = 'System Manager'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 85
Path 11/17 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "TABEVENT"."SUBJECT",
        "TABEVENT"."EVENT_TYPE",
        "TABEVENT"."NAME",
        "TABEVENT"."MODIFIED",
        "TABEVENT"."DOCSTATUS" 
    FROM
        "TABEVENT" 
    RIGHT JOIN
        "TABEVENT ROLE" 
            ON (
                "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME"
            ) 
    WHERE
        (
            (
                "TABEVENT"."NAME" IS NULL
            ) 
            AND (
                "TABEVENT ROLE"."PARENT" IS NOT NULL
            )
        ) 
        AND (
            "TABEVENT ROLE"."ROLE" = 'System Manager' 
            AND (
                EXISTS (
                    SELECT
                        * 
                    FROM
                        "TABEVENT ROLE" 
                    WHERE
                        "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                        AND "TABEVENT ROLE"."ROLE" IN (
                            'Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'
                        )
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 85
Path 12/17 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "TABEVENT"."SUBJECT",
        "TABEVENT"."EVENT_TYPE",
        "TABEVENT"."NAME",
        "TABEVENT"."MODIFIED",
        "TABEVENT"."DOCSTATUS" 
    FROM
        "TABEVENT" 
    RIGHT JOIN
        "TABEVENT ROLE" 
            ON (
                "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME"
            ) 
    WHERE
        (
            (
                "TABEVENT"."NAME" IS NULL
            ) 
            AND (
                "TABEVENT ROLE"."PARENT" IS NULL
            )
        ) 
        AND (
            "TABEVENT ROLE"."ROLE" = 'System Manager' 
            AND (
                EXISTS (
                    SELECT
                        * 
                    FROM
                        "TABEVENT ROLE" 
                    WHERE
                        "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                        AND "TABEVENT ROLE"."ROLE" IN (
                            'Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'
                        )
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 87
Path 6/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TS"."NAME" AS "NAME",
        "TSD"."FROM_TIME" AS "FROM_TIME",
        "TSD"."TO_TIME" AS "TO_TIME" 
    FROM
        "TABTIMESHEET DETAIL" "TSD" 
    INNER JOIN
        "TABTIMESHEET" "TS" 
            ON "TSD"."PARENT" = "TS"."NAME" 
    WHERE
        (
            "TSD"."FROM_TIME" IS NULL
        ) 
        AND (
            '2017-02-09 13:55:59.427627' < "TSD"."TO_TIME"
        ) 
        AND NOT (('2017-02-09 15:55:59.427627' < "TSD"."TO_TIME")) 
        AND NOT (('2017-02-09 15:55:59.427627' >= "TSD"."TO_TIME")) 
        AND (
            "TS"."EMPLOYEE" = '_T-Employee-0001'
        ) 
        AND (
            "TSD"."NAME" <> 'df9353a452'
        ) 
        AND (
            "TS"."NAME" <> 'TS-00012'
        ) 
        AND (
            "TS"."DOCSTATUS" < 2
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 87
Path 8/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TS"."NAME" AS "NAME",
        "TSD"."FROM_TIME" AS "FROM_TIME",
        "TSD"."TO_TIME" AS "TO_TIME" 
    FROM
        "TABTIMESHEET DETAIL" "TSD" 
    INNER JOIN
        "TABTIMESHEET" "TS" 
            ON "TSD"."PARENT" = "TS"."NAME" 
    WHERE
        (
            "TSD"."TO_TIME" IS NULL
        ) 
        AND (
            '2017-02-09 13:55:59.427627' > "TSD"."FROM_TIME"
        ) 
        AND NOT (('2017-02-09 15:55:59.427627' > "TSD"."FROM_TIME")) 
        AND NOT (('2017-02-09 13:55:59.427627' <= "TSD"."FROM_TIME")) 
        AND (
            "TS"."EMPLOYEE" = '_T-Employee-0001'
        ) 
        AND (
            "TSD"."NAME" <> 'df9353a452'
        ) 
        AND (
            "TS"."NAME" <> 'TS-00012'
        ) 
        AND (
            "TS"."DOCSTATUS" < 2
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 87
Path 11/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 2.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TS"."NAME" AS "NAME",
        "TSD"."FROM_TIME" AS "FROM_TIME",
        "TSD"."TO_TIME" AS "TO_TIME" 
    FROM
        "TABTIMESHEET DETAIL" "TSD" 
    INNER JOIN
        "TABTIMESHEET" "TS" 
            ON "TSD"."PARENT" = "TS"."NAME" 
    WHERE
        (
            "TSD"."FROM_TIME" IS NULL
        ) 
        AND (
            '2017-02-09 15:55:59.427627' < "TSD"."TO_TIME"
        ) 
        AND NOT (('2017-02-09 13:55:59.427627' < "TSD"."TO_TIME")) 
        AND NOT (('2017-02-09 15:55:59.427627' >= "TSD"."TO_TIME")) 
        AND (
            "TS"."EMPLOYEE" = '_T-Employee-0001'
        ) 
        AND (
            "TSD"."NAME" <> 'df9353a452'
        ) 
        AND (
            "TS"."NAME" <> 'TS-00012'
        ) 
        AND (
            "TS"."DOCSTATUS" < 2
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 87
Path 13/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TS"."NAME" AS "NAME",
        "TSD"."FROM_TIME" AS "FROM_TIME",
        "TSD"."TO_TIME" AS "TO_TIME" 
    FROM
        "TABTIMESHEET DETAIL" "TSD" 
    INNER JOIN
        "TABTIMESHEET" "TS" 
            ON "TSD"."PARENT" = "TS"."NAME" 
    WHERE
        (
            "TSD"."TO_TIME" IS NULL
        ) 
        AND (
            '2017-02-09 15:55:59.427627' > "TSD"."FROM_TIME"
        ) 
        AND NOT (('2017-02-09 13:55:59.427627' > "TSD"."FROM_TIME")) 
        AND NOT (('2017-02-09 13:55:59.427627' <= "TSD"."FROM_TIME")) 
        AND (
            "TS"."EMPLOYEE" = '_T-Employee-0001'
        ) 
        AND (
            "TSD"."NAME" <> 'df9353a452'
        ) 
        AND (
            "TS"."NAME" <> 'TS-00012'
        ) 
        AND (
            "TS"."DOCSTATUS" < 2
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 1/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 230.21912244992293 | Has no output, distance is 61.24185879300864 | Has no output, distance is 207.59222444222445 | Has no output, distance is 211.755479714007 | Has no output, distance is 174.94212438937208 | Has no output, distance is 31.955769490096923 | Has no output, distance is 209.64032721217805 | Has no output, distance is 70.4012476410824 | Has no output, distance is 231.22853396603398 | Has no output, distance is 219.6164530877131

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 2/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 60.18384721018681 | Has no output, distance is 172.0 | Has no output, distance is 225.96904761904761 | Has no output, distance is 11.30515129119207 | Has no output, distance is 9.912168388749965 | Has no output, distance is 4.116161616161616 | Has no output, distance is 369.30227364685436 | Has no output, distance is 170.99074074074073 | Has no output, distance is 3.387094444979301 | Has no output, distance is 32.53701803183972

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_CITY", '') = '') 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 3/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 221.0 | Has no output, distance is 10.33828730722316 | Has no output, distance is 172.29854456402444 | Has no output, distance is 12.535050521449314 | Has no output, distance is 25.0 | Has no output, distance is 7.062134502923977 | Has no output, distance is 199.44644115574349 | Has no output, distance is 13.298035970302188 | Has no output, distance is 35.468400417524116

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("COMPANY", '') = '_Test Company') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 4/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 52.25761531642289 | Has no output, distance is 11.824163049594084 | Has no output, distance is 390.0 | Has no output, distance is 200.38795280824195 | Has no output, distance is 27.92558392402695 | Has no output, distance is 41.01533568577907 | Has no output, distance is 35.20478187431224 | Has no output, distance is 14.645132286958622 | Has no output, distance is 200.25539215686274 | Has no output, distance is 221.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_STATE", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 5/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 37.88671938886534 | Has no output, distance is 171.9457215836526 | Has no output, distance is 33.69091329429439 | Has no output, distance is 67.11317047648889 | Has no output, distance is 214.01927388419216 | Has no output, distance is 221.0 | Has no output, distance is 153.2397007286624 | Has no output, distance is 11.417575066567533 | Has no output, distance is 161.42839034239066 | Has no output, distance is 46.065600976897144

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_COUNTY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 6/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 23.0372894374747 | Has no output, distance is 3.96875 | Has no output, distance is 24.745748447889348 | Has no output, distance is 219.6901849787932 | Has no output, distance is 16.545944543432405 | Has no output, distance is 211.65697598612263 | Has no output, distance is 15.449745460979917 | Has no output, distance is 231.63386100638786 | Has no output, distance is 37.43105967169885 | Has no output, distance is 221.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SUPPLIER_TYPE", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 7/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 24.239479363068735 | Has no output, distance is 184.59748478716435 | Has no output, distance is 35.65633765751471 | Has no output, distance is 221.0 | Has no output, distance is 35.593740981240984 | Has no output, distance is 59.069566309538054 | Has no output, distance is 36.11082917806831 | Has no output, distance is 60.09675609478241 | Has no output, distance is 20.563944284621556 | Has no output, distance is 368.9883626177744

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_COUNTRY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 8/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 14.729546444554568 | Has no output, distance is 2.980392156862745 | Has no output, distance is 45.865590729801895 | Has no output, distance is 25.0 | Has no output, distance is 194.0 | Has no output, distance is 25.0 | Has no output, distance is 172.94127851504902 | Has no output, distance is 25.0 | Has no output, distance is 2.6533333333333333 | Has no output, distance is 36.433191452610956

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("CUSTOMER", '') = '_Test Customer') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 11/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 196.0 | Has no output, distance is 365.0 | Has no output, distance is 8.318014781782898 | Has no output, distance is 182.3676911881253 | Has no output, distance is 221.0 | Has no output, distance is 169.0 | Has no output, distance is 36.53823529411765 | Has no output, distance is 199.89007516490258 | Has no output, distance is 54.04852910988535 | Has no output, distance is 13.888286707001166

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_COUNTRY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 12/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 198.35714285714286 | Has no output, distance is 48.069022869022874 | Has no output, distance is 46.024150044758876 | Has no output, distance is 204.52292425215964 | Has no output, distance is 17.296248218425358 | Has no output, distance is 8.107128636685639 | Has no output, distance is 20.46391129127131 | Has no output, distance is 36.43254642605666 | Has no output, distance is 7.912820512820513 | Has no output, distance is 35.09059549851122

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SUPPLIER", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 13/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 196.0 | Has no output, distance is 194.0 | Has no output, distance is 47.09377247229615 | Has no output, distance is 22.10393133201393 | Has no output, distance is 46.154237271871196 | Has no output, distance is 41.52790203266075 | Has no output, distance is 15.267506710356148 | Has no output, distance is 208.46666666666667 | Has no output, distance is 214.09471620227038 | Has no output, distance is 27.026870778109696

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_COUNTY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 15/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 42.88473584451151 | Has no output, distance is 42.58377387755538 | Has no output, distance is 29.4 | Has no output, distance is 1.0 | Has no output, distance is 225.18069727891157 | Has no output, distance is 194.0 | Has no output, distance is 172.12653288740245 | Has no output, distance is 24.30119864958082 | Has no output, distance is 207.12607527169044 | Has no output, distance is 3.0257936507936507

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_STATE", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 17/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 205.65036559343744 | Has no output, distance is 234.18901369613653 | Has no output, distance is 169.0 | Has no output, distance is 54.472485333539176 | Has no output, distance is 33.91918139608809 | Has no output, distance is 37.91904761904762 | Has no output, distance is 277.2871466871527 | Has no output, distance is 185.9371856225866 | Has no output, distance is 47.75703571104971 | Has no output, distance is 65.29411871197777

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ("FROM_DATE" > '2015-01-03') 
        AND (
            "FROM_DATE" < '2015-01-09'
        ) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' > "FROM_DATE" 
        AND '2015-01-03' < "TO_DATE")) 
        AND NOT (('2015-01-03' = "FROM_DATE" 
        AND '2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 18/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.652236263073156 | Has no output, distance is 15.139984269742875 | Has no output, distance is 25.5315873015873 | Has no output, distance is 33.62961253061533 | Has no output, distance is 37.705557397162835 | Has no output, distance is 22.261841219377217 | Has no output, distance is 37.0620997027247 | Has no output, distance is 25.272947008975137 | Has no output, distance is 27.374047865021073 | Has no output, distance is 204.03288808447004

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            "FROM_DATE" IS NULL
        ) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' < "TO_DATE")) 
        AND NOT (('2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 19/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 205.75029570631145 | Has no output, distance is 28.43611186288821 | Has no output, distance is 163.8752565993639 | Has no output, distance is 390.0 | Has no output, distance is 58.64939030540366 | Has no output, distance is 199.1485578498853 | Has no output, distance is 11.092524537995553 | Has no output, distance is 46.1236054834327 | Has no output, distance is 36.16870083867899 | Has no output, distance is 61.404989350358555

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ("FROM_DATE" < '2015-01-09') 
        AND (
            "FROM_DATE" > '2015-01-03'
        ) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' > "FROM_DATE" 
        AND '2015-01-03' < "TO_DATE")) 
        AND NOT (('2015-01-03' = "FROM_DATE" 
        AND '2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 20/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 43.92986994481553 | Has no output, distance is 37.8540277873722 | Has no output, distance is 65.01703091714651 | Has no output, distance is 45.874851909163624 | Has no output, distance is 247.13061176038934 | Has no output, distance is 47.89519947073498 | Has no output, distance is 24.195178616717445 | Has no output, distance is 210.29201078737026 | Has no output, distance is 15.17398126273756 | Has no output, distance is 209.25565295849177

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            "TO_DATE" > '2015-01-03'
        ) 
        AND (
            "TO_DATE" < '2015-01-09'
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' > "FROM_DATE" 
        AND '2015-01-03' < "TO_DATE")) 
        AND NOT (('2015-01-03' = "FROM_DATE" 
        AND '2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 21/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 28.32108488510332 | Has no output, distance is 25.0 | Has no output, distance is 206.15208691903285 | Has no output, distance is 100.75148709450922 | Has no output, distance is 33.17728869023865 | Has no output, distance is 47.82574137776447 | Has no output, distance is 14.666584918073712 | Has no output, distance is 194.0 | Has no output, distance is 15.296516486820627 | Has no output, distance is 60.36429884775625

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ("TO_DATE" > '2015-01-03') 
        AND (
            "TO_DATE" < '2015-01-09'
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' > "FROM_DATE" 
        AND '2015-01-03' < "TO_DATE")) 
        AND NOT (('2015-01-03' = "FROM_DATE" 
        AND '2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 22/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 36.207843137254905 | Has no output, distance is 28.794642857142858 | Has no output, distance is 199.27518796992481 | Has no output, distance is 8.608373038024201 | Has no output, distance is 36.186077065481385 | Has no output, distance is 390.0 | Has no output, distance is 15.439480147525039 | Has no output, distance is 26.485647937838575 | Has no output, distance is 6.687946179902385

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            "TO_DATE" IS NULL
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' > "FROM_DATE")) 
        AND NOT (('2015-01-03' = "FROM_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 23/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 191.35019103625137 | Has no output, distance is 45.35227489621616 | Has no output, distance is 197.0 | Has no output, distance is 207.00349302764585 | Has no output, distance is 14.725441399414013 | Has no output, distance is 42.45719412864355 | Has no output, distance is 197.75 | Has no output, distance is 207.01838206079105 | Has no output, distance is 25.69812832775003 | Has no output, distance is 34.893407960199006

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ("TO_DATE" < '2015-01-09') 
        AND (
            "TO_DATE" > '2015-01-03'
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' > "FROM_DATE" 
        AND '2015-01-03' < "TO_DATE")) 
        AND NOT (('2015-01-03' = "FROM_DATE" 
        AND '2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 24/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 191.21737445624845 | Has no output, distance is 19.692243403141468 | Has no output, distance is 11.34312837414496 | Has no output, distance is 243.81490247276176 | Has no output, distance is 11.470595851800415 | Has no output, distance is 212.60624549029976 | Has no output, distance is 206.48561280249805 | Has no output, distance is 36.49540348974908 | Has no output, distance is 28.25072961968793 | Has no output, distance is 209.53160323933957

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            '2015-01-03' > "FROM_DATE"
        ) 
        AND (
            '2015-01-03' < "TO_DATE"
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' = "FROM_DATE" 
        AND '2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 25/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 205.98877772191832 | Has no output, distance is 194.64061029626754 | Has no output, distance is 81.2125 | Has no output, distance is 33.98763669627779 | Has no output, distance is 369.3954313878594 | Has no output, distance is 194.0 | Has no output, distance is 181.54003908419384 | Has no output, distance is 11.850202826395696 | Has no output, distance is 9.522627372627372 | Has no output, distance is 39.63618269322434

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ('2015-01-03' > "FROM_DATE") 
        AND (
            '2015-01-03' < "TO_DATE"
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' = "FROM_DATE" 
        AND '2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 26/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 47.52333230184414 | Has no output, distance is 55.00992004948563 | Has no output, distance is 16.56747002233471 | Has no output, distance is 231.99152062239824 | Has no output, distance is 179.99185543139032 | Has no output, distance is 48.85918322418594 | Has no output, distance is 176.83586552336553 | Has no output, distance is 53.947872332811585 | Has no output, distance is 26.61987431504387 | Has no output, distance is 221.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            "FROM_DATE" IS NULL
        ) 
        AND (
            '2015-01-03' < "TO_DATE"
        ) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 27/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 29.036058304536716 | Has no output, distance is 22.734019328273988 | Has no output, distance is 390.0 | Has no output, distance is 74.26979869233179 | Has no output, distance is 22.38431880080652 | Has no output, distance is 65.87617770590981 | Has no output, distance is 74.09926063016724 | Has no output, distance is 41.591375661375665 | Has no output, distance is 231.2348398818987 | Has no output, distance is 243.82824379445114

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ('2015-01-03' < "TO_DATE") 
        AND (
            '2015-01-03' > "FROM_DATE"
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' = "FROM_DATE" 
        AND '2015-01-09' = "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 28/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 390.0 | Has no output, distance is 46.48992784210411 | Has no output, distance is 10.021445571497328 | Has no output, distance is 46.3480437730842 | Has no output, distance is 171.81884057971016 | Has no output, distance is 20.64754251694241 | Has no output, distance is 181.51123877361306 | Has no output, distance is 19.375482111337718 | Has no output, distance is 49.0788186162316 | Has no output, distance is 192.08380473977954

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            "TO_DATE" IS NULL
        ) 
        AND (
            '2015-01-03' > "FROM_DATE"
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' = "FROM_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 29/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 37.35559788743751 | Has no output, distance is 391.0 | Has no output, distance is 357.91978021978025 | Has no output, distance is 23.248955722639934 | Has no output, distance is 227.4146796827951 | Has no output, distance is 113.1027292018595 | Has no output, distance is 93.75876162575953 | Has no output, distance is 182.98563721085918 | Has no output, distance is 234.34504259200136 | Has no output, distance is 211.73174429897352

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            '2015-01-03' = "FROM_DATE"
        ) 
        AND (
            '2015-01-09' = "TO_DATE"
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' > "FROM_DATE" 
        AND '2015-01-03' < "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 30/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 196.85714285714286 | Has no output, distance is 44.9861586975822 | Has no output, distance is 200.3720668220668 | Has no output, distance is 32.86676199860873 | Has no output, distance is 39.50987824990415 | Has no output, distance is 41.39965331278891 | Has no output, distance is 208.44831834831837 | Has no output, distance is 11.526567876567878 | Has no output, distance is 232.97687512970123 | Has no output, distance is 48.650572505253166

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ('2015-01-03' = "FROM_DATE") 
        AND (
            '2015-01-09' = "TO_DATE"
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' > "FROM_DATE" 
        AND '2015-01-03' < "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 31/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 10.104973065819667 | Has no output, distance is 48.47224156607753 | Has no output, distance is 205.7199233716475 | Has no output, distance is 26.59601604820095 | Has no output, distance is 47.843555503126936 | Has no output, distance is 11.880841625181247 | Has no output, distance is 187.688420927028 | Has no output, distance is 37.03592883549629 | Has no output, distance is 14.589459459459459 | Has no output, distance is 8.697744615087414

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            "FROM_DATE" IS NULL
        ) 
        AND (
            '2015-01-09' = "TO_DATE"
        ) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' < "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 32/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 234.84564006957356 | Has no output, distance is 130.54840714840714 | Has no output, distance is 53.640750428667495 | Has no output, distance is 19.441533561641783 | Has no output, distance is 215.16267437098892 | Has no output, distance is 29.296892508453418 | Has no output, distance is 18.789840362668897 | Has no output, distance is 25.5 | Has no output, distance is 37.557458006583495 | Has no output, distance is 394.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ('2015-01-09' = "TO_DATE") 
        AND (
            '2015-01-03' = "FROM_DATE"
        ) 
        AND NOT (("FROM_DATE" > '2015-01-03' 
        AND "FROM_DATE" < '2015-01-09')) 
        AND NOT (("TO_DATE" > '2015-01-03' 
        AND "TO_DATE" < '2015-01-09')) 
        AND NOT (('2015-01-03' > "FROM_DATE" 
        AND '2015-01-03' < "TO_DATE")) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 34/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 35.3948170456994 | Has no output, distance is 52.98974982224532 | Has no output, distance is 51.42217874958948 | Has no output, distance is 38.17071822641804 | Has no output, distance is 226.90488605902473 | Has no output, distance is 186.5186462507126 | Has no output, distance is 219.54168454546732 | Has no output, distance is 17.00208536189549 | Has no output, distance is 70.62291577174108 | Has no output, distance is 205.73498114820066

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ("NAME" <> 'TR0008') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 35/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 69.69459688634946 | Has no output, distance is 186.01517277202936 | Has no output, distance is 40.05769230769231 | Has no output, distance is 3.929029605263158 | Has no output, distance is 32.082251082251084 | Has no output, distance is 46.69564834616687 | Has no output, distance is 203.8612536818458 | Has no output, distance is 219.84786051825176 | Has no output, distance is 48.371649994848156 | Has no output, distance is 36.34993674063147

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SHIPPING_CITY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 36/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 169.0 | Has no output, distance is 36.601415385309146 | Has no output, distance is 14.36422013303352 | Has no output, distance is 15.921498694117917 | Has no output, distance is 35.743335561885985 | Has no output, distance is 59.61867418585107 | Has no output, distance is 44.158609867777955 | Has no output, distance is 14.796715168839759 | Has no output, distance is 196.0 | Has no output, distance is 30.723105841526895

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SHIPPING_CITY" IS NULL
            )
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 37/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 23.316235356180144 | Has no output, distance is 37.707219351615564 | Has no output, distance is 18.21057222379975 | Has no output, distance is 11.247211328853567 | Has no output, distance is 199.947920981773 | Has no output, distance is 35.819022283686394 | Has no output, distance is 36.064000183473915 | Has no output, distance is 15.367437279136063 | Has no output, distance is 202.24633400368694 | Has no output, distance is 46.415597027671325

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "COMPANY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 38/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 4.131944444444445 | Has no output, distance is 3.38399209486166 | Has no output, distance is 15.411823176462358 | Has no output, distance is 196.5 | Has no output, distance is 44.81448992852502 | Has no output, distance is 53.2999814057374 | Has no output, distance is 12.24352450701758 | Has no output, distance is 41.739224734365514 | Has no output, distance is 16.91099935202074 | Has no output, distance is 25.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "COMPANY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 39/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 196.38717948717948 | Has no output, distance is 35.522615107039925 | Has no output, distance is 47.48773718740962 | Has no output, distance is 25.102938598814145 | Has no output, distance is 202.97287950491446 | Has no output, distance is 13.924463886556282 | Has no output, distance is 45.72307243064924 | Has no output, distance is 56.586582376262044 | Has no output, distance is 221.0 | Has no output, distance is 5.7334654813135035

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SHIPPING_STATE" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 40/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 32.87510233918128 | Has no output, distance is 33.96103031554833 | Has no output, distance is 46.18146533436317 | Has no output, distance is 221.0 | Has no output, distance is 205.41157436077592 | Has no output, distance is 43.977402672420936 | Has no output, distance is 19.206275628734943 | Has no output, distance is 20.440471753044477 | Has no output, distance is 216.8413338856859 | Has no output, distance is 226.2031991744066

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SHIPPING_STATE" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 41/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 15.369702459376374 | Has no output, distance is 10.358674119974431 | Has no output, distance is 51.25472442664225 | Has no output, distance is 2.4502732240437157 | Has no output, distance is 35.08269656699889 | Has no output, distance is 39.21714493970857 | Has no output, distance is 11.479921388779683 | Has no output, distance is 45.749843674843675 | Has no output, distance is 20.391467469077114 | Has no output, distance is 102.44932126051133

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SHIPPING_COUNTY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 42/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 242.38430654313007 | Has no output, distance is 39.83289834858184 | Has no output, distance is 365.0 | Has no output, distance is 221.0 | Has no output, distance is 205.56894616548567 | Has no output, distance is 30.798076923076923 | Has no output, distance is 10.442712215320912 | Has no output, distance is 232.95098806876976 | Has no output, distance is 21.224447814439895 | Has no output, distance is 35.71089922913735

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SHIPPING_COUNTY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 43/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 34.986675173776 | Has no output, distance is 12.57657071971395 | Has no output, distance is 33.18947028423773 | Has no output, distance is 19.115298326461314 | Has no output, distance is 173.3125 | Has no output, distance is 208.021085760083 | Has no output, distance is 16.880452716992828 | Has no output, distance is 15.10232842561587 | Has no output, distance is 42.50237986308444 | Has no output, distance is 194.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SUPPLIER_TYPE" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 44/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 11.665887940172482 | Has no output, distance is 46.124122429347516 | Has no output, distance is 14.916282573635517 | Has no output, distance is 4.145228833406105 | Has no output, distance is 25.09771211479422 | Has no output, distance is 198.97815420560747 | Has no output, distance is 21.196173529753942 | Has no output, distance is 21.71872485509856 | Has no output, distance is 32.22352522040006

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SUPPLIER_TYPE" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 45/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 59.33667665121725 | Has no output, distance is 368.74725274725273 | Has no output, distance is 51.13333333333333 | Has no output, distance is 205.5470513735241 | Has no output, distance is 24.92739490370322 | Has no output, distance is 390.0 | Has no output, distance is 31.80008900402651 | Has no output, distance is 31.943327067669173 | Has no output, distance is 110.03268503641175 | Has no output, distance is 12.317188718050787

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "BILLING_COUNTRY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 46/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 231.86039257614942 | Has no output, distance is 230.83608488144998 | Has no output, distance is 197.5 | Has no output, distance is 25.0 | Has no output, distance is 17.743636182252914 | Has no output, distance is 14.30506149998558 | Has no output, distance is 10.77300790996443 | Has no output, distance is 68.04 | Has no output, distance is 14.505813893235683 | Has no output, distance is 32.055902908869015

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "BILLING_COUNTRY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 48/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 2.6549019607843136 | Has no output, distance is 25.0 | Has no output, distance is 2.9142857142857146 | Has no output, distance is 12.7609914117957 | Has no output, distance is 169.0 | Has no output, distance is 37.489212287963596 | Has no output, distance is 25.364179500784093 | Has no output, distance is 172.24475703324808 | Has no output, distance is 36.04917219532604 | Has no output, distance is 14.109784873435554

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "CUSTOMER" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 50/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 4.655677655677655 | Has no output, distance is 34.1746628563495 | Has no output, distance is 14.433681408610761 | Has no output, distance is 21.138109320281217 | Has no output, distance is 221.0 | Has no output, distance is 182.4428160068573 | Has no output, distance is 38.08932482344732 | Has no output, distance is 29.516456582633054 | Has no output, distance is 198.53641456582633 | Has no output, distance is 27.79213609547768

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "BILLING_CITY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 51/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 15.319879585235231 | Has no output, distance is 169.0 | Has no output, distance is 12.074227785097351 | Has no output, distance is 200.71742424242424 | Has no output, distance is 368.0 | Has no output, distance is 170.0 | Has no output, distance is 196.0 | Has no output, distance is 20.938919213524237 | Has no output, distance is 7.309483204134367 | Has no output, distance is 180.0125032102442

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "TAX_TYPE" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 54/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 24.159094882581407 | Has no output, distance is 62.98830456394998 | Has no output, distance is 10.357703359858533 | Has no output, distance is 35.03153873989787 | Has no output, distance is 52.027403493044325 | Has no output, distance is 216.91721416880992 | Has no output, distance is 25.0 | Has no output, distance is 46.252894511010865 | Has no output, distance is 19.524973316543857 | Has no output, distance is 14.990864130665646

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SHIPPING_COUNTRY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 55/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 172.89217798594848 | Has no output, distance is 19.86528155893899 | Has no output, distance is 205.17027189702466 | Has no output, distance is 18.603789089588588 | Has no output, distance is 201.7061837483593 | Has no output, distance is 52.6953233081576 | Has no output, distance is 41.01214036896731 | Has no output, distance is 198.76666666666668 | Has no output, distance is 8.239734507187563 | Has no output, distance is 42.00377692094012

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SUPPLIER" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 56/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 47.116641607512165 | Has no output, distance is 206.60804565951503 | Has no output, distance is 38.599889619496736 | Has no output, distance is 222.0 | Has no output, distance is 247.96924659292736 | Has no output, distance is 173.1904761904762 | Has no output, distance is 46.13582382006502 | Has no output, distance is 53.931117795421535 | Has no output, distance is 40.71582536044836 | Has no output, distance is 25.966574591104816

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SUPPLIER" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 57/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 7.975153991945037 | Has no output, distance is 209.40465925879298 | Has no output, distance is 59.96237806242107 | Has no output, distance is 232.62085937583493 | Has no output, distance is 28.059425284702666 | Has no output, distance is 269.03712614555207 | Has no output, distance is 16.34117258006727 | Has no output, distance is 13.477656958631412 | Has no output, distance is 82.07463149587943 | Has no output, distance is 10.385093167701863

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "BILLING_COUNTY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 58/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 58.64444354195051 | Has no output, distance is 32.13884479717813 | Has no output, distance is 369.2396790840187 | Has no output, distance is 16.928369905956114 | Has no output, distance is 185.53556313949593 | Has no output, distance is 182.60968188920464 | Has no output, distance is 26.232083640206223 | Has no output, distance is 37.706437025260556 | Has no output, distance is 53.36732573461441 | Has no output, distance is 67.13825434255666

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "BILLING_COUNTY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 59/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 34.006661795152844 | Has no output, distance is 25.0 | Has no output, distance is 32.954022106251024 | Has no output, distance is 35.84700000721292 | Has no output, distance is 21.088162028845897 | Has no output, distance is 206.12779532091463 | Has no output, distance is 184.3689097084116 | Has no output, distance is 46.25044417797633 | Has no output, distance is 21.07673004065608 | Has no output, distance is 230.4779466989087

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "CUSTOMER_GROUP" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 60/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 38.37575719830498 | Has no output, distance is 29.69804105846917 | Has no output, distance is 369.1589664082687 | Has no output, distance is 49.10757537234805 | Has no output, distance is 13.729942449915175 | Has no output, distance is 23.774430907717104 | Has no output, distance is 62.37608315988991 | Has no output, distance is 8.300293634695258 | Has no output, distance is 196.02595613150623 | Has no output, distance is 211.40001873118007

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "CUSTOMER_GROUP" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 61/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 201.80780138204707 | Has no output, distance is 42.95812351065851 | Has no output, distance is 220.57710275355674 | Has no output, distance is 14.315823842388028 | Has no output, distance is 9.640901453720444 | Has no output, distance is 32.94920634920635 | Has no output, distance is 28.59379459598925 | Has no output, distance is 63.964130465706674 | Has no output, distance is 183.95042787026 | Has no output, distance is 19.194111333613698

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "BILLING_STATE" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process2, query 88
Path 62/62 - 0 successes, 10 failures
Failure messages: Has no output, distance is 365.0 | Has no output, distance is 37.661548826334425 | Has no output, distance is 48.403714617819155 | Has no output, distance is 23.28694199487908 | Has no output, distance is 31.190121308246706 | Has no output, distance is 18.540091238742466 | Has no output, distance is 10.24024940165465 | Has no output, distance is 222.0 | Has no output, distance is 24.02600722864669 | Has no output, distance is 20.101868693813866

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "BILLING_STATE" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND (
                (
                    "FROM_DATE" > '2015-01-03' 
                    AND "FROM_DATE" < '2015-01-09'
                ) 
                OR (
                    "TO_DATE" > '2015-01-03' 
                    AND "TO_DATE" < '2015-01-09'
                ) 
                OR (
                    '2015-01-03' > "FROM_DATE" 
                    AND '2015-01-03' < "TO_DATE"
                ) 
                OR (
                    '2015-01-03' = "FROM_DATE" 
                    AND '2015-01-09' = "TO_DATE"
                )
            ) 
            AND "NAME" <> 'TR0008'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process3, query 56
Path 5/5 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "ROUTE" 
    FROM
        "TABBLOG POST" 
    WHERE
        (
            "PUBLISHED" IS NULL
        )
-----------------------------------

-----------------------------------
Query: erpnext-process3, query 73
Path 8/8 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABSUPPLIER QUOTATION" 
    WHERE
        (
            (
                "TABSUPPLIER QUOTATION"."DOCSTATUS" IS NULL
            )
        ) 
        AND (
            "TABSUPPLIER QUOTATION"."SUPPLIER" = '_Test Supplier'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process3, query 84
Path 13/14 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
            WHERE
                NOT ("PARENT" <> '_Test Variant Item-S') 
                AND (
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME"
                ) 
                AND (
                    (
                        "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                        AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Small'
                    )
                )
        ) 
        AND (
            "VARIANT_OF" = '_Test Variant Item'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process3, query 86
Path 21/21 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "T2"."ITEM_CODE",
        "T2"."QTY" / IFNULL("T1"."QUANTITY",
        1) AS "QTY_CONSUMED_PER_UNIT",
        "T2"."RATE",
        "T2"."STOCK_UOM",
        "T2"."NAME",
        "T2"."DESCRIPTION" 
    FROM
        "TABBOM" "T1" 
    INNER JOIN
        "TABBOM ITEM" "T2" 
            ON "T2"."PARENT" = "T1"."NAME" 
    INNER JOIN
        "TABITEM" "T3" 
            ON "T2"."ITEM_CODE" = "T3"."NAME" 
    WHERE
        (
            (
                "T1"."QUANTITY" IS NULL
            )
        ) 
        AND (
            "T1"."ITEM" = '_Test FG Item' 
            AND "T1"."DOCSTATUS" = 1 
            AND "T1"."IS_ACTIVE" = 1 
            AND "T1"."NAME" = 'BOM-_Test FG Item-001' 
            AND "T3"."IS_STOCK_ITEM" = 1
        )
-----------------------------------

-----------------------------------
Query: erpnext-process4, query 56
Path 3/5 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "USERNAME",
        COUNT(*) 
    FROM
        "TABUSER" 
    GROUP BY
        "USERNAME" 
    HAVING
        (
            COUNT(*) = 0
        )
-----------------------------------

-----------------------------------
Query: erpnext-process4, query 82
Path 11/11 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE" 
    WHERE
        (
            (
                "TABPURCHASE INVOICE"."DOCSTATUS" IS NULL
            )
        ) 
        AND (
            "TABPURCHASE INVOICE"."SUPPLIER" = '_Test Supplier 1' 
            AND "TABPURCHASE INVOICE"."OUTSTANDING_AMOUNT" > 0.0
        )
-----------------------------------

-----------------------------------
Query: erpnext-process4, query 86
Path 11/21 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "B"."COST_CENTER",
        "BA"."BUDGET_AMOUNT",
        "B"."MONTHLY_DISTRIBUTION",
        "B"."ACTION_IF_ANNUAL_BUDGET_EXCEEDED",
        "B"."ACTION_IF_ACCUMULATED_MONTHLY_BUDGET_EXCEEDED" 
    FROM
        "TABBUDGET" "B" 
    RIGHT JOIN
        "TABBUDGET ACCOUNT" "BA" 
            ON "B"."NAME" = "BA"."PARENT" 
    WHERE
        (
            (
                "B"."NAME" IS NULL
            ) 
            AND (
                "BA"."PARENT" IS NOT NULL
            )
        ) 
        AND (
            "BA"."ACCOUNT" = '_Test Write Off - _TC' 
            AND EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABCOST CENTER" 
                WHERE
                    "LFT" <= 8 
                    AND "RGT" >= 9 
                    AND "NAME" = "B"."COST_CENTER"
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process4, query 86
Path 12/21 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "B"."COST_CENTER",
        "BA"."BUDGET_AMOUNT",
        "B"."MONTHLY_DISTRIBUTION",
        "B"."ACTION_IF_ANNUAL_BUDGET_EXCEEDED",
        "B"."ACTION_IF_ACCUMULATED_MONTHLY_BUDGET_EXCEEDED" 
    FROM
        "TABBUDGET" "B" 
    RIGHT JOIN
        "TABBUDGET ACCOUNT" "BA" 
            ON "B"."NAME" = "BA"."PARENT" 
    WHERE
        (
            (
                "B"."NAME" IS NULL
            ) 
            AND (
                "BA"."PARENT" IS NULL
            )
        ) 
        AND (
            "BA"."ACCOUNT" = '_Test Write Off - _TC' 
            AND EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABCOST CENTER" 
                WHERE
                    "LFT" <= 8 
                    AND "RGT" >= 9 
                    AND "NAME" = "B"."COST_CENTER"
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process4, query 87
Path 31/43 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "SUBJECT",
        "DESCRIPTION",
        "STARTS_ON",
        "ENDS_ON",
        "OWNER",
        "ALL_DAY",
        "EVENT_TYPE",
        "REPEAT_THIS_EVENT",
        "REPEAT_ON",
        "REPEAT_TILL",
        "MONDAY",
        "TUESDAY",
        "WEDNESDAY",
        "THURSDAY",
        "FRIDAY",
        "SATURDAY",
        "SUNDAY" 
    FROM
        "TABEVENT" 
    WHERE
        (
            (
                "SEND_REMINDER" IS NULL
            )
        ) 
        AND (
            (
                (
                    (
                        date("STARTS_ON") BETWEEN TIMESTAMP('2015-02-01') AND TIMESTAMP('2015-02-01')
                    ) 
                    OR (
                        date("ENDS_ON") BETWEEN TIMESTAMP('2015-02-01') AND TIMESTAMP('2015-02-01')
                    ) 
                    OR (
                        date("STARTS_ON") <= TIMESTAMP('2015-02-01') 
                        AND TIMESTAMP("ENDS_ON") >= TIMESTAMP('2015-02-01')
                    )
                ) 
                OR (
                    TIMESTAMP("STARTS_ON") <= TIMESTAMP('2015-02-01') 
                    AND "REPEAT_THIS_EVENT" = 1 
                    AND IFNULL("REPEAT_TILL", '3000-01-01') > TIMESTAMP('2015-02-01')
                )
            ) 
            AND (
                "EVENT_TYPE" = 'Public' 
                OR "OWNER" = 'Administrator' 
                OR EXISTS (
                    SELECT
                        "NAME" 
                    FROM
                        "TABDOCSHARE" 
                    WHERE
                        "TABDOCSHARE"."SHARE_DOCTYPE" = 'Event' 
                        AND "TABDOCSHARE"."SHARE_NAME" = "TABEVENT"."NAME" 
                        AND "TABDOCSHARE"."USER" = 'Administrator'
                ) 
                OR EXISTS (
                    SELECT
                        * 
                    FROM
                        "TABEVENT ROLE" 
                    WHERE
                        "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                        AND "TABEVENT ROLE"."ROLE" IN (
                            'Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'
                        )
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process5, query 58
Path 6/6 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABTASK" 
    WHERE
        (
            (
                "TABTASK"."NAME" IS NULL
            )
        ) 
        AND (
            "TABTASK"."PROJECT" = '_Test Project'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process5, query 82
Path 11/11 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE ORDER" 
    WHERE
        (
            (
                "TABPURCHASE ORDER"."DOCSTATUS" IS NULL
            )
        ) 
        AND (
            IFNULL("TABPURCHASE ORDER"."STATUS", '') NOT IN (
                'Completed', 'Closed'
            ) 
            AND "TABPURCHASE ORDER"."SUPPLIER" = '_Test Supplier with Country'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process5, query 87
Path 31/43 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "SUBJECT",
        "DESCRIPTION",
        "STARTS_ON",
        "ENDS_ON",
        "OWNER",
        "ALL_DAY",
        "EVENT_TYPE",
        "REPEAT_THIS_EVENT",
        "REPEAT_ON",
        "REPEAT_TILL",
        "MONDAY",
        "TUESDAY",
        "WEDNESDAY",
        "THURSDAY",
        "FRIDAY",
        "SATURDAY",
        "SUNDAY" 
    FROM
        "TABEVENT" 
    WHERE
        (
            (
                "SEND_REMINDER" IS NULL
            )
        ) 
        AND (
            (
                (
                    (
                        date("STARTS_ON") BETWEEN TIMESTAMP('2017-02-09') AND TIMESTAMP('2017-02-09')
                    ) 
                    OR (
                        date("ENDS_ON") BETWEEN TIMESTAMP('2017-02-09') AND TIMESTAMP('2017-02-09')
                    ) 
                    OR (
                        date("STARTS_ON") <= TIMESTAMP('2017-02-09') 
                        AND TIMESTAMP("ENDS_ON") >= TIMESTAMP('2017-02-09')
                    )
                ) 
                OR (
                    TIMESTAMP("STARTS_ON") <= TIMESTAMP('2017-02-09') 
                    AND "REPEAT_THIS_EVENT" = 1 
                    AND IFNULL("REPEAT_TILL", '3000-01-01') > TIMESTAMP('2017-02-09')
                )
            ) 
            AND (
                "EVENT_TYPE" = 'Public' 
                OR "OWNER" = 'test@example.com' 
                OR EXISTS (
                    SELECT
                        "NAME" 
                    FROM
                        "TABDOCSHARE" 
                    WHERE
                        "TABDOCSHARE"."SHARE_DOCTYPE" = 'Event' 
                        AND "TABDOCSHARE"."SHARE_NAME" = "TABEVENT"."NAME" 
                        AND "TABDOCSHARE"."USER" = 'test@example.com'
                ) 
                OR EXISTS (
                    SELECT
                        * 
                    FROM
                        "TABEVENT ROLE" 
                    WHERE
                        "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                        AND "TABEVENT ROLE"."ROLE" IN (
                            'System Manager', '_Test Role', 'Employee', 'All', 'Guest'
                        )
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process6, query 62
Path 4/6 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "BLOG_CATEGORY" 
    FROM
        "TABBLOG POST" 
    WHERE
        (
            "TABBLOG POST"."BLOG_CATEGORY" IS NULL
        ) 
        AND NOT (IFNULL("TABBLOG POST"."BLOG_CATEGORY", '') = '')
-----------------------------------

-----------------------------------
Query: erpnext-process6, query 80
Path 9/9 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABSTOCK ENTRY" 
    WHERE
        NOT ("NAME" <> NULL) 
        AND (
            "DOCSTATUS" <> 2
        ) 
        AND (
            "PRODUCTION_ORDER" = 'PRO-00008'
        ) 
        AND (
            "PURPOSE" = 'Manufacture'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process6, query 82
Path 11/11 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABDELIVERY NOTE" 
    WHERE
        (
            (
                "TABDELIVERY NOTE"."DOCSTATUS" IS NULL
            )
        ) 
        AND (
            IFNULL("TABDELIVERY NOTE"."STATUS", '') NOT IN (
                'Completed', 'Closed'
            ) 
            AND "TABDELIVERY NOTE"."CUSTOMER" = '_Test Customer 3'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process6, query 85
Path 18/18 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "T1"."NAME",
        "T1"."SALARY_STRUCTURE" 
    FROM
        "TABSALARY SLIP" "T1" 
    WHERE
        (
            (
                "SALARY_SLIP_BASED_ON_TIMESHEET" IS NULL
            )
        ) 
        AND (
            "T1"."DOCSTATUS" = 0 
            AND "T1"."START_DATE" >= '2016-11-01' 
            AND "T1"."END_DATE" <= '2016-11-30' 
            AND (
                (
                    "T1"."JOURNAL_ENTRY" IS NULL
                ) 
                OR "T1"."JOURNAL_ENTRY" = ''
            ) 
            AND "T1"."COMPANY" = 'Wind Power LLC'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process6, query 86
Path 18/22 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        COUNT(*) 
    FROM
        "TABGL ENTRY" "T1" 
    INNER JOIN
        "TABACCOUNT" "T2" 
            ON "T1"."ACCOUNT" = "T2"."NAME" 
    WHERE
        "T2"."ROOT_TYPE" = 'Expense' 
        AND "T2"."DOCSTATUS" < 2 
        AND "T2"."COMPANY" = '_Test Company' 
        AND "T1"."POSTING_DATE" BETWEEN '2017-01-01' AND '2017-02-09' 
    HAVING
        (
            count(DISTINCT "T1"."ACCOUNT") > 1
        ) 
        AND (
            SUM("T1"."DEBIT") > SUM("T1"."CREDIT")
        )
-----------------------------------

-----------------------------------
Query: erpnext-process6, query 87
Path 31/43 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "SUBJECT",
        "DESCRIPTION",
        "STARTS_ON",
        "ENDS_ON",
        "OWNER",
        "ALL_DAY",
        "EVENT_TYPE",
        "REPEAT_THIS_EVENT",
        "REPEAT_ON",
        "REPEAT_TILL",
        "MONDAY",
        "TUESDAY",
        "WEDNESDAY",
        "THURSDAY",
        "FRIDAY",
        "SATURDAY",
        "SUNDAY" 
    FROM
        "TABEVENT" 
    WHERE
        (
            (
                "SEND_REMINDER" IS NULL
            )
        ) 
        AND (
            (
                (
                    (
                        date("STARTS_ON") BETWEEN TIMESTAMP('2017-02-09') AND TIMESTAMP('2017-02-09')
                    ) 
                    OR (
                        date("ENDS_ON") BETWEEN TIMESTAMP('2017-02-09') AND TIMESTAMP('2017-02-09')
                    ) 
                    OR (
                        date("STARTS_ON") <= TIMESTAMP('2017-02-09') 
                        AND TIMESTAMP("ENDS_ON") >= TIMESTAMP('2017-02-09')
                    )
                ) 
                OR (
                    TIMESTAMP("STARTS_ON") <= TIMESTAMP('2017-02-09') 
                    AND "REPEAT_THIS_EVENT" = 1 
                    AND IFNULL("REPEAT_TILL", '3000-01-01') > TIMESTAMP('2017-02-09')
                )
            ) 
            AND (
                "EVENT_TYPE" = 'Public' 
                OR "OWNER" = 'test@erpnext.com' 
                OR EXISTS (
                    SELECT
                        "NAME" 
                    FROM
                        "TABDOCSHARE" 
                    WHERE
                        "TABDOCSHARE"."SHARE_DOCTYPE" = 'Event' 
                        AND "TABDOCSHARE"."SHARE_NAME" = "TABEVENT"."NAME" 
                        AND "TABDOCSHARE"."USER" = 'test@erpnext.com'
                ) 
                OR EXISTS (
                    SELECT
                        * 
                    FROM
                        "TABEVENT ROLE" 
                    WHERE
                        "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                        AND "TABEVENT ROLE"."ROLE" IN (
                            'Expense Approver', 'Support Team', 'Manufacturing User', 'Website Manager', 'Purchase Manager', 'Sales User', 'Sales Manager', 'Quality Manager', 'Newsletter Manager', 'Maintenance User', 'System Manager', 'Fleet Manager', 'Maintenance Manager', 'Stock Manager', 'Purchase Master Manager', 'Knowledge Base Contributor', 'Report Manager', 'Student', 'Item Manager', 'Accounts Manager', 'Projects Manager', 'Projects User', 'Accounts User', 'Knowledge Base Editor', 'Sales Master Manager', 'Manufacturing Manager', 'Stock User', 'HR Manager', 'Leave Approver', 'HR User', 'Analytics', 'Auditor', 'Purchase User', 'Blogger', 'Instructor', 'All', 'Guest'
                        )
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 84
Path 10/14 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "FY"."NAME",
        "FY"."YEAR_START_DATE",
        "FY"."YEAR_END_DATE" 
    FROM
        "TABFISCAL YEAR" "FY" 
    WHERE
        EXISTS (
            SELECT
                "COMPANY" 
            FROM
                "TABFISCAL YEAR COMPANY" "FYC" 
            WHERE
                (
                    "FYC"."PARENT" = "FY"."NAME"
                ) 
                AND (
                    "FYC"."COMPANY" = 'Wind Power LLC'
                )
        ) 
        AND (
            "DISABLED" = 0 
            AND (
                NOT EXISTS (
                    SELECT
                        "NAME" 
                    FROM
                        "TABFISCAL YEAR COMPANY" "FYC" 
                    WHERE
                        "FYC"."PARENT" = "FY"."NAME"
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 84
Path 13/14 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "FY"."NAME",
        "FY"."YEAR_START_DATE",
        "FY"."YEAR_END_DATE" 
    FROM
        "TABFISCAL YEAR" "FY" 
    WHERE
        EXISTS (
            SELECT
                "COMPANY" 
            FROM
                "TABFISCAL YEAR COMPANY" "FYC" 
            WHERE
                NOT ("FYC"."COMPANY" = 'Wind Power LLC') 
                AND (
                    "FYC"."PARENT" = "FY"."NAME"
                )
        ) 
        AND (
            "DISABLED" = 0 
            AND (
                NOT EXISTS (
                    SELECT
                        "NAME" 
                    FROM
                        "TABFISCAL YEAR COMPANY" "FYC" 
                    WHERE
                        "FYC"."PARENT" = "FY"."NAME"
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 84
Path 14/14 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "FY"."NAME",
        "FY"."YEAR_START_DATE",
        "FY"."YEAR_END_DATE" 
    FROM
        "TABFISCAL YEAR" "FY" 
    WHERE
        EXISTS (
            SELECT
                "COMPANY" 
            FROM
                "TABFISCAL YEAR COMPANY" "FYC" 
            WHERE
                (
                    "FYC"."COMPANY" IS NULL
                ) 
                AND (
                    "FYC"."PARENT" = "FY"."NAME"
                )
        ) 
        AND (
            "DISABLED" = 0 
            AND (
                NOT EXISTS (
                    SELECT
                        "NAME" 
                    FROM
                        "TABFISCAL YEAR COMPANY" "FYC" 
                    WHERE
                        "FYC"."PARENT" = "FY"."NAME"
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 85
Path 12/18 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "PARENT" 
    FROM
        "TABSALARY STRUCTURE EMPLOYEE" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABSALARY STRUCTURE" 
            WHERE
                (
                    "FROM_DATE" <= '2013-01-01'
                ) 
                AND NOT ("FROM_DATE" <= '2016-11-01') 
                AND (
                    "IS_ACTIVE" = 'Yes'
                ) 
                AND (
                    (
                        (
                            "TO_DATE" IS NULL
                        ) 
                        OR "TO_DATE" >= '2016-11-30' 
                        OR "TO_DATE" >= NULL
                    )
                ) 
                AND (
                    "PAYROLL_FREQUENCY" = 'Monthly'
                )
        ) 
        AND (
            "EMPLOYEE" = 'EMP-0002'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 85
Path 13/18 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "PARENT" 
    FROM
        "TABSALARY STRUCTURE EMPLOYEE" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABSALARY STRUCTURE" 
            WHERE
                (
                    (
                        "TO_DATE" IS NOT NULL
                    )
                ) 
                AND NOT ("TO_DATE" >= '2016-11-30') 
                AND NOT ("TO_DATE" >= NULL) 
                AND (
                    "IS_ACTIVE" = 'Yes'
                ) 
                AND (
                    (
                        "FROM_DATE" <= '2016-11-01' 
                        OR "FROM_DATE" <= '2013-01-01'
                    )
                ) 
                AND (
                    "PAYROLL_FREQUENCY" = 'Monthly'
                )
        ) 
        AND (
            "EMPLOYEE" = 'EMP-0002'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 85
Path 15/18 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "PARENT" 
    FROM
        "TABSALARY STRUCTURE EMPLOYEE" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABSALARY STRUCTURE" 
            WHERE
                (
                    "TO_DATE" >= '2016-11-30'
                ) 
                AND (
                    (
                        "TO_DATE" IS NOT NULL
                    )
                ) 
                AND NOT ("TO_DATE" >= NULL) 
                AND (
                    "IS_ACTIVE" = 'Yes'
                ) 
                AND (
                    (
                        "FROM_DATE" <= '2016-11-01' 
                        OR "FROM_DATE" <= '2013-01-01'
                    )
                ) 
                AND (
                    "PAYROLL_FREQUENCY" = 'Monthly'
                )
        ) 
        AND (
            "EMPLOYEE" = 'EMP-0002'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 85
Path 16/18 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "PARENT" 
    FROM
        "TABSALARY STRUCTURE EMPLOYEE" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABSALARY STRUCTURE" 
            WHERE
                (
                    "TO_DATE" >= NULL
                ) 
                AND (
                    (
                        "TO_DATE" IS NOT NULL
                    )
                ) 
                AND NOT ("TO_DATE" >= '2016-11-30') 
                AND (
                    "IS_ACTIVE" = 'Yes'
                ) 
                AND (
                    (
                        "FROM_DATE" <= '2016-11-01' 
                        OR "FROM_DATE" <= '2013-01-01'
                    )
                ) 
                AND (
                    "PAYROLL_FREQUENCY" = 'Monthly'
                )
        ) 
        AND (
            "EMPLOYEE" = 'EMP-0002'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 86
Path 6/22 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "BOM_ITEM"."ITEM_CODE",
        SUM("BOM_ITEM"."QTY" / IFNULL("BOM"."QUANTITY",
        1)) * 1 AS "QTY",
        "ITEM"."STOCK_UOM" 
    FROM
        "TABBOM EXPLOSION ITEM" "BOM_ITEM" 
    INNER JOIN
        "TABBOM" "BOM" 
            ON "BOM_ITEM"."PARENT" = "BOM"."NAME" 
    INNER JOIN
        "TABITEM" "ITEM" 
            ON "ITEM"."NAME" = "BOM_ITEM"."ITEM_CODE" 
    WHERE
        (
            "BOM_ITEM"."PARENT" IS NULL
        ) 
        AND (
            "BOM_ITEM"."DOCSTATUS" < 2
        ) 
        AND (
            "IS_STOCK_ITEM" = 1
        ) 
        AND (
            "ITEM"."IS_SUB_CONTRACTED_ITEM" = 0
        ) 
    GROUP BY
        "BOM_ITEM"."ITEM_CODE",
        "ITEM"."STOCK_UOM"
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 86
Path 20/22 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "ITEM"."STOCK_UOM" 
    FROM
        "TABBOM EXPLOSION ITEM" "BOM_ITEM" 
    INNER JOIN
        "TABBOM" "BOM" 
            ON "BOM_ITEM"."PARENT" = "BOM"."NAME" 
    INNER JOIN
        "TABITEM" "ITEM" 
            ON "ITEM"."NAME" = "BOM_ITEM"."ITEM_CODE" 
    WHERE
        "BOM_ITEM"."DOCSTATUS" < 2 
        AND "BOM_ITEM"."PARENT" = 'BOM-_Test FG Item 2-001' 
        AND "IS_STOCK_ITEM" = 1 
        AND "ITEM"."IS_SUB_CONTRACTED_ITEM" = 0 
    GROUP BY
        "ITEM"."STOCK_UOM" 
    HAVING
        count(DISTINCT "BOM_ITEM"."ITEM_CODE") > 1
-----------------------------------

-----------------------------------
Query: erpnext-process7, query 87
Path 31/43 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "SUBJECT",
        "DESCRIPTION",
        "STARTS_ON",
        "ENDS_ON",
        "OWNER",
        "ALL_DAY",
        "EVENT_TYPE",
        "REPEAT_THIS_EVENT",
        "REPEAT_ON",
        "REPEAT_TILL",
        "MONDAY",
        "TUESDAY",
        "WEDNESDAY",
        "THURSDAY",
        "FRIDAY",
        "SATURDAY",
        "SUNDAY" 
    FROM
        "TABEVENT" 
    WHERE
        (
            (
                "SEND_REMINDER" IS NULL
            )
        ) 
        AND (
            (
                (
                    (
                        date("STARTS_ON") BETWEEN TIMESTAMP('2017-02-09') AND TIMESTAMP('2017-02-09')
                    ) 
                    OR (
                        date("ENDS_ON") BETWEEN TIMESTAMP('2017-02-09') AND TIMESTAMP('2017-02-09')
                    ) 
                    OR (
                        date("STARTS_ON") <= TIMESTAMP('2017-02-09') 
                        AND TIMESTAMP("ENDS_ON") >= TIMESTAMP('2017-02-09')
                    )
                ) 
                OR (
                    TIMESTAMP("STARTS_ON") <= TIMESTAMP('2017-02-09') 
                    AND "REPEAT_THIS_EVENT" = 1 
                    AND IFNULL("REPEAT_TILL", '3000-01-01') > TIMESTAMP('2017-02-09')
                )
            ) 
            AND (
                "EVENT_TYPE" = 'Public' 
                OR "OWNER" = 'testdelete@example.com' 
                OR EXISTS (
                    SELECT
                        "NAME" 
                    FROM
                        "TABDOCSHARE" 
                    WHERE
                        "TABDOCSHARE"."SHARE_DOCTYPE" = 'Event' 
                        AND "TABDOCSHARE"."SHARE_NAME" = "TABEVENT"."NAME" 
                        AND "TABDOCSHARE"."USER" = 'testdelete@example.com'
                ) 
                OR EXISTS (
                    SELECT
                        * 
                    FROM
                        "TABEVENT ROLE" 
                    WHERE
                        "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                        AND "TABEVENT ROLE"."ROLE" IN (
                            '_Test Role 2', 'System Manager', 'All', 'Guest'
                        )
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process8, query 86
Path 21/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "FROM_TIME",
        "TO_TIME" 
    FROM
        "TABASSESSMENT PLAN" 
    WHERE
        (
            "FROM_TIME" IS NULL
        ) 
        AND (
            '4:00:00' = "TO_TIME"
        ) 
        AND NOT (("TO_TIME" > '3:00:00' 
        AND "TO_TIME" < '4:00:00')) 
        AND NOT (('3:00:00' < "TO_TIME")) 
        AND (
            "STUDENT_GROUP" = 'TC-TP-2014-2015-2014-2015 (_Test Academic Term)'
        ) 
        AND (
            "SCHEDULE_DATE" = '2017-02-09'
        ) 
        AND (
            "NAME" <> 'SH00023'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process8, query 87
Path 31/43 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "SUBJECT",
        "DESCRIPTION",
        "STARTS_ON",
        "ENDS_ON",
        "OWNER",
        "ALL_DAY",
        "EVENT_TYPE",
        "REPEAT_THIS_EVENT",
        "REPEAT_ON",
        "REPEAT_TILL",
        "MONDAY",
        "TUESDAY",
        "WEDNESDAY",
        "THURSDAY",
        "FRIDAY",
        "SATURDAY",
        "SUNDAY" 
    FROM
        "TABEVENT" 
    WHERE
        (
            (
                "SEND_REMINDER" IS NULL
            )
        ) 
        AND (
            (
                (
                    (
                        date("STARTS_ON") BETWEEN TIMESTAMP('2017-02-09') AND TIMESTAMP('2017-02-09')
                    ) 
                    OR (
                        date("ENDS_ON") BETWEEN TIMESTAMP('2017-02-09') AND TIMESTAMP('2017-02-09')
                    ) 
                    OR (
                        date("STARTS_ON") <= TIMESTAMP('2017-02-09') 
                        AND TIMESTAMP("ENDS_ON") >= TIMESTAMP('2017-02-09')
                    )
                ) 
                OR (
                    TIMESTAMP("STARTS_ON") <= TIMESTAMP('2017-02-09') 
                    AND "REPEAT_THIS_EVENT" = 1 
                    AND IFNULL("REPEAT_TILL", '3000-01-01') > TIMESTAMP('2017-02-09')
                )
            ) 
            AND (
                "EVENT_TYPE" = 'Public' 
                OR "OWNER" = 'test2@example.com' 
                OR EXISTS (
                    SELECT
                        "NAME" 
                    FROM
                        "TABDOCSHARE" 
                    WHERE
                        "TABDOCSHARE"."SHARE_DOCTYPE" = 'Event' 
                        AND "TABDOCSHARE"."SHARE_NAME" = "TABEVENT"."NAME" 
                        AND "TABDOCSHARE"."USER" = 'test2@example.com'
                ) 
                OR EXISTS (
                    SELECT
                        * 
                    FROM
                        "TABEVENT ROLE" 
                    WHERE
                        "TABEVENT ROLE"."PARENT" = "TABEVENT"."NAME" 
                        AND "TABEVENT ROLE"."ROLE" IN (
                            'Employee', 'All', 'Guest'
                        )
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process9, query 84
Path 15/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABSALARY STRUCTURE" 
    WHERE
        (
            (
                "SALARY_SLIP_BASED_ON_TIMESHEET" IS NULL
            )
        ) 
        AND (
            "DOCSTATUS" <> 2 
            AND "IS_ACTIVE" = 'Yes' 
            AND "COMPANY" = 'Wind Power LLC' 
            AND "PAYROLL_FREQUENCY" = 'Monthly'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process9, query 86
Path 21/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "FROM_TIME",
        "TO_TIME" 
    FROM
        "TABCOURSE SCHEDULE" 
    WHERE
        (
            "FROM_TIME" IS NULL
        ) 
        AND (
            '2:00:00' = "TO_TIME"
        ) 
        AND NOT (("TO_TIME" > '1:00:00' 
        AND "TO_TIME" < '2:00:00')) 
        AND NOT (('1:00:00' < "TO_TIME")) 
        AND (
            "ROOM" = 'RM0001'
        ) 
        AND (
            "SCHEDULE_DATE" = '2017-02-09'
        ) 
        AND (
            "NAME" <> 'SH00001'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process10, query 87
Path 2/44 - 0 successes, 10 failures
Failure messages: Has no output, distance is 12.206718407415948 | Has no output, distance is 29.516156754120566 | Has no output, distance is 19.46977911323373 | Has no output, distance is 25.0 | Has no output, distance is 15.546254039449598 | Has no output, distance is 6.043873815676141 | Has no output, distance is 3.7282051282051283 | Has no output, distance is 7.972865890542264 | Has no output, distance is 31.425030192009594 | Has no output, distance is 24.606273966909292

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_CITY", '') = '') 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0003'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process10, query 87
Path 4/44 - 0 successes, 10 failures
Failure messages: Has no output, distance is 11.2610471153274 | Has no output, distance is 15.950753956320245 | Has no output, distance is 4.325471866096866 | Has no output, distance is 1.0 | Has no output, distance is 169.0 | Has no output, distance is 25.0 | Has no output, distance is 3.479591836734694 | Has no output, distance is 6.991865079365079 | Has no output, distance is 11.188137744704143 | Has no output, distance is 8.397345518093214

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_STATE", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0003'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process10, query 87
Path 6/44 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 196.0 | Has no output, distance is 5.666666666666666 | Has no output, distance is 221.0 | Has no output, distance is 19.14429341118096 | Has no output, distance is 13.02644305714674 | Has no output, distance is 18.481368476512397 | Has no output, distance is 12.970722019707955 | Has no output, distance is 8.725103187693954 | Has no output, distance is 3.395479641131815

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SUPPLIER_TYPE", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0003'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process10, query 87
Path 12/44 - 0 successes, 10 failures
Failure messages: Has no output, distance is 15.180493539885678 | Has no output, distance is 2.4565217391304346 | Has no output, distance is 12.384371634541335 | Has no output, distance is 1.9583333333333335 | Has no output, distance is 33.53006202270855 | Has no output, distance is 16.033655591305955 | Has no output, distance is 19.51665318134783 | Has no output, distance is 11.192064341041146 | Has no output, distance is 29.959212299441916 | Has no output, distance is 23.53173897651896

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SUPPLIER", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0003'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process10, query 87
Path 13/44 - 0 successes, 10 failures
Failure messages: Has no output, distance is 6.702491883116883 | Has no output, distance is 22.692833326888454 | Has no output, distance is 11.661671058410189 | Has no output, distance is 29.89903846153846 | Has no output, distance is 1.0 | Has no output, distance is 6.739186471116138 | Has no output, distance is 12.290290069996578 | Has no output, distance is 21.96156831851559 | Has no output, distance is 11.427469954302502 | Has no output, distance is 12.592245634399335

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_COUNTY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0003'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process10, query 87
Path 23/44 - 0 successes, 10 failures
Failure messages: Has no output, distance is 8.602237519961978 | Has no output, distance is 18.794187921836034 | Has no output, distance is 6.1164335664335665 | Has no output, distance is 4.7827586206896555 | Has no output, distance is 19.251555858121737 | Has no output, distance is 7.615160155549171 | Has no output, distance is 9.79904175238338 | Has no output, distance is 197.16666666666666 | Has no output, distance is 7.581595727721983 | Has no output, distance is 8.588241076093764

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SHIPPING_COUNTY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "NAME" <> 'TR0003'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process10, query 87
Path 35/44 - 0 successes, 10 failures
Failure messages: Has no output, distance is 73.4913507121247 | Has no output, distance is 7.375990279205207 | Has no output, distance is 6.538235802487964 | Has no output, distance is 196.0 | Has no output, distance is 7.161578736578736 | Has no output, distance is 13.569836939244542 | Has no output, distance is 18.49787278105358 | Has no output, distance is 32.83492813683492 | Has no output, distance is 7.782828282828283 | Has no output, distance is 25.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SHIPPING_COUNTRY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "NAME" <> 'TR0003'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process10, query 87
Path 37/44 - 0 successes, 10 failures
Failure messages: Has no output, distance is 2.4767441860465116 | Has no output, distance is 25.0 | Has no output, distance is 6.061822953948939 | Has no output, distance is 38.29299144102658 | Has no output, distance is 25.0 | Has no output, distance is 2.9155354449472095 | Has no output, distance is 25.0 | Has no output, distance is 2.783333333333333 | Has no output, distance is 25.0 | Has no output, distance is 40.324003927200636

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SUPPLIER" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "NAME" <> 'TR0003'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process10, query 87
Path 40/44 - 0 successes, 10 failures
Failure messages: Has no output, distance is 10.572675003779702 | Has no output, distance is 6.006674208144796 | Has no output, distance is 2.326839826839827 | Has no output, distance is 36.097867668729734 | Has no output, distance is 10.443840150550729 | Has no output, distance is 5.216666666666667 | Has no output, distance is 12.788022479423507 | Has no output, distance is 202.44113243715955 | Has no output, distance is 33.96668204052268 | Has no output, distance is 9.935020535155719

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "BILLING_COUNTY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "NAME" <> 'TR0003'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 60
Path 4/6 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "OWNER" 
    FROM
        "TABBLOG POST" 
    WHERE
        (
            "TABBLOG POST"."BLOGGER" IS NULL
        ) 
        AND NOT (IFNULL("TABBLOG POST"."BLOGGER", '') = '')
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 70
Path 1/7 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "USER" 
    FROM
        "TABPOS PROFILE" 
    WHERE
        (
            IFNULL("USER", '') = NULL
        ) 
        AND (
            "NAME" <> '6125d62f89'
        ) 
        AND (
            "COMPANY" = '_Test Company'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 70
Path 3/7 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "USER" 
    FROM
        "TABPOS PROFILE" 
    WHERE
        NOT ("NAME" <> '6125d62f89') 
        AND (
            IFNULL("USER", '') = NULL
        ) 
        AND (
            "COMPANY" = '_Test Company'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 70
Path 4/7 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "USER" 
    FROM
        "TABPOS PROFILE" 
    WHERE
        NOT ("COMPANY" = '_Test Company') 
        AND (
            IFNULL("USER", '') = NULL
        ) 
        AND (
            "NAME" <> '6125d62f89'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 70
Path 5/7 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "USER" 
    FROM
        "TABPOS PROFILE" 
    WHERE
        (
            "COMPANY" IS NULL
        ) 
        AND (
            IFNULL("USER", '') = NULL
        ) 
        AND (
            "NAME" <> '6125d62f89'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 82
Path 11/11 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        * 
    FROM
        "TABCUSTOM DOCPERM" 
    WHERE
        (
            (
                "PERMLEVEL" IS NULL
            )
        ) 
        AND (
            "DOCSTATUS" = 0 
            AND "ROLE" IN (
                'Manufacturing User', 'Sales User', 'Instructor', 'Knowledge Base Contributor', 'Stock User', 'HR Manager', 'Purchase User', 'Item Manager', 'Accounts User', 'Auditor', 'Supplier', 'Newsletter Manager', 'Leave Approver', 'Maintenance User', '_Test Role', '_Test Role 3', 'Customer', 'Report Manager', '_Test Role 2', 'Administrator', 'Sales Master Manager', 'Manufacturing Manager', 'Purchase Master Manager', 'Maintenance Manager', 'Expense Approver', 'System Manager', 'Analytics', 'HR User', 'Stock Manager', 'Website Manager', '_Test Role 4', 'Quality Manager', 'Student', 'Support Team', 'Projects Manager', 'Fleet Manager', 'Blogger', 'Knowledge Base Editor', 'Sales Manager', 'Purchase Manager', 'Accounts Manager', 'Projects User', 'All', 'Guest'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 1/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        (
            "DOCSTATUS" = 2
        ) 
        AND (
            "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        ) 
        AND (
            EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABGL ENTRY" 
                WHERE
                    "VOUCHER_TYPE" = 'Purchase Invoice' 
                    AND "VOUCHER_NO" = "PI"."PARENT" 
                    AND "ACCOUNT" = 'Expenses Included In Valuation - _TC'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 2/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        (
            "DOCSTATUS" = 1
        ) 
        AND (
            "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        ) 
        AND (
            EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABGL ENTRY" 
                WHERE
                    "VOUCHER_TYPE" = 'Purchase Invoice' 
                    AND "VOUCHER_NO" = "PI"."PARENT" 
                    AND "ACCOUNT" = 'Expenses Included In Valuation - _TC'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 3/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        (
            "DOCSTATUS" = 0
        ) 
        AND (
            "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        ) 
        AND (
            EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABGL ENTRY" 
                WHERE
                    "VOUCHER_TYPE" = 'Purchase Invoice' 
                    AND "VOUCHER_NO" = "PI"."PARENT" 
                    AND "ACCOUNT" = 'Expenses Included In Valuation - _TC'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 4/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        (
            "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        ) 
        AND (
            "DOCSTATUS" = 1
        ) 
        AND (
            EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABGL ENTRY" 
                WHERE
                    "VOUCHER_TYPE" = 'Purchase Invoice' 
                    AND "VOUCHER_NO" = "PI"."PARENT" 
                    AND "ACCOUNT" = 'Expenses Included In Valuation - _TC'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 5/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        NOT ("PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004') 
        AND (
            "DOCSTATUS" = 1
        ) 
        AND (
            EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABGL ENTRY" 
                WHERE
                    "VOUCHER_TYPE" = 'Purchase Invoice' 
                    AND "VOUCHER_NO" = "PI"."PARENT" 
                    AND "ACCOUNT" = 'Expenses Included In Valuation - _TC'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 6/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        (
            "PURCHASE_RECEIPT" IS NULL
        ) 
        AND (
            "DOCSTATUS" = 1
        ) 
        AND (
            EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABGL ENTRY" 
                WHERE
                    "VOUCHER_TYPE" = 'Purchase Invoice' 
                    AND "VOUCHER_NO" = "PI"."PARENT" 
                    AND "ACCOUNT" = 'Expenses Included In Valuation - _TC'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 8/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABGL ENTRY" 
            WHERE
                (
                    "VOUCHER_TYPE" = 'Purchase Invoice'
                ) 
                AND (
                    "VOUCHER_NO" = "PI"."PARENT"
                ) 
                AND (
                    "ACCOUNT" = 'Expenses Included In Valuation - _TC'
                )
        ) 
        AND (
            "DOCSTATUS" = 1 
            AND "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 9/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABGL ENTRY" 
            WHERE
                NOT ("VOUCHER_TYPE" = 'Purchase Invoice') 
                AND (
                    "VOUCHER_NO" = "PI"."PARENT"
                ) 
                AND (
                    "ACCOUNT" = 'Expenses Included In Valuation - _TC'
                )
        ) 
        AND (
            "DOCSTATUS" = 1 
            AND "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 10/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABGL ENTRY" 
            WHERE
                (
                    "VOUCHER_TYPE" IS NULL
                ) 
                AND (
                    "VOUCHER_NO" = "PI"."PARENT"
                ) 
                AND (
                    "ACCOUNT" = 'Expenses Included In Valuation - _TC'
                )
        ) 
        AND (
            "DOCSTATUS" = 1 
            AND "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 11/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABGL ENTRY" 
            WHERE
                NOT ("VOUCHER_NO" = "PI"."PARENT") 
                AND (
                    "VOUCHER_TYPE" = 'Purchase Invoice'
                ) 
                AND (
                    "ACCOUNT" = 'Expenses Included In Valuation - _TC'
                )
        ) 
        AND (
            "DOCSTATUS" = 1 
            AND "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 12/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABGL ENTRY" 
            WHERE
                (
                    "VOUCHER_NO" IS NULL
                ) 
                AND (
                    "VOUCHER_TYPE" = 'Purchase Invoice'
                ) 
                AND (
                    "ACCOUNT" = 'Expenses Included In Valuation - _TC'
                )
        ) 
        AND (
            "DOCSTATUS" = 1 
            AND "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 13/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABGL ENTRY" 
            WHERE
                (
                    "PI"."PARENT" IS NULL
                ) 
                AND (
                    "VOUCHER_TYPE" = 'Purchase Invoice'
                ) 
                AND (
                    "ACCOUNT" = 'Expenses Included In Valuation - _TC'
                )
        ) 
        AND (
            "DOCSTATUS" = 1 
            AND "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 14/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABGL ENTRY" 
            WHERE
                NOT ("ACCOUNT" = 'Expenses Included In Valuation - _TC') 
                AND (
                    "VOUCHER_TYPE" = 'Purchase Invoice'
                ) 
                AND (
                    "VOUCHER_NO" = "PI"."PARENT"
                )
        ) 
        AND (
            "DOCSTATUS" = 1 
            AND "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 84
Path 15/15 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABPURCHASE INVOICE ITEM" "PI" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABGL ENTRY" 
            WHERE
                (
                    "ACCOUNT" IS NULL
                ) 
                AND (
                    "VOUCHER_TYPE" = 'Purchase Invoice'
                ) 
                AND (
                    "VOUCHER_NO" = "PI"."PARENT"
                )
        ) 
        AND (
            "DOCSTATUS" = 1 
            AND "PURCHASE_RECEIPT" = '_T-Purchase Receipt-00004'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process11, query 86
Path 21/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "FROM_TIME",
        "TO_TIME" 
    FROM
        "TABASSESSMENT PLAN" 
    WHERE
        (
            "FROM_TIME" IS NULL
        ) 
        AND (
            '4:00:00' = "TO_TIME"
        ) 
        AND NOT (("TO_TIME" > '3:00:00' 
        AND "TO_TIME" < '4:00:00')) 
        AND NOT (('3:00:00' < "TO_TIME")) 
        AND (
            "SUPERVISOR" = '_T-Instructor-00001'
        ) 
        AND (
            "SCHEDULE_DATE" = '2017-02-09'
        ) 
        AND (
            "NAME" <> 'SH00023'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 78
Path 2/9 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABFISCAL YEAR" 
    WHERE
        (
            (
                '2021-01-01' BETWEEN "YEAR_START_DATE" AND "YEAR_END_DATE"
            )
        ) 
        AND (
            (
                '2021-12-31' NOT BETWEEN "YEAR_START_DATE" AND "YEAR_END_DATE"
            )
        ) 
        AND (
            (
                "YEAR_START_DATE" NOT BETWEEN '2021-01-01' AND '2021-12-31'
            )
        ) 
        AND (
            (
                "YEAR_END_DATE" NOT BETWEEN '2021-01-01' AND '2021-12-31'
            )
        ) 
        AND (
            "NAME" <> '_Test Fiscal Year 2021'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 78
Path 5/9 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABFISCAL YEAR" 
    WHERE
        (
            (
                '2021-12-31' BETWEEN "YEAR_START_DATE" AND "YEAR_END_DATE"
            )
        ) 
        AND (
            (
                '2021-01-01' NOT BETWEEN "YEAR_START_DATE" AND "YEAR_END_DATE"
            )
        ) 
        AND (
            (
                "YEAR_START_DATE" NOT BETWEEN '2021-01-01' AND '2021-12-31'
            )
        ) 
        AND (
            (
                "YEAR_END_DATE" NOT BETWEEN '2021-01-01' AND '2021-12-31'
            )
        ) 
        AND (
            "NAME" <> '_Test Fiscal Year 2021'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 79
Path 9/9 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TABEMAIL UNSUBSCRIBE"."NAME" 
    FROM
        "TABEMAIL UNSUBSCRIBE" 
    WHERE
        (
            (
                "TABEMAIL UNSUBSCRIBE"."NAME" IS NULL
            )
        ) 
        AND (
            "TABEMAIL UNSUBSCRIBE"."EMAIL" = 'test@example.com' 
            AND "TABEMAIL UNSUBSCRIBE"."GLOBAL_UNSUBSCRIBE" = 1.0
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 80
Path 10/10 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "BOM_ITEM"."ITEM_CODE",
        "BOM_ITEM"."ITEM_NAME",
        "BOM_ITEM"."DESCRIPTION",
        "BOM_ITEM"."STOCK_UOM",
        "BOM_ITEM"."QTY",
        "BOM_ITEM"."RATE",
        "BOM_ITEM"."QTY" / IFNULL("BOM"."QUANTITY",
        1) AS "QTY_CONSUMED_PER_UNIT" 
    FROM
        "TABBOM EXPLOSION ITEM" "BOM_ITEM" 
    INNER JOIN
        "TABBOM" "BOM" 
            ON "BOM_ITEM"."PARENT" = "BOM"."NAME" 
    WHERE
        (
            (
                "BOM"."QUANTITY" IS NULL
            )
        ) 
        AND (
            "BOM"."NAME" = 'BOM-_Test PPT Item Sub A-001' 
            AND "BOM"."DOCSTATUS" = 1
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 1/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        (
            "VARIANT_OF" = '_Test Numeric Template Item'
        ) 
        AND (
            EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
                WHERE
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME" 
                    AND (
                        (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1'
                        ) 
                        OR (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large'
                        )
                    ) 
                    AND "PARENT" <> '_Test Numeric Variant-L-1.1'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 2/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        NOT ("VARIANT_OF" = '_Test Numeric Template Item') 
        AND (
            EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
                WHERE
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME" 
                    AND (
                        (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1'
                        ) 
                        OR (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large'
                        )
                    ) 
                    AND "PARENT" <> '_Test Numeric Variant-L-1.1'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 3/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        (
            "VARIANT_OF" IS NULL
        ) 
        AND (
            EXISTS (
                SELECT
                    "NAME" 
                FROM
                    "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
                WHERE
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME" 
                    AND (
                        (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1'
                        ) 
                        OR (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large'
                        )
                    ) 
                    AND "PARENT" <> '_Test Numeric Variant-L-1.1'
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 5/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
            WHERE
                (
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME"
                ) 
                AND (
                    (
                        (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1'
                        ) 
                        OR (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large'
                        )
                    )
                ) 
                AND (
                    "PARENT" <> '_Test Numeric Variant-L-1.1'
                )
        ) 
        AND (
            "VARIANT_OF" = '_Test Numeric Template Item'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 7/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
            WHERE
                (
                    "IV_ATTRIBUTE"."PARENT" IS NULL
                ) 
                AND (
                    (
                        (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1'
                        ) 
                        OR (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large'
                        )
                    )
                )
        ) 
        AND (
            "VARIANT_OF" = '_Test Numeric Template Item'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 8/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
            WHERE
                (
                    "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length'
                ) 
                AND (
                    "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1'
                ) 
                AND NOT (("IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large')) 
                AND (
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME"
                ) 
                AND (
                    "PARENT" <> '_Test Numeric Variant-L-1.1'
                )
        ) 
        AND (
            "VARIANT_OF" = '_Test Numeric Template Item'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 11/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
            WHERE
                NOT ("IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1') 
                AND (
                    "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length'
                ) 
                AND NOT (("IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large')) 
                AND (
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME"
                ) 
                AND (
                    "PARENT" <> '_Test Numeric Variant-L-1.1'
                )
        ) 
        AND (
            "VARIANT_OF" = '_Test Numeric Template Item'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 12/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
            WHERE
                (
                    "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" IS NULL
                ) 
                AND (
                    "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length'
                ) 
                AND NOT (("IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size')) 
                AND (
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME"
                ) 
                AND (
                    "PARENT" <> '_Test Numeric Variant-L-1.1'
                )
        ) 
        AND (
            "VARIANT_OF" = '_Test Numeric Template Item'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 13/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
            WHERE
                (
                    "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size'
                ) 
                AND (
                    "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large'
                ) 
                AND NOT (("IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length' 
                AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1')) 
                AND (
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME"
                ) 
                AND (
                    "PARENT" <> '_Test Numeric Variant-L-1.1'
                )
        ) 
        AND (
            "VARIANT_OF" = '_Test Numeric Template Item'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 18/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
            WHERE
                NOT ("PARENT" <> '_Test Numeric Variant-L-1.1') 
                AND (
                    "IV_ATTRIBUTE"."PARENT" = "ITEM"."NAME"
                ) 
                AND (
                    (
                        (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1'
                        ) 
                        OR (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large'
                        )
                    )
                )
        ) 
        AND (
            "VARIANT_OF" = '_Test Numeric Template Item'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 85
Path 19/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "NAME" 
    FROM
        "TABITEM" "ITEM" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABITEM VARIANT ATTRIBUTE" "IV_ATTRIBUTE" 
            WHERE
                (
                    "PARENT" IS NULL
                ) 
                AND (
                    (
                        (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Item Length' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = '1.1'
                        ) 
                        OR (
                            "IV_ATTRIBUTE"."ATTRIBUTE" = 'Test Size' 
                            AND "IV_ATTRIBUTE"."ATTRIBUTE_VALUE" = 'Large'
                        )
                    )
                )
        ) 
        AND (
            "VARIANT_OF" = '_Test Numeric Template Item'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process12, query 86
Path 21/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "FROM_TIME",
        "TO_TIME" 
    FROM
        "TABASSESSMENT PLAN" 
    WHERE
        (
            "FROM_TIME" IS NULL
        ) 
        AND (
            '2:00:00' = "TO_TIME"
        ) 
        AND NOT (("TO_TIME" > '1:00:00' 
        AND "TO_TIME" < '2:00:00')) 
        AND NOT (('1:00:00' < "TO_TIME")) 
        AND (
            "ROOM" = 'RM0001'
        ) 
        AND (
            "SCHEDULE_DATE" = '2017-02-09'
        ) 
        AND (
            "NAME" <> 'SH00001'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process13, query 80
Path 10/10 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "TABEMAIL UNSUBSCRIBE"."NAME" 
    FROM
        "TABEMAIL UNSUBSCRIBE" 
    WHERE
        (
            (
                "TABEMAIL UNSUBSCRIBE"."NAME" IS NULL
            )
        ) 
        AND (
            "TABEMAIL UNSUBSCRIBE"."REFERENCE_DOCTYPE" = 'Event' 
            AND "TABEMAIL UNSUBSCRIBE"."EMAIL" = 'test@example.com' 
            AND "TABEMAIL UNSUBSCRIBE"."REFERENCE_NAME" = 'EV00016'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process13, query 82
Path 11/11 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABSALES INVOICE" 
    WHERE
        (
            (
                "TABSALES INVOICE"."DOCSTATUS" IS NULL
            )
        ) 
        AND (
            "TABSALES INVOICE"."CUSTOMER" = 'Party Status Test' 
            AND "TABSALES INVOICE"."OUTSTANDING_AMOUNT" > 0.0
        )
-----------------------------------

-----------------------------------
Query: erpnext-process13, query 85
Path 6/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "BOM_ITEM"."ITEM_CODE",
        SUM("BOM_ITEM"."QTY" / IFNULL("BOM"."QUANTITY",
        1)) * 1 AS "QTY",
        "ITEM"."STOCK_UOM" 
    FROM
        "TABBOM ITEM" "BOM_ITEM" 
    INNER JOIN
        "TABBOM" "BOM" 
            ON "BOM_ITEM"."PARENT" = "BOM"."NAME" 
    INNER JOIN
        "TABITEM" "ITEM" 
            ON "ITEM"."NAME" = "BOM_ITEM"."ITEM_CODE" 
    WHERE
        (
            "BOM_ITEM"."PARENT" IS NULL
        ) 
        AND (
            "BOM_ITEM"."DOCSTATUS" < 2
        ) 
        AND (
            "IS_STOCK_ITEM" = 1
        ) 
    GROUP BY
        "BOM_ITEM"."ITEM_CODE",
        "ITEM"."STOCK_UOM"
-----------------------------------

-----------------------------------
Query: erpnext-process13, query 86
Path 21/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "FROM_TIME",
        "TO_TIME" 
    FROM
        "TABCOURSE SCHEDULE" 
    WHERE
        (
            "FROM_TIME" IS NULL
        ) 
        AND (
            '5:00:00' = "TO_TIME"
        ) 
        AND NOT (("TO_TIME" > '4:00:00' 
        AND "TO_TIME" < '5:00:00')) 
        AND NOT (('4:00:00' < "TO_TIME")) 
        AND (
            "INSTRUCTOR" = '_T-Instructor-00001'
        ) 
        AND (
            "SCHEDULE_DATE" = '2017-02-09'
        ) 
        AND (
            "NAME" <> 'SH00043'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process14, query 86
Path 12/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 4.576278971170153 | Has no output, distance is 8.948491030639747 | Has no output, distance is 1.0 | Has no output, distance is 5.963109756097561 | Has no output, distance is 3.8488328053987058 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 6.578382838283828 | Has no output, distance is 6.350422517384039 | Has no output, distance is 1.9910714285714286

    SELECT
        'Journal Entry' AS "REFERENCE_TYPE",
        "T1"."NAME" AS "REFERENCE_NAME",
        "T1"."REMARK" AS "REMARKS",
        "T2"."CREDIT_IN_ACCOUNT_CURRENCY" AS "AMOUNT",
        "T2"."NAME" AS "REFERENCE_ROW",
        "T2"."REFERENCE_NAME" AS "AGAINST_ORDER" 
    FROM
        "TABJOURNAL ENTRY" "T1" 
    INNER JOIN
        "TABJOURNAL ENTRY ACCOUNT" "T2" 
            ON "T1"."NAME" = "T2"."PARENT" 
    WHERE
        (
            "T1"."DOCSTATUS" = 0
        ) 
        AND (
            "T2"."ACCOUNT" = 'Debtors - _TC'
        ) 
        AND (
            "T2"."PARTY_TYPE" = 'Customer'
        ) 
        AND (
            "T2"."PARTY" = '_Test Customer'
        ) 
        AND (
            "T2"."IS_ADVANCE" = 'Yes'
        ) 
        AND (
            "CREDIT_IN_ACCOUNT_CURRENCY" > 0
        ) 
        AND (
            (
                "T2"."REFERENCE_TYPE" = 'Sales Order' 
                AND IFNULL("T2"."REFERENCE_NAME", '') IN (
                    'SO-00003'
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process14, query 86
Path 16/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 9.921298636118175 | Has no output, distance is 4.3105590062111805 | Has no output, distance is 0.5 | Has no output, distance is 12.366868686868687 | Has no output, distance is 5.943578732655197 | Has no output, distance is 1.25 | Has no output, distance is 1.1666666666666665 | Has no output, distance is 1.4333333333333333 | Has no output, distance is 8.200269110084546 | Has no output, distance is 1.375

    SELECT
        'Journal Entry' AS "REFERENCE_TYPE",
        "T1"."NAME" AS "REFERENCE_NAME",
        "T1"."REMARK" AS "REMARKS",
        "T2"."CREDIT_IN_ACCOUNT_CURRENCY" AS "AMOUNT",
        "T2"."NAME" AS "REFERENCE_ROW",
        "T2"."REFERENCE_NAME" AS "AGAINST_ORDER" 
    FROM
        "TABJOURNAL ENTRY" "T1" 
    INNER JOIN
        "TABJOURNAL ENTRY ACCOUNT" "T2" 
            ON "T1"."NAME" = "T2"."PARENT" 
    WHERE
        (
            "T2"."REFERENCE_TYPE" = 'Sales Order'
        ) 
        AND (
            IFNULL("T2"."REFERENCE_NAME", '') IN (
                'SO-00003'
            )
        ) 
        AND (
            "T2"."ACCOUNT" = 'Debtors - _TC'
        ) 
        AND (
            "T2"."PARTY_TYPE" = 'Customer'
        ) 
        AND (
            "T2"."PARTY" = '_Test Customer'
        ) 
        AND (
            "T2"."IS_ADVANCE" = 'Yes'
        ) 
        AND (
            "T1"."DOCSTATUS" = 1
        ) 
        AND (
            "CREDIT_IN_ACCOUNT_CURRENCY" > 0
        )
-----------------------------------

-----------------------------------
Query: erpnext-process14, query 86
Path 20/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 2.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 2.0 | Has no output, distance is 2.0 | Has no output, distance is 2.0 | Has no output, distance is 1.0

    SELECT
        'Journal Entry' AS "REFERENCE_TYPE",
        "T1"."NAME" AS "REFERENCE_NAME",
        "T1"."REMARK" AS "REMARKS",
        "T2"."CREDIT_IN_ACCOUNT_CURRENCY" AS "AMOUNT",
        "T2"."NAME" AS "REFERENCE_ROW",
        "T2"."REFERENCE_NAME" AS "AGAINST_ORDER" 
    FROM
        "TABJOURNAL ENTRY" "T1" 
    LEFT JOIN
        "TABJOURNAL ENTRY ACCOUNT" "T2" 
            ON "T1"."NAME" = "T2"."PARENT" 
    WHERE
        (
            (
                "T2"."PARENT" IS NULL
            ) 
            AND (
                "T1"."NAME" IS NOT NULL
            )
        ) 
        AND (
            "T1"."DOCSTATUS" = 1 
            AND (
                IFNULL("T2"."REFERENCE_NAME", '') IN (
                    'SO-00003'
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 82
Path 11/11 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABSALES ORDER" 
    WHERE
        (
            (
                "TABSALES ORDER"."DOCSTATUS" IS NULL
            )
        ) 
        AND (
            IFNULL("TABSALES ORDER"."STATUS", '') NOT IN (
                'Completed', 'Closed'
            ) 
            AND "TABSALES ORDER"."CUSTOMER" = '_Test Customer 1 - 1'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 85
Path 6/19 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "BOM_ITEM"."ITEM_CODE",
        SUM("BOM_ITEM"."QTY" / IFNULL("BOM"."QUANTITY",
        1)) * 2 AS "QTY",
        "ITEM"."STOCK_UOM" 
    FROM
        "TABBOM SCRAP ITEM" "BOM_ITEM" 
    INNER JOIN
        "TABBOM" "BOM" 
            ON "BOM_ITEM"."PARENT" = "BOM"."NAME" 
    INNER JOIN
        "TABITEM" "ITEM" 
            ON "ITEM"."NAME" = "BOM_ITEM"."ITEM_CODE" 
    WHERE
        (
            "BOM_ITEM"."PARENT" IS NULL
        ) 
        AND (
            "BOM_ITEM"."DOCSTATUS" < 2
        ) 
        AND (
            "IS_STOCK_ITEM" = 1
        ) 
    GROUP BY
        "BOM_ITEM"."ITEM_CODE",
        "ITEM"."STOCK_UOM"
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 86
Path 15/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 10.778189195199978 | Has no output, distance is 12.852408516942328 | Has no output, distance is 5.57936507936508 | Has no output, distance is 5.1150761648745515 | Has no output, distance is 10.393070032800512 | Has no output, distance is 7.08096618357488 | Has no output, distance is 0.0012600000000000389 | Has no output, distance is 10.0 | Has no output, distance is 3.4912280701754383 | Has no output, distance is 5.4360140135411745

    SELECT
        'Journal Entry' AS "REFERENCE_TYPE",
        "T1"."NAME" AS "REFERENCE_NAME",
        "T1"."REMARK" AS "REMARKS",
        "T2"."DEBIT_IN_ACCOUNT_CURRENCY" AS "AMOUNT",
        "T2"."NAME" AS "REFERENCE_ROW",
        "T2"."REFERENCE_NAME" AS "AGAINST_ORDER" 
    FROM
        "TABJOURNAL ENTRY" "T1" 
    INNER JOIN
        "TABJOURNAL ENTRY ACCOUNT" "T2" 
            ON "T1"."NAME" = "T2"."PARENT" 
    WHERE
        (
            "DEBIT_IN_ACCOUNT_CURRENCY" = -1
        ) 
        AND (
            "T2"."ACCOUNT" = 'Creditors - _TC'
        ) 
        AND (
            "T2"."PARTY_TYPE" = 'Supplier'
        ) 
        AND (
            "T2"."PARTY" = '_Test Supplier'
        ) 
        AND (
            "T2"."IS_ADVANCE" = 'Yes'
        ) 
        AND (
            "T1"."DOCSTATUS" = 1
        ) 
        AND (
            (
                "T2"."REFERENCE_TYPE" = 'Purchase Order' 
                AND IFNULL("T2"."REFERENCE_NAME", '') IN (
                    'PO-00006'
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 86
Path 20/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 2.0

    SELECT
        'Journal Entry' AS "REFERENCE_TYPE",
        "T1"."NAME" AS "REFERENCE_NAME",
        "T1"."REMARK" AS "REMARKS",
        "T2"."DEBIT_IN_ACCOUNT_CURRENCY" AS "AMOUNT",
        "T2"."NAME" AS "REFERENCE_ROW",
        "T2"."REFERENCE_NAME" AS "AGAINST_ORDER" 
    FROM
        "TABJOURNAL ENTRY" "T1" 
    LEFT JOIN
        "TABJOURNAL ENTRY ACCOUNT" "T2" 
            ON "T1"."NAME" = "T2"."PARENT" 
    WHERE
        (
            (
                "T2"."PARENT" IS NULL
            ) 
            AND (
                "T1"."NAME" IS NOT NULL
            )
        ) 
        AND (
            "T1"."DOCSTATUS" = 1 
            AND (
                IFNULL("T2"."REFERENCE_NAME", '') IN (
                    'PO-00006'
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 1/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 31.502202205047787 | Has no output, distance is 49.25952190854283 | Has no output, distance is 33.00166812543861 | Has no output, distance is 14.86235922244074 | Has no output, distance is 43.658808129870856 | Has no output, distance is 9.475931832827026 | Has no output, distance is 13.158068617420046 | Has no output, distance is 8.92387875583752 | Has no output, distance is 32.044367369589345 | Has no output, distance is 25.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 2/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 368.4493866695614 | Has no output, distance is 27.689048879825435 | Has no output, distance is 180.39438084333858 | Has no output, distance is 22.217170301049045 | Has no output, distance is 179.01862466341987 | Has no output, distance is 7.56423930867897 | Has no output, distance is 10.532488368910784 | Has no output, distance is 10.24885488478917 | Has no output, distance is 57.630722533844256 | Has no output, distance is 13.740990303734204

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_CITY", '') = '') 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 3/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 6.118259337561663 | Has no output, distance is 6.8691968509085415 | Has no output, distance is 25.0 | Has no output, distance is 196.0 | Has no output, distance is 2.772972972972973 | Has no output, distance is 3.321969696969697 | Has no output, distance is 148.39177796722552 | Has no output, distance is 25.0 | Has no output, distance is 12.851847281715342 | Has no output, distance is 4.397251425822854

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("COMPANY", '') = '_Test Company') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 4/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 12.364949212127268 | Has no output, distance is 12.645538509534935 | Has no output, distance is 2.6462585034013606 | Has no output, distance is 8.5631743452166 | Has no output, distance is 9.402012087638942 | Has no output, distance is 1.5 | Has no output, distance is 6.420145687645688 | Has no output, distance is 6.5686382113821145 | Has no output, distance is 29.42583257348411 | Has no output, distance is 57.91297583450939

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_STATE", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 5/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 23.22555555555555 | Has no output, distance is 25.0 | Has no output, distance is 13.414742306408414 | Has no output, distance is 14.284025043258083 | Has no output, distance is 3.1610644257703084 | Has no output, distance is 203.3301326470903 | Has no output, distance is 34.612688757114064 | Has no output, distance is 32.00156564338544 | Has no output, distance is 21.52801994275432 | Has no output, distance is 31.597211699383543

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_COUNTY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 6/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 0.5 | Has no output, distance is 25.171715957481254 | Has no output, distance is 3.4264469183824025 | Has no output, distance is 30.061799311799312 | Has no output, distance is 8.39681787050208 | Has no output, distance is 15.28462487146387 | Has no output, distance is 4.408854166666666 | Has no output, distance is 20.972403420796944 | Has no output, distance is 230.18762065670364 | Has no output, distance is 23.707515342403614

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SUPPLIER_TYPE", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 7/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 7.587606837606838 | Has no output, distance is 9.581954623380769 | Has no output, distance is 45.386051759629396 | Has no output, distance is 14.034912181526808 | Has no output, distance is 46.002276335284236 | Has no output, distance is 170.85714285714286 | Has no output, distance is 3.4873417721518987 | Has no output, distance is 39.57653804144877 | Has no output, distance is 0.5 | Has no output, distance is 14.826456405403366

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_COUNTRY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 9/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 64.34416098719628 | Has no output, distance is 21.74013759956145 | Has no output, distance is 10.23823023404039 | Has no output, distance is 2.3777777777777778 | Has no output, distance is 33.69784552617033 | Has no output, distance is 30.724821109123436 | Has no output, distance is 4.872653362897266 | Has no output, distance is 52.204378367400615 | Has no output, distance is 23.272654871566957 | Has no output, distance is 12.925595432583403

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_CITY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 10/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 6.008359754808708 | Has no output, distance is 17.605099729546993 | Has no output, distance is 20.285576416006094 | Has no output, distance is 18.32726030746818 | Has no output, distance is 199.14285714285714 | Has no output, distance is 5.67185145196482 | Has no output, distance is 16.74503065719196 | Has no output, distance is 5.088095238095239 | Has no output, distance is 176.1271164021164 | Has no output, distance is 17.840628219173755

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("TAX_TYPE", '') = 'Sales') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 12/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 8.979615889783142 | Has no output, distance is 25.0 | Has no output, distance is 33.13723756735498 | Has no output, distance is 6.692663732159531 | Has no output, distance is 10.42854402731452 | Has no output, distance is 25.0 | Has no output, distance is 5.4224138778318345 | Has no output, distance is 13.16274016287376 | Has no output, distance is 3.7916666666666665 | Has no output, distance is 23.904012616475473

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SUPPLIER", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 16/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 0.5 | Has no output, distance is 17.3076440633346 | Has no output, distance is 10.319685652038592 | Has no output, distance is 34.29487344565618 | Has no output, distance is 4.63516447412533 | Has no output, distance is 196.0 | Has no output, distance is 169.0 | Has no output, distance is 25.0 | Has no output, distance is 8.928422246091419

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ("TO_DATE" > '2015-01-01') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 17/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 9.477500361150552 | Has no output, distance is 11.069311499903604 | Has no output, distance is 9.640631586962494 | Has no output, distance is 180.15810696707584 | Has no output, distance is 5.7404761904761905 | Has no output, distance is 202.16752844522287 | Has no output, distance is 225.75485248767296 | Has no output, distance is 2.445721583652618 | Has no output, distance is 35.364044087500254 | Has no output, distance is 7.0639097274318585

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            "TO_DATE" IS NULL
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 18/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 54.79429460836 | Has no output, distance is 239.28397352576457 | Has no output, distance is 22.696638351923305 | Has no output, distance is 169.0 | Has no output, distance is 29.640119837207052 | Has no output, distance is 17.586411668978435 | Has no output, distance is 17.777712940578052 | Has no output, distance is 126.7364504219146 | Has no output, distance is 53.63332789335928 | Has no output, distance is 47.28606575037631

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT ("NAME" <> 'TR0005') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "TO_DATE" > '2015-01-01'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 20/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 35.33999139982564 | Has no output, distance is 32.441484582228114 | Has no output, distance is 22.39629775859339 | Has no output, distance is 169.0 | Has no output, distance is 22.129350102986656 | Has no output, distance is 25.0 | Has no output, distance is 1.0 | Has no output, distance is 11.95310191975722 | Has no output, distance is 33.84701765469653 | Has no output, distance is 196.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SHIPPING_CITY" IS NULL
            )
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 22/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 11.011615894140018 | Has no output, distance is 25.0 | Has no output, distance is 25.0 | Has no output, distance is 25.0 | Has no output, distance is 25.0 | Has no output, distance is 9.372269435107851 | Has no output, distance is 221.0 | Has no output, distance is 12.544785681306205 | Has no output, distance is 25.0 | Has no output, distance is 8.263536599133074

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "COMPANY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 24/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 11.268700220256479 | Has no output, distance is 42.264931901720566 | Has no output, distance is 173.6157894736842 | Has no output, distance is 43.08699662682897 | Has no output, distance is 209.7751273823404 | Has no output, distance is 25.0 | Has no output, distance is 46.15793419515401 | Has no output, distance is 52.794728915257 | Has no output, distance is 9.321358189740543 | Has no output, distance is 365.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SHIPPING_STATE" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 26/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 172.137641723356 | Has no output, distance is 15.714471896190346 | Has no output, distance is 33.80527759363966 | Has no output, distance is 11.865448307202474 | Has no output, distance is 8.768921589573765 | Has no output, distance is 16.36302145923208 | Has no output, distance is 15.76213867889883 | Has no output, distance is 37.755970988027684 | Has no output, distance is 29.541803278688526

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SHIPPING_COUNTY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 27/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 221.0 | Has no output, distance is 3.8397435897435894 | Has no output, distance is 10.12525623044557 | Has no output, distance is 9.432636996253727 | Has no output, distance is 12.712491969128536 | Has no output, distance is 8.090787700790969 | Has no output, distance is 25.0 | Has no output, distance is 8.551133180544946 | Has no output, distance is 2.932806324110672 | Has no output, distance is 11.974711789041722

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SUPPLIER_TYPE" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 29/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 32.856525108769404 | Has no output, distance is 8.937071435246372 | Has no output, distance is 33.70794278376252 | Has no output, distance is 2.419437340153453 | Has no output, distance is 11.322254845757321 | Has no output, distance is 46.936832069601394 | Has no output, distance is 197.16666666666666 | Has no output, distance is 22.9848794615003 | Has no output, distance is 10.034647691169429

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "BILLING_COUNTRY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 30/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 19.851687197820038 | Has no output, distance is 8.427996121195664 | Has no output, distance is 12.190277177525799 | Has no output, distance is 13.262948049284239 | Has no output, distance is 2.9019607843137254 | Has no output, distance is 25.0 | Has no output, distance is 7.34665725047081 | Has no output, distance is 11.955722109622505 | Has no output, distance is 36.055959662396525 | Has no output, distance is 7.224911934626339

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "BILLING_COUNTRY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 33/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 34.917512917538566 | Has no output, distance is 21.15966168936869 | Has no output, distance is 10.537353960259228 | Has no output, distance is 12.95244021414174 | Has no output, distance is 178.43773873185637 | Has no output, distance is 37.24555716542353 | Has no output, distance is 121.59118298788066 | Has no output, distance is 37.975143892055655 | Has no output, distance is 19.839072632696066 | Has no output, distance is 26.436510426758094

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "BILLING_CITY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 37/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 15.4910874098579 | Has no output, distance is 2.4554361567635903 | Has no output, distance is 191.3756224938096 | Has no output, distance is 9.570867789988913 | Has no output, distance is 10.111270757069981 | Has no output, distance is 25.0 | Has no output, distance is 8.607448547191918 | Has no output, distance is 6.335896898653078 | Has no output, distance is 11.797423687561864 | Has no output, distance is 14.20749506653343

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SHIPPING_COUNTRY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 39/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 21.864898771250143 | Has no output, distance is 10.727246941598754 | Has no output, distance is 236.43561438561437 | Has no output, distance is 10.998701079622133 | Has no output, distance is 1.0 | Has no output, distance is 35.57903316205795 | Has no output, distance is 3.9209239130434783 | Has no output, distance is 17.186207563254605 | Has no output, distance is 10.83328134828135 | Has no output, distance is 30.15830235180697

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SUPPLIER" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 43/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 3.5898809523809523 | Has no output, distance is 11.389194405430551 | Has no output, distance is 8.542790269446972 | Has no output, distance is 19.450438849262365 | Has no output, distance is 16.093768778017132 | Has no output, distance is 13.295841136432 | Has no output, distance is 35.522260296843825 | Has no output, distance is 35.508620738371825 | Has no output, distance is 17.548042533922498

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "CUSTOMER_GROUP" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 45/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 39.61137952470216 | Has no output, distance is 24.235390598776412 | Has no output, distance is 390.0 | Has no output, distance is 15.022471810896212 | Has no output, distance is 7.77859115234096 | Has no output, distance is 18.552977603957622 | Has no output, distance is 9.478320445645924 | Has no output, distance is 22.006397525110504 | Has no output, distance is 221.0 | Has no output, distance is 21.671051864184225

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "BILLING_STATE" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process15, query 87
Path 46/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 9.568176375471412 | Has no output, distance is 1.0 | Has no output, distance is 10.338579925614898 | Has no output, distance is 15.031058047039945 | Has no output, distance is 12.27604588033021 | Has no output, distance is 25.0 | Has no output, distance is 221.0 | Has no output, distance is 10.38236227282558 | Has no output, distance is 10.633093894948127 | Has no output, distance is 50.14537276801976

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "BILLING_STATE" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND "TO_DATE" > '2015-01-01' 
            AND "NAME" <> 'TR0005'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 80
Path 10/10 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME" 
    FROM
        "TABQUOTATION" 
    WHERE
        (
            (
                "TABQUOTATION"."DOCSTATUS" IS NULL
            )
        ) 
        AND (
            "TABQUOTATION"."CUSTOMER" = '_Test Customer' 
            AND "TABQUOTATION"."ORDER_TYPE" = 'Shopping Cart'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 83
Path 11/14 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        DISTINCT "USER"."NAME" 
    FROM
        "TABUSERROLE" "USER_ROLE" 
    INNER JOIN
        "TABUSER" "USER" 
            ON "USER_ROLE"."PARENT" = "USER"."NAME" 
    WHERE
        (
            "USER_ROLE"."PARENT" IS NULL
        ) 
        AND (
            "USER_ROLE"."ROLE" = 'System Manager'
        ) 
        AND (
            "USER"."DOCSTATUS" < 2
        ) 
        AND (
            "USER"."ENABLED" = 1
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 84
Path 12/16 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "PARENT" 
    FROM
        "TABSALARY STRUCTURE EMPLOYEE" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABSALARY STRUCTURE" 
            WHERE
                (
                    "FROM_DATE" <= '2010-01-01'
                ) 
                AND NOT ("FROM_DATE" <= '2017-02-09') 
                AND (
                    "IS_ACTIVE" = 'Yes'
                ) 
                AND (
                    (
                        (
                            "TO_DATE" IS NULL
                        ) 
                        OR "TO_DATE" >= '2017-02-09' 
                        OR "TO_DATE" >= NULL
                    )
                )
        ) 
        AND (
            "EMPLOYEE" = '_T-Employee-0001'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 84
Path 13/16 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "PARENT" 
    FROM
        "TABSALARY STRUCTURE EMPLOYEE" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABSALARY STRUCTURE" 
            WHERE
                (
                    (
                        "TO_DATE" IS NOT NULL
                    )
                ) 
                AND NOT ("TO_DATE" >= '2017-02-09') 
                AND NOT ("TO_DATE" >= NULL) 
                AND (
                    "IS_ACTIVE" = 'Yes'
                ) 
                AND (
                    (
                        "FROM_DATE" <= '2017-02-09' 
                        OR "FROM_DATE" <= '2010-01-01'
                    )
                )
        ) 
        AND (
            "EMPLOYEE" = '_T-Employee-0001'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 84
Path 15/16 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "PARENT" 
    FROM
        "TABSALARY STRUCTURE EMPLOYEE" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABSALARY STRUCTURE" 
            WHERE
                (
                    "TO_DATE" >= '2017-02-09'
                ) 
                AND (
                    (
                        "TO_DATE" IS NOT NULL
                    )
                ) 
                AND NOT ("TO_DATE" >= NULL) 
                AND (
                    "IS_ACTIVE" = 'Yes'
                ) 
                AND (
                    (
                        "FROM_DATE" <= '2017-02-09' 
                        OR "FROM_DATE" <= '2010-01-01'
                    )
                )
        ) 
        AND (
            "EMPLOYEE" = '_T-Employee-0001'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 84
Path 16/16 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306 | Has no output, distance is 1.7976931348623156E306

    SELECT
        "PARENT" 
    FROM
        "TABSALARY STRUCTURE EMPLOYEE" 
    WHERE
        EXISTS (
            SELECT
                "NAME" 
            FROM
                "TABSALARY STRUCTURE" 
            WHERE
                (
                    "TO_DATE" >= NULL
                ) 
                AND (
                    (
                        "TO_DATE" IS NOT NULL
                    )
                ) 
                AND NOT ("TO_DATE" >= '2017-02-09') 
                AND (
                    "IS_ACTIVE" = 'Yes'
                ) 
                AND (
                    (
                        "FROM_DATE" <= '2017-02-09' 
                        OR "FROM_DATE" <= '2010-01-01'
                    )
                )
        ) 
        AND (
            "EMPLOYEE" = '_T-Employee-0001'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 86
Path 21/24 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.0

    SELECT
        "NAME",
        "FROM_TIME",
        "TO_TIME" 
    FROM
        "TABCOURSE SCHEDULE" 
    WHERE
        (
            "FROM_TIME" IS NULL
        ) 
        AND (
            '2:00:00' = "TO_TIME"
        ) 
        AND NOT (("TO_TIME" > '1:00:00' 
        AND "TO_TIME" < '2:00:00')) 
        AND NOT (('1:00:00' < "TO_TIME")) 
        AND (
            "STUDENT_GROUP" = 'TC-TP-2014-2015-2014-2015 (_Test Academic Term)'
        ) 
        AND (
            "SCHEDULE_DATE" = '2017-02-09'
        ) 
        AND (
            "NAME" <> 'SH00025'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 2/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 15.009801193238514 | Has no output, distance is 30.991176470588236 | Has no output, distance is 15.612742043322244 | Has no output, distance is 13.564279989303056 | Has no output, distance is 17.05262076828455 | Has no output, distance is 13.046773731183489 | Has no output, distance is 26.474358974358974 | Has no output, distance is 39.92598444870782 | Has no output, distance is 7.155844155844156 | Has no output, distance is 31.590462185290647

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_CITY", '') = '') 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "FROM_DATE" < '2013-01-01'
        ) 
        AND (
            "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 5/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 15.953443616027009 | Has no output, distance is 25.0 | Has no output, distance is 13.749004281750153 | Has no output, distance is 0.5 | Has no output, distance is 29.9016204860264 | Has no output, distance is 4.935502392344498 | Has no output, distance is 10.875372378507691 | Has no output, distance is 33.25153616886608 | Has no output, distance is 23.70707751830505 | Has no output, distance is 10.158887524765394

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SHIPPING_COUNTY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "FROM_DATE" < '2013-01-01'
        ) 
        AND (
            "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 7/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 18.330326220979963 | Has no output, distance is 16.784204051934715 | Has no output, distance is 35.26377335070974 | Has no output, distance is 25.0 | Has no output, distance is 36.46238570994471 | Has no output, distance is 22.177681847627372 | Has no output, distance is 42.10979293759519 | Has no output, distance is 27.523741309235213 | Has no output, distance is 29.85720571095571 | Has no output, distance is 9.30687120298401

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_COUNTRY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "FROM_DATE" < '2013-01-01'
        ) 
        AND (
            "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 9/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 8.238236554237421 | Has no output, distance is 2.951206140350877 | Has no output, distance is 9.554563492063492 | Has no output, distance is 180.94117647058823 | Has no output, distance is 28.90656108597285 | Has no output, distance is 10.2416929007551 | Has no output, distance is 29.394871794871797 | Has no output, distance is 199.71969696969697 | Has no output, distance is 3.176391683433937 | Has no output, distance is 24.344471856296693

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_CITY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "FROM_DATE" < '2013-01-01'
        ) 
        AND (
            "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 12/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 4.12683284457478 | Has no output, distance is 25.0 | Has no output, distance is 55.17055694486207 | Has no output, distance is 4.908961943126219 | Has no output, distance is 1.0 | Has no output, distance is 25.0 | Has no output, distance is 16.123901594465664 | Has no output, distance is 5.811301369863014 | Has no output, distance is 9.752784880854415 | Has no output, distance is 177.31351232837721

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("SUPPLIER", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "FROM_DATE" < '2013-01-01'
        ) 
        AND (
            "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 13/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 20.412438998240113 | Has no output, distance is 46.02501378146627 | Has no output, distance is 12.314812223346818 | Has no output, distance is 6.8292572463768115 | Has no output, distance is 22.825212607126836 | Has no output, distance is 25.0 | Has no output, distance is 26.666666666666668 | Has no output, distance is 18.95763627979614 | Has no output, distance is 28.333333333333332 | Has no output, distance is 200.2995265151515

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_COUNTY", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "FROM_DATE" < '2013-01-01'
        ) 
        AND (
            "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 14/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 30.967105322624576 | Has no output, distance is 9.948403507867793 | Has no output, distance is 52.79143421139585 | Has no output, distance is 12.530998168498167 | Has no output, distance is 4.446895644635758 | Has no output, distance is 7.557784589927448 | Has no output, distance is 8.310368077723137 | Has no output, distance is 13.258257271963119 | Has no output, distance is 17.42714365869914 | Has no output, distance is 46.70576948002006

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("CUSTOMER_GROUP", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "FROM_DATE" < '2013-01-01'
        ) 
        AND (
            "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 15/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 12.693186110298143 | Has no output, distance is 205.2844503517812 | Has no output, distance is 10.953849853295491 | Has no output, distance is 27.238354423067104 | Has no output, distance is 5.390267627109733 | Has no output, distance is 39.7210752688172 | Has no output, distance is 2.4166666666666665 | Has no output, distance is 198.36296296296297 | Has no output, distance is 12.235525565123265 | Has no output, distance is 9.325569831027064

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        NOT (IFNULL("BILLING_STATE", '') = '') 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            "FROM_DATE" < '2013-01-01'
        ) 
        AND (
            "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 17/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 7.819111740224544 | Has no output, distance is 10.353401506362376 | Has no output, distance is 25.0 | Has no output, distance is 25.320052723907814 | Has no output, distance is 9.219869429104634 | Has no output, distance is 19.019379060695584 | Has no output, distance is 40.58604163146488 | Has no output, distance is 200.34607843137255 | Has no output, distance is 3.438888888888889 | Has no output, distance is 12.438180152115015

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            "FROM_DATE" IS NULL
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = ''
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company'
        ) 
        AND (
            IFNULL("SHIPPING_STATE", '') = ''
        ) 
        AND (
            IFNULL("SHIPPING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER_TYPE", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER", '') = '_Test Customer'
        ) 
        AND (
            IFNULL("BILLING_CITY", '') = ''
        ) 
        AND (
            IFNULL("TAX_TYPE", '') = 'Sales'
        ) 
        AND (
            IFNULL("SHIPPING_COUNTRY", '') = ''
        ) 
        AND (
            IFNULL("SUPPLIER", '') = ''
        ) 
        AND (
            IFNULL("BILLING_COUNTY", '') = ''
        ) 
        AND (
            IFNULL("CUSTOMER_GROUP", '') = ''
        ) 
        AND (
            IFNULL("BILLING_STATE", '') = ''
        ) 
        AND (
            "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 19/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 179.29680587435794 | Has no output, distance is 44.90317953238686 | Has no output, distance is 9.868873308609734 | Has no output, distance is 9.361068578460959 | Has no output, distance is 9.531243461514215 | Has no output, distance is 19.43570642746174 | Has no output, distance is 27.875 | Has no output, distance is 8.403213735417125 | Has no output, distance is 19.33575108483895

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "SHIPPING_CITY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 24/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 5.0777777777777775 | Has no output, distance is 18.46340880187558 | Has no output, distance is 5.381405299515414 | Has no output, distance is 1.1666666666666665 | Has no output, distance is 16.61618422253611 | Has no output, distance is 13.266664476370838 | Has no output, distance is 34.01336674321831 | Has no output, distance is 15.887678834926541 | Has no output, distance is 25.0 | Has no output, distance is 185.7483417160991

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SHIPPING_STATE" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 28/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 28.79758064516129 | Has no output, distance is 13.913302795313982 | Has no output, distance is 1.8 | Has no output, distance is 40.57766828938047 | Has no output, distance is 10.382775629096283 | Has no output, distance is 14.032432117513853 | Has no output, distance is 11.841292836074949 | Has no output, distance is 33.48568282746448 | Has no output, distance is 3.6203703703703702 | Has no output, distance is 26.540373658107754

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SUPPLIER_TYPE" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 30/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 1.0 | Has no output, distance is 34.4138796257201 | Has no output, distance is 35.57548167849412 | Has no output, distance is 25.0 | Has no output, distance is 9.818417944247464 | Has no output, distance is 14.134934547017204 | Has no output, distance is 15.598215625319082 | Has no output, distance is 16.945461918488263 | Has no output, distance is 12.315555957020745 | Has no output, distance is 390.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "BILLING_COUNTRY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 31/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 36.942773709328335 | Has no output, distance is 11.65956258058779 | Has no output, distance is 3.823234811165846 | Has no output, distance is 9.554244605304447 | Has no output, distance is 12.419008488150935 | Has no output, distance is 10.344878769155878 | Has no output, distance is 171.64779874213838 | Has no output, distance is 2.4462864721485413 | Has no output, distance is 2.2333333333333334 | Has no output, distance is 9.238519718623317

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "CUSTOMER" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 35/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 10.91757900927214 | Has no output, distance is 206.08998109849173 | Has no output, distance is 8.823386786849737 | Has no output, distance is 4.486801242236025 | Has no output, distance is 174.34957983193277 | Has no output, distance is 8.008471898018467 | Has no output, distance is 169.0 | Has no output, distance is 27.855378685586935 | Has no output, distance is 7.317669262526431 | Has no output, distance is 169.0

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "TAX_TYPE" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 38/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 25.0 | Has no output, distance is 9.629341736694677 | Has no output, distance is 9.12569178974124 | Has no output, distance is 3.469717514124294 | Has no output, distance is 34.56162252965425 | Has no output, distance is 29.557216905901115 | Has no output, distance is 1.3333333333333333 | Has no output, distance is 23.831515206117068 | Has no output, distance is 13.445239462178323 | Has no output, distance is 30.633333333333333

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "SHIPPING_COUNTRY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 41/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 28.587730537114773 | Has no output, distance is 37.962500377085114 | Has no output, distance is 11.942225662364839 | Has no output, distance is 10.472180024955414 | Has no output, distance is 9.505681978692802 | Has no output, distance is 41.08471747550695 | Has no output, distance is 203.20940495242363 | Has no output, distance is 17.86013450764057 | Has no output, distance is 3.5897435897435894 | Has no output, distance is 150.3864468864469

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "BILLING_COUNTY" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 42/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 2.654166666666667 | Has no output, distance is 38.69428645437891 | Has no output, distance is 22.75968524810481 | Has no output, distance is 27.65728170806767 | Has no output, distance is 5.865404040404041 | Has no output, distance is 24.993557135459426 | Has no output, distance is 6.117896084687129 | Has no output, distance is 3.858209731980224 | Has no output, distance is 217.90927078168576 | Has no output, distance is 8.720963385243449

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "BILLING_COUNTY" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 44/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 37.810385939651646 | Has no output, distance is 30.756189716716033 | Has no output, distance is 41.68067969646835 | Has no output, distance is 1.9166666666666665 | Has no output, distance is 206.76731040764918 | Has no output, distance is 10.365904163183012 | Has no output, distance is 25.0 | Has no output, distance is 12.352142872873955 | Has no output, distance is 3.906944444444444 | Has no output, distance is 41.34414492084452

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                "CUSTOMER_GROUP" IS NULL
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("BILLING_STATE", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process16, query 87
Path 45/46 - 0 successes, 10 failures
Failure messages: Has no output, distance is 3.2666666666666666 | Has no output, distance is 39.29624189007366 | Has no output, distance is 36.809635457528685 | Has no output, distance is 4.930495598337038 | Has no output, distance is 24.197615103254478 | Has no output, distance is 202.0498652590082 | Has no output, distance is 25.0 | Has no output, distance is 25.0 | Has no output, distance is 169.0 | Has no output, distance is 35.3692349929797

    SELECT
        "NAME",
        "PRIORITY" 
    FROM
        "TABTAX RULE" 
    WHERE
        (
            (
                (
                    "BILLING_STATE" IS NOT NULL
                )
            )
        ) 
        AND (
            IFNULL("SHIPPING_CITY", '') = '' 
            AND IFNULL("COMPANY", '') = '_Test Company' 
            AND IFNULL("SHIPPING_STATE", '') = '' 
            AND IFNULL("SHIPPING_COUNTY", '') = '' 
            AND IFNULL("SUPPLIER_TYPE", '') = '' 
            AND IFNULL("BILLING_COUNTRY", '') = '' 
            AND IFNULL("CUSTOMER", '') = '_Test Customer' 
            AND IFNULL("BILLING_CITY", '') = '' 
            AND IFNULL("TAX_TYPE", '') = 'Sales' 
            AND IFNULL("SHIPPING_COUNTRY", '') = '' 
            AND IFNULL("SUPPLIER", '') = '' 
            AND IFNULL("BILLING_COUNTY", '') = '' 
            AND IFNULL("CUSTOMER_GROUP", '') = '' 
            AND "FROM_DATE" < '2013-01-01' 
            AND "NAME" <> 'TR0006'
        )
-----------------------------------

-----------------------------------
Query: erpnext-process17, query 86
Path 12/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 23.708332432173798 | Has no output, distance is 16.64810999668685 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 1.5 | Has no output, distance is 2.1666666666666665 | Has no output, distance is 7.8198534851964725 | Has no output, distance is 1.0 | Has no output, distance is 1.0 | Has no output, distance is 2.4375

    SELECT
        'Journal Entry' AS "REFERENCE_TYPE",
        "T1"."NAME" AS "REFERENCE_NAME",
        "T1"."REMARK" AS "REMARKS",
        "T2"."CREDIT_IN_ACCOUNT_CURRENCY" AS "AMOUNT",
        "T2"."NAME" AS "REFERENCE_ROW",
        "T2"."REFERENCE_NAME" AS "AGAINST_ORDER" 
    FROM
        "TABJOURNAL ENTRY" "T1" 
    INNER JOIN
        "TABJOURNAL ENTRY ACCOUNT" "T2" 
            ON "T1"."NAME" = "T2"."PARENT" 
    WHERE
        (
            "T1"."DOCSTATUS" = 0
        ) 
        AND (
            "T2"."ACCOUNT" = 'Debtors - _TC'
        ) 
        AND (
            "T2"."PARTY_TYPE" = 'Customer'
        ) 
        AND (
            "T2"."PARTY" = '_Test Customer'
        ) 
        AND (
            "T2"."IS_ADVANCE" = 'Yes'
        ) 
        AND (
            "CREDIT_IN_ACCOUNT_CURRENCY" > 0
        ) 
        AND (
            (
                IFNULL("T2"."REFERENCE_NAME", '') = '' 
                OR (
                    "T2"."REFERENCE_TYPE" = 'Sales Order' 
                    AND IFNULL("T2"."REFERENCE_NAME", '') IN (
                        '_T-Quotation-00002'
                    )
                )
            )
        )
-----------------------------------

-----------------------------------
Query: erpnext-process17, query 86
Path 18/26 - 0 successes, 10 failures
Failure messages: Has no output, distance is 2.9230769230769234 | Has no output, distance is 7.076904442456767 | Has no output, distance is 8.364287414472816 | Has no output, distance is 2.1535087719298245 | Has no output, distance is 6.20530303030303 | Has no output, distance is 7.704875283446712 | Has no output, distance is 11.300256331621334 | Has no output, distance is 3.856373815676141 | Has no output, distance is 2.4702608695652173 | Has no output, distance is 5.831216926374238

    SELECT
        'Journal Entry' AS "REFERENCE_TYPE",
        "T1"."NAME" AS "REFERENCE_NAME",
        "T1"."REMARK" AS "REMARKS",
        "T2"."CREDIT_IN_ACCOUNT_CURRENCY" AS "AMOUNT",
        "T2"."NAME" AS "REFERENCE_ROW",
        "T2"."REFERENCE_NAME" AS "AGAINST_ORDER" 
    FROM
        "TABJOURNAL ENTRY" "T1" 
    INNER JOIN
        "TABJOURNAL ENTRY ACCOUNT" "T2" 
            ON "T1"."NAME" = "T2"."PARENT" 
    WHERE
        (
            "T2"."REFERENCE_TYPE" = 'Sales Order'
        ) 
        AND (
            IFNULL("T2"."REFERENCE_NAME", '') IN (
                '_T-Quotation-00002'
            )
        ) 
        AND NOT (IFNULL("T2"."REFERENCE_NAME", '') = '') 
        AND (
            "T2"."ACCOUNT" = 'Debtors - _TC'
        ) 
        AND (
            "T2"."PARTY_TYPE" = 'Customer'
        ) 
        AND (
            "T2"."PARTY" = '_Test Customer'
        ) 
        AND (
            "T2"."IS_ADVANCE" = 'Yes'
        ) 
        AND (
            "T1"."DOCSTATUS" = 1
        ) 
        AND (
            "CREDIT_IN_ACCOUNT_CURRENCY" > 0
        )
-----------------------------------
