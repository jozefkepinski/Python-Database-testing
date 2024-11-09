*** Settings ***
Library    DatabaseLibrary
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

Check Procedure Name
    [Arguments]    ${pro_name}

    Execute Sql String    Use ${db_name};
    ${output} =    Query    show procedure status where name='${pro_name}';
    Log To Console    ${output}
    Should Be Equal As Strings    ${output}[0][1]    GetCustomerShipping
