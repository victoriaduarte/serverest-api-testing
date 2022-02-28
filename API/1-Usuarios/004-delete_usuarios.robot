*** Settings ***
Library     RequestsLibrary
Resource    Payload/usuario_valido.robot
Resource    Payload/usuario_invalido.robot


*** Variables ***
${URL}    https://serverest.dev


*** Test Cases ***
Deletar usuário cadastrado
    Realizar requisição para deletar usuário cadastrado
    A API deve responder com código 200 e deletar o usuário

Deletar usuário não cadastrado
    Realizar requisição para deletar usuário não cadastrado
    A API deve responder com código 200 e não deletar o usuário

# Atualizar usuário com email já utilizado
# # Não é permitido excluir usuário com carrinho cadastrado
#     Realizar requisição para deletar usuário com carrinho cadastrado
#     A API deve responder com código 400

*** Keywords ***
Realizar requisição para deletar usuário cadastrado
    Create Session   DeletarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Atualizar usuário cadastrado
    ${RESPONSE}      Delete On Session     DeletarUsuario    ${URL}/usuarios/${ID_USUARIO}    headers=${HEADERS}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 200 e deletar o usuário
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Registro excluído com sucesso'

Realizar requisição para deletar usuário não cadastrado
    Create Session   DeletarUsuario      ${URL}     verify=true 
    &{HEADERS}       Create Dictionary   Content-Type=application/json
    Atualizar usuário não cadastrado    
    ${RESPONSE}      Delete On Session     DeletarUsuario    ${URL}/usuarios/${ID_NOVO}    headers=${HEADERS}
    Set Test Variable     ${RESPONSE}    
    Set Test Variable	  ${RESPONSE_BODY}     ${RESPONSE.json()}
A API deve responder com código 200 e não deletar o usuário
    Should Be True  '${RESPONSE.status_code}'=='200'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}
    Should Be True  '${RESPONSE_BODY['message']}'=='Nenhum registro excluído'
