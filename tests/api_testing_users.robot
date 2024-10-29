*** Settings ***
Resource    ../resources/api_testing_users.resource

*** Test Cases ***

Cenario 1: Cadastrar um novo usuario com sucesso na ServeRest
    Criar um usuário novo
    Cadastar usuario criado na ServeRest    ${Email_test}    status_code=201
    Conferir se o usuario foi cadastrado corretamente
    
Cenario 2: Cadastrar Ususraio já existente
    Criar um usuário novo
    Cadastar usuario criado na ServeRest    ${Email_test}    status_code=201
    Repetir cadastro do usuário   
    Verificar se o sistema impede o cadastro
Cenario 3: Consultar um unico usuario
    Criar um usuário novo
    Cadastar usuario criado na ServeRest    ${Email_test}    status_code=201
    Consultar os dados do usuario
    Conferir os dados do usuario
Cenario 4: Buscar por um usuario por parametro
    Criar Sessão na ServeRest
    Buscar por um usuario por parametro "Diego Patricio" e com senha "12345" e id "2ZUvUmEVctWAMlrT"