*** Settings ***
Documentation        Ações e elementos do componente de criação de tasks

Library        Browser
Resource        ../env.resource  

*** Keywords ***
Submit task form
    [Arguments]        ${task}

    ${name_element}        Set Variable        css=.form-input input[placeholder="Nome da tarefa"]
    ${tags_element}      Set Variable        css=input[name="tags"],[placeholder="Informe até 3 tags"]  

    Wait For Elements State    ${name_element}    visible        5
    Fill Text    ${name_element}    ${task}[name]

    FOR    ${tag}    IN    @{task}[tags]
        Fill Text    ${tags_element}    ${tag}
        Sleep    1
        Press Keys        ${tags_element}    Enter
        
    END

    Click    css=button >> text=cadastrar


    
