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

Check Procedure Name
    [Arguments]    ${pro_name}

    Execute Sql String    Use ${db_name};
    ${output} =    Query    show procedure status where name='${pro_name}';
    Should Be Equal As Strings    ${output}[0][1]    GetCustomerShipping

Check procedure select all customers
    ${procedure_output} =    Query    call SelectAllCustomers();
    ${sql_command_output}=    Query    select * from customers;
    ${result}=    Compare Tuples    ${procedure_output}    ${sql_command_output}
    Should Be True    ${result}
    
Check procedure select customers from city
    [Arguments]    ${city}
    ${procedure_output} =    Query    call SelectAllCustomersByCity('${city}');
    Log To Console    ${procedure_output}
    ${sql_command_output}=    Query    select * from customers where city='${city}';
    ${result}=    Compare Tuples    ${procedure_output}    ${sql_command_output}
    Should Be True    ${result}
