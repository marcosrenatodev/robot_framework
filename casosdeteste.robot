*** Settings ***
Documentation     Casos de teste automatizados da Secretaria On-line.
Test Setup        Abrir browser
Test Teardown     Fechar browser
Resource          resource.robot

*** Test Cases ***
CT01: Realizar um requerimento geral como aluno
    [Documentation]    Cria uma solicitação do tipo Requerimento Geral sem anexo.
    [Tags]    aluno    requerimento-geral
    Acessar Secretaria Online
    Fazer login como aluno
    Abrir nova solicitação
    Selecionar solicitação do tipo Requerimento Geral
    Preencher solicitação de requerimento geral
    Salvar solicitação
    Solicitação criada deve aparecer na lista do aluno

CT02: Deliberar requerimento geral como secretaria
    [Documentation]    Finaliza pela secretaria a solicitação criada pelo aluno.
    [Tags]    secretaria    requerimento-geral
    Acessar Secretaria Online
    Fazer login como secretaria
    Localizar solicitação criada e deliberar
    Preencher deliberação finalizando a solicitação
    Salvar deliberação
    Solicitação deve aparecer como concluída para o aluno
