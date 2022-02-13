*** Settings ***
Library     RequestsLibrary
Library     Collections


*** Variables ***
${URL}      https://serverest.dev
${USER}     {"email": "fulano@qa.com", "password": "teste"}

*** Test Cases ***
Realizar login válido
    Autenticar

*** Keywords ***
Autenticar    
# A duração do token retornado em authorization é de 600 segundos (10 minutos)
    Create Session   Login      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    ${RESPONSE}      Post On Session     Login    ${URL}/login    data=${USER}    headers=${HEADERS}
    Set Test Variable    ${RESPONSE_BODY}     ${RESPONSE.json()}
    Set Test Variable    ${TOKEN}    ${RESPONSE_BODY['authorization']}
    Should Be True      '${RESPONSE_BODY['message']}' == 'Login realizado com sucesso'