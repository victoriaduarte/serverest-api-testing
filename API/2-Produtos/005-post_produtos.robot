*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../0-Login/000-post_login.robot
Resource    Payload/produto_valido.robot


*** Variables ***
${URL}    https://serverest.dev


*** Test Cases ***
Cadastrar produto
    Realizar requisição para cadastrar produto
    A API deve responder com código 201 e cadastrar produto
    

*** Keywords ***
Realizar requisição para cadastrar produto
    Autenticar
    Create Session   CadastrarProduto      ${URL}       verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json     
    Gerar produto
    Set Global Variable   ${NOME}        ${NOME}  
    Set Global Variable   ${PRECO}       ${PRECO}  
    Set Global Variable   ${DESCRICAO}   ${DESCRICAO}  
    Set Global Variable   ${QUANTIDADE}  ${QUANTIDADE}  
    ${RESPONSE}      Post On Session     CadastrarProduto    ${URL}/produtos    data=${DATA}    headers=${AUTH}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
    Set Global Variable	  ${ID_PRODUTO}        ${RESPONSE_BODY['_id']}
A API deve responder com código 201 e cadastrar produto
    Should Be True  '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Cadastro realizado com sucesso'