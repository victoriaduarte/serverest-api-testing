*** Settings ***
Library     RequestsLibrary
Library     Collections


*** Variables ***
${URL}    https://serverest.dev


*** Test Cases ***
Listar usuários cadastrados
    Realizar requisição para listar usuários cadastrados
    A API deve responder com código 200 e listar usuários cadastrados

Listar usuários administradores 
    Realizar requisição para listar usuários administradores
    A API deve responder com código 200 e listar usuários administradores

Listar usuários não administradores 
    Realizar requisição para listar usuários não administradores 
    A API deve responder com código 200 e listar usuários não administradores 

Listar usuários por parâmetro id
    Realizar requisição para listar usuários por parâmetro id
    A API deve responder com código 200 e listar usuários por parâmetro id

Listar usuários por parâmetro nome
    Realizar requisição para listar usuários por parâmetro nome
    A API deve responder com código 200 e listar usuários por parâmetro nome

Listar usuários por parâmetro email
    Realizar requisição para listar usuários por parâmetro email
    A API deve responder com código 200 e listar usuários por parâmetro email

Listar usuários por parâmetro senha
    Realizar requisição para listar usuários por parâmetro senha
    A API deve responder com código 200 e listar usuários por parâmetro senha

*** Keywords ***
Realizar requisição para listar usuários cadastrados
    Create Session    ListarUsuarios      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarUsuarios      ${URL}/usuarios      headers=${HEADERS}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar usuários cadastrados
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

Realizar requisição para listar usuários administradores
    Create Session    ListarUsuarios      ${URL}      verify=true 
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarUsuarios      ${URL}/usuarios      headers=${HEADERS}     params=administrador=true
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar usuários administradores
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    FOR    ${DADOS}    IN   @{RESPONSE_BODY['usuarios']}
        Should Be True  '${DADOS['administrador']}' == 'true'
    END

Realizar requisição para listar usuários não administradores 
    Create Session    ListarUsuarios      ${URL}      verify=true 
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarUsuarios      ${URL}/usuarios      headers=${HEADERS}     params=administrador=false
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar usuários não administradores 
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    FOR    ${DADOS}    IN   @{RESPONSE_BODY['usuarios']}
        Should Be True  '${DADOS['administrador']}' == 'false'
    END

Realizar requisição para listar usuários por parâmetro id
    Create Session    ListarUsuarios      ${URL}      verify=true 
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    # Set Test Variable    ${PARAM_ID}    ${ID}
    ${RESPONSE}       Get On Session      ListarUsuarios      ${URL}/usuarios      headers=${HEADERS}     params=_id=${ID}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar usuários por parâmetro id
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    IF  ${RESPONSE_BODY['quantidade']} == 0
        Fail  msg=Usuário com id "${ID}" não encontrado
    ELSE
        FOR    ${DADOS}    IN   @{RESPONSE_BODY['usuarios']}
            Should Be True  '${DADOS['_id']}' == '${ID}'
        END
    END

Realizar requisição para listar usuários por parâmetro nome
    Create Session    ListarUsuarios      ${URL}      verify=true 
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarUsuarios      ${URL}/usuarios      headers=${HEADERS}     params=nome=${NOME}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar usuários por parâmetro nome
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    IF  ${RESPONSE_BODY['quantidade']} == 0
        Fail  msg=Usuário com nome "${NOME}" não encontrado
    ELSE
        FOR    ${DADOS}    IN   @{RESPONSE_BODY['usuarios']}
            Should Be True  '${DADOS['nome']}' == '${NOME}'
        END
    END

Realizar requisição para listar usuários por parâmetro email
    Create Session    ListarUsuarios      ${URL}      verify=true 
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarUsuarios      ${URL}/usuarios      headers=${HEADERS}     params=email=${EMAIL}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar usuários por parâmetro email
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    IF  ${RESPONSE_BODY['quantidade']} == 0
        Fail  msg=Usuário com email "${EMAIL}" não encontrado
    ELSE
        FOR    ${DADOS}    IN   @{RESPONSE_BODY['usuarios']}
            Should Be True  '${DADOS['email']}' == '${EMAIL}'
        END
    END

Realizar requisição para listar usuários por parâmetro senha
    Create Session    ListarUsuarios      ${URL}      verify=true 
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarUsuarios      ${URL}/usuarios      headers=${HEADERS}     params=password=${PASSWORD}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar usuários por parâmetro senha
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    FOR    ${DADOS}    IN   @{RESPONSE_BODY['usuarios']}
        Should Be True  '${DADOS['password']}' == '${PASSWORD}'
    END