*** Settings ***
Library     FakerLibrary  locale=pt_br
Library     String
Library     RPA.JSON

*** Keywords ***
Gerar carrinho válido
    ${QUANTIDADE}       FakerLibrary.RandomNumber   digits=1 
    Set Test Variable   ${ID_PRODUTO_NOVO}
    ${DATA}=   Convert String to JSON    {"produtos": [{"idProduto": "id", "quantidade": 1}]}
    ${DATA}=   Update value to JSON      ${DATA}     $..quantidade   ${QUANTIDADE}
    ${DATA}=   Update value to JSON      ${DATA}     $..idProduto    ${ID_PRODUTO_NOVO}     
    # ${DATA}=   Update value to JSON      ${DATA}     $.produtos[1].idProduto    ${ID_PRODUTO}     
    ${DATA}=   Evaluate      json.dumps(${DATA})     json

    Set Suite Variable    ${QUANTIDADE}      
    Set Suite Variable    ${ID_PRODUTO_NOVO} 
    Set Suite Variable    ${DATA}