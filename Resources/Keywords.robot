*** Settings ***
Library     SeleniumLibrary

*** Keywords ***
Click button by ID
    [Arguments]     ${id}
    Click Button    ${id}

Click button by class
    [Arguments]     ${class}
    Click Element    xpath://button[contains(@class, '${class}')]

Click button by name
    [Arguments]     ${name}
    Click button    ${name}

Count by class
    [Arguments]     ${class}
    ${resultado}=    Get Element Count    xpath://button[@class='${class}']
    RETURN    ${resultado}

Recargar pagina
    ${url_actual}=    Get Location
    Go To    ${url_actual}