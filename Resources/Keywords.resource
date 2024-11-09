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
    Log    ${procedure_output}
    ${sql_command_output}=    Query    select * from customers where city='${city}';
    ${result}=    Compare Tuples    ${procedure_output}    ${sql_command_output}
    Should Be True    ${result}
    
Check Procedure Select Customers From City and Postal Code
    [Arguments]    ${city}    ${postal_code}
    ${procedure_output} =    Query    call SelectCustomersByCityAndPin('${city}', '${postal_code}');
    Log    ${procedure_output}
    ${sql_command_output}=    Query    select * from customers where city='${city}' and postalCode='${postal_code}';
    ${result}=    Compare Tuples    ${procedure_output}    ${sql_command_output}
    Should Be True    ${result}

Check get the order
    [Arguments]    ${cust_no}
    ${shipped}    Set Variable    0
    ${canceled}    Set Variable    0
    ${resolved}    Set Variable    0
    ${disputed}    Set Variable    0
    @{params}=    Create List    ${cust_no}    ${shipped}    ${canceled}    ${resolved}    ${disputed}
    
    ${params_values}    ${order_output}=    Call Stored Procedure    get_order_by_cust    ${params}
    Log    ${order_output}
    Log    ${params_values}
    ${shipped}=    Set Variable    ${params_values}[1]
    ${canceled}    Set Variable    ${params_values}[2]
    ${resolved}    Set Variable    ${params_values}[3]
    ${disputed}    Set Variable    ${params_values}[4]
    ${query_shipped}=    Query    select count(*) from orders where customerNumber=${cust_no} and status = 'Shipped';
    ${query_canceled}=    Query    select count(*) from orders where customerNumber=${cust_no} and status = 'Canceled';
    ${query_resolved}=    Query    select count(*) from orders where customerNumber=${cust_no} and status = 'Resolved';
    ${query_disputed}=    Query    select count(*) from orders where customerNumber=${cust_no} and status = 'Disputed';
    Should Be Equal    ${shipped}    ${query_shipped}[0][0]
    Should Be Equal    ${canceled}   ${query_canceled}[0][0]
    Should Be Equal    ${resolved}   ${query_resolved}[0][0]
    Should Be Equal    ${disputed}   ${query_disputed}[0][0]

