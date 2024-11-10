*** Settings ***
Resource    ../../Resources/Procedures.resource
Suite Setup    Connect To MySQL Database
Suite Teardown    Disconnect From Database


*** Test Cases ***
Check get the order
    Check get the order    141