
*** Settings ***
Documentation   To validate the login form
Test Setup      open the browser with the Mortgage payment url
Test Teardown   Close Browser Session
Resource        ressources.robot

*** Variables ***
${Error_Message_Login}      css:.alert-danger



*** Test Cases ***
Validate UnSuccesful login
    Fill the login form
    wait until it checks and display error message
    verify error message is correct


*** Keywords ***

Fill the login form
    Input Text          id:username     ${username}
    input Password      id:password     ${password}
    Click Button        signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible       ${Error_Message_Login}
   
verify error message is correct
   ${result}=  Get Text    ${Error_Message_Login}
   Should Be Equal As Strings   ${result}       Incorrect username/password.
   # same things that two line before
   Element Text Should Be    ${Error_Message_Login}     Incorrect username/password.
