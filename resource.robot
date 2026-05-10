*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    chrome
${LINK_CONTATO}    //a[contains(., 'Contato')]

*** Keywords ***
Abrir browser
    Open Browser    about:blank    browser=${BROWSER}
    Maximize Browser Window

Fechar browser
    Capture Page Screenshot
    Close Browser

Acessar Secretaria Online no endereço "${URL}"
    Go To     ${URL}
    Wait Until Element Is Visible    ${LINK_CONTATO}

Acessar página de contato
    Click Element    locator=${LINK_CONTATO}

Verificar se contato é exibido
    Element Should Be Visible    locator=//h3[contains(.,'Contato com os Administradores do Sistema')]
