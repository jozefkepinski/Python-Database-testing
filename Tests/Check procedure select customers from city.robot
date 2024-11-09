*** Settings ***
Resource    ../Resources/Keywords.resource
Suite Setup    Connect To MySQL Database
Suite Teardown    Disconnect From Database


*** Test Cases ***
Check Procedure Select Customers From City
    Check Procedure Select Customers From City    Singapore