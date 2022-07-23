
*** Settings ***
Documentation   To validate the login form
Test Setup      open the browser with the Mortgage payment url
Test Teardown   Close Browser Session
Resource        ressources.robot

*** Variables ***
${Error_Message_Login}      css:.alert-danger
${Shop_page_load}           xpath=//app-card-list[@class='row']


*** Test Cases ***
Validate UnSuccesful login
    Fill the login form     ${username}     ${invalid_password}
    wait until Element is located in the page    ${Error_Message_Login}
    verify error message is correct

Validate cards display in the Shopping Page
    Fill the login form     ${username}     ${valid_password}
    wait until Element is located in the page       ${Shop_page_load}



*** Keywords ***

Fill the login form
    [arguments]     ${username}     ${password}
    Input Text          id:username     ${username}
    input Password      id:password     ${password}
    Click Button        signInBtn


wait until Element is located in the page
    [arguments]     ${element}
    Wait Until Element Is Visible   ${element}

verify error message is correct
   ${result}=  Get Text    ${Error_Message_Login}
   Should Be Equal As Strings   ${result}       Incorrect username/password.
   # same things that two line before
   Element Text Should Be    ${Error_Message_Login}     Incorrect username/password.
