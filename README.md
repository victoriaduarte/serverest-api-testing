# ServeRest API

O ServeRest é uma API REST que simula uma loja virtual para servir de material de estudos de testes de API

:shopping_cart: https://serverest.dev/


## Endpoints
- [x] Login
- [x] Usuários
- [x] Produtos
- [x] Carrinhos

## Instalação

- Instalar o Python
- Instalar o driver do navegador e adicionar ao path nas variáveis de ambiente do sistema
- Instalar as dependências do Robot Framework: `python -m pip install -r requirements.txt`

## Libraries externas utilizadas

- RequestsLibrary
- FakerLibrary
- RPA.JSON

## Execução dos testes

- Executar no terminal: `robot -d Results .\API\`

## Resultado dos testes

- Acessar o arquivo *log.html* na pasta *Results*