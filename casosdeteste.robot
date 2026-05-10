*** Settings ***
Documentation     Demonstração do robot
Test Setup        Abrir browser
Test Teardown     Fechar browser
Resource          resource.robot

*** Test Cases ***

CT01: Verificar tela de contatos
    [Documentation]  Verifica se os contatos estão lá
    [Tags]  contatos
    Acessar Secretaria Online no endereço "http://200.236.3.198:28080/secretariaonline2/Home"
    Acessar página de contato
    Verificar se contato é exibido
