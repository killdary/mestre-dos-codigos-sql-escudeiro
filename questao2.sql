CREATE TABLE estudio(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(500) NULL
);

CREATE TABLE diretor(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    dataNascimento DATETIME NOT NULL,
    descricao VARCHAR(500) NULL,
    genero TINYINT NOT NULL
);

CREATE TABLE genero(
    id int IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE conta(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    dataNascimento DATETIME NOT NULL,
    ultimoLogin DATETIME NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    senha VARCHAR(200) NOT NULL,
    genero TINYINT NOT NULL
);

CREATE TABLE ator(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(500),
    genero TINYINT NOT NULL,
    dataNascimento DATETIME NOT NULL
);


CREATE TABLE filme(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    duracao INT NOT NULL,
    dataLancamento DATETIME NOT NULL,
    diretorId INT NOT NULL,
    estudioId INT NOT NULL,
    FOREIGN KEY (diretorId) REFERENCES diretor(id),
    FOREIGN KEY (estudioId) REFERENCES estudio(id)
);

CREATE TABLE imagem(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    caminho VARCHAR(100) NOT NULL,
    principal BIT,
    ativa BIT,
    filmeId BIGINT NOT NULL,
    FOREIGN KEY (filmeId) REFERENCES filme(id)
);

CREATE TABLE filmegenero(
    filmeId BIGINT,
    generoId INT,
    FOREIGN KEY (filmeId) REFERENCES filme(id),
    FOREIGN KEY (generoId) REFERENCES genero(id),    
    CONSTRAINT [PK_filmegenero] PRIMARY KEY CLUSTERED ( filmeId, generoId )
);

CREATE TABLE email(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    endereco VARCHAR(50) NOT NULL,
    principal BIT,
    contaId BIGINT,
    FOREIGN KEY(contaId) REFERENCES conta(id)
);

CREATE TABLE perfil(
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    principal BIT,
    contaId BIGINT,
    FOREIGN KEY(contaId) REFERENCES conta(id)
);

CREATE TABLE filmesAssistidos(
    filmeId BIGINT,
    perfilId BIGINT,
    dataAssistido DATETIME NOT NULL,
    FOREIGN KEY(filmeId) REFERENCES filme(id),
    FOREIGN KEY(perfilId) REFERENCES perfil(id),    
    CONSTRAINT [PK_filmesAssistidos] PRIMARY KEY CLUSTERED ( filmeId, perfilId )
);

CREATE TABLE atorFilme(
    atorId BIGINT,
    filmeId BIGINT,
    FOREIGN KEY(atorId) REFERENCES ator(id),
    FOREIGN KEY(filmeId) REFERENCES filme(id),    
    CONSTRAINT [PK_atorFilme] PRIMARY KEY CLUSTERED ( filmeId, atorId )
);

-----inserts

-- INSERT INTO 
-- 	estudio(nome) 
-- values 
-- 	('Estudio 1'),
-- 	('Estudio 2'),
-- 	('Estudio 3');

-- INSERT INTO 
-- 	diretor(nome,dataNascimento, genero)  
-- values 
-- 	('Diretor 1', '1950-01-01', 1), 
-- 	('Diretor 2', '1960-01-01', 2), 
-- 	('Diretor 3', '1970-01-01', 2), 
-- 	('Diretor 4', '1980-01-01', 3), 
-- 	('Diretor 5', '1990-01-01', 3);

-- INSERT INTO 
-- 	ator(nome,dataNascimento, genero)  
-- values
-- 	('Ator 1', '1980-01-01', 3), 
-- 	('Ator 2', '1960-01-01', 4), 
-- 	('Ator 3', '1985-01-01', 1), 
-- 	('Ator 4', '1990-01-01', 1), 
-- 	('Ator 5', '1978-01-01', 2), 
-- 	('Ator 6', '1999-01-01', 2), 
-- 	('Ator 7', '1974-01-01', 2);
	
-- INSERT INTO 
-- 	genero(nome)
-- values
-- 	('Genero 1'),
-- 	('Genero 2'),
-- 	('Genero 3'),
-- 	('Genero 4'),
-- 	('Genero 5');


-- INSERT INTO 
-- 	conta(nome, dataNascimento, ultimoLogin, usuario, senha, genero)
-- VALUES
-- 	('Conta 1', '2000-01-01', '2020-01-01 10:00:00', 'usuario 1', 'senha1', 1),
-- 	('Conta 2', '2002-01-01', '2020-09-01 18:00:00', 'usuario 2', 'senha2', 2),
-- 	('Conta 3', '1995-01-01', '2020-04-01 09:00:00', 'usuario 3', 'senha3', 3),
-- 	('Conta 4', '1990-01-01', '2020-05-01 00:00:00', 'usuario 4', 'senha4', 2),
-- 	('Conta 5', '1987-01-01', '2020-09-01 22:00:00', 'usuario 5', 'senha5', 2),
-- 	('Conta 6', '1980-01-01', '2020-09-01 19:00:00', 'usuario 6', 'senha6', 1),
-- 	('Conta 7', '1994-01-01', '2020-09-01 06:00:00', 'usuario 7', 'senha7', 1);


-- INSERT INTO 
-- 	email(endereco, principal, contaId)
-- VALUES
-- 	('email1@mdc.com', 1, 1),
-- 	('email11@mdc.com', 0, 1),
-- 	('email2@mdc.com', 1, 2),
-- 	('email3@mdc.com', 1, 3),
-- 	('email4@mdc.com', 1, 4),
-- 	('email5@mdc.com', 1, 5),
-- 	('email55@mdc.com', 0, 5),
-- 	('email6@mdc.com', 1, 6),
-- 	('email7@mdc.com', 1, 7);

-- INSERT INTO 
-- 	perfil(nome, principal, contaId)
-- VALUES
-- 	('perfil1-1',1,1),
-- 	('perfil1-2',0,1),
-- 	('perfil1-3',0,1),
-- 	('perfil1-4',0,1),
-- 	('perfil1-5',0,1),
-- 	('perfil2-1',1,2),
-- 	('perfil2-2',0,2),
-- 	('perfil2-3',0,2),
-- 	('perfil2-4',0,2),
-- 	('perfil2-5',0,2),
-- 	('perfil3-1',1,3),
-- 	('perfil3-2',0,3),
-- 	('perfil3-3',0,3),
-- 	('perfil3-4',0,3),
-- 	('perfil3-5',0,3),
-- 	('perfil4-1',1,4),
-- 	('perfil4-2',0,4),
-- 	('perfil4-3',0,4),
-- 	('perfil4-4',0,4),
-- 	('perfil4-5',0,4),
-- 	('perfil5-1',1,5),
-- 	('perfil5-2',0,5),
-- 	('perfil5-3',0,5),
-- 	('perfil5-4',0,5),
-- 	('perfil5-5',0,5),
-- 	('perfil6-1',1,6),
-- 	('perfil6-2',0,6),
-- 	('perfil6-3',0,6),
-- 	('perfil6-4',0,6),
-- 	('perfil6-5',0,6),
-- 	('perfil7-1',1,7),
-- 	('perfil7-2',0,7),
-- 	('perfil7-3',0,7),
-- 	('perfil7-4',0,7),
-- 	('perfil7-5',0,7);

-- INSERT INTO 
-- 	filme(nome, duracao, dataLancamento,diretorId, estudioId)
-- VALUES
-- 	('Filme1', 60, '2000-02-01',1,1),
-- 	('Filme2', 80, '2001-10-01',2,2),
-- 	('Filme3', 120, '2002-09-01',3,3),
-- 	('Filme4', 240, '2003-12-01',4,1),
-- 	('Filme5', 180, '2004-01-01',5,2),
-- 	('Filme6', 115, '2005-05-01',1,3),
-- 	('Filme7', 175, '2016-03-01',2,3),
-- 	('Filme8', 210, '2020-04-01',3,2),
-- 	('Filme9', 65, '2018-06-01',4,2),
-- 	('Filme10', 88, '2019-03-01',5,1);

-- INSERT INTO 
-- 	filmegenero(filmeId,generoId)
-- VALUES
-- 	(1,1),
-- 	(1,2),
-- 	(2,3),
-- 	(3,4),
-- 	(4,5),
-- 	(5,1),
-- 	(6,2),
-- 	(7,3),
-- 	(8,4),
-- 	(9,2),
-- 	(10,1),
-- 	(1,3),
-- 	(2,4),
-- 	(3,5),
-- 	(4,2),
-- 	(5,4),
-- 	(7,1),
-- 	(6,3),
-- 	(7,4),
-- 	(8,5),
-- 	(9,1),
-- 	(2,1),
-- 	(3,2),
-- 	(4,4),
-- 	(10,4),
-- 	(8,1),
-- 	(9,5);

-- INSERT INTO 
-- 	atorFilme(filmeId, atorId)
-- VALUES
-- 	(1,1),
-- 	(2,2),
-- 	(3,3),
-- 	(4,4),
-- 	(5,5),
-- 	(6,6),
-- 	(7,7),
-- 	(8,1),
-- 	(9,2),
-- 	(10,3),
-- 	(1,4),
-- 	(2,5),
-- 	(3,6),
-- 	(4,7),
-- 	(5,1),
-- 	(6,2),
-- 	(7,3),
-- 	(8,4),
-- 	(9,5),
-- 	(10,6),
-- 	(1,7),
-- 	(2,1),
-- 	(3,2),
-- 	(4,3);

-- INSERT INTO
-- 	filmesAssistidos(filmeId, perfilId, dataAssistido)
-- VALUES
-- 	(1 ,1 ,'2020-01-01 10:00:00'),
-- 	(2 ,6 ,'2020-09-01 18:00:00'),
-- 	(3 ,11,'2020-04-01 09:00:00'),
-- 	(4 ,16,'2020-05-01 00:00:00'),
-- 	(5 ,21,'2020-09-01 22:00:00'),
-- 	(6 ,26,'2020-09-01 19:00:00'),
-- 	(7 ,31,'2020-09-01 06:00:00'),
-- 	(8 ,1 ,'2020-01-01 09:00:00'),
-- 	(9 ,6 ,'2020-09-01 06:00:00'),
-- 	(10,11,'2020-04-01 07:00:00'),
-- 	(1 ,16,'2020-04-20 00:00:00'),
-- 	(2 ,21,'2020-09-01 15:00:00'),
-- 	(3 ,26,'2020-09-01 02:00:00'),
-- 	(4 ,31,'2020-09-01 03:00:00'),
-- 	(5 ,1 ,'2020-01-01 9:00:00'),
-- 	(6 ,6 ,'2020-09-01 17:00:00'),
-- 	(7 ,11,'2020-04-01 02:00:00'),
-- 	(8 ,16,'2020-04-01 15:00:00'),
-- 	(9 ,21,'2020-09-01 17:00:00'),
-- 	(10,26,'2020-09-01 10:00:00'),
-- 	(1 ,31,'2020-09-01 04:00:00'),
-- 	(2 ,2 ,'2020-01-01 07:30:00'),
-- 	(3 ,7 ,'2020-09-01 18:59:00'),
-- 	(4 ,12,'2020-04-01 06:00:00');