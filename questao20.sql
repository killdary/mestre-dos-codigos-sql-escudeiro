CREATE TABLE cliente(
    clienteId INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(100) NULL,
    email VARCHAR(100) NULL
);

CREATE TABLE usuario(
    clienteId INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(100) NULL,
    email VARCHAR(100) NULL
);

CREATE TABLE fornecedor(
    clienteId INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(100) NULL,
    email VARCHAR(100) NULL
);

CREATE TABLE funcionario(
    clienteId INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(100) NULL,
    email VARCHAR(100) NULL
);

CREATE TABLE endereco(
    enderecoId INT IDENTITY(1,1) PRIMARY KEY,
    endereco VARCHAR(200) NOT NULL,
    cidade VARCHAR(150) NOT NULL,
    estado VARCHAR(50) NULL,
    bairro VARCHAR(30) NULL
);

CREATE TABLE clienteEndereco(
    clienteId INT,
    enderecoId INT,
    FOREIGN KEY(clienteId) REFERENCES cliente(id),
    FOREIGN KEY(enderecoId) REFERENCES endereco(id),    
    CONSTRAINT [PK_clienteEndereco] PRIMARY KEY CLUSTERED ( clienteId, enderecoId )
);


CREATE TABLE usuarioEndereco(
    usuarioId INT,
    enderecoId INT,
    FOREIGN KEY(usuarioId) REFERENCES usuario(id),
    FOREIGN KEY(enderecoId) REFERENCES endereco(id),    
    CONSTRAINT [PK_usuarioEndereco] PRIMARY KEY CLUSTERED ( usuarioId, enderecoId )
);

CREATE TABLE fornecedorEndereco(
    fornecedorId INT,
    enderecoId INT,
    FOREIGN KEY(fornecedorId) REFERENCES fornecedor(id),
    FOREIGN KEY(enderecoId) REFERENCES endereco(id),    
    CONSTRAINT [PK_fornecedorEndereco] PRIMARY KEY CLUSTERED ( fornecedorId, enderecoId )
);

CREATE TABLE funcionarioEndereco(
    funcionarioId INT,
    enderecoId INT,
    FOREIGN KEY(funcionarioId) REFERENCES funcionario(id),
    FOREIGN KEY(enderecoId) REFERENCES endereco(id),    
    CONSTRAINT [PK_funcionarioEndereco] PRIMARY KEY CLUSTERED ( funcionarioId, enderecoId )
);