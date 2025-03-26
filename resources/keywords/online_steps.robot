*** Settings ***
Documentation    Keywords para validação de sistema online
Resource        ../base.resource

*** Keywords ***
Dado que inicio a sessão no sistema
    Start Session

Quando verifico o título da página
    ${title}    Get Title
    Set Test Variable    ${PAGE_TITLE}    ${title}

Então deve exibir "${expected_title}"
    Should Be Equal    ${PAGE_TITLE}    ${expected_title}
