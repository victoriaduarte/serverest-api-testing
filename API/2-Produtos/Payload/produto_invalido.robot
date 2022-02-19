*** Settings ***
Library     FakerLibrary  locale=pt_br
Library     String
Library     RPA.JSON

*** Keywords ***
Gerar produto com campos em branco
    ${DATA}=   Convert String to JSON    {"nome": "", "preco": "", "descricao": "", "quantidade": ""}
    ${DATA}=   Evaluate      json.dumps(${DATA})     json

    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${PRECO} 
    Set Suite Variable    ${DESCRICAO} 
    Set Suite Variable    ${QUANTIDADE}
    Set Suite Variable    ${DATA}

Gerar produto com body vazio
    ${DATA}=   Convert String to JSON    {}

    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${PRECO} 
    Set Suite Variable    ${DESCRICAO} 
    Set Suite Variable    ${QUANTIDADE}
    Set Suite Variable    ${DATA}