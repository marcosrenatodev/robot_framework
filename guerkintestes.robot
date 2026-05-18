*** Settings ***
Documentation     Casos de teste automatizados da Secretaria On-line em Gherkin.
Test Setup        Abrir browser
Test Teardown     Fechar browser
Resource          resource.robot

*** Test Cases ***
CT01 Gherkin: Realizar um requerimento geral como aluno
    [Documentation]    Cria uma solicitação do tipo Requerimento Geral sem anexo.
    [Tags]    aluno    requerimento-geral
    Given O aluno está logado na Secretaria On-line
    When Abrir nova solicitação
    And Selecionar solicitação do tipo Requerimento Geral
    And Preencher solicitação de requerimento geral
    And Salvar solicitação
    Then Solicitação criada deve aparecer na lista do aluno

CT02 Gherkin: Deliberar requerimento geral como secretaria
    [Documentation]    Finaliza pela secretaria a solicitação criada pelo aluno.
    [Tags]    secretaria    requerimento-geral
    Given Acessar Secretaria Online
    And Fazer login como secretaria
    When Localizar solicitação criada e deliberar
    And Preencher deliberação finalizando a solicitação
    And Salvar deliberação
    Then Solicitação deve aparecer como concluída para o aluno
