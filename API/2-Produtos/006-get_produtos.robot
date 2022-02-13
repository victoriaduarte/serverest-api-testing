*** Settings ***
Library     RequestsLibrary
Library     Collections


*** Variables ***
${URL}    https://serverest.dev


*** Test Cases ***
Listar produtos cadastrados
    Realizar requisição para listar produtos cadastrados
    A API deve responder com código 200 e listar produtos cadastrados

Listar produtos por parâmetro id
    Realizar requisição para listar produtos por parâmetro id
    A API deve responder com código 200 e listar produtos por parâmetro id

Listar produtos por parâmetro nome
    Realizar requisição para listar produtos por parâmetro nome
    A API deve responder com código 200 e listar produtos por parâmetro nome

Listar produtos por parâmetro preço
    Realizar requisição para listar produtos por parâmetro preço
    A API deve responder com código 200 e listar produtos por parâmetro preço

Listar produtos por parâmetro descrição
    Realizar requisição para listar produtos por parâmetro descrição
    A API deve responder com código 200 e listar produtos por parâmetro descrição

Listar produtos por parâmetro quantidade
    Realizar requisição para listar produtos por parâmetro quantidade
    A API deve responder com código 200 e listar produtos por parâmetro quantidade

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
    Should Be True  "${RESPONSE_BODY}" == "{'nome': '${NOME}', 'preco': ${PRECO}, 'descricao': '${DESCRICAO}', 'quantidade': ${QUANTIDADE}, '_id': '${ID_PRODUTO}'}"

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

Realizar requisição para listar produtos por parâmetro id
    Create Session    ListarProdutos      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarProdutos     ${URL}/produtos    headers=${HEADERS}    params=_id=${ID_PRODUTO}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar produtos por parâmetro id
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    FOR   ${DADOS}   IN   @{RESPONSE_BODY['produtos']}
        Should Be True  '${DADOS['nome']}' == '${NOME}' and '${DADOS['preco']}' == '${PRECO}' and '${DADOS['descricao']}' == '${DESCRICAO}' and '${DADOS['quantidade']}' == '${QUANTIDADE}' and '${DADOS['_id']}' == '${ID_PRODUTO}'
    END

Realizar requisição para listar produtos por parâmetro nome
    Create Session    ListarProdutos      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarProdutos     ${URL}/produtos    headers=${HEADERS}    params=nome=${NOME}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar produtos por parâmetro nome
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    FOR   ${DADOS}   IN   @{RESPONSE_BODY['produtos']}
        Should Be True  '${DADOS['nome']}' == '${NOME}' and '${DADOS['preco']}' == '${PRECO}' and '${DADOS['descricao']}' == '${DESCRICAO}' and '${DADOS['quantidade']}' == '${QUANTIDADE}' and '${DADOS['_id']}' == '${ID_PRODUTO}'
    END

Realizar requisição para listar produtos por parâmetro preço
    Create Session    ListarProdutos      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarProdutos     ${URL}/produtos    headers=${HEADERS}    params=preco=${PRECO}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar produtos por parâmetro preço
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    FOR   ${DADOS}   IN   @{RESPONSE_BODY['produtos']}
        Should Be True  '${DADOS['nome']}' == '${NOME}' and '${DADOS['preco']}' == '${PRECO}' and '${DADOS['descricao']}' == '${DESCRICAO}' and '${DADOS['quantidade']}' == '${QUANTIDADE}' and '${DADOS['_id']}' == '${ID_PRODUTO}'
    END

Realizar requisição para listar produtos por parâmetro descrição
    Create Session    ListarProdutos      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarProdutos     ${URL}/produtos    headers=${HEADERS}    params=descricao=${DESCRICAO}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar produtos por parâmetro descrição
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    FOR   ${DADOS}   IN   @{RESPONSE_BODY['produtos']}
        Should Be True  '${DADOS['nome']}' == '${NOME}' and '${DADOS['preco']}' == '${PRECO}' and '${DADOS['descricao']}' == '${DESCRICAO}' and '${DADOS['quantidade']}' == '${QUANTIDADE}' and '${DADOS['_id']}' == '${ID_PRODUTO}'
    END

Realizar requisição para listar produtos por parâmetro quantidade
    Create Session    ListarProdutos      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarProdutos     ${URL}/produtos    headers=${HEADERS}    params=quantidade=${QUANTIDADE}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar produtos por parâmetro quantidade
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}

    FOR   ${DADOS}   IN   @{RESPONSE_BODY['produtos']}
        Should Be True  '${DADOS['nome']}' == '${NOME}' and '${DADOS['preco']}' == '${PRECO}' and '${DADOS['descricao']}' == '${DESCRICAO}' and '${DADOS['quantidade']}' == '${QUANTIDADE}' and '${DADOS['_id']}' == '${ID_PRODUTO}'
    END
