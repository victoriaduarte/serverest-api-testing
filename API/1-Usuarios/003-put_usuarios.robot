*** Settings ***
Library     RequestsLibrary
Resource    Payload/usuario_valido.robot
Resource    Payload/usuario_invalido.robot


*** Variables ***
${URL}    https://serverest.dev


*** Test Cases ***
Atualizar usuário cadastrado
    Realizar requisição para atualizar usuário cadastrado
    A API deve responder com código 200 e atualizar o usuário

Atualizar usuário não cadastrado
# Caso não seja encontrado usuário com o ID informado é realizado novo cadastro ao invés de alteração
    Realizar requisição para atualizar usuário não cadastrado
    A API deve responder com código 201 e realizar novo cadastro

Atualizar usuário com email já utilizado
# Não é permitido cadastrar usuário com email já utilizado
    Realizar requisição para atualizar usuário com email já utilizado
    A API deve responder com código 400 e informar que o email já está sendo usado

Atualizar usuários com campos em branco
    Realizar requisição para atualizar usuário com campos em branco
    A API deve responder com código 400 e informar os campos em branco

Atualizar usuários com body vazio
    Realizar requisição para atualizar usuário com body vazio
    A API deve responder com código 400 e informar os campos obrigatórios

*** Keywords ***
Realizar requisição para atualizar usuário cadastrado
    Create Session   AtualizarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Atualizar usuário cadastrado
    ${RESPONSE}      Put On Session     AtualizarUsuario    ${URL}/usuarios/${ID_USUARIO}    data=${DATA}    headers=${HEADERS}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 200 e atualizar o usuário
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Registro alterado com sucesso'

Realizar requisição para atualizar usuário não cadastrado
    Create Session   AtualizarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Atualizar usuário não cadastrado    
    ${RESPONSE}      Put On Session     AtualizarUsuario    ${URL}/usuarios/${ID_NOVO}    data=${DATA}    headers=${HEADERS}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
    Set Suite Variable    ${DATA_EXISTENTE}    ${DATA}
A API deve responder com código 201 e realizar novo cadastro
    Should Be True  '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Cadastro realizado com sucesso'

Realizar requisição para atualizar usuário com email já utilizado
    Create Session   AtualizarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    ${RESPONSE}      Put On Session     AtualizarUsuario    ${URL}/usuarios/${ID_USUARIO}    data=${DATA_EXISTENTE}    headers=${HEADERS}    expected_status=400
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 400 e informar que o email já está sendo usado
    Should Be True  '${RESPONSE.status_code}'=='400'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Este email já está sendo usado'

Realizar requisição para atualizar usuário com campos em branco
    Create Session   AtualizarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Gerar usuário com campos em branco
    ${RESPONSE}      Put On Session     AtualizarUsuario    ${URL}/usuarios/${ID_USUARIO}    data=${DATA}    headers=${HEADERS}    expected_status=400
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 400 e informar os campos em branco
    Should Be True  '${RESPONSE.status_code}'=='400'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  ${RESPONSE_BODY} == {'nome': 'nome não pode ficar em branco', 'email': 'email não pode ficar em branco', 'password': 'password não pode ficar em branco', 'administrador': "administrador deve ser 'true' ou 'false'"}

Realizar requisição para atualizar usuário com body vazio
    Create Session   AtualizarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Gerar usuário com body vazio
    ${RESPONSE}      Put On Session     AtualizarUsuario    ${URL}/usuarios/${ID_USUARIO}    data=${DATA}    headers=${HEADERS}    expected_status=400
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 400 e informar os campos obrigatórios
    Should Be True  '${RESPONSE.status_code}'=='400'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  ${RESPONSE_BODY} == {'nome': 'nome é obrigatório', 'email': 'email é obrigatório', 'password': 'password é obrigatório', 'administrador': 'administrador é obrigatório'}