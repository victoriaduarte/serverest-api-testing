*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../0-Login/000-post_login.robot


*** Variables ***
${URL}          https://serverest.dev
${USER_01}      {"email": "fulano@qa.com", "password": "teste"}

*** Test Cases ***
Deletar carrinho e concluir a compra
# Ao concluir uma compra o carrinho é excluído
# O carrinho excluído será o vinculado ao usuário do token utilizado
    Realizar requisição para deletar carrinho e concluir a compra
    A API deve responder com código 200, deletar o carrinho e concluir a compra


*** Keywords ***
Realizar requisição para deletar carrinho e concluir a compra
    Autenticar   ${USER_01} 
    Create Session   DeletarCarrinho      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    ${RESPONSE}      Delete On Session     DeletarCarrinho    ${URL}/carrinhos/concluir-compra   headers=${AUTH}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 200, deletar o carrinho e concluir a compra
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Registro excluído com sucesso'