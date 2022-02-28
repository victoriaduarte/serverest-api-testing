*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../0-Login/000-post_login.robot
Resource    Payload/produto_valido.robot
Resource    Payload/produto_invalido.robot


*** Variables ***
${URL}    https://serverest.dev


*** Test Cases ***
Atualizar produto cadastrado
    Realizar requisição para atualizar produto cadastrado
    A API deve responder com código 200 e atualizar o produto

Atualizar produto não cadastrado
# Caso não seja encontrado produto com o ID informado é realizado novo cadastro ao invés de alteração
    Realizar requisição para atualizar produto não cadastrado
    A API deve responder com código 201 e realizar novo cadastro

Atualizar produto com nome já utilizado
# Não é permitido cadastrar produto com nome já utilizado
    Realizar requisição para atualizar produto com nome já utilizado
    A API deve responder com código 400 e informar que o nome já está sendo usado

Atualizar produtos com campos em branco
    Realizar requisição para atualizar produto com campos em branco
    A API deve responder com código 400 e informar os campos em branco

Atualizar produtos com body vazio
    Realizar requisição para atualizar produto com body vazio
    A API deve responder com código 400 e informar os campos obrigatórios

*** Keywords ***
Realizar requisição para atualizar produto cadastrado
    # Autenticar
    Create Session   AtualizarProduto      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Atualizar produto cadastrado
    ${RESPONSE}      Put On Session     AtualizarProduto    ${URL}/produtos/${ID_PRODUTO}    data=${DATA}    headers=${AUTH}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 200 e atualizar o produto
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Registro alterado com sucesso'

Realizar requisição para atualizar produto não cadastrado
    # Autenticar
    Create Session   AtualizarProduto      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Atualizar produto não cadastrado    
    ${RESPONSE}      Put On Session     AtualizarProduto    ${URL}/produtos/${ID_NOVO}    data=${DATA}    headers=${AUTH}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
    Set Suite Variable    ${DATA_EXISTENTE}    ${DATA}
    Set Global Variable	  ${ID_PRODUTO_NOVO}        ${RESPONSE_BODY['_id']}
A API deve responder com código 201 e realizar novo cadastro
    Should Be True  '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Cadastro realizado com sucesso'

Realizar requisição para atualizar produto com nome já utilizado
    # Autenticar
    Create Session   AtualizarProduto      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    ${RESPONSE}      Put On Session     AtualizarProduto    ${URL}/produtos/${ID_NOVO}    data=${DATA_EXISTENTE}    headers=${AUTH}    expected_status=400
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 400 e informar que o nome já está sendo usado
    Should Be True  '${RESPONSE.status_code}'=='400'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Já existe produto com esse nome'

Realizar requisição para atualizar produto com campos em branco
    # Autenticar
    Create Session   AtualizarProduto      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Gerar produto com campos em branco
    ${RESPONSE}      Put On Session     AtualizarProduto    ${URL}/produtos/${ID_PRODUTO}    data=${DATA}    headers=${AUTH}    expected_status=400
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 400 e informar os campos em branco
    Should Be True  '${RESPONSE.status_code}'=='400'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  ${RESPONSE_BODY} == {'nome': 'nome não pode ficar em branco', 'preco': 'preco deve ser um número', 'descricao': 'descricao não pode ficar em branco', 'quantidade': 'quantidade deve ser um número'}

Realizar requisição para atualizar produto com body vazio
    # Autenticar
    Create Session   AtualizarProduto      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Gerar produto com body vazio
    ${RESPONSE}      Put On Session     AtualizarProduto    ${URL}/produtos/${ID_PRODUTO}    data=${DATA}    headers=${AUTH}    expected_status=400
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 400 e informar os campos obrigatórios
    Should Be True  '${RESPONSE.status_code}'=='400'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  ${RESPONSE_BODY} == {'nome': 'nome é obrigatório', 'preco': 'preco é obrigatório', 'descricao': 'descricao é obrigatório', 'quantidade': 'quantidade é obrigatório'}