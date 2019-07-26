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

`3.10 - todas as consultas não realizadas`

SELECT * FROM consulta_medica WHERE NOT realizada;

`3.11 - mostre todas as consultas que se realizaram fora do periodo de 2015/06/12 a 2016/07/29`

SELECT * FROM consulta_medica WHERE data_hora NOT BETWEEN "2015-06-12" AND "2016-07-19";

`3.12 - mostre todos os utentes portugueses e espanhóis`
SELECT * FROM utente WHERE nacionalidade in ("portuguesa", "espanhola");

`3.13 - mostra todos os utentes que não tem telefone ou não tem telemóvel`
SELECT * FROM utente WHERE telefone is NULL or telemovel IS NULL;

`3.14 - lista os utentes que tem telefone e telemovel`
SELECT * FROM utente WHERE telefone is NOT NULL AND telemovel IS NOT NULL;

`4.1 - listar consultas por ordem ascendente da data`
SELECT * FROM consulta_medica order by data_hora ASC:

`4.2 - listar medicos, ordenado pelo nome de forma ascendente e em caso de colisão, pela data de nascimento asc`
SELECT * FROM medico order by nome asc and order by data_nascimento asc;
SELECT * FROM medico order by nome asc, data_nascimento asc;

`5.1- Todas as especialidades são influenciadas em 5% no preço` 
SELECT especialidade_codigo, especialidade_designacao, (especialidade_preco * 1.05) as especialidade_preco_inflacionado from especialidade order by especialidade_preco_inflacionado asc;

`5.2 - liste o iva de cada uma das especialidades, considerando que cada especialidade teria uma taxa de 23%`
select especialidade_codigo, especialidade_designacao, especialidade_preco, (especialidade_preco - especialidade_preco / 1.23) as IVA from especialidade;

`6.1 - liste as datas e apenas as datas de todas as consultas de 2015`
select date(data_year) from consulta_medica where year(data_hora) = 2015;

`6.2 - liste todas as horas (apenas as horas) das consultas realizadas no segundo semestre `
select hour(data_hora) from consulta_medica where year(data_hora) = 2015 and month(data_year) between 6 and 12;

`6.3 - liste os utentes (codigo) que tenham sido consultados apos as 17h`
select codigo, data_hora from consulta_medica where hour(data_hora) >= 17;

`6.4 - liste o nome e num de telefone de cada utente, se não tiver telefone , resultado = sem telefone`
select nome, ifnull(telefone, "sem telefone") as telefone from utente;

`6.5 - Liste o nome de todos os utentes com o respectivo nif , ex : "José moreira - nif xxxxxxxx"`
select concat(nome, " - ", nif) as agregado_nome_nif from utente;

`6.6 - liste o ultimo dia do mes em que cada utente faz anos`
select nome, day(last_day(data_nascimento)) as "Ultimo dia do mes do ano de nascimento" from utente;

`6.7 - Mostre todas as consultas com excepção dos dias 2 e 10 sept e 2 de março.`
select * from consulta_medica where date(data_hora) not in ("2015-09-10", "2015-09-02", "2015-03-02");

`6.8 - mostre todas as consultas que ocorrem nos dias 13 e 22 julho de qualquer ano e ainda dia 21 outubro`
select * from consulta_medica where day(data_hora) in (13,21,22) and month(data_hora) = 07 or date(data_hora) = "2015-10-21";

`7.1 - calcule a idade de todos os utentes`
select nome, floor(datediff(now(), date(data_nascimento)) / 365) as idade from utente;

`7.2 - formatar , numero utente, nome e idade`
select numero_utente, nome, concat(floor(datediff(now(), date(data_nascimento)) / 365), ' anos') as idade from utente;

`7.3 - listar especialidades em que se o preço da especialidade é inferior a 68€, é influenciada a 7%`
select especialidade_designacao, if(especialidade_preco < 68, especialidade_preco * 1.07, especialidade_preco) as preco from especialidade;

`8.1 - liste o nome e código de todos os utentes consultados`
select utente.nome as nome, consulta_medica.utente as codigo_utente, 
consulta_medica.codigo as codigo_consulta from consulta_medica
INNER JOIN utente on utente.numero_utente = consulta_medica.utente;
`8.2 - mostre o código e o nome de todos os utentes consultados sem repetidos`

`TOFIX`

`9.1 - mostre as 3 primeiras consultas feitas na clinica`
select * from consulta_medica limit 0, 3;

`9.2 - faça uma lista da terceira e quarta consulta médica do ano 2015`
select * from consulta_medica where year(data_hora) = 2015 limit 2,2;

`10.1 - mostre o nome da especialidade de cada médico`
select medico.nome , especialidade.especialidade_designacao from medico, especialidade 
where especialidade.especialidade_codigo = medico.especialidade;

select nome, especialidade_designacao from especialidade 
JOIN medico ON(especialidade.especialidade_codigo = medico.especialidade);

`10.2 - mostrar quanto custou cada consulta`
select consulta_medica.codigo, consulta_medica.data_hora, consulta_medica.utente, consulta_medica.sala, especialidade.especialidade_preco as precario, 
medico.nome from consulta_medica, especialidade, medico
where consulta_medica.medico = medico.numero_ordem and medico.especialidade = especialidade.especialidade_codigo;

`10.3 - especialidade em que cada utente foi consultado`
`select codigo, data_hora, utente.nome, medico.nome, sala, especialidade_designacao from consulta_medica
JOIN especialidade ON(especialidade.especialidade_codigo = medico.especialidade);


select nome, data_hora, sala, especialidade_designacao from utente
JOIN consulta_medica ON(especialidade.utente = utente.nome)
JOIN especialidade ON(especialidade_designacao = consul)`
