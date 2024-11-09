*** Settings ***
Resource    ../Resources/Keywords.resource
Suite Setup    Connect To MySQL Database
Suite Teardown    Disconnect From Database

*** Test Cases ***
Check stored procedures name if exists in db
    Check Procedure Name    GetCustomerShipping
