--- 1
SELECT
	genero,
	SUM(quantidadeFilmes) ,
	SUM(totalHora)
FROM
	(
		SELECT 
			genero.nome genero,
			count(*) quantidadeFilmes,
			SUM(filme.duracao) totalHora
		FROM
			FILME 
			inner join filmegenero on filmegenero.filmeId = filme.id
			inner join genero on genero.id = filmegenero.generoId
		WHERE
			YEAR(filme.dataLancamento) >= YEAR(GETDATE())
		GROUP by
			genero.nome
	UNION
		SELECT 
			genero.nome genero,
			count(*) quantidadeFilmes,
			SUM(filme.duracao) totalHora
		FROM
			FILME 
			inner join filmegenero on filmegenero.filmeId = filme.id
			inner join genero on genero.id = filmegenero.generoId
		WHERE
			YEAR(filme.dataLancamento) <= YEAR(DATEADD(year, 0,(select min(filme.dataLancamento) from filme)))
		GROUP by
			genero.nome
) TEMP
GROUP BY
	genero;

--- 2
    SELECT 
        filme.nome
    from 
        filme
MINUS--sqlserver deve usar o EXCEPT
    SELECT
        filme.nome
    FROM
        filme
        left join filmesAssistidos on filmesAssistidos.filmeId = filme.id
    WHERE
        filmesAssistidos.dataAssistido > '2020-09-01 17:00:00.000';


-- 3
SELECT 
	*
FROM 
	FILME
WHERE 
	id in (
			SELECT
				filmeId
			from 
				ator
				right join atorFilme on atorFilme.atorId = ator.id
			WHERE
				genero = 3
		UNION
			SELECT
				filmeId
			from 
				diretor
				right join Filme on Filme.diretorId = diretor.id
			WHERE
				genero = 3
	)

--- select 4
SELECT 
	perfil.*
FROM 
	filmesAssistidos
	inner join perfil on perfil.id = filmesAssistidos.perfilId
WHERE 
	filmesAssistidos.filmeId in (
			SELECT
				filmeId
			from 
				ator
				right join atorFilme on atorFilme.atorId = ator.id
			WHERE
				genero = 3
		INTERSECT
			SELECT
				filmeId
			from 
				diretor
				right join Filme on Filme.diretorId = diretor.id
			WHERE
				genero = 3
	)
	and perfil.principal = 0

	
--- select 5
SELECT 
	conta.Nome,
	DATEDIFF(YY, conta.dataNascimento, GETDATE()) idade
FROM 
	filmesAssistidos
	inner join perfil on perfil.id = filmesAssistidos.perfilId
	inner join conta on conta.id = perfil.contaId
WHERE 
	filmesAssistidos.filmeId in (
			SELECT
				filmeId
			from 
				ator
				right join atorFilme on atorFilme.atorId = ator.id
			WHERE
				genero <> 3
		UNION
			SELECT
				filmeId
			from 
				diretor
				right join Filme on Filme.diretorId = diretor.id
			WHERE
				genero <> 3
	)
	and DATEDIFF(YY, conta.dataNascimento, GETDATE()) > 25
GROUP BY 
	conta.Nome,
	DATEDIFF(YY, conta.dataNascimento, GETDATE()) 

	
