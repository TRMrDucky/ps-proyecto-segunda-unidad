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

# Drag and Drop
Drag and drop
    Open Browser    ${URL-DRAG-N-DROP}    ${BROWSER}
    Drag And Drop    id:column-a    id:column-b
    Element Text Should Be    id:column-a    B
    Drag And Drop    id:column-b    id:column-a
    Element Text Should Be    id:column-a    A
    [Teardown]    Close Browser

Dynamic controls
    Open Browser    ${URL-DYNAMIC-CONTROLS}    ${BROWSER}
    Click Button    xpath://button[text()='Remove']
    Validar elemento no visible    id:checkbox
    Click Button    xpath://button[text()='Enable']
    Wait Until Element Is Enabled    xpath://input[@type='text']
    [Teardown]    Close Browser

Floating menu
    Open Browser    ${URL-FLOATING-MENU}    ${BROWSER}
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Element Should Be Visible    id:menu
    [Teardown]    Close Browser

Login exitoso y logout
    Open Browser    ${URL-AUTH-FORM}    ${BROWSER}
    Input Text      id:username    tomsmith
    Input Text      id:password    SuperSecretPassword!
    Click Button    xpath://button[@type='submit']
    Wait Until Page Contains    You logged into a secure area!    timeout=10s
    Click Element   xpath://a[@href='/logout']
    Wait Until Page Contains    You logged out of the secure area!    timeout=10s
    [Teardown]    Close Browser

Login invalido
    Open Browser    ${URL-AUTH-FORM}    ${BROWSER}
    Input Text      id:username    tomsmith1
    Input Text      id:password    SuperSecretPassword!
    Click Button    xpath://button[@type='submit']
    Wait Until Page Contains    Your username is invalid!    timeout=10s

    Input Text      id:username    tomsmith
    Input Text      id:password    SuperS1ecretPassword!
    Click Button    xpath://button[@type='submit']
    Wait Until Page Contains    Your password is invalid!    timeout=10s
    [Teardown]    Close Browser

Key presses
    Open Browser    ${URL-PRESSED-KEYS}    ${BROWSER}
    Presionar tecla    ESCAPE
    Element Text Should Be    id:result    You entered: ESCAPE
    Presionar tecla    SPACE
    Element Text Should Be    id:result    You entered: SPACE
    [Teardown]    Close Browser
