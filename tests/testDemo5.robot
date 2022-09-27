
*** Settings ***
Documentation   To validate the login form
Library     SeleniumLibrary
Library     DataDriver      file=resources/test.csv   encoding=utf_8   dialect=unix
Test Teardown       Close Browser
Test Template   Validate UnSuccesful login

*** Variables ***
${Error_Message_Login}      css:.alert-danger


*** Test Cases ***
Login with user ${username} and password ${password}

*** Keywords ***
Validate UnSuccesful login
    [Arguments]     ${username}    ${password}
    open the browser with the Mortgage payment url
    Fill the login form    ${username}    ${password}
    wait until it checks and display error message
    verify error message is correct


open the browser with the Mortgage payment url
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    test-type
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Create Webdriver    Chrome      chrome_options=${chrome_options}
    Go To   https://rahulshettyacademy.com/loginpagePractise/

Fill the login form
    [arguments]     ${username}    ${password}  
    Input Text          id:username    ${username}  
    input Password      id:password    ${password}
    Click Button        signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible       ${Error_Message_Login}
   
verify error message is correct
   ${result}=  Get Text    ${Error_Message_Login}
   Should Be Equal As Strings   ${result}       Incorrect username/password.
   # same things that two line before
   Element Text Should Be    ${Error_Message_Login}     Incorrect username/password.

Close Browser Session