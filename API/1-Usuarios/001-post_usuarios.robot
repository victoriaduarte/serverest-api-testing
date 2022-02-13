*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    Payload/usuario_valido.robot


*** Variables ***
${URL}    https://serverest.dev


*** Test Cases ***
Cadastrar usuário administrador
    Realizar requisição para cadastrar usuário administrador
    A API deve responder com código 201 e cadastrar usuário
    
Cadastrar usuário não administrador
    Realizar requisição para cadastrar usuário não administrador
    A API deve responder com código 201 e cadastrar usuário
    
Cadastrar usuário inválido
# Não é permitido cadastrar usuário com email já utilizado
    Realizar requisição para cadastrar usuário inválido
    A API deve retornar status 400


*** Keywords ***
Realizar requisição para cadastrar usuário administrador
    Create Session   CadastrarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Gerar usuário administrador
    Set Global Variable   ${NOME}       ${NOME}  
    Set Global Variable   ${EMAIL}      ${EMAIL}  
    Set Global Variable   ${PASSWORD}   ${PASSWORD}  

    ${RESPONSE}      Post On Session     CadastrarUsuario    ${URL}/usuarios    data=${DATA}    headers=${HEADERS}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
    Set Global Variable	  ${ID_USUARIO}        ${RESPONSE_BODY['_id']}  
A API deve responder com código 201 e cadastrar usuário
    Should Be True  '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Cadastro realizado com sucesso'

Realizar requisição para cadastrar usuário não administrador
    Create Session   CadastrarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Gerar usuário não administrador
    ${RESPONSE}      Post On Session     CadastrarUsuario    ${URL}/usuarios    data=${DATA}    headers=${HEADERS}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}

Realizar requisição para cadastrar usuário inválido
    Create Session   CadastrarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    ${RESPONSE}      Post On Session     CadastrarUsuario    ${URL}/usuarios    data=${DATA}    headers=${HEADERS}    expected_status=400
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve retornar status 400
    Should Be True  '${RESPONSE.status_code}'=='400'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Este email já está sendo usado'