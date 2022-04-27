
-- Criação da tabela  de funcionários. Abaixo:


create table funcionario (
	cpf char(11) not null COMMENT "CPF do funcionário. Será a PK da tabela.",
	primeiro_nome varchar(15) not null COMMENT " Nome do funcionário.",
	nome_meio char(1) COMMENT "Inicial do nome do meio do funcionário.",
	ultimo_nome varchar(15) not null COMMENT "Sobrenome  - funcionário.",
	data_nascimento date,
	endereco varchar(10) COMMENT "Endereço - funcionário.",
	sexo char(1) COMMENT "Sexo - funcionário.",
	salario decimal(10, 2) COMMENT "Salário - funcionário.",
	cpf_supervisor char(11) COMMENT "CPF - supervisor. FK - auto-relacionamento da FK.",
	numero_departamento integer not null COMMENT "Número departamento - funcionário.",
	primary key (cpf),
	foreign key (cpf_supervisor) references funcionario(cpf)
) COMMENT "Tabela - armazenamento de dados - funcionários."



-- Criação tabela dependente - Colunas e tabela já comentadas. Abaixo:

create table dependente (
	cpf_funcionario char(11) not null COMMENT "CPF - funcionário. Incluida na PK desta tabela sendo uma FK na tabela funcionário.",
	nome_dependente varchar(15) not null COMMENT "Nome - dependente. Incluida na PK desta mesma tabela.",
	sexo char(1) COMMENT "Sexo - dependente.",
	data_nascimento date COMMENT "Nascimento -  dependente.",
	parentesco varchar(15) COMMENT "Relação do dependente com funcionário.",
	primary key(cpf_funcionario, nome_dependente),
	foreign key (cpf_funcionario) references funcionario(cpf)
) COMMENT "tabela - funcionários.";


-- Criação da tabela departamentos.

create table departamento (


	numero_departamento integer not null COMMENT "Número - departamento - PK da tabela.",
	nome_departamento varchar(15) unique not null COMMENT "Nome - departamento - Apenas um.",
	cpf_gerente char(11) not null COMMENT "CPF - gerente - FK de funcionários.",
	data_inicio_gerente date COMMENT "Data - inicio -  gerente no departamento.",
	primary key (numero_departamento),
	foreign key (cpf_gerente) references funcionario(cpf)

) COMMENT "Tabela - departamentos.";

-- Criação - tabela - localizacoes_departamento -já comentadas.

create table localizacoes_departamento (
	numero_departamento integer not null COMMENT "Número -  departamento -   PK dessa tabela - FK da tabela departamento.",
	local varchar(15) not null COMMENT "Localização - departamento - PK da tabela.",
	primary key(numero_departamento, local),
	foreign key (numero_departamento) references departamento(numero_departamento)
) COMMENT "Tabela- armazenamento/localizações de departamentos.";



-- Crianção - tabela projeto - comentadas. 


create table projeto (
	numero_projeto integer not null COMMENT "Número - projeto -  PK da tabela.",
	nome_projeto varchar(15) unique not null COMMENT "Nome - projeto - único.",
	local_projeto varchar(15) COMMENT "Localização - projeto.",
	numero_departamento integer not null COMMENT "Número - departamento - FK para  departamento." ,
	primary key(numero_projeto),
	foreign key (numero_departamento) references departamento(numero_departamento)
) COMMENT "Tabela - guarda informações DE: projetos dos departamentos.";

-- Crianção de tabela - trabalha_em -  já comentadas

create table trabalha_em (
	cpf_funcionario char(11) not null COMMENT "CPF - funcionário- PK desta tabela - FK tabela funcionário.",
	numero_projeto integer not null COMMENT "Número - projeto - PK da tabela - FK da tabela projeto.",
	horas decimal(3,1) COMMENT "Horas trabalhadas",
	primary key(cpf_funcionario, numero_projeto),
	foreign key (cpf_funcionario) references funcionario(cpf),
	foreign key (numero_projeto) references projeto(numero_projeto)
) COMMENT "Tabela - funcionários em relação a projetos.";


/*  DADOS */

-- Inserindo dados funcionários - 
INSERT INTO funcionario
values 
	(88866555576, 'Jorge','E','Brito','1937-11-10','R. do Horto,35,São Paulo,SP','M',55000, null ,1),

	(99988777767, 'Alice','J','Zelaya','1968-01-19','R. Souza Lima,35,Curitiba,PR','F',25000,98765432168,4),

	(98765432168, 'Jennifer','S','Souza','1941-06-20','Av. Arthur de Lima,54,S.A,SP','F',43000,88866555576,4),

	(33344555587, 'Fernando','T','Wong','1955-12-08','R. da Lapa,34,São Paulo,SP','M',40000,88866555576,5),

	(12345678966,'João','B','Silva','1965-01-09','R. das Flores,751,São Paulo,Sp','M',30000,33344555587,5),

	(98798798733, 'André','V','Pereira','1969-03-29','R. Timbira,35,São Paulo, SP','M',25000,98765432168,4),

	(45345345376, 'Joice','A','Leite','1972-07-31','Av. Lucas Obes,74 São Paulo,SP','F',25000,33344555587,5);

	(66688444476, 'Ronaldo','K','Lima','1962-09-15','R. Rebouças,65,Piracicaba,SP','M',38000,33344555587,5),

-- Inserindo os dados dos departamentos 

INSERT INTO departamento 
values 
	
    (4, 'Administração',98765432168,'1995-01-01'),
	(5,'Pesquisa',33344555587,'1988-05-22'),
    (1, 'Matriz', 88866555576,'1981-06-19');

-- Inserindo a localizão dos departamentos 

INSERT INTO localizacoes_departamento 
values  
    (4,'Mauá'),
	(1,'São Paulo'),
    (5,'Itu'),
    (5,'São Paulo');
	(5,'Santo André'),

-- Inserindo os dados dos projetos 

INSERT INTO projeto 
values  
	(1,'ProdutoX','Santo André',5),
	(3,'ProdutoZ','São Paulo',5),
	(20,'Reorganização','São Paulo',1),
	(30,'Novosbenefícios','Mauá',4);
	(2,'ProdutoY','Itu',5),
	(10,'Informatização','Mauá',4),
     
-- Inserindo os dados dos dependestes 


INSERT INTO dependente 
values  

    (12345678966,'Michael','M','1988-01-04','filho'),
	(12345678966,'Alicia','F','1988-12-30','filha'),
	(12345678966,'Elizabeth','F','1967-05-05','esposa');
	(33344555587,'Janaína','F','1958-05-03','esposa'),
	(98765432168,'Antonio','M','1942-02-28','marido'),
	(33344555587,'Alicia','F','1986-04-05','filha'),
	(33344555587,'Tiago','M','1983-10-25','filho'),
	

-- Inserindo - onde projeto o funcionario atua e quantas horas na tabela trabalha_em
INSERT INTO trabalha_em 
values
	
	(45345345376,1,20.0),
    (12345678966,1,32.5),
	(12345678966,2,7.5),
	(66688444476,3,40.0),
	(45345345376,2,20.0),
	(33344555587,2,10.0),
	(33344555587,3,10.0),
	(33344555587,10,10.0),
	(33344555587,20,10.0),
	(99988777767,30,30.0),
	(99988777767,10,10.0),
	(98798798733,10,35.0),
	(98765432168,20,15.0),
	(88866555576,20,null);
	(98798798733,30,5.0),
	(98765432168,30,20.0),
	