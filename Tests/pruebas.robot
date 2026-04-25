*** Settings ***
Library     SeleniumLibrary
Resource    ../Data/Variables.robot
Resource    ../Resources/Keywords.robot

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
Basic auth con credenciales validas
    Open Browser    https://${VALID-USER}:${VALID-PSW}@${URL-BASIC-AUTH}    ${BROWSER}
    Page Should Contain    Congratulations

    [Teardown]    Close Browser

Basic auth con credenciales invalidas
    Open Browser    https://${INVALID-USER}:${INVALID-PSW}@${URL-BASIC-AUTH}    ${BROWSER}
    Page Should not Contain    Congratulations

    [Teardown]    Close Browser


#Checkboxes
Select checkboxes
    Open Browser    ${URL-CHECKBOXES}    ${BROWSER}

    Select Checkbox    xpath://form[@id='checkboxes']/input[1]
    Checkbox Should Be Selected    xpath://form[@id='checkboxes']/input[1]

    Select Checkbox    xpath://form[@id='checkboxes']/input[2]
    Checkbox Should Be Selected    xpath://form[@id='checkboxes']/input[2]

    [Teardown]    Close Browser


#Context menu
Context menu
    Open Browser    ${URL-CONTEXT-MENU}    ${BROWSER}

    Open Context Menu    id:hot-spot
    Alert Should Be Present    You selected a context menu

    Alert Should Not Be Present

    [Teardown]    Close Browser


# Disappearing elements
Disappearing elements
    Open Browser    ${URL-DISAPPEARING-ELEMENTS}    ${BROWSER}

    WHILE    ${TRUE}
         ${galery}=    Run Keyword And Return Status    Page Should Contain Element    xpath://a[text()='Gallery']

         IF    ${galery}
            BREAK
         ELSE
            Reload Page
            Sleep    0.5s
         END
    END

    Element Should Be Visible    xpath://a[text()='Gallery']

    [Teardown]    Close Browser
