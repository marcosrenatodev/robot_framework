*** Settings ***
Documentation     Casos de teste automatizados para pesquisa no YouTube em Gherkin.
Test Setup        Abrir browser
Test Teardown     Fechar browser
Resource          resource.robot

*** Test Cases ***
Caso de Teste 1: Buscar aula de Web Service Login em Java
    [Tags]    pesquisa
    Given YouTube foi acessado
    When Buscar aula de "Web Service Login em Java"
    Then A aula do Prof. Razer deve aparecer nos resultados
