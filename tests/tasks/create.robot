*** Settings ***
Documentation            Cenários de cadastro de tarefas

Library            JSONLibrary

Resource            ../../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Tags]    smoke    critico    regressao
    ...    novoCadastro    fluxoPrincipal    criacao_tarefa
    Dado que estou logado como usuário válido    create
    E tenho uma nova tarefa válida para cadastrar
    Quando submeto o formulário da tarefa
    Então a tarefa deve ser registrada com sucesso


Não deve cadastrar tarefa com nome duplicado via interface
    [Tags]    regressao    alta    validacao
    ...    cadastroDuplicado    duplicidade    criacao_tarefa
    Dado que estou logado como usuário válido    duplicate
    E tenho uma tarefa duplicada para cadastrar
    Quando tento cadastrar a mesma tarefa duas vezes
    Então devo ver a mensagem de tarefa duplicada


Não deve cadastrar tarefa com nome duplicado via API
    [Tags]    regressao    alta    integracao
    ...    cadastroDuplicadoAPI    duplicidade    criacao_tarefa
    Dado que tenho uma tarefa cadastrada via API    duplicate
    E estou logado como usuário válido    duplicate
    Quando tento cadastrar a mesma tarefa via interface
    Então devo ver a mensagem de tarefa duplicada


Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]    regressao    media    validacao
    ...    limiteTags    limites_sistema    criacao_tarefa
    Dado que estou logado como usuário válido    tags_limit
    E tenho uma tarefa com muitas tags para cadastrar
    Quando submeto o formulário da tarefa
    Então devo ver a mensagem de limite de tags atingido



*** Keywords ***

Dado que estou logado como usuário válido
    [Arguments]    ${fixture}
    ${data}    Get fixture    tasks    ${fixture}
    Set Suite Variable           ${data}
    Reset user from database     ${data}
    Do Login                     ${data}[user]

E tenho uma nova tarefa válida para cadastrar
    [Documentation]  # Dados já inicializados no passo anterior
    No Operation

Quando submeto o formulário da tarefa
    Go to task form          
    Submit task form        ${data}[task]

Então a tarefa deve ser registrada com sucesso
    Task should be registered    ${data}[task][name]

E tenho uma tarefa duplicada para cadastrar
    [Documentation]  # Dados já inicializados no passo anterior
    No Operation

Quando tento cadastrar a mesma tarefa duas vezes
    Go to task form
    Submit task form          ${data}[task]
    Go to task form
    Submit task form          ${data}[task]

Então devo ver a mensagem de tarefa duplicada
    Notice should be          Oops! Tarefa duplicada.

Dado que tenho uma tarefa cadastrada via API
    [Arguments]    ${fixture}
    ${data}    Get fixture    tasks    ${fixture}
    Set Suite Variable        ${data}
    Reset user from database  ${data}
    Create a new task from API     ${data}

E estou logado como usuário válido
    [Arguments]    ${fixture}
    ${data}    Get fixture    tasks    ${fixture}
    Set Suite Variable        ${data}
    Do Login                  ${data}[user]

Quando tento cadastrar a mesma tarefa via interface
    Go to task form
    Submit task form          ${data}[task]

E tenho uma tarefa com muitas tags para cadastrar
    [Documentation]  # Dados já inicializados no passo anterior
    No Operation

Então devo ver a mensagem de limite de tags atingido
    Notice should be          Oops! Limite de tags atingido.