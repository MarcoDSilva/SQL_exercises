`2.1 - todos os dados dos medicos`
select * from medico;

`2.2 - todos os dados das consultas medicas`
select * from consulta_medica;

`2.3 - nome e contactos dos utentes`
select nome, telefone, telemovel from utente;

`2.4 - numero de consultas e data `
select data_hora, codigo, utente from consulta_medica;

`2.5 - selecione o utente e medico, e veja porque aparece(ou nao)`
select utente, medico from consulta_medica;

`selecionar o nome e utente das consultas, em vez dos ids`
select utente.nome , medico.nome from consulta_medica 
INNER JOIN utente ON utente.nome = consulta_medica.utente
INNER JOIN medico ON medico.nome = consulta_medica.medico;

`3.1 - medicos nascidos apos 10 dez 1969`
select * from medico where data_nascimento > "1969-12-10";

`3.2 - medico com atividade iniciada entre 2005 e 2009`
select * from medico where data_inicio_atividade between "2005-01-01" and "2009-12-31";

`3.3 - utentes com nacionalidade portuguesa`
select * from utente where nacionalidade = "Portuguesa";

`3.4 - utentes cujo primeiro nome é Maria`
select * from utente where nome like "Maria %";

`3.5 - utentes cujo nome de familia é Santoro`
select * from utente where nome like "% Santoro";

`3.6 - utentes com nome Galvão em qualquer parte do nome`
select * from utente where nome like "% Galvão %";

`3.7 - utentes que moren na rua trás, com ou sem acento`
select * from utente where morada like "%tras%" 'or morada like "%trás%";

''bloquear os acentos na pesquisa, fazendo que só elementos com o acento surjam'

select * from utente where morada like "%trás" COLLATE utf8_bin;