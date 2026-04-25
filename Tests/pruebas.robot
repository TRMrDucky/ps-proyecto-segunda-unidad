*** Settings ***
Library     SeleniumLibrary
Resource    ../Data/Variables.robot
Resource    ../Resources/Keywords.robot

*** Test Cases ***

*** Test Cases ***
#Add / Delete elements
Add / delete elements
    Open Browser    ${URL-TODO}    ${BROWSER}

    FOR    ${i}    IN RANGE    1    21

        Click button by name     Add Element

        ${cantidad} =    count by class      added-manually

        Should Be Equal As Integers    ${cantidad}    ${i}

    END

    FOR    ${i}    IN RANGE    1    21

        Click button by name     Delete

    END

    Page Should Not Contain Element    xpath://button[@class='added-manually']

    [Teardown]    Close Browser

#Basic Auth
