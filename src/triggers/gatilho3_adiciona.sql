.mode columns
.headers on
.nullvalue NULL

PRAGMA FOREIGN_KEYS = ON;

-- pequena descricao
CREATE TABLE avisoJogador(
    id                  INTEGER PRIMARY KEY AUTOINCREMENT,
    idJogador           INTEGER NOT NULL REFERENCES Jogador(idJogador),
    mensagem            TEXT NOT NULL
);

CREATE TRIGGER verificarJogador_altura_peso
AFTER INSERT ON Jogador
WHEN NEW.altura IS NULL AND NEW.peso IS NULL
BEGIN
    INSERT INTO avisoJogador (idJogador, mensagem)
    VALUES (NEW.idJogador, 'O jogador ' || NEW.nome || ' não apresenta um valor para a altura nem para o peso!');
END;


CREATE TRIGGER verificarJogador_altura
AFTER INSERT ON Jogador
WHEN NEW.altura IS NULL AND NEW.peso IS NOT NULL
BEGIN
    INSERT INTO avisoJogador (idJogador, mensagem)
    VALUES (NEW.idJogador, 'O jogador ' || NEW.nome || ' não apresenta um valor para a altura!');
END;
        
CREATE TRIGGER verificarJogador_peso
AFTER INSERT ON Jogador
WHEN NEW.peso IS NULL AND NEW.altura IS NOT NULL
BEGIN
    INSERT INTO avisoJogador (idJogador, mensagem)
    VALUES (NEW.idJogador, 'O jogador ' || NEW.nome || ' não apresenta um valor para o peso!');
END;