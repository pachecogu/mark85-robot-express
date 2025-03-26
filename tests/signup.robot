*** Settings ***
Documentation        Cenários de testes do cadastro de usuários em BDD

Library    Browser
Library    String

Resource        ../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Cenário: Cadastro de novo usuário com sucesso
    [Tags]    smoke    regressao    critico    novoCadastro
    Dado que o email "gustavo@gmail.com" não está cadastrado no sistema
    Quando preencho o formulário de cadastro com nome "Gustavo Pacheco", email "gustavo@gmail.com" e senha "teste123"
    E submeto o formulário de cadastro
    Então devo ver a mensagem de boas-vindas "Boas vindas ao Mark85, o seu gerenciador de tarefas."

Cenário: Tentativa de cadastro com email duplicado
    [Tags]    regressao    alta    emailDuplicado
    Dado que o email "gustavo@gmail.com" já está cadastrado no sistema
    Quando preencho o formulário de cadastro com nome "Gustavo Pacheco", email "gustavo@gmail.com" e senha "teste123"
    E submeto o formulário de cadastro
    Então devo ver a mensagem de erro "Oops! Já existe uma conta com o e-mail informado."

Cenário: Tentativa de cadastro sem preencher campos obrigatórios
    [Tags]    regressao    alta    camposObrigatorios
    Quando preencho o formulário de cadastro com nome "", email "" e senha ""
    E submeto o formulário de cadastro
    Então devo ver as mensagens de erro para campos obrigatórios

Cenário: Tentativa de cadastro com email inválido
    [Tags]    regressao    media    emailIncorreto
    Quando preencho o formulário de cadastro com nome "Gustavo Manoel", email "manoel.com.br" e senha "123456"
    E submeto o formulário de cadastro
    Então a mensagem de erro "Digite um e-mail válido" deve ser apresentada

Cenário: Tentativa de cadastro com senha muito curta
    [Tags]    regressao    media    senhaCurta
    Quando tento me cadastrar com senhas menores que 6 caracteres
    Então devo ver a mensagem de erro para senha curta

