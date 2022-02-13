*** Settings ***
Library     FakerLibrary  locale=pt_br
Library     String
Library     RPA.JSON

*** Keywords ***
Gerar usuário administrador
    ${NOME}             FakerLibrary.Name
    ${EMAIL}            FakerLibrary.Email
    ${PASSWORD}         FakerLibrary.Password     length=10     special_chars=False

    ${DATA}=   Convert String to JSON    {"nome": "Novo Usuario","email": "novousuario@email.com","password": "abc123","administrador": "true"}
    ${DATA}=   Update value to JSON      ${DATA}     $.nome            ${NOME}
    ${DATA}=   Update value to JSON      ${DATA}     $.email           ${EMAIL}      
    ${DATA}=   Update value to JSON      ${DATA}     $.password        ${PASSWORD}
    ${DATA}=   Evaluate      json.dumps(${DATA})     json

    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${EMAIL} 
    Set Suite Variable    ${PASSWORD} 
    Set Suite Variable    ${DATA}

Gerar usuário não administrador
    ${NOME}             FakerLibrary.Name
    ${EMAIL}            FakerLibrary.Email
    ${PASSWORD}         FakerLibrary.Password     length=10     special_chars=False

    ${DATA}=   Convert String to JSON    {"nome": "Novo Usuario","email": "novousuario@email.com","password": "abc123","administrador": "false"}
    ${DATA}=   Update value to JSON      ${DATA}     $.nome            ${NOME}
    ${DATA}=   Update value to JSON      ${DATA}     $.email           ${EMAIL}      
    ${DATA}=   Update value to JSON      ${DATA}     $.password        ${PASSWORD}
    ${DATA}=   Evaluate      json.dumps(${DATA})     json

    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${EMAIL} 
    Set Suite Variable    ${PASSWORD} 
    Set Suite Variable    ${DATA}

Atualizar usuário cadastrado
    ${NOME}             FakerLibrary.Name
    ${EMAIL}            FakerLibrary.Email
    ${PASSWORD}         FakerLibrary.Password     length=10     special_chars=False

    ${DATA}=   Convert String to JSON    {"nome": "Novo Usuario","email": "novousuario@email.com","password": "abc123","administrador": "true"}
    ${DATA}=   Update value to JSON      ${DATA}     $.nome            ${NOME}
    ${DATA}=   Update value to JSON      ${DATA}     $.email           ${EMAIL}      
    ${DATA}=   Update value to JSON      ${DATA}     $.password        ${PASSWORD}
    ${DATA}=   Evaluate      json.dumps(${DATA})     json

    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${EMAIL} 
    Set Suite Variable    ${PASSWORD} 
    Set Suite Variable    ${DATA}

Atualizar usuário não cadastrado
    ${ID_NOVO}          FakerLibrary.Password     length=15     special_chars=False
    ${NOME}             FakerLibrary.Name
    ${EMAIL}            FakerLibrary.Email
    ${PASSWORD}         FakerLibrary.Password     length=10     special_chars=False

    ${DATA}=   Convert String to JSON    {"nome": "Novo Usuario","email": "novousuario@email.com","password": "abc123","administrador": "true"}
    ${DATA}=   Update value to JSON      ${DATA}     $.nome            ${NOME}
    ${DATA}=   Update value to JSON      ${DATA}     $.email           ${EMAIL}      
    ${DATA}=   Update value to JSON      ${DATA}     $.password        ${PASSWORD}
    ${DATA}=   Evaluate      json.dumps(${DATA})     json

    Set Suite Variable    ${ID_NOVO}      
    Set Suite Variable    ${NOME}      
    Set Suite Variable    ${EMAIL} 
    Set Suite Variable    ${PASSWORD} 
    Set Suite Variable    ${DATA}