*** Settings ***
Library    DatabaseLibrary
Library    ..\\Library\\python_db.py
Variables    ..\\DBObjects\\locators.py


*** Keywords ***
Connect to MySQL Database
    Connect To Database
    ...    pymysql
    ...    db_name=${db_name}
    ...    db_user=${db_user}
    ...    db_password=${db_password}
    ...    db_host=${db_host}
    ...    db_port=${db_port}

Check Check if function exist
    [Arguments]    ${function_name}

    Execute Sql String    Use ${db_name};
    ${output} =    Query    show function status where name='${function_name}';
    Should Be Equal As Strings    ${output}[0][1]    ${function_name}

Check customer level
    ${function_output}=    Query    select customerName, CustomerLevel(creditLimit) from customers;
    ${query_output}=    Query    select customerName, case when creditLimit>50000 then 'Platinum' when creditLimit >= 10000 AND creditLimit <= 50000 then 'Gold' when creditLimit < 10000 then 'Silver' end as customerlevel from customers;
    Should Be Equal    ${function_output}    ${query_output}