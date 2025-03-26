*** Settings ***
Documentation        Consumindo a API REST do sistema

Library        RequestsLibrary

*** Keywords ***
POST user session   
    [Arguments]        ${data}

    ${payload}        Create Dictionary
    ...    email=${data}[email]
    ...    password=${data}[password]

    ${resp}    POST     url=http://localhost:3333/sessions
    ...                 json=${payload}
    ...                 expected_status=200
    ${token}    Set Variable    ${resp.json()}[token]

    Set Test Variable    ${token}

POST a new task     
    [Arguments]        ${payload}

    ${headers}         Create Dictionary
    ...                Authorization=${token}
    
    Log    ${token}

    Log    ${payload}
    Log    ${headers}
    

    ${response}    POST     url=http://localhost:3333/tasks
    ...                     json=${payload}
    ...                     headers=${headers}
    ...                     expected_status=201

   