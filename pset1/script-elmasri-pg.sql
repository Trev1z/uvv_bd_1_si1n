

-- Criação - tabela - funcionarios

create table elmasri.funcionario (
	cpf char(11) primary key,
	primeiro_nome varchar(15) not null,
	nome_meio char(1),
	ultimo_nome varchar(15) not null,
	data_nascimento date,
	endereco varchar(30),
	sexo char(1),
	salario decimal(10, 2),
	cpf_supervisor char(11) references elmasri.funcionario(cpf),
	numero_departamento integer not null
);


-- Comentanrios - colunas

comment on table elmasri.funcionario is 'Tabela - informações - funcionários.';
comment on column elmasri.funcionario.cpf is 'CPF - funcionário - PK da tabela.';
comment on column elmasri.funcionario.primeiro_nome is 'Primeiro nome - funcionário.';
comment on column elmasri.funcionario.nome_meio is 'Inicial - nome do meio.';
comment on column elmasri.funcionario.ultimo_nome is 'Sobrenome - funcionário.';
comment on column elmasri.funcionario.endereco is 'Endereço - funcionário.';
comment on column elmasri.funcionario.sexo is 'Sexo -funcionário.';
comment on column elmasri.funcionario.salario is 'Salário - funcionário.';
comment on column elmasri.funcionario.cpf_supervisor is 'CPF - supervisor - FK - auto-relacionamento.';
comment on column elmasri.funcionario.numero_departamento is 'Número - departamento do funcionário.';

-- Criação - tabela - dependentes - 

create table elmasri.dependente  (
	cpf_funcionario char(11) not null references elmasri.funcionario(cpf),
	nome_dependente varchar(15) not null,
	sexo char(1),
	data_nascimento date,
	parentesco varchar(15),
	primary key(cpf_funcionario, nome_dependente)
);


-- Comentando - tabela dependentes 
comment on table elmasri.dependente is 'Tabela - informações - dependentes dos funcionários.';
comment on column elmasri.dependente.cpf_funcionario is 'CPF - funcionário- PK da tabela - FK tabela funcionário.';
comment on column elmasri.dependente.nome_dependente is 'Nome - dependente - PK desta tabela.';
comment on column elmasri.dependente.sexo is 'Sexo - dependente.';
comment on column elmasri.dependente.data_nascimento is 'Data - nascimento - dependente.'; 
comment on column elmasri.dependente.parentesco is 'Descrição - parentesco entre dependente efuncionário.'; 

-- Criação -  tabela de departamento 


create table elmasri.departamento (
	numero_departamento integer primary key,
	nome_departamento varchar(15) unique not null,
	cpf_gerente char(11) not null references elmasri.funcionario(cpf),
	data_inicio_gerente date
);


-- Comentando a tabela 


comment on table elmasri.departamento is 'Tabela -informaçoẽs dos departamentos.';
comment on column elmasri.departamento.numero_departamento is 'Número - departamento - PK desta tabela.';
comment on column elmasri.departamento.nome_departamento is 'Nome - departamento -único.';
comment on column elmasri.departamento.cpf_gerente is 'CPF - gerente - departamento - FK de funcionários.';
comment on column elmasri.departamento.data_inicio_gerente is 'Data- inicio - gerente';

-- Criando a tabela de localizacoes_departamento 

create table elmasri.localizacoes_departamento (
	numero_departamento integer not null references elmasri.departamento(numero_departamento),
	local varchar(15) not null,
	primary key(numero_departamento, local)
);


-- Comentando a tabela 

comment on table elmasri.localizacoes_departamento is 'Tabela - localizações dos departamentos.';
comment on column elmasri.localizacoes_departamento.numero_departamento is 'Número - departamento - PK desta tabela - FK da tabela departamento.';
comment on column elmasri.localizacoes_departamento.local is 'Localização - departamento - PK desta tabela.';




-- Criação da tabela de projeto 
create table elmasri.projeto (
	numero_projeto integer primary key,
	nome_projeto varchar(15) unique not null,
	local_projeto varchar(15),
	numero_departamento integer not null references elmasri.departamento(numero_departamento)
);
-- Comentando 
comment on table elmasri.projeto is 'Tabela - informações projetos dos departamentos.';
comment on column elmasri.projeto.numero_projeto is 'Número do projeto - PK da tabela.';
comment on column elmasri.projeto.nome_projeto is 'Nome do projeto - único.';
comment on column elmasri.projeto.local_projeto is 'Localização do projeto.';
comment on column elmasri.projeto.numero_departamento is 'Número do departamento -FK para a tabela departamento.';





-- Criaçaõ da tabela trabalha_em
create table elmasri.trabalha_em (
	cpf_funcionario char(11) not null references elmasri.funcionario(cpf),
	numero_projeto integer not null references elmasri.projeto(numero_projeto),
	horas decimal(3,1),
	primary key(cpf_funcionario, numero_projeto)
);
-- Comentando a tabela e as colunas logo após a criação
comment on table elmasri.trabalha_em is ' funcionários trabalham em quais projetos.';
comment on column elmasri.trabalha_em.cpf_funcionario is 'CPF do funcionário- PK desta tabela - FK para a tabela funcionário.';
comment on column elmasri.trabalha_em.numero_projeto is 'Número do projeto-PK desta tabela - FK para a tabela projeto.';
comment on column elmasri.trabalha_em.horas is 'Horas trabalhadas - neste projeto.';







-- Inserindo os dados dos funcionarios 

INSERT INTO elmasri.funcionario
values 
	
	(99988777767, 'Alice','J','Zelaya','1968-01-19','R. Souza Lima,35,Curitiba,PR','F',25000,98765432168,4),
	(98798798733, 'André','V','Pereira','1969-03-29','R. Timbira,35,São Paulo, SP','M',25000,98765432168,4),
	(12345678966,'João','B','Silva','1965-01-09','R. das Flores,751,São Paulo,Sp','M',30000,33344555587,5),
	(88866555576, 'Jorge','E','Brito','1937-11-10','R. do Horto,35,São Paulo,SP','M',55000, null ,1),
	(98765432168, 'Jennifer','S','Souza','1941-06-20','Av. Arthur de Lima,54,S.A,SP','F',43000,88866555576,4),
	(33344555587, 'Fernando','T','Wong','1955-12-08','R. da Lapa,34,São Paulo,SP','M',40000,88866555576,5),
	(66688444476, 'Ronaldo','K','Lima','1962-09-15','R. Rebouças,65,Piracicaba,SP','M',38000,33344555587,5),
	(45345345376, 'Joice','A','Leite','1972-07-31','Av. Lucas Obes,74 São Paulo,SP','F',25000,33344555587,5);

-- Inserindo os dados dos departamentos na tabela 

INSERT INTO elmasri.departamento 
values 
	
    (4, 'Administração',98765432168,'1995-01-01'),
	(5,'Pesquisa',33344555587,'1988-05-22'),
    (1, 'Matriz', 88866555576,'1981-06-19');

-- Inserindo - localizão dos departamentos na tabela 
INSERT INTO elmasri.localizacoes_departamento 
values  
	
    (5,'Itu'),
    (5,'São Paulo');
	(1,'São Paulo'),
    (4,'Mauá'),
    (5,'Santo André'),

-- Inserindo - dados dos projetos na tabela 
INSERT INTO elmasri.projeto 
values  
	
	(10,'Informatização','Mauá',4),
	(1,'ProdutoX','Santo André',5),
	(2,'ProdutoY','Ittu',5),
	(3,'ProdutoZ','São Paulo',5),
	(20,'Reorganização','São Paulo',1),
	(30,'Novosbenefícios','Mauá',4);
     
-- Inserindo os dados dos dependestes dos funcionarios na tabela dependente
INSERT INTO elmasri.dependente 
values  
	(33344555587,'Alicia','F','1986-04-05','filha'),
	(33344555587,'Tiago','M','1983-10-25','filho'),
	(98765432168,'Antonio','M','1942-02-28','marido'),
	(12345678966,'Michael','M','1988-01-04','filho'),
	(33344555587,'Janaína','F','1958-05-03','esposa'),
	(12345678966,'Alicia','F','1988-12-30','filha'),
	(12345678966,'Elizabeth','F','1967-05-05','esposa');

-- Inserindo os dados de onde projeto o funcionario atua e quantas horas na tabela trabalha_em
INSERT INTO elmasri.trabalha_em 
values
	(12345678966,1,32.5),
	(12345678966,2,7.5),
	(66688444476,3,40.0),
	(45345345376,1,20.0),
	(45345345376,2,20.0),
	(99988777767,30,30.0),
	(99988777767,10,10.0),
	(98798798733,10,35.0),
	(98798798733,30,5.0),
	(98765432168,30,20.0),
	(98765432168,20,15.0),
	(88866555576,20,null);
	(33344555587,2,10.0),
	(33344555587,3,10.0),
	(33344555587,10,10.0),
	(33344555587,20,10.0),
	