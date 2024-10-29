*** Settings  ***
Library  RequestsLibrary
Library  String
Library  Collections
Library  OperatingSystem

*** Keywords ***
Criar um usuário novo
    # Gera uma string aleatória com 4 letras e armazena em `palavra_aleatoria`
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    # Converte a string gerada para letras minúsculas
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    # Define `Email_test` como uma combinação da string aleatória com "@emailtest.com"
    Set Test Variable    ${Email_test}  ${palavra_aleatoria}@emailtest.com
    # Exibe o email gerado no log
    Log  ${Email_test}

Cadastar usuario criado na ServeRest
    [Arguments]    ${email}    ${status_code}
    # Cria o corpo da requisição com dados do usuário a ser cadastrado
    ${body}    Create Dictionary    
    ...    nome=Fulano de tal    
    ...    email=${email}
    ...    password=1234
    ...    administrador=true
    Log    ${body}
    
    # Chama o método para criar uma sessão na API ServeRest
    Criar Sessão na ServeRest

    # Envia a requisição POST para criar o usuário com o corpo e status esperados
    ${resposta}    POST On Session
    ...            alias=ServeRest
    ...            url=/usuarios
    ...            json=${body}
    ...            expected_status=${status_code}

    # Exibe o conteúdo da resposta no log
    Log    ${resposta.json()} 

    # Verifica se o código de status é 201 (criado com sucesso)
    IF  ${resposta.status_code} == 201
        # Armazena o ID do usuário criado em `ID_USUARIO`
        Set Test Variable    ${ID_USUARIO}    ${resposta.json()["_id"]} 
    END
    
    # Armazena a resposta completa em `RESPOSTA` para validações posteriores
    Set Test Variable    ${RESPOSTA}      ${resposta.json()}

Criar Sessão na ServeRest
    # Define cabeçalhos para a sessão com JSON como formato de conteúdo
    ${headers}    Create Dictionary      accept=application/json      Content-Type=application/json
    # Cria a sessão com o alias `ServeRest` para chamadas subsequentes
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}

Conferir se o usuario foi cadastrado corretamente
    # Exibe a resposta completa armazenada no log
    Log    ${RESPOSTA}
    # Verifica se a resposta contém a mensagem de sucesso e a chave `_id`
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key     ${RESPOSTA}    _id

Repetir cadastro do usuário
    # Tenta cadastrar o mesmo usuário novamente esperando o código de erro 400
    Cadastar usuario criado na ServeRest    ${Email_test}    status_code=400

Verificar se o sistema impede o cadastro
    # Verifica se a mensagem de erro retornada é "Este email já está sendo usado"
    Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado

Consultar os dados do usuario
    # Faz uma requisição GET para obter os dados do usuário usando seu ID
    ${resposta_consulta}    GET On Session    alias=ServeRest    url=/usuarios/${ID_USUARIO}
    # Armazena a resposta da consulta em `RESP_CONSULTA`
    Set Test Variable    ${RESP_CONSULTA}    ${resposta_consulta.json()}

Conferir os dados do usuario
    # Verifica se os dados consultados coincidem com os dados cadastrados
    Dictionary Should Contain Item    ${RESP_CONSULTA}    nome           Fulano de tal
    Dictionary Should Contain Item    ${RESP_CONSULTA}    email          ${Email_test}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    password       1234
    Dictionary Should Contain Item    ${RESP_CONSULTA}    administrador  true
    Dictionary Should Contain Item    ${RESP_CONSULTA}    _id            ${ID_USUARIO}

Buscar por um usuario por parametro "${nome}" e com senha "${senha}" e id "${id_o}"
    # Cria um dicionário com os parâmetros de busca (nome, senha e ID)
    ${Params}    Create Dictionary    nome=${nome}    password=${senha}    _id=${id_o}
    # Realiza a busca de um usuário com os parâmetros definidos
    GET On Session    alias=ServeRest    url=usuarios    params=${Params}
