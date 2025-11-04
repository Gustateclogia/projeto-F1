CREATE DATABASE F11;
USE F11;
CREATE TABLE PAIS (
    id_pais INT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL
);

-- Tabela CAMPEONATO
CREATE TABLE CAMPEONATO (
    id_campeonato INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    ano INT UNIQUE NOT NULL CHECK (ano >= 1950)
);

-- Tabela EQUIPE
CREATE TABLE EQUIPE (
    id_equipe INT PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL,
    id_pais_sede INT NOT NULL,
    CONSTRAINT fk_equipe_pais FOREIGN KEY (id_pais_sede) REFERENCES PAIS(id_pais)
);

-- Tabela PILOTO
CREATE TABLE PILOTO (
    id_piloto INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    id_equipe INT NOT NULL,
    id_pais_nacionalidade INT NOT NULL,
    CONSTRAINT fk_piloto_equipe FOREIGN KEY (id_equipe) REFERENCES EQUIPE(id_equipe),
    CONSTRAINT fk_piloto_pais FOREIGN KEY (id_pais_nacionalidade) REFERENCES PAIS(id_pais)
);

-- Tabela GRANDE_PREMIO
CREATE TABLE GRANDE_PREMIO (
    id_gp INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data DATE UNIQUE NOT NULL,
    id_campeonato INT NOT NULL,
    id_pais_realizacao INT NOT NULL,
    CONSTRAINT fk_gp_campeonato FOREIGN KEY (id_campeonato) REFERENCES CAMPEONATO(id_campeonato),
    CONSTRAINT fk_gp_pais FOREIGN KEY (id_pais_realizacao) REFERENCES PAIS(id_pais)
);

-- Tabela RESULTADO_GP (Tabela Associativa para Pontuação)
CREATE TABLE RESULTADO_GP (
    id_piloto INT,
    id_gp INT,
    pontuacao INT NOT NULL DEFAULT 0 CHECK (pontuacao >= 0),
    PRIMARY KEY (id_piloto, id_gp),
    CONSTRAINT fk_resultado_piloto FOREIGN KEY (id_piloto) REFERENCES PILOTO(id_piloto),
    CONSTRAINT fk_resultado_gp FOREIGN KEY (id_gp) REFERENCES GRANDE_PREMIO(id_gp)
);


-- 2. INSERTS (10 REGISTROS EM CADA TABELA)
----------------------------------------------------------------------

-- 2.1 PAIS (10 REGISTROS)
INSERT INTO PAIS (id_pais, nome) VALUES
(1, 'Reino Unido'), (2, 'Alemanha'), (3, 'Itália'), (4, 'Áustria'), (5, 'Brasil'),
(6, 'França'), (7, 'Japão'), (8, 'EUA'), (9, 'Espanha'), (10, 'Canadá');

-- 2.2 CAMPEONATO (10 REGISTROS)
INSERT INTO CAMPEONATO (id_campeonato, nome, ano) VALUES
(202301, 'Fórmula 1 2023', 2023), (202201, 'Fórmula 1 2022', 2022),
(202101, 'Fórmula 1 2021', 2021), (202001, 'Fórmula 1 2020', 2020),
(201901, 'Fórmula 1 2019', 2019), (201801, 'Fórmula 1 2018', 2018),
(201701, 'Fórmula 1 2017', 2017), (201601, 'Fórmula 1 2016', 2016),
(201501, 'Fórmula 1 2015', 2015), (201401, 'Fórmula 1 2014', 2014);

-- 2.3 EQUIPE (10 REGISTROS)
INSERT INTO EQUIPE (id_equipe, nome, id_pais_sede) VALUES
(1, 'Red Bull Racing', 4), (2, 'Mercedes-AMG F1', 2), (3, 'Scuderia Ferrari', 3),
(4, 'McLaren F1 Team', 1), (5, 'Aston Martin F1', 1), (6, 'Alpine F1 Team', 6),
(7, 'AlphaTauri', 3), (8, 'Alfa Romeo F1', 3), (9, 'Haas F1 Team', 8),
(10, 'Williams Racing', 1);

-- 2.4 PILOTO (10 REGISTROS)
INSERT INTO PILOTO (id_piloto, nome, data_nascimento, id_equipe, id_pais_nacionalidade) VALUES
(101, 'Max Verstappen', '1997-09-30', 1, 4), (102, 'Sergio Pérez', '1990-01-26', 1, 5),
(103, 'Lewis Hamilton', '1985-01-07', 2, 1), (104, 'George Russell', '1998-02-15', 2, 1),
(105, 'Charles Leclerc', '1997-10-16', 3, 6), (106, 'Carlos Sainz', '1994-09-01', 3, 9),
(107, 'Lando Norris', '1999-11-13', 4, 1), (108, 'Oscar Piastri', '2001-04-06', 4, 7),
(109, 'Fernando Alonso', '1981-07-29', 5, 9), (110, 'Pierre Gasly', '1996-02-07', 6, 6);

-- 2.5 GRANDE_PREMIO (10 REGISTROS)
INSERT INTO GRANDE_PREMIO (id_gp, nome, data, id_campeonato, id_pais_realizacao) VALUES
(1001, 'GP do Bahrein', '2023-03-05', 202301, 7), (1002, 'GP da Arábia Saudita', '2023-03-19', 202301, 7),
(1003, 'GP da Austrália', '2023-04-02', 202301, 7), (1004, 'GP de Baku', '2023-04-30', 202301, 7),
(1005, 'GP de Miami', '2023-05-07', 202301, 8), (1006, 'GP de Mônaco', '2023-05-28', 202301, 6),
(1007, 'GP do Canadá', '2023-06-18', 202301, 10), (1008, 'GP da Áustria', '2023-07-02', 202301, 4),
(1009, 'GP da Grã-Bretanha', '2023-07-09', 202301, 1), (1010, 'GP da Hungria', '2023-07-23', 202301, 7);

-- 2.6 RESULTADO_GP (10 REGISTROS de participação/pontuação)
-- Resultados do GP do Bahrein (1001) para 10 pilotos
INSERT INTO RESULTADO_GP (id_piloto, id_gp, pontuacao) VALUES
(101, 1001, 25), (102, 1001, 18), (103, 1001, 12), (104, 1001, 10), (105, 1001, 8),
(106, 1001, 6), (107, 1001, 4), (108, 1001, 2), (109, 1001, 1), (110, 1001, 0);


-- 3. COMANDOS DE MANIPULAÇÃO DE DADOS
----------------------------------------------------------------------

-- DELETE; (1 comando)
-- Remove um piloto (ex: Oscar Piastri) que porventura tenha saído da equipe.
DELETE FROM PILOTO WHERE nome = 'Oscar Piastri' AND id_piloto = 108;
-- NOTA: O SGBD deve ser configurado para usar ON DELETE CASCADE nas chaves estrangeiras, caso contrário a linha em RESULTADO_GP impediria a exclusão.
-- Assumindo que o SGBD lida com a exclusão em RESULTADO_GP (ou a linha é removida manualmente/em cascata).

-- UPDATE; (1 comando)
-- Atualiza o nome da equipe 'AlphaTauri' para 'Visa Cash App RB F1 Team' (mudança real)
UPDATE EQUIPE SET nome = 'Visa Cash App RB F1 Team' WHERE nome = 'AlphaTauri';


-- 4. COMANDOS SELECT
----------------------------------------------------------------------

-- SELECT com ORDER BY (1 comando)
-- Listar todos os pilotos ordenados por data de nascimento (do mais jovem ao mais velho)
SELECT nome, data_nascimento FROM PILOTO ORDER BY data_nascimento DESC;

-- SELECT com alguma destas cláusulas (AND, OR, NOT, IN, BETWEEN) (1 comando)
-- Listar os GPs que aconteceram em Março OU em Maio de 2023
SELECT nome, data
FROM GRANDE_PREMIO
WHERE (data BETWEEN '2023-03-01' AND '2023-03-31') OR (data BETWEEN '2023-05-01' AND '2023-05-31')
ORDER BY data;

-- SELECT com INNER JOIN e LIKE; (1 comando)
-- Listar o nome dos pilotos e suas equipes, onde o nome da equipe contém a palavra 'F1'
SELECT
    P.nome AS Nome_Piloto,
    E.nome AS Nome_Equipe
FROM PILOTO P
INNER JOIN EQUIPE E ON P.id_equipe = E.id_equipe
WHERE E.nome LIKE '%F1%';

-- SELECT com INNER JOIN e NOT LIKE. (1 comando)
-- Listar o nome e a pontuação dos pilotos no GP do Bahrein (ID 1001), excluindo pilotos cujo nome comece com 'L'
SELECT
    P.nome AS Nome_Piloto,
    RG.pontuacao,
    GP.nome AS Nome_GP
FROM PILOTO P
INNER JOIN RESULTADO_GP RG ON P.id_piloto = RG.id_piloto
INNER JOIN GRANDE_PREMIO GP ON RG.id_gp = GP.id_gp
WHERE RG.id_gp = 1001 AND P.nome NOT LIKE 'L%';