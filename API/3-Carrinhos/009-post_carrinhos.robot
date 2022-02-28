*** Settings ***
Library     RequestsLibrary
Resource    ../0-Login/000-post_login.robot
Resource    Payload/carrinho_valido.robot


*** Variables ***
${URL}          https://serverest.dev
${USER_01}      {"email": "fulano@qa.com", "password": "teste"}


*** Test Cases ***
Cadastrar carrinho
    Realizar requisição para cadastrar carrinho
    A API deve responder com código 201 e cadastrar carrinho


*** Keywords ***
Realizar requisição para cadastrar carrinho
    Autenticar   ${USER_01} 
    Create Session   CadastrarCarrinho      ${URL}       verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json 
    Gerar carrinho válido  
    Set Global Variable   ${QUANTIDADE}        ${QUANTIDADE}  
    Set Global Variable   ${ID_PRODUTO_NOVO}   ${ID_PRODUTO_NOVO}  
    ${RESPONSE}      Post On Session     CadastrarCarrinho    ${URL}/carrinhos    data=${DATA}    headers=${AUTH}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
    Set Global Variable	  ${ID_CARRINHO}      ${RESPONSE_BODY['_id']}
A API deve responder com código 201 e cadastrar carrinho
    Should Be True  '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Cadastro realizado com sucesso'