*** Settings ***
Documentation     Casos de teste automatizados para pesquisa no YouTube.
Test Setup        Abrir browser
Test Teardown     Fechar browser
Resource          resource.robot

*** Test Cases ***
Caso de Teste 1: Buscar aula de Web Service Login em Java
    [Tags]    pesquisa
    Acessar YouTube
    Buscar aula de Web Service Login em Java
    Verificar se aula do Prof. Razer aparece nos resultados

Caso de Teste 2: Buscar vídeo de Robot Framework
    [Tags]    pesquisa
    Acessar YouTube
    Buscar aula de "Robot Framework SeleniumLibrary"
    Verificar se resultados contem "Robot Framework"
