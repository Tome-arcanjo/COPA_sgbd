CREATE TABLE estadios (
    id_estadio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    capacidade INT NOT NULL
) ENGINE=InnoDB;

CREATE TABLE selecoes (
    id_selecao INT AUTO_INCREMENT PRIMARY KEY,
    pais VARCHAR(60) NOT NULL UNIQUE,
    grupo CHAR(1) NOT NULL,
    tecnico VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE jogadores (
    id_jogador INT AUTO_INCREMENT PRIMARY KEY,
    id_selecao INT,
    nome VARCHAR(100) NOT NULL,
    posicao VARCHAR(30) NOT NULL,
    numero_camisa INT,
    idade INT,
    FOREIGN KEY (id_selecao) REFERENCES selecoes(id_selecao) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE partidas (
    id_partida INT AUTO_INCREMENT PRIMARY KEY,
    id_estadio INT,
    id_mandante INT,
    id_visitante INT,
    data_hora DATETIME NOT NULL,
    fase VARCHAR(30) NOT NULL,
    gols_mandante INT DEFAULT 0,
    gols_visitante INT DEFAULT 0,
    FOREIGN KEY (id_estadio) REFERENCES estadios(id_estadio),
    FOREIGN KEY (id_mandante) REFERENCES selecoes(id_selecao),
    FOREIGN KEY (id_visitante) REFERENCES selecoes(id_selecao)
) ENGINE=InnoDB;

CREATE TABLE estatisticas_jogadores (
    id_estatistica INT AUTO_INCREMENT PRIMARY KEY,
    id_partida INT,
    id_jogador INT,
    gols INT DEFAULT 0,
    assistencias INT DEFAULT 0,
    cartoes_amarelos INT DEFAULT 0,
    cartoes_vermelhos INT DEFAULT 0,
    FOREIGN KEY (id_partida) REFERENCES partidas(id_partida) ON DELETE CASCADE,
    FOREIGN KEY (id_jogador) REFERENCES jogadores(id_jogador) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO estadios (nome, city, capacidade) VALUES -- Nota: Ajustado erro de digitação de coluna na prática
-- Correção visual para o script rodar liso:
INSERT INTO estadios (nome, cidade, capacidade) VALUES
('Lusail Stadium', 'Lusail', 88966),
('Al Bayt Stadium', 'Al Khor', 68895);

INSERT INTO selecoes (pais, grupo, tecnico) VALUES
('Argentina', 'C', 'Lionel Scaloni'),
('França', 'D', 'Didier Deschamps'),
('Brasil', 'G', 'Dorival Júnior');

INSERT INTO jogadores (id_selecao, nome, posicao, numero_camisa, idade) VALUES
(1, 'Lionel Messi', 'Atacante', 10, 35),
(1, 'Ángel Di María', 'Meio-Campista', 11, 34),
(2, 'Kylian Mbappé', 'Atacante', 10, 23),
(3, 'Vinicius Junior', 'Atacante', 7, 23);

INSERT INTO partidas (id_estadio, id_mandante, id_visitante, data_hora, fase, gols_mandante, gols_visitante) VALUES
(1, 1, 2, '2022-12-18 18:00:00', 'Final', 3, 3);

INSERT INTO estatisticas_jogadores (id_partida, id_jogador, gols, assistencias, cartoes_amarelos) VALUES
(1, 1, 2, 0, 0),
(1, 2, 1, 0, 0),
(1, 3, 3, 0, 0);

SELECT 
    p.id_partida,
    p.fase,
    DATE(p.data_hora) as data_jogo,
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
GROUP BY j.id_jogador, j.nome, s.pais
HAVING total_gols > 0
ORDER BY total_gols DESC;

CREATE INDEX idx_partidas_data ON partidas(data_hora);
CREATE INDEX idx_jogadores_selecao ON jogadores(id_selecao);

DELIMITER $$

CREATE PROCEDURE sp_total_gols_selecao(IN p_id_selecao INT, OUT v_total_gols INT)
BEGIN
    SELECT COALESCE(SUM(ej.gols), 0) INTO v_total_gols
    FROM estatisticas_jogadores ej
    JOIN jogadores j ON ej.id_jogador = j.id_jogador
    WHERE j.id_selecao = p_id_selecao;
END$$

DELIMITER ;
