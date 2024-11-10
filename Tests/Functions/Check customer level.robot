*** Settings ***
Resource    ../../Resources/Functions.resource
Suite Setup    Connect To MySQL Database
Suite Teardown    Disconnect From Database


*** Test Cases ***
Check if function exist
    Check Check if function exist    CustomerLevel

Check customer level
    Check customer level
    
Check customer level with stored procedure
    Check customer level with stored procedure    131