*** Settings ***
Library     FakerLibrary  locale=pt_br
Library     String
Library     RPA.JSON

*** Variables ***
@{PRODUTO}     Televisão    Computador    Monitor    Memória    Mouse    Gabinete    Teclado
@{MARCA}       Samsung      Philco        LG         Dell       Sony     Panasonic   HP

*** Keywords ***
Gerar produto
    ${NOME}=            Evaluate    random.choice($PRODUTO) + " " + random.choice($MARCA)   random
    ${PRECO}            FakerLibrary.RandomNumber   digits=3
    ${DESCRICAO}        FakerLibrary.Word      
    ${QUANTIDADE}       FakerLibrary.RandomNumber   digits=4

    ${DATA}=   Convert String to JSON    {"nome": "Produto", "preco": "000", "descricao": "Descricao", "quantidade": "0000"}
    ${DATA}=   Update value to JSON      ${DATA}     $.nome            ${NOME}
    ${DATA}=   Update value to JSON      ${DATA}     $.preco           ${PRECO}      
    ${DATA}=   Update value to JSON      ${DATA}     $.descricao       ${DESCRICAO}
    ${DATA}=   Update value to JSON      ${DATA}     $.quantidade      ${QUANTIDADE}
    ${DATA}=   Evaluate      json.dumps(${DATA})     json

    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${PRECO} 
    Set Suite Variable    ${DESCRICAO} 
    Set Suite Variable    ${QUANTIDADE}
    Set Suite Variable    ${DATA}