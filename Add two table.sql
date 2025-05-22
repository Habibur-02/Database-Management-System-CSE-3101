SELECT
    TableA.column1,
    TableA.column2,
    TableB.column3,
    TableB.column4
FROM
    TableA
JOIN
    TableB ON TableA.common_column = TableB.common_column;
