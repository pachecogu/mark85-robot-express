Mark85 Robot Express

Este repositório contém testes automatizados utilizando o Robot Framework (https://robotframework.org/). 
Abaixo estão as instruções para configurar o ambiente e executar os testes.

Pré-requisitos

Certifique-se de que as seguintes ferramentas estão instaladas no seu sistema:

1. Git: Para clonar o repositório.
   - Download Git: https://git-scm.com/downloads
2. Python 3.13.1 ou superior: Para executar o Robot Framework.
   - Download Python: https://www.python.org/downloads/
   - Durante a instalação, marque as opções:
     - Add Python to PATH
     - Install pip
3. Node.js: Para rodar o servidor web (se necessário).
   - Download Node.js: https://nodejs.org/

Atenção! Certifique que a aplicação web e a api estão sendo executadas.

Configuração do Ambiente

1. ACESSAR O GIT BASH
   - Abra o terminal Git Bash no seu computador.

2. CRIAR E ACESSAR O DIRETÓRIO
   Execute os comandos:
   mkdir -p /c/QAx/projects/
   cd /c/QAx/projects/

3. CLONAR O REPOSITÓRIO
   Execute o comando:
   git clone https://github.com/pachecogu/mark85-robot-express.git

4. INSTALAR DEPENDÊNCIAS
   Navegue até a pasta do projeto e instale os requisitos:
   cd mark85-robot-express
   pip install -r requirements.txt

5. EXECUTAR OS TESTES
    Execute o comando:
    robot -d ./logs ./tests
   
  
