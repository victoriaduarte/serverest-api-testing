*** Settings ***
Library     FakerLibrary  locale=pt_br
Library     String
Library     RPA.JSON

*** Variables ***
@{PRODUTO}     Televisão    Computador    Monitor    Memória    Mouse    Gabinete    Teclado
@{MARCA}       Samsung      Philco        LG         Dell       Sony     Panasonic   HP

*** Keywords ***
Gerar produto
    ${PRDOUTO}=         Evaluate    random.choice($PRODUTO) + " " + random.choice($MARCA)   random
    ${CODIGO}           FakerLibrary.RandomNumber   digits=5    
    ${NOME}             Catenate    ${PRDOUTO} ${CODIGO}    
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

Atualizar produto cadastrado
    ${PRDOUTO}=         Evaluate    random.choice($PRODUTO) + " " + random.choice($MARCA)   random
    ${CODIGO}           FakerLibrary.RandomNumber   digits=5    
    ${NOME}             Catenate    ${PRDOUTO} ${CODIGO}    
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

Atualizar produto não cadastrado
    ${ID_NOVO}          FakerLibrary.Password     length=15     special_chars=False
    ${PRDOUTO}=         Evaluate    random.choice($PRODUTO) + " " + random.choice($MARCA)   random
    ${CODIGO}           FakerLibrary.RandomNumber   digits=5    
    ${NOME}             Catenate    ${PRDOUTO} ${CODIGO}    
    ${PRECO}            FakerLibrary.RandomNumber   digits=3
    ${DESCRICAO}        FakerLibrary.Word      
    ${QUANTIDADE}       FakerLibrary.RandomNumber   digits=4

    ${DATA}=   Convert String to JSON    {"nome": "Produto", "preco": "000", "descricao": "Descricao", "quantidade": "0000"}
    ${DATA}=   Update value to JSON      ${DATA}     $.nome            ${NOME}
    ${DATA}=   Update value to JSON      ${DATA}     $.preco           ${PRECO}      
    ${DATA}=   Update value to JSON      ${DATA}     $.descricao       ${DESCRICAO}
    ${DATA}=   Update value to JSON      ${DATA}     $.quantidade      ${QUANTIDADE}
    ${DATA}=   Evaluate      json.dumps(${DATA})     json

    Set Suite Variable    ${ID_NOVO}      
    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${PRECO} 
    Set Suite Variable    ${DESCRICAO} 
    Set Suite Variable    ${QUANTIDADE}
    Set Suite Variable    ${DATA}