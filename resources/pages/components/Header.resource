*** Settings ***
Documentation        Ações e elementos do componente de mensagens de alertas

Library        Browser
Library        String

*** Keywords ***
User should be logged in
    [Arguments]        ${name}

    @{splited_name}    Split String    ${name}

    ${element}        Set Variable        css=header .right small

    Wait For Elements State    ${element}    
    ...    visible        5
    
    Get Text                   ${element}    
    ...    equal          Olá, ${splited_name}[0]


Go to task form
    #Go to login page

    Click    css=.left a .button-add 
