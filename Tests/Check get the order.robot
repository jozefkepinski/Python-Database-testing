*** Settings ***
Resource    ../Resources/Keywords.resource
Suite Setup    Connect To MySQL Database
Suite Teardown    Disconnect From Database


*** Test Cases ***
Check get the order
    Check get theorder    141