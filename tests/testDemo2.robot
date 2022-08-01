#https://rahulshettyacademy.com/loginpagePractise/


*** Settings ***
Documentation   To validate the login form
Test Setup      open the browser with the Mortgage payment url
#Test Teardown   Close Browser Session
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
    Verify Card titles in the Shop page
    Select the Card     Blackberry

Select the From and navigate to Child window
    Fill the Login Details and Login Form


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

Verify Card titles in the Shop page
    @{expectedList} =   Create list     iphone X    Samsung Note 8    Nokia Edge    Blackberry
    ${elements} =       Get WebElements     css:.card-title
    @{actualList}=   Create List
    FOR  ${element}  IN     @{elements}
         Log    ${element.text}
         Append To List    ${actualList}      ${element.text}
    END
    Lists Should Be Equal    ${expectedList}    ${actualList}


Select the Card
    [arguments]     ${card_name}
    ${elements} =       Get WebElements     css:.card-title
    ${index}=   Set Variable    1
    FOR  ${element}  IN     @{elements}
        Exit For Loop If   '${card_name}' == '${element.text}'
        ${index}=   Evaluate    ${index} + 1
    END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button


Fill the Login Details and Login Form
    Input Text          id:username     ${username} 
    input Password      id:password     ${valid_password}
    Click Element       css:input[value='user']
    wait until Element is located in the page       css:.modal-dialog
    Click Button       id:okayBtn
    Click Button       id:okayBtn
    Wait Until Element Is Not Visible       css:.modal-dialog
    Select From List by value      css:select.form-control     teach
    Select Checkbox     terms
    Checkbox Should Be Selected     terms