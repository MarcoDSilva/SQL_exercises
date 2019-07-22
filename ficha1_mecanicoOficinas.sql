`2.1 - listar todos os proprietarios`
select * from proprietario;

`2.2 - listar todos os dados das intervencoes`
select * from intervencao;

`2.3 - nome e contactos dos mecanicos`
select nome, contacto from mecanico;

`3.1, - todas as invertencoes depois de 10 dezembro de 2010`
select * from intervencao where data_hora > "2010/12/10";

`3.2 - todos os proprietarios cujo primeiro nome é Pedro`
select * from proprietario where nome like "Pedro%";

`3.3 - todas as intervencoes realizadas entre dia 5 marco 2015 e 9 set 2015`
select * from intervencao where data_hora between "2015-3-5" and "2015-09-09";

`3.4 - todas as intervencoes que não se realizaram`
select * from intervencao where NOT realizou-se;

`3.5 - todas as intervencoes fora do periodo de 12 junho 2015 e 20 julho 2016`
select * from intervencao where	 data_hora	not between	"2015-6-12" and "2016-7-29";

`3.6 - todos os proprietarios que moram na rua 2 e rua 6`
select * from proprietario	where morada = "Rua 6" or morada = "Rua 2";

`3.7 - todos os proprietarios que não tem contacto`
select * from proprietario	 where contacto is NULL;

`4.1 - todos os proprietarios ordenados por nome`
select * from proprietario	order by nome;
select * from proprietario	order by nome asc;
select * from proprietario	order by nome desc;

