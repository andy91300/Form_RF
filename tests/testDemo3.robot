*** Settings ***
Documentation   To validate the login form
Test Setup      open the browser with the Mortgage payment url
#Test Teardown   Close Browser Session
Resource        ressources.robot




*** Variables ***
${Error_Message_Login}      css:.alert-danger



*** Test Cases ***
Validate Child window Functionality
    Select the link of Child window
    Verify the user is Switched to Child Windows
    Grab the email id in the child Windows
    Switch to Parent window and enter the Email

*** Keywords ***
Select the link of Child window
    click element      css:.blinkingText
    Sleep              5sec
    
Verify the user is Switched to Child Windows
    Switch window      NEW
    Element Text Should be     css:h1     DOCUMENTS REQUEST

Grab the email id in the child Windows
    ${text}=    get text     css:.red
    @{words}=   Split String    ${text}     at
    ${text_split}=   Get From List       ${words}   1
    log     ${text_split}                console=yes     
    @{words_2}=   Split String    ${text_split}
    ${email}=     Get From List    ${words_2}    0
    Set Global Variable     ${email}

Switch to Parent window and enter the Email
    Switch window      MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text         id:username      ${email}