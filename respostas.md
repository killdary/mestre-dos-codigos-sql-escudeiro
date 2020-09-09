#  SQL do Mestre dos Códigos
## Escudeiro

1. Crie um modelo de dados no formato de DER contendo pelo menos 10 tabelas, sendo que pelo menos uma tabela deve conter chave composta; Criar ligações entre as tabelas com relacionamentos MxN e 1xN.
   - Resposta:
     - Imagem questao1.png; 

2. Com base base no modelo criado no exercicio 1 crie os códigos DDL para criação das tabelas e os cuidados tomados com normalização e com a criação de indices;
   - Resposta:
     - SQL questao2.sql;

3. Extrair um relatório do modelo de dados criado no item 1, utilizando 3 funções de agregação diferentes, e filtrando por pelo menos uma função agregadora;
   - Resposta:
        ```
            SELECT 
                genero.nome as Genero,
                sum(filme.duracao) as TotalDeHorasAssistido,
                max(filme.duracao) as DuracaoMaximaDoFilme,
                min(filme.duracao) as DuracaoMinima,
                avg(filme.duracao) as MediaDeTempoAssistidoPorFilme,
                avg(DATEDIFF(YY, conta.dataNascimento, GETDATE())) as MediaDeIdadeAssistida
            FROM
                filme
                inner join filmeGenero on filmeGenero.filmeId = filme.id
                inner join genero on genero.id = filmeGenero.generoId
                left join filmesAssistidos on filmesAssistidos.filmeId = filme.id
                left join perfil on perfil.id = filmesAssistidos.perfilId
                left join conta on conta.id = perfil.id
            WHERE   
                filmesAssistidos.dataAssistido BETWEEN  DATEADD(WEEK,-1,GETDATE()) AND GETDATE()
            GROUP BY
                genero.nome
            HAVING 
                min(filme.duracao) > 40
        ```

4. Criar uma query hierarquica, ordenando os registros por uma coluna específica;
    - Resposta:
        ```
        Drop table dbo.usuario;

        CREATE TABLE dbo.usuario (
                id INTEGER IDENTITY PRIMARY KEY,
                parent_id INTEGER NULL REFERENCES dbo.usuario(id),
                nome VARCHAR(50)
            );
            
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (NULL, 'Ilson');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (1, 'Desiree');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (2, 'Filipe Bezerra');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (3, 'Guilherme Lofrano');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (3, 'Taciana Claudia');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (1, 'Marco Aurélio');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (6, 'Carlos Barbosa');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (6, 'Killdary Aguiar');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (6, 'Pricila Santana');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (1, 'Luis Feitosa');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (9, 'Renisson Sousa');
        INSERT INTO dbo.usuario (parent_id, nome) VALUES (9, 'Daphine');

        WITH hierarquia (id, parent_id, nome) AS (
                    SELECT id, parent_id, nome
                    FROM dbo.usuario
                    WHERE parent_id IS NULL
        UNION ALL

        SELECT child.id, child.parent_id, child.nome
        FROM dbo.usuario child
        JOIN hierarquia ON hierarquia.id = child.parent_id
        )
        SELECT usu.nome AS parent, hier.nome AS child
        FROM hierarquia hier
        LEFT JOIN dbo.usuario usu ON usu.id = hier.parent_id
        ORDER BY usu.id;  
        ```
        
5. Realize 5 consultas no modelo de dados criado no item 1, realizando pelo menos uma das seguintes operações: Union, Intersect, Minus, e utilizando pelo menos 3 tipos diferentes de joins;
    - Resposta:
      - questao5.sql

6. O que são os comandos DML?
   - Opção 1;
   - Linguagem de Manipulação de Dados: esses comandos indicam uma ação para o SGBD executar. Utilizados para recuperar, inserir e modificar um registro no banco de dados. Seus comandos são: INSERT, DELETE, UPDATE, SELECT e LOCK;
7. O que são os comandos DDL?
   - Opção 2;
   - Linguagem de Definição de Dados:comandos DDL são responsáveis pela criação, alteração e exclusão dos objetos no banco de dados. São eles: CREATE TABLE, CREATE INDEX, ALTER TABLE, DROP TABLE, DROP VIEW e DROP INDEX; 
8. O que são os comandos DDL?
   - Opção 3;
   - Linguagem de Controle de Dados:responsável pelo controle de acesso dos usuários, controlando as sessões e transações do SGBD. Alguns de seus comandos são: COMMIT, ROLLBACK, GRANT e REVOKE.
9.  Temos 2 tabelas a "serviceorder" e "client". Análise os códigos abaixos e aponte qual é o correto para criação de uma chave estrangeira na tabela "serviceorder" referenciando a tabel "client".
    - Nenhuma das opções criará uma chave estrangeira válida. O comando certo seria:

    ```
    ALTER TABLE serviceorder ADD FOREIGN KEY (id_client) REFERENCES client(id_client);
    ```
10. Dado a tabela abaixo, criamos um comando de "INSERT", no entando ele esta apresentando um erro. Reescreva o código corrigindo o:
    - A questao é meio dúbia, já que podemos ter dois códigos para **id**, sem conhecer a estrutura da tabela não tem como determinar o tipo da coluna **id**. Para corrigir o SQL foi assumido que o tipo do **id** será um *int*, neste caso o insert ficaria da seguinte maneira:
    ```
        insert into cliente(
            id,
            nome_cliente,
            razao_social,
            dt_cadastro,
            cnpj,
            telefone,
            cidade,
            estado
        )
        values (
            1,
            'AARONSON',
            'AARONSON FURNITURE LTDA',
            '2015-02-17',
            '17.807.928/0001-85',
            '(21) 8167-6584',
            'MARINGA',
            'PR'
        );
    ```

11.  Reescreva o código abaixo corrigindo o comando:
    
     - Resposta
    ``` 
        update client set name = 'FULANO DE TAL', cnpj = '17807928000185' 
        where id = 3234;
    ```

12. Você precisa montar um relatório para buscar os vendedores agrupados por nome, cliente e mostrando o total que cada um realizou de vendas por cliente. Para isso considere as seguintes tabelas:


13. Utilizamos a função "GROUP BY" para agrupar informações iguais de determidas colunas. Com base nos seus conhecimento a respeito da função "GROUP BY" assinale o código correto:
    - Opção 3
    ```
        SELECT c.nome, sum(v.total_venda)
            FROM cliente
        INNER JOIN vendas v on v.id_cliente = c.id
            WHERE v.dt_venda > '01/01/2019'
        GROUP BY c.nome
        ORDER BY nome
    ```

14. Muitas vezes queremos buscar um registro no banco de dados mas não sabemos o termo completo que queremos consultar. Ex: Você foi instruído para consultar o nome de todos clientes que possuem o nome "Souza" no nome. Para isso você recebeu o comando abaixo incorreto. Análise a consulta e reescreva a da maneira correta.

    - Resposta
    ```
    sql> " SELECT nome
        FROM cliente
        WHERE nome like '%Souza%' "
    ```
      
15. A tabela "cliente" foi criado com a estrutura incorreta. Agora você precisa criar um comando para excluir essa tabela do banco de dados. Assinale a alternativa correta.

    - Drop table cliente;

16. É muito comum termos a necessidade de buscar diversas informações utilizando um único comando. Ex: Precisamos trazer em uma única consulta todos os nomes dos clientes referente aos ids "12", "10", "199", "18", "01", "2016". Construa a consulta utilizando a tabela "cliente" e o campo "id":

    - Resposta:
    ```
        SELECT *
        FROM cliente
        WHERE id IN (12, 10, 199, 18, 01, 2016);
    ```

17. a
    - Resposta: Opcao 1 

18. O analista responsavel pelo gerenciamento do banco de dados precisa excluir a tabela cliente. Levando em consideração o relacionamento entre as duas tabelas. Como seria o único comando que iria excluir a tabela clientes e vendas de uma só vez.
    - Resposta:
    ```
        DROP TABLE vendas, cliente;
    ``` 


19. A tabela "cliente" do produto que você trabalha, possuí os seguintes campos:

Nome; Telefone; E-mail; Endereço; Cidade; Estado; Bairro.

Com o aumento da complexidade do produto, surgiu a necessidade de criar uma estrutura de tabelas para armazenar endereços que será utilizada por outras tabelas como "usuario", "forncedor" e "funcionario". Sabendo disso, a sua missão é criar essa nova estrutura de tabelas de endereços que será utilizada nos demais locais do produto. Crie um modelo de dados no formato de DER com as tabelas dessa nova estrutura.
   - Resposta:
     - Imagem questao19.png; 


20. Com base no modelo anterior de endereços crie os códigos DDL para criação das tabelas e os cuidados tomados com normalização e com a criação de indices;
   - Resposta:
     - SQL questao20.sql;