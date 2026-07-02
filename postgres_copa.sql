CREATE TABLE estadios (
    id_estadio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    capacidade INT NOT NULL
);

CREATE TABLE selecoes (
    id_selecao SERIAL PRIMARY KEY,
    pais VARCHAR(60) NOT NULL UNIQUE,
    grupo CHAR(1) NOT NULL,
    tecnico VARCHAR(100)
);

CREATE TABLE jogadores (
    id_jogador SERIAL PRIMARY KEY,
    id_selecao INT REFERENCES selecoes(id_selecao) ON DELETE CASCADE,
    nome VARCHAR(100) NOT NULL,
    posicao VARCHAR(30) NOT NULL,
    numero_camisa INT,
    idade INT
);

CREATE TABLE partidas (
    id_partida SERIAL PRIMARY KEY,
    id_estadio INT REFERENCES estadios(id_estadio),
    id_mandante INT REFERENCES selecoes(id_selecao),
    id_visitante INT REFERENCES selecoes(id_selecao),
    data_hora TIMESTAMP NOT NULL,
    fase VARCHAR(30) NOT NULL,
    gols_mandante INT DEFAULT 0,
    gols_visitante INT DEFAULT 0
);

CREATE TABLE estatisticas_jogadores (
    id_estatistica SERIAL PRIMARY KEY,
    id_partida INT REFERENCES partidas(id_partida) ON DELETE CASCADE,
    id_jogador INT REFERENCES jogadores(id_jogador) ON DELETE CASCADE,
    gols INT DEFAULT 0,
    assistencias INT DEFAULT 0,
    cartoes_amarelos INT DEFAULT 0,
    cartoes_vermelhos INT DEFAULT 0
);

INSERT INTO estadios (nome, city, capacidade) VALUES -- Nota: Ajustado erro de digitação de coluna na prática
-- Correção visual para o script rodar liso:
INSERT INTO estadios (nome, cidade, capacidade) VALUES
('Lusail Stadium', 'Lusail', 88966),
('Al Bayt Stadium', 'Al Khor', 68895);

INSERT INTO selecoes (pais, grupo, tecnico) VALUES
('Argentina', 'C', 'Lionel Scaloni'),
('França', 'D', 'Didier Deschamps'),
('Brasil', 'G', 'Carlo Ancelotti');

INSERT INTO jogadores (id_selecao, nome, posicao, numero_camisa, idade) VALUES
(1, 'Lionel Messi', 'Atacante', 10, 39),
(1, 'Ángel Di María', 'Meio-Campista', 11, 38),
(2, 'Kylian Mbappé', 'Atacante', 10, 27),
(3, 'Vinicius Junior', 'Atacante', 7, 27);

INSERT INTO partidas (id_estadio, id_mandante, id_visitante, data_hora, fase, gols_mandante, gols_visitante) VALUES
(1, 1, 2, '2022-12-18 18:00:00', 'Final', 3, 3);

INSERT INTO estatisticas_jogadores (id_partida, id_jogador, gols, assistencias, cartoes_amarelos) VALUES
(1, 1, 2, 0, 0),
(1, 2, 1, 0, 0),
(1, 3, 3, 0, 0);

SELECT 
    p.id_partida,
    p.fase,
    p.data_hora::DATE as data_jogo,
    sel_m.pais AS mandante,
    p.gols_mandante,
    p.gols_visitante,
    sel_v.pais AS visitante,
    e.nome AS estadio
FROM partidas p
JOIN selecoes sel_m ON p.id_mandante = sel_m.id_selecao
JOIN selecoes sel_v ON p.id_visitante = sel_v.id_selecao
JOIN estadios e ON p.id_estadio = e.id_estadio;

SELECT 
    j.nome AS jogador,
    s.pais AS selecao,
    SUM(ej.gols) AS total_gols
FROM estatisticas_jogadores ej
JOIN jogadores j ON ej.id_jogador = j.id_jogador
JOIN selecoes s ON j.id_selecao = s.id_selecao
GROUP BY j.nome, s.pais
HAVING SUM(ej.gols) > 0
ORDER BY total_gols DESC;

CREATE INDEX idx_partidas_data ON partidas(data_hora);
CREATE INDEX idx_jogadores_selecao ON jogadores(id_selecao);

CREATE OR REPLACE FUNCTION total_gols_selecao(p_id_selecao INT)
RETURNS INT AS $$
DECLARE
    v_total_gols INT;
BEGIN
    SELECT COALESCE(SUM(ej.gols), 0) INTO v_total_gols
    FROM estatisticas_jogadores ej
    JOIN jogadores j ON ej.id_jogador = j.id_jogador
    WHERE j.id_selecao = p_id_selecao;
    
    RETURN v_total_gols;
END;
$$ LANGUAGE plpgsql;
