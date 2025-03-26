*** Settings ***
Documentation        Keywords de autenticação do usuario

Library             Collections
Resource            ../base.resource

*** Keywords ***
Dado que existe um usuário pré-cadastrado no sistema
    ${user}        Create Dictionary    
    ...            name=Gustavo Pacheco
    ...            email=gustavo@gmail.com
    ...            password=pwd123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    Set Suite Variable           ${user}

E o usuário está na página de login
    Go to login page

Quando o usuário submete o formulário de login com credenciais válidas
    Submit login form    ${user}

Então o usuário deve ser redirecionado para a área logada
    User should be logged in    ${user}[name]

E o nome do usuário deve ser exibido no menu
    Log    Nome do usuário exibido no menu

Quando o usuário submete o formulário de login com uma senha inválida
    Set To Dictionary        ${user}        password=abc123
    Submit login form        ${user}

Então uma mensagem de erro deve ser exibida
    Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.

E o usuário não deve ser redirecionado para a área logada
    Log    Usuário não foi redirecionado para a área logada

