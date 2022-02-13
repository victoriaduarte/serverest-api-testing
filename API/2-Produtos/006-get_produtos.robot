*** Settings ***
Library     RequestsLibrary
Library     Collections


*** Variables ***
${URL}    https://serverest.dev


*** Test Cases ***
Listar produtos cadastrados
    Realizar requisição para listar produtos cadastrados
    A API deve responder com código 200 e listar produtos cadastrados

Buscar produto por id existente
    Realizar requisição para buscar produto por id existente
    A API deve responder com código 200 e listar o produto

Buscar produto por id não existente
    Realizar requisição para buscar produto por id não existente
    A API deve responder com código 400


*** Keywords ***
Realizar requisição para listar produtos cadastrados
    Create Session    ListarProdutos      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarProdutos      ${URL}/produtos      headers=${HEADERS}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar produtos cadastrados
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

Realizar requisição para buscar produto por id existente
    Create Session    ListarProdutos      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarProdutos      ${URL}/produtos/${ID_PRODUTO}      headers=${HEADERS}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar o produto
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY}' == '{'nome': '${NOME}', 'preco': ${PRECO}, 'descricao': '${DESCRICAO}', 'quantidade': ${QUANTIDADE}, '_id': '${ID_PRODUTO}'}'

Realizar requisição para buscar produto por id não existente
    Create Session    ListarProdutos      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    Set Test Variable     ${ID_PRODUTO_INEXISTENTE}      951753654258
    ${RESPONSE}       Get On Session      ListarProdutos      ${URL}/produtos/${ID_PRODUTO_INEXISTENTE}      headers=${HEADERS}     expected_status=400
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 400
    Should Be True  '${RESPONSE.status_code}'=='400'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Produto não encontrado'