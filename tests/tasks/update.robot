*** Settings ***
Documentation    Cenários de testes de atualização de tarefas
Resource         ../../resources/base.resource
Library          Collections

Suite Setup      Inicializar Dados da Suite 
Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Cenário: Deve poder marcar uma tarefa como concluída
    [Tags]    smoke    critico    regressao    marcar_concluida    atualizacao_status    fluxoPrincipal    bdd    tarefa_concluida
    Dado que o usuário possui uma tarefa cadastrada
    E está logado no sistema
    Quando marca a tarefa como concluída
    Então a tarefa deve ser exibida como concluída na lista



*** Keywords ***

Inicializar Dados da Suite
    ${data}    Get fixture    tasks    done
    Set Suite Variable            ${data}

    Reset user from database      ${data}
    Create a new task from API    ${data}

Dado que o usuário possui uma tarefa cadastrada
    [Documentation]  # Dados já inicializados no Suite Setup
    No Operation

E está logado no sistema
    Do Login    ${data}[user]

Quando marca a tarefa como concluída
    Mark task as completed    ${data}[task][name]

Então a tarefa deve ser exibida como concluída na lista
    Task should be completed    ${data}[task][name]
