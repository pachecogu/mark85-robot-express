*** Settings ***
Documentation        Cenários de autenticação do usuario - Gherkin style

Library             Collections
Resource            ../resources/base.resource

Test Setup          Start Session
Test Teardown       Take Screenshot

*** Test Cases ***
Cenário: Deve poder logar com um usuário pré-cadastrado
    [Tags]    smoke    critico    regressao    fazerLogin    autenticacaoSucesso    fluxoPrincipal
    Dado que existe um usuário pré-cadastrado no sistema
    E o usuário está na página de login
    Quando o usuário submete o formulário de login com credenciais válidas
    Então o usuário deve ser redirecionado para a área logada
    E o nome do usuário deve ser exibido no menu

Cenário: Não deve logar com senha inválida
    [Tags]    regressao    alta    validacao    senhaInvalida    autenticacaoFalha    seguranca
    Dado que existe um usuário pré-cadastrado no sistema
    E o usuário está na página de login
    Quando o usuário submete o formulário de login com uma senha inválida
    Então uma mensagem de erro deve ser exibida
    E o usuário não deve ser redirecionado para a área logada


