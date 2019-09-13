`Marco Silva n09`

`1.1 - login no my mysql `
\. criacao_database_postais.sql

`2.1 - todos postais existentes`
SELECT p.codigo, t.designacao
FROM postal p, tipo t
WHERE p.codigo = t.codigo;

`2.2 - postais oferecidos sem repetição`
SELECT distinct p.tipo, t.designacao
FROM postal p, tipo t , oferta o 
WHERE p.tipo = t.codigo 
AND o.postal = p.codigo;

`2.3 - quantidade postais cada pessoa recebeu`
select r.nome, count(o.recetor) as total_recebido 
from oferta o, recetor r
where r.codigo = o.recetor
group by r.codigo;

`2.4 - quais os postais mais oferecidos`
`não sei se pretendia algo do género top 3`
select count(o.postal) as mais_oferecidos, t.designacao as tipo_de_postal
from oferta o, postal p, tipo t
where o.postal = p.codigo
and p.codigo = t.codigo
group by t.designacao
limit 3;

`2.5 - se cada postal custar 0.50, qual foi o valor gasto por cada pessoa`
select count(o.oferecedor) * 0.5 as custo_total, ofr.nome
from oferta o, oferecedor ofr
where o.oferecedor = ofr.codigo
group by ofr.nome;

`2.6 - liste quanto cada pessoa gastou por época em postais`
select t.designacao epoca, sum(preco_compra) as total
from tipo t
	INNER JOIN postal p ON t.codigo = p.tipo 
	INNER JOIN oferta o ON o.postal = p.codigo
GROUP BY t.designacao; 


`2.7 - qual o ano em que mais dinheiro se gastou`
select year(o.data_hora) as ano, sum(t.preco_compra) as preco_gasto 
from oferta o
	INNER JOIN postal p ON o.postal = p.codigo
	INNER JOIN tipo t ON p.tipo = t.codigo
GROUP by year(o.data_hora)
ORDER BY ano desc;


`2.8 - listagem de todos os postais oferecidos em agosto`
SELECT t.designacao, o.data_hora
FROM tipo t
	INNER JOIN postal p ON t.codigo = p.tipo
	INNER JOIN oferta o ON o.postal = p.codigo
WHERE month(data_hora) = 8;

`2.9 - liste todos os postais recebidos entre 21-12-2016 e 28-12-2016`
SELECT * from oferta
WHERE year(data_hora) = 2016 
AND month(data_hora) = 12 
AND day(data_hora) BETWEEN 21 and 28;


`2.10 - quais as pessoas sem telefone`
SELECT o.nome, o.contacto
FROM oferecedor o
WHERE o.contacto is null
UNION 
SELECT r.nome, r.contacto
FROM recetor r
WHERE r.contacto is null;

`2.11 - quais as ofertas efectuadas nos dias 2,6,18, com 1 op de comparação???`
SELECT * FROM oferta
WHERE day(data_hora) IN (2,6,19);

`3.1 - remova todas as ofertas efectuadas antes do ano 2017`
DELETE FROM oferta WHERE year(data_hora) < 2017;

`4.1 inserir dados`
`inserir filha para ofereder ao pai (oferecedor e recebedor) e a mae (recebedor)`

INSERT INTO oferecedor(nome, morada, contacto) values ('Filha Nicas', 'rua do truka truka', NULL);
INSERT INTO oferecedor(nome, morada, contacto) values ('Pai Neca', 'Rua do pumba pumba', 92999999);
INSERT INTO recetor(nome, morada, contacto) values ('Pai Neca', 'Rua do pumba pumba', 92999999);
INSERT INTO recetor(nome,morada, contacto) values ('Mae Mica', 'Rua do pumba pumba', 999999999);

`enviar da filha para o pai, e do pai para a mae`

INSERT INTO oferta(data_hora, oferecedor, recetor, postal) values ('2018-07-12', 10, 8, 7);
INSERT INTO oferta(data_hora, oferecedor, recetor, postal) values ('2018-08-12', 9, 7, 7);

`verificar com nomes, e ano`

select o.codigo, ofr.nome, r.nome, p.ano, t.designacao
from oferta o
	INNER JOIN oferecedor ofr ON o.oferecedor = ofr.codigo
	INNER JOIN recetor r ON o.recetor = r.codigo
	INNER JOIN postal p ON p.codigo = o.postal
	INNER JOIN tipo t ON p.tipo = t.codigo;


`5.1 - actualizar dados`
UPDATE tipo 
SET preco_compra = preco_compra + 0.2
WHERE tipo.codigo IS NOT NULL;


`6.1 - view lista_postais_oferecidos com lista dos postais existentes`
CREATE VIEW lista_postais_oferecidos AS 
	SELECT t.designacao, p.tipo
	FROM tipo t, postal p
	WHERE p.codigo = t.codigo;


`6.2 - view lista_postais_sem_repeticao com lista de todos os postais oferecidos sem repetir`
CREATE VIEW lista_postais_sem_repeticao AS
	SELECT distinct p.tipo, t.designacao postais_oferecidos
	FROM postal p, tipo t , oferta o 
	WHERE p.tipo = t.codigo 
	AND o.postal = p.codigo;