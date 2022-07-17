*** Settings ***
Documentation    A ressource file with the reusable keyword and variables
...              The system specific keyword created here from our own
...              domain specific language. They utilize keywords provides
...              by the inported SelenuimLibrary

Library     SeleniumLibrary


*** Variables ***
${username}     lequeuxAndy
${password}     abcdefg
${url}          https://rahulshettyacademy.com/loginpagePractise/

*** keywords ***
open the browser with the Mortgage payment url
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    test-type
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Create Webdriver    Chrome      chrome_options=${chrome_options}
    Go To    ${url}


Close Browser Session
    Close Browser