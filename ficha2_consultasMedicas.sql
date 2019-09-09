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

select codigo, U.nome nome, data_hora, especialidade_designacao 
FROM utente U, especialidade E, medico M, consulta_medica C 
WHERE U.numero_utente = C.utente 
AND E.especialidade_codigo = M.especialidade
AND C.medico = M.numero_ordem
AND C.realizada = 1;

`10.4 - mostre os utentes e médicos que moram na mesma localidade`

select U.nome, M.nome, U.codigo_postal
FROM utente U, medico M
WHERE U.codigo_postal = M.codigo_postal;


`10.5. Faça uma listagem das consultas médicas com indicação dos nomes do médico e da utente e ainda o preço da consulta.`

select c.codigo consulta, u.nome utente , m.nome medico, e.especialidade_preco
FROM consulta_medica c, utente u, medico m, especialidade e
WHERE u.numero_utente = c.utente
AND e.especialidade_codigo = m.especialidade
AND m.numero_ordem = c.medico
AND c.realizada = 1;

`10.6. Mostre o nome de todos os utentes que pagaram mais que 69,00 € por uma consulta.`

select c.codigo consulta, u.nome utente, e.especialidade_preco preco
FROM consulta_medica c, utente u, especialidade e, medico m
WHERE u.numero_utente = c.utente
	AND e.especialidade_codigo = m.especialidade
	AND m.numero_ordem = c.medico
	AND e.especialidade_preco >= 69;

`10.7. Mostre o nome dos utentes que foram consultados a “PEDIATRIA”. `

select c.codigo consulta, u.nome utente, e.especialidade_designacao
FROM consulta_medica c, utente u, especialidade e, medico m
WHERE u.numero_utente = c.utente 
	AND m.numero_ordem = c.medico
	AND m.especialidade = e.especialidade_codigo
	AND e.especialidade_designacao in ('pediatria');


`10.8. Algum utente com nome “Santoro” teve consulta de “GINECOLOGIA”?`
SELECT c.codigo consulta, u.nome utente, e.especialidade_designacao
FROM consulta_medica c, utente u, especialidade e, medico m
WHERE u.numero_utente = c.utente
	AND m.numero_ordem = c.medico
	AND m.especialidade = e.especialidade_codigo
	AND e.especialidade_designacao in ('GINECOLOGIA')
	AND u.nome like '%Santoro%'; 


`10.9. Qual dos “Santoro” pagaram a consulta mais alta?`
SELECT c.codigo consulta, u.nome utente, e.especialidade_preco preco_max
FROM consulta_medica c, utente u, especialidade e, medico m
WHERE u.numero_utente = c.utente
	AND m.numero_ordem = c.medico
	AND m.especialidade = e.especialidade_codigo
	AND u.nome like '%Santoro%'
	ORDER BY e.especialidade_preco desc limit 1;

`10.10. Quais os nomes dos médicos, que viram as suas consultas não se realizarem?`

select c.codigo consulta, m.nome, c.realizada
FROM consulta_medica c, medico m
WHERE m.numero_ordem = c.medico
	AND NOT c.realizada;


`11.1. Mostre o nome da especialidade de cada médico.`
SELECT m.nome , e.especialidade_designacao 
FROM medico m
	INNER JOIN especialidade e on e.especialidade_codigo = m.especialidade;

`11.2. Mostre quanto custou cada consulta.`
codigo , preco 
consulta , medico, especialidade

SELECT c.codigo, e.especialidade_preco
FROM consulta_medica c
	INNER JOIN medico m ON m.numero_ordem = c.medico
	INNER JOIN especialidade e ON e.especialidade_codigo = m.especialidade;

`11.3. Mostre a especialidade que cada utente foi consultado.`

SELECT c.codigo, u.nome, e.especialidade_designacao
FROM utente u
	INNER JOIN consulta_medica c ON u.numero_utente = c.utente
	INNER JOIN medico m ON m.numero_ordem = c.medico
	INNER JOIN especialidade e ON e.especialidade_codigo = m.especialidade
WHERE c.realizada = 1;

`11.4. Mostre os utentes e médicos que moram na mesma localidade.`
SELECT u.nome, m.nome , u.codigo_postal
FROM utente u
	INNER JOIN medico m ON m.codigo_postal = u.codigo_postal;

`11.5. Faça uma listagem das consultas médicas com indicação dos nomes do médico e da utente e ainda o preço da consulta.`
SELECT c.codigo , u.nome, m.nome , e.especialidade_preco
FROM utente u
	INNER JOIN consulta_medica c ON u.numero_utente = c.utente
	INNER JOIN medico m ON m.numero_ordem = c.medico
	INNER JOIN especialidade e ON e.especialidade_codigo = m.especialidade;

`11.6. Mostre o nome de todos os utentes que pagaram mais que 69,00 € por uma consulta.`
SELECT c.codigo, u.nome , e.especialidade_preco
FROM utente u
	INNER JOIN consulta_medica c ON u.numero_utente = c.utente
	INNER JOIN medico m ON m.numero_ordem = c.medico
	INNER JOIN especialidade e ON e.especialidade_codigo = m.especialidade
WHERE e.especialidade_preco > 69;


`11.7. Mostre o nome dos utentes que foram consultados a “PEDIATRIA”.`
SELECT c.codigo, u.nome, e.especialidade_designacao
FROM utente u
	INNER JOIN consulta_medica c ON u.numero_utente = c.utente
	INNER JOIN medico m ON m.numero_ordem = c.medico
	INNER JOIN especialidade e ON e.especialidade_codigo = m.especialidade
WHERE e.especialidade_designacao = 'pediatria';


`11.8. Algum utente com nome “Santoro” teve consulta de “GINECOLOGIA”?`
SELECT c.codigo, u.nome, e.especialidade_designacao
FROM utente u
	INNER JOIN consulta_medica c ON u.numero_utente = c.utente
	INNER JOIN medico m ON m.numero_ordem = c.medico
	INNER JOIN especialidade e ON e.especialidade_codigo = m.especialidade
WHERE u.nome like '%santoro%'
AND e.especialidade_designacao = 'GINECOLOGIA';


`11.9. Qual dos “Santoro” pagaram a consulta mais alta?`
SELECT c.codigo, u.nome, e.especialidade_preco
FROM utente u
	INNER JOIN consulta_medica c ON u.numero_utente = c.utente
	INNER JOIN medico m ON m.numero_ordem = c.medico
	INNER JOIN especialidade e ON e.especialidade_codigo = m.especialidade
WHERE u.nome like '%santoro%'
ORDER BY e.especialidade_preco desc limit 1;

`11.10. Quais os nomes dos médicos, que viram as suas consultas não se realizarem?`
SELECT c.codigo, m.nome, c.realizada
FROM consulta_medica c
	INNER JOIN medico m ON m.numero_ordem = c.medico 
	INNER JOIN especialidade e ON e.especialidade_codigo = m.especialidade
WHERE NOT c.realizada;


`OUTER JOINS`
`12.1. Mostre todas as localidades com os respetivos utentes que lá residem.`
SELECT cp.localidade, u.nome, cp.codigo_postal
FROM codigo_postal cp 
	LEFT JOIN utente u 
	ON cp.codigo_postal = u.codigo_postal;

`12.2. Liste todos os utentes (nome e data de nascimento) e a data de cada uma das consultas que estes tiveram.`

SELECT u.nome, u.data_nascimento, c.data_hora
FROM utente u
	RIGHT JOIN consulta_medica c 
	ON u.numero_utente = c.utente;

SELECT u.nome, u.data_nascimento, c.data_hora
FROM utente u
	LEFT JOIN consulta_medica c 
	ON u.numero_utente = c.utente;

`12.3. Mostre todas as localidades cujos seus utentes nunca fizeram nenhuma consulta.`
utente nome , consulta realizada 

SELECT cp.localidade, c.realizada consulta
FROM utente u 
	LEFT JOIN consulta_medica c
	ON u.numero_utente = c.utente
	LEFT JOIN codigo_postal cp 
	ON u.codigo_postal = cp.codigo_postal
WHERE NOT c.realizada;

`12.4. Mostre todos os utentes que nunca tiveram nenhuma consulta.`
SELECT u.nome, c.realizada consulta 
FROM utente u
	LEFT JOIN consulta_medica c 
	ON u.numero_utente = c.utente 
	WHERE NOT c.realizada;

`UNIONS`
`13.1. Liste o nome e o código postal de todos os utentes e de todos os médicos na mesma consulta`
SELECT u.nome, u.codigo_postal
FROM utente u
UNION 
SELECT m.nome, m.codigo_postal
FROM medico m;


`13.2. Liste todos os códigos postais usados por utentes e médicos, sem repetições.`
SELECT u.codigo_postal
FROM utente u 
UNION
select m.codigo_postal
FROM medico m;


`agregação`
`14.1. Quantos utentes estão registados na clinica?`
SELECT count(u.numero_utente) as total_de_utentes
FROM utente u;

`14.2. Quantos utentes já tiveram consultas?`
SELECT  count(c.realizada) as total_consultados
FROM consulta_medica c
WHERE c.realizada
GROUP BY c.realizada;

`14.3. Quanto cada utente já despendeu em consultas?`
SELECT u.nome, sum(e.especialidade_preco) as preco 
FROM utente u
INNER JOIN consulta_medica c ON c.utente = u.numero_utente
INNER JOIN medico m ON m.numero_ordem = c.medico
INNER JOIN especialidade e ON m.especialidade = e.especialidade_codigo
GROUP BY u.nome;

`14.4. Quanto cada médico já contribuiu para o lucro da clinica?`
SELECT m.nome, sum(e.especialidade_preco) as preco 
FROM medico m
INNER JOIN consulta_medica c ON c.medico = m.numero_ordem
INNER JOIN especialidade e ON m.especialidade = e.especialidade_codigo
GROUP BY m.nome;


`14.5. Quantos utentes não têm telefone?`
SELECT count(1) as utentes_sem_telefone
FROM utente u
WHERE u.telefone IS NULL;

SELECT count(u.nome) as utentes_sem_telefone
FROM utente u
WHERE u.telefone IS NULL;

`14.6. Qual é a média de gastos de cada utente?`
SELECT u.nome, avg(e.especialidade_preco) as preco 
FROM utente u
INNER JOIN consulta_medica c ON c.utente = u.numero_utente
INNER JOIN medico m ON m.numero_ordem = c.medico
INNER JOIN especialidade e ON m.especialidade = e.especialidade_codigo
GROUP BY u.nome;

`14.7. Qual o melhor médico, em termos financeiros?`
SELECT m.nome, sum(e.especialidade_preco) as preco 
FROM medico m
	INNER JOIN consulta_medica c ON c.medico = m.numero_ordem
	INNER JOIN especialidade e ON m.especialidade = e.especialidade_codigo
GROUP BY m.nome 
HAVING preco = (
				SELECT MAX(ganhos_maximos.preco) as abc
				FROM (
					SELECT m.nome, sum(e.especialidade_preco) as preco 
					FROM medico m
						INNER JOIN consulta_medica c ON c.medico = m.numero_ordem
						INNER JOIN especialidade e ON m.especialidade = e.especialidade_codigo
					GROUP BY m.nome) 
					ganhos_maximos
				);


`14.8. Quanto já rendeu cada especialidade?`
SELECT e.especialidade_designacao, sum(e.especialidade_preco) AS total_rendimento
FROM especialidade e
	INNER JOIN medico m ON e.especialidade_codigo = m.especialidade
	INNER JOIN consulta_medica c ON c.medico = m.numero_ordem
GROUP BY e.especialidade_codigo;

`14.9. Qual o resultado bruto da clinica?`
SELECT SUM(e.especialidade_preco) AS total_bruto
FROM especialidade e 
	INNER JOIN medico m ON e.especialidade_codigo = m.especialidade
	INNER JOIN consulta_medica c ON c.medico = m.numero_ordem;

`14.10. Obtenha a lista de todos os utentes consultados, em que o nome apareça repetido 3 vezes.`
SELECT u.nome
FROM consulta_medica c 
	INNER JOIN utente u ON c.utente = u.numero_utente
GROUP BY u.nome
HAVING count(u.nome) = 3;

`14.11. Sabendo que 23% do valor arrecadado pela clinica é IVA, qual o valor real que a clinica recebeu?`
SELECT SUM((e.especialidade_preco) / 1.23) AS total_apos_iva
FROM especialidade e 
	INNER JOIN medico m ON e.especialidade_codigo = m.especialidade
	INNER JOIN consulta_medica c ON c.medico = m.numero_ordem;

`14.12. Sabendo que apenas 20% do valor recebido pela clinica é que é lucro, calcule até ao momento o lucro da instituição.`

SELECT SUM(e.especialidade_preco) - SUM((e.especialidade_preco) * 0.80) AS total_apos_desconto
FROM especialidade e 
	INNER JOIN medico m ON e.especialidade_codigo = m.especialidade
	INNER JOIN consulta_medica c ON c.medico = m.numero_ordem;

`14.13. Qual o médico que mais consultas deu?`
SELECT m.nome, count(c.medico) as consultas_dadas 
FROM medico m
	INNER JOIN consulta_medica c ON c.medico = m.numero_ordem
GROUP BY c.medico;


`14.14. Qual o utente que menos consultas realizadas?`
SELECT u.nome, count(c.utente) as consultas_obtidas
FROM utente u 
	INNER JOIN consulta_medica c ON c.utente = u.numero_utente
GROUP BY c.utente
ORDER BY consultas_obtidas asc limit 1;


`14.15. Quais as especialidades que tem mais consultas não realizadas?`
SELECT e.especialidade_designacao, count(c.realizada) faltas
FROM especialidade e 
	INNER JOIN medico m ON e.especialidade_codigo = m.especialidade
	INNER JOIN consulta_medica c ON c.medico = m.numero_ordem
WHERE c.realizada = 0
GROUP BY e.especialidade_designacao;

`14.16. Consultas canceladas após as 18:00, têm uma taxa de 2,00€. Qual o valor que cada utente tem a pagar?`

SELECT c.data_hora, concat(c.realizada * 2, " euros") as multa, u.nome
FROM consulta_medica c
	INNER JOIN utente u ON u.numero_utente = c.utente
WHERE hour(c.data_hora) >= 18 AND realizada = 0;

`14.17. Quantas pessoas têm “Galvão”, com e sem acento no seu nome?`

`14.18. Calcule o total de consultas por utente e por especialidade.`
`14.19. Quantos utentes que não têm telefone já tiveram consulta a “Ginecologia”?`
