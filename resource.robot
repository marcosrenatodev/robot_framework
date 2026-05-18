*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${URL}                  http://200.236.3.198:28080/secretariaonline2/Home
${BROWSER}              chrome
${ALUNO_LOGIN}          GRR11111111
${ALUNO_SENHA}          123
${SECRETARIA_LOGIN}     rafaela.fontana@ufpr.br
${SECRETARIA_SENHA}     123
${DESCRICAO_SOLICITACAO}    Este é um texto utilizado para teste das solicitações da Secretaria Online.
${TEXTO_DELIBERACAO}        Solicitação concluída por teste automatizado.
${TIMEOUT}              15s
${NUMERO_SOLICITACAO}   ${EMPTY}

*** Keywords ***
Abrir browser
    Open Browser    about:blank    browser=${BROWSER}
    Maximize Browser Window

Fechar browser
    Run Keyword And Ignore Error    Capture Page Screenshot
    Close Browser

Acessar Secretaria Online
    Go To    ${URL}
    Wait Until Element Is Visible    name=email    ${TIMEOUT}

Fazer login como aluno
    Fazer login    ${ALUNO_LOGIN}    ${ALUNO_SENHA}    Bem Vinda

O aluno está logado na Secretaria On-line
    Acessar Secretaria Online
    Fazer login como aluno

Fazer login como secretaria
    Fazer login    ${SECRETARIA_LOGIN}    ${SECRETARIA_SENHA}    Bem Vinda

Fazer login
    [Arguments]    ${usuario}    ${senha}    ${texto_esperado}
    Input Text    name=email    ${usuario}
    Input Password    name=senha    ${senha}
    Click Button    Entrar
    Wait Until Page Contains    ${texto_esperado}    ${TIMEOUT}
    Wait Until Element Is Visible    id=dataTables    ${TIMEOUT}

Abrir nova solicitação
    Click Link    Abrir Nova Solicitação
    Wait Until Page Contains    Nova Solicitação    ${TIMEOUT}
    Wait Until Element Is Visible    id=idTipoSolicitacao    ${TIMEOUT}

Selecionar solicitação do tipo Requerimento Geral
    Select From List By Label    id=idTipoSolicitacao    Requerimento Geral
    Click Button    Avançar
    Wait Until Page Contains    Nova Solicitação - Requerimento Geral    ${TIMEOUT}
    Wait Until Element Is Visible    id=descricao    ${TIMEOUT}
    Guardar número da solicitação exibida

Guardar número da solicitação exibida
    ${cabecalho}=    Get Text    xpath=//h4[contains(., 'Solicitação:')]
    ${numero}=    Fetch From Right    ${cabecalho}    Solicitação:
    ${numero}=    Strip String    ${numero}
    Set Suite Variable    ${NUMERO_SOLICITACAO}    ${numero}

Preencher solicitação de requerimento geral
    Input Text    id=descricao    ${DESCRICAO_SOLICITACAO}

Salvar solicitação
    Click Button    Salvar
    Wait Until Page Contains    cadastrada com sucesso    ${TIMEOUT}
    Click Link    Voltar
    Wait Until Element Is Visible    id=dataTables    ${TIMEOUT}

Solicitação criada deve aparecer na lista do aluno
    Pesquisar solicitação criada na tabela
    Wait Until Page Contains Element    xpath=//tr[td[normalize-space(.)='${NUMERO_SOLICITACAO}'] and td[contains(normalize-space(.), 'Requerimento Geral')] and td[contains(normalize-space(.), 'Aberta')]]    ${TIMEOUT}

Localizar solicitação criada e deliberar
    Wait Until Keyword Succeeds    3x    2s    Ir para deliberação da solicitação criada
    Wait Until Page Contains    Deliberar Solicitação - Requerimento Geral    ${TIMEOUT}
    Wait Until Element Is Visible    id=descricaoDeliberacao    ${TIMEOUT}

Ir para deliberação da solicitação criada
    Go To    ${URL}
    Wait Until Element Is Visible    id=dataTables    ${TIMEOUT}
    Pesquisar solicitação criada na tabela
    Click Element    xpath=//tr[td[normalize-space(.)='${NUMERO_SOLICITACAO}']]//a[normalize-space(.)='Deliberar']

Preencher deliberação finalizando a solicitação
    Input Text    id=descricaoDeliberacao    ${TEXTO_DELIBERACAO}
    Select From List By Value    id=idUsuarioEmail    0
    Select From List By Value    id=finalizar    sim

Salvar deliberação
    Click Button    Salvar Deliberação
    Wait Until Element Is Visible    id=dataTables    ${TIMEOUT}

Solicitação deve aparecer como concluída para o aluno
    Click Element    xpath=//a[normalize-space(.)='Sair' and contains(@class, 'btn')]
    Wait Until Element Is Visible    name=email    ${TIMEOUT}
    Fazer login como aluno
    Pesquisar solicitação criada na tabela
    Wait Until Page Contains Element    xpath=//tr[td[normalize-space(.)='${NUMERO_SOLICITACAO}'] and td[contains(normalize-space(.), 'Concluida')]]    ${TIMEOUT}

Pesquisar solicitação criada na tabela
    Wait Until Element Is Visible    xpath=//div[@id='dataTables_filter']//input    ${TIMEOUT}
    Input Text    xpath=//div[@id='dataTables_filter']//input    ${NUMERO_SOLICITACAO}
    Wait Until Page Contains Element    xpath=//tr[td[normalize-space(.)='${NUMERO_SOLICITACAO}']]    ${TIMEOUT}
