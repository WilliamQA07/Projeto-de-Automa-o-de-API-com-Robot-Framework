# Projeto de Automação de API com Robot Framework

Este repositório contém um projeto de automação de testes para a API ServeRest, desenvolvido em Robot Framework, que cobre cenários de cadastro, verificação e consulta de usuários. O projeto foi criado por **William Souza** e utiliza o `RequestsLibrary` para gerenciar as requisições HTTP.

## Tecnologias Utilizadas

- **Robot Framework**: Framework de automação de testes
- **RequestsLibrary**: Biblioteca do Robot Framework para envio de requisições HTTP
- **String, Collections, OperatingSystem Libraries**: Bibliotecas auxiliares do Robot Framework

## Cenários de Teste Cobertos

O projeto cobre quatro cenários de teste principais que validam o cadastro e consulta de usuários na API ServeRest.

### Cenário 1: Cadastrar um novo usuário com sucesso

Este cenário cobre o fluxo de criação de um novo usuário e valida se o cadastro foi concluído com sucesso.

Passos:
1. Criar um usuário novo com um email gerado automaticamente.
2. Cadastrar o usuário na ServeRest com status de sucesso (201).
3. Conferir se a resposta contém uma mensagem de cadastro bem-sucedido e um ID de usuário.

### Cenário 2: Cadastrar usuário já existente

Este cenário tenta cadastrar o mesmo usuário duas vezes para verificar se o sistema impede cadastros duplicados.

Passos:
1. Criar um usuário novo com um email gerado automaticamente.
2. Cadastrar o usuário na ServeRest com status de sucesso (201).
3. Repetir o cadastro do mesmo usuário, esperando um status de erro (400).
4. Verificar se a resposta contém uma mensagem indicando que o email já está em uso.

### Cenário 3: Consultar um único usuário

Este cenário realiza a consulta de um usuário específico usando seu ID e valida se os dados retornados coincidem com os dados cadastrados.

Passos:
1. Criar um usuário novo com um email gerado automaticamente.
2. Cadastrar o usuário na ServeRest com status de sucesso (201).
3. Consultar os dados do usuário cadastrado usando seu ID.
4. Conferir se os dados retornados correspondem ao nome, email, senha e status de administrador do usuário.

### Cenário 4: Buscar por um usuário por parâmetro

Este cenário realiza uma busca de um usuário específico utilizando parâmetros como nome, senha e ID.

Passos:
1. Criar uma sessão com a ServeRest.
2. Buscar por um usuário com o nome "Diego Patricio", senha "12345" e ID "2ZUvUmEVctWAMlrT".

## Estrutura do Projeto

- `*** Settings ***`: Configurações e importação de bibliotecas necessárias para a automação.
- `*** Keywords ***`: Definição de palavras-chave (keywords) que encapsulam funcionalidades de criação de sessão, cadastro, consulta e verificação de usuários na API.
- `*** Variables ***`: Variáveis de teste definidas durante a execução para manter valores temporários, como email e ID do usuário.
- `*** Test Cases ***`: Casos de teste específicos que utilizam as keywords para cobrir cada cenário listado acima.

## Pré-Requisitos

1. **Python 3.x**: É necessário para executar o Robot Framework.
2. **Robot Framework**: Instale com o comando:
   ```bash
   pip install robotframework
   ```
3. **RequestsLibrary**: Instale com o comando:
   ```bash
   pip install robotframework-requests
   ```

## Como Executar

1. Clone o repositório.
2. Navegue até o diretório do projeto.
3. Execute o comando para rodar todos os testes:
   ```bash
   robot -d results tests/
   ```
   O comando acima executa os testes e gera relatórios detalhados em HTML na pasta `results`.

## Estrutura de Relatório

Após a execução, os relatórios estarão disponíveis em `results/`, incluindo:
- `log.html`: Log detalhado de cada etapa executada.
- `report.html`: Sumário dos resultados dos testes.
- `output.xml`: Arquivo de saída dos testes, utilizado para integrar com outras ferramentas de CI.

## Autor

- **William Souza**

Este projeto foi desenvolvido para validar e garantir a consistência dos dados na API ServeRest, cobrindo cenários críticos de cadastro e consulta de usuários.