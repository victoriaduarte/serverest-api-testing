*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../0-Login/000-post_login.robot
Resource    Payload/produto_valido.robot
Resource    Payload/produto_invalido.robot


*** Variables ***
${URL}          https://serverest.dev
${USER_01}      {"email": "fulano@qa.com", "password": "teste"}


*** Test Cases ***
Deletar produto cadastrado
    Realizar requisição para deletar produto cadastrado
    A API deve responder com código 200 e deletar o produto

Deletar produto não cadastrado
    Realizar requisição para deletar produto não cadastrado
    A API deve responder com código 200 e não deletar o produto

# Deletar produto que faz parte de carrinho
# # Não é permitido excluir produto que faz parte de carrinho
#     Realizar requisição para deletar produto com carrinho cadastrado
#     A API deve responder com código 400

*** Keywords ***
Realizar requisição para deletar produto cadastrado
    Autenticar   ${USER_01} 
    Create Session   DeletarProduto      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    ${RESPONSE}      Delete On Session     DeletarProduto    ${URL}/produtos/${ID_PRODUTO}    headers=${AUTH}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 200 e deletar o produto
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Registro excluído com sucesso'

Realizar requisição para deletar produto não cadastrado
    Autenticar   ${USER_01} 
    Create Session   DeletarProduto      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Atualizar produto não cadastrado    
    ${RESPONSE}      Delete On Session     DeletarProduto    ${URL}/produtos/${ID_NOVO}    headers=${AUTH}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 200 e não deletar o produto
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Nenhum registro excluído'
