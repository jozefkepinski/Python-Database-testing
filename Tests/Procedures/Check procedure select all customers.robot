*** Settings ***
Resource    ../../Resources/Procedures.resource
Suite Setup    Connect To MySQL Database
Suite Teardown    Disconnect From Database


*** Test Cases ***
Check procedure select all customers
    Check procedure select all customers
