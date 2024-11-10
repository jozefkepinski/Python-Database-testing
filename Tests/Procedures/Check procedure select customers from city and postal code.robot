*** Settings ***
Resource    ../../Resources/Procedures.resource
Suite Setup    Connect To MySQL Database
Suite Teardown    Disconnect From Database


*** Test Cases ***
Check Procedure Select Customers From City and Postal code
    Check Procedure Select Customers From City and Postal Code    Singapore    079903