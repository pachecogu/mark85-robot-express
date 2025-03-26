*** Settings ***
Documentation        Keywords de cadastro do usuario

#Library    Browser
#Library    String

Resource        ../base.resource

*** Keywords ***
Dado que o email "${email}" não está cadastrado no sistema
    Remove user from database    ${email}

Dado que o email "${email}" já está cadastrado no sistema
    ${user}    Create Dictionary    
    ...        name=Gustavo Pacheco
    ...        email=${email}
    ...        password=teste123
    Remove user from database    ${email}
    Insert user from database    ${user}

Quando preencho o formulário de cadastro com nome "${name}", email "${email}" e senha "${password}"
    ${user}    Create Dictionary    
    ...        name=${name}
    ...        email=${email}
    ...        password=${password}
    Go to signup page
    Submit signup form    ${user}

E submeto o formulário de cadastro
    [Documentation]    A submissão já está incluída na keyword "Submit signup form"
    
    Log    A submissão já está incluída na keyword "Submit signup form"

Então devo ver a mensagem de boas-vindas "${expected_message}"
    Notice should be    ${expected_message}

Então devo ver a mensagem de erro "${expected_message}"
    Notice should be    ${expected_message}

Então a mensagem de erro "${expected_message}" deve ser apresentada
    Alert should be        Digite um e-mail válido

Então devo ver as mensagens de erro para campos obrigatórios
    Alert should be    Informe seu nome completo 
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos

Então devo ver a mensagem de erro para senha curta
    Alert should be    Informe uma senha com pelo menos 6 digitos

Quando tento me cadastrar com senhas menores que 6 caracteres
    @{password_list}    Create List    1    12    123    1234    12345
    FOR    ${password}    IN    @{password_list}
        ${user}    Create Dictionary    
        ...        name=Maria de Fatima
        ...        email=maria@gmail.com
        ...        password=${password}
        Go to signup page
        Submit signup form    ${user}
        Alert should be    Informe uma senha com pelo menos 6 digitos
    END