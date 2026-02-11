# 📝 To-Do List - Gerenciador de Tarefas (Delphi VCL)

Aplicação Desktop desenvolvida em **Delphi (VCL)** para gerenciamento de tarefas (To-Do List), permitindo adicionar, editar, listar, filtrar e excluir tarefas.

O sistema utiliza **MySQL** como banco de dados e **FireDAC** para acesso aos dados.

---

# 🚀 Funcionalidades

✔ Listar tarefas  
✔ Adicionar nova tarefa  
✔ Editar tarefa  
✔ Excluir tarefa  
✔ Filtrar por status (Pendente, Em andamento, Concluída)  
✔ Edição rápida de status direto no Grid  
✔ Configuração de conexão via arquivo externo  

---

# 🛠 Tecnologias Utilizadas

- Delphi VCL
- FireDAC
- MySQL
- Arquitetura em camadas (DAO + Service)
- Padrões de boas práticas (Clean Code)

---
# ⚙ Configuração do Banco de Dados

A conexão com o banco é configurada através do arquivo "tarefas.config". Esse arquivo deve estar na mesma pasta do executável (.exe).

# 📄 Estrutura do arquivo tarefas.config

```
server=localhost 
database=db_tarefas 
username=admin 
password=123456 
port=3306 
```
# 🔎 Descrição dos parâmetros
| Chave    | Descrição                                        |
| -------- | ------------------------------------------------ |
| server   | Endereço do servidor MySQL (ex: localhost ou IP) |
| database | Nome do banco de dados                           |
| username | Usuário do banco                                 |
| password | Senha do usuário                                 |
| port     | Porta do MySQL (padrão 3306)                     |

# 👨‍💻 Como Configurar a Conexão

1. Instale o MySQL Server.

2. Crie o banco de dados:

```sql
CREATE DATABASE db_tarefas;
```

3. Execute o script de criação da tabela.

4. Configure corretamente o arquivo tarefas.config com:

    - Servidor correto

    - Nome do banco criado

    - Usuário e senha válidos

5. Coloque o arquivo tarefas.config na mesma pasta do .exe.


# 🗄 Estrutura da Tabela no Banco

```sql
CREATE TABLE tarefas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    status INT NOT NULL DEFAULT 0,
    data_criacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

# 📌 Status da Tarefa
| Código | Descrição    |
| ------ | ------------ |
| 0      | Pendente     |
| 1      | Em andamento |
| 2      | Concluída    |

# ▶ Como Executar

1. Compile o projeto no Delphi.

2. Certifique-se que:

    - O MySQL esteja rodando

    - O banco esteja criado

    - O arquivo tarefas.config esteja configurado corretamente

3. Execute o .exe.

# ⚠ Possíveis Problemas
### Erro de conexão

Verifique:

    - Se o MySQL está em execução

    - Se usuário e senha estão corretos

    - Se a porta está correta

    - Se o banco existe

### Erro de libmysql.dll

Verifique se a DLL compatível com a arquitetura (x86 ou x64) está junto ao executável.

❌ Erro de Conexão (10061)

MySQL não está rodando ou porta incorreta.

❌ Access denied

Usuário ou senha incorretos.

❌ Can't connect to MySQL server

Servidor incorreto ou firewall bloqueando porta.

❌ libmysql.dll inválida

Verifique se a DLL corresponde à arquitetura do projeto (x86 ou x64).

# 📈 Melhorias Futuras

- Paginação de resultados

- Controle de usuários

- Logs de auditoria

- Tema escuro

- Deploy com instalador

- Criptografia da senha no arquivo config

# 👨‍💻 Autor

Desenvolvido como projeto de desafio técnico em Delphi, aplicando boas práticas de arquitetura e organização de código.
