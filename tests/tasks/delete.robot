*** Settings ***
Documentation           Cenário de teste de remoção de tarefa em BDD
Resource         ../../resources/base.resource
Library          Collections

Suite Setup      Inicializar Dados da Suite 
Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder apagar uma tarefa indesejada
    [Tags]    smoke    alta    regressao
    ...    apagarTarefa    remocao_tarefa    fluxoPrincipal
    ...    BDD    gerenciamento_tarefas
    
    Dado que existe uma tarefa cadastrada no sistema
    E o usuário está logado
    Quando a tarefa é solicitada para remoção
    Então a tarefa deve ser removida com sucesso



*** Keywords ***

Inicializar Dados da Suite
    ${data}    Get fixture    tasks    delete
    Set Suite Variable            ${data}

    Reset user from database      ${data}
    Create a new task from API    ${data}

Dado que existe uma tarefa cadastrada no sistema
    [Documentation]  # Dados já inicializados no Suite Setup
    No Operation

E o usuário está logado
    Do Login    ${data}[user]

Quando a tarefa é solicitada para remoção
    Request removal          ${data}[task][name]

Então a tarefa deve ser removida com sucesso
    Task should not exist    ${data}[task][name]
