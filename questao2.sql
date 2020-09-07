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



