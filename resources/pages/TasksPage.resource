*** Settings ***
Documentation        Ações e elementos da página de listagem de tarefas

Library        Browser
Resource        ../env.resource  

*** Keywords ***
Task should be registered
    [Arguments]        ${task_name}

    Wait For Elements State    css=.task-todo >> text=${task_name}    
    ...    visible    5

Mark task as completed 
    [Arguments]        ${task_name}

    ${element}    Set Variable        
    ...    xpath=//strong[text()="${task_name}"]/..//button[@class="item-toggle"]

    Wait For Elements State    ${element}    visible    5

    Click        ${element}

Task should be completed
    [Arguments]        ${task_name}

    ${element}        Set Variable        css=strong.task-done >> text="Criar uma nova IA"

    Wait For Elements State    ${element}    visible    5

    Get Style    ${element}    
    ...    text-decoration-line    equal    line-through

Request removal 
    [Arguments]        ${task_name}

    ${element}    Set Variable
    ...    xpath=//strong[text()="${task_name}"]/..//button[@class="task-remove"]

    Click        ${element}

Task should not exist
    [Arguments]        ${task_name}

    Wait For Elements State    css=.task-todo >> text=${task_name}    
    ...    detached    5

