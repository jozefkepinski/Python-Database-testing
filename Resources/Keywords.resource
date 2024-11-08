*** Settings ***
Library    DatabaseLibrary
Variables    ..\\PageObjects\\locators.py


*** Keywords ***
Connect to MySQL Database
    Connect To Database    pymysql    db_name=${db_name}    db_user=${db_user}    db_password=${db_password}    db_host=${db_host}    db_port=${db_port}
    Disconnect From Database