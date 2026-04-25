*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Mi Primer Test
    Open Browser    https://www.google.com    chrome
    Title Should Be    Google
    [Teardown]    Close Browser