*** Settings ***
Documentation            Elementos e ações da página de Login

Library        Browser
Library        String
Resource        ../env.resource        

*** Keywords ***
Go to login page
    Go To    ${BASE_URL}

    # Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text                   css=h1    equal      Faça seu login

Submit login form
    [Arguments]        ${user}   

    Fill Text    css=input[placeholder$=mail]          ${user}[email]   
    Fill Text    css=input[placeholder=Senha]          ${user}[password]
    Click        css=button >> text=Entrar

