*** Settings ***
Library     FakerLibrary  locale=pt_br
Library     String
Library     RPA.JSON

*** Keywords ***
Gerar usuário com campos em branco
    ${DATA}=   Convert String to JSON    {"nome": "","email": "","password": "","administrador": ""}
    ${DATA}=   Evaluate      json.dumps(${DATA})     json

    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${EMAIL} 
    Set Suite Variable    ${PASSWORD} 
    Set Suite Variable    ${DATA}

Gerar usuário com body vazio
    ${DATA}=   Convert String to JSON    {}

    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${EMAIL} 
    Set Suite Variable    ${PASSWORD} 
    Set Suite Variable    ${DATA}