*** Settings ***
Library     RequestsLibrary


*** Variables ***
${URL}    https://serverest.dev


*** Test Cases ***
Listar carrinhos cadastrados
# Os carrinhos retornados são únicos por usuário
    Realizar requisição para listar carrinhos cadastrados
    A API deve responder com código 200 e listar carrinhos cadastrados


*** Keywords ***
Realizar requisição para listar carrinhos cadastrados
    Create Session    ListarCarrinhos      ${URL}      verify=true      
    &{HEADERS}        Create Dictionary   Content-Type=application/json
    ${RESPONSE}       Get On Session      ListarCarrinhos      ${URL}/carrinhos      headers=${HEADERS}
    Set Test Variable      ${RESPONSE}    
    Set Test Variable      ${RESPONSE_BODY}      ${RESPONSE.json()}
A API deve responder com código 200 e listar carrinhos cadastrados
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    FOR    ${CARRINHO}    IN   @{RESPONSE_BODY['carrinhos']}
        ${QUANTIDADE_TOTAL}=   Set Variable    ${0}
        ${PRECO_TOTAL}=        Set Variable    ${0}
        FOR    ${PRODUTO}    IN   @{CARRINHO['produtos']}
            Set Test Variable   ${QUANTIDADE}       ${PRODUTO['quantidade']}
            Set Test Variable   ${PRECO_UNITARIO}   ${PRODUTO['precoUnitario']}
            ${QUANTIDADE_TOTAL}=  Evaluate    ${QUANTIDADE_TOTAL} + ${PRODUTO['quantidade']}
            ${PRECO_TOTAL}=       Evaluate    (${PRECO_UNITARIO} * ${PRODUTO['quantidade']}) + ${PRECO_TOTAL}
        END
        Set Test Variable  ${QUANTIDADE_TOTAL}
        Set Test Variable  ${PRECO_TOTAL}
        Should Be True  '${CARRINHO['quantidadeTotal']}' == '${QUANTIDADE_TOTAL}'
        Should Be True  '${CARRINHO['precoTotal']}' == '${PRECO_TOTAL}'
    END