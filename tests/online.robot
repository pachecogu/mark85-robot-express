*** Settings ***
Documentation    Verifica se o webapp está online no padrão Gherkin
Resource        ../resources/base.resource

*** Test Cases ***
Cenário: Webapp deve exibir o título correto
    [Tags]    smoke    critico    regressao    iniciarSessao    tituloPagina
    Dado que inicio a sessão no sistema
    Quando verifico o título da página
    Então deve exibir "Mark85 by QAx"
