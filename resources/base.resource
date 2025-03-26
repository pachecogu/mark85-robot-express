*** Settings ***

Library        libs/database.py
Library        Browser
Library        String
Library        JSONLibrary

#Camada de recursos de ambiente
Resource       env.resource 

#Camada de Keywords
Resource       keywords/login_steps.robot
Resource       keywords/online_steps.robot
Resource       keywords/signup_steps.robot
#Resource       keywords/task/create_steps.robot

#Camada de componente das páginas
Resource       pages/components/Notice.resource 
Resource       pages/components/Header.resource
Resource       pages/components/Alert.resource 

#Camada das páginas
Resource       pages/SignupPage.resource
Resource       pages/LoginPage.resource
Resource       pages/TaskCreatePage.resource
Resource       pages/TasksPage.resource

#Camada de serviços
Resource       services.resource

*** Keywords ***
Start Session

    New Browser        browser=${BROWSER}    headless=False           
    New Page           ${BASE_URL}


#HELPERS
Get fixture
    [Arguments]        ${file_name}        ${scenario}

        ${data}    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=UTF-8

    RETURN    ${data}[${scenario}]

Reset user from database
    [Arguments]        ${data} 
        
    Log        ${data}[user][email]
    Log        ${data}[user]

    Clean user from database         ${data}[user][email]
    Insert user from database        ${data}[user]

Create a new task from API
     [Arguments]        ${data} 

    Log    ${data} 
    
    POST user session            ${data}[user]
    POST a new task              ${data}[task]

Do Login
     [Arguments]        ${user} 
   
    Submit login form            ${user} 
    User should be logged in     ${user}[name]

