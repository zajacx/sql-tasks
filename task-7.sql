CREATE TABLE Mieszkaniec (
    ID NUMERIC(5) PRIMARY KEY NOT NULL,
    PESEL TEXT NOT NULL UNIQUE,
    Imie TEXT NOT NULL,
    Nazwisko TEXT NOT NULL,
    ID_mieszkania NUMERIC(4) NOT NULL,
    FOREIGN KEY (ID_mieszkania) REFERENCES Mieszkanie(ID_mieszkania)
);

CREATE TABLE Mieszkanie (
    ID_mieszkania NUMERIC(4) PRIMARY KEY NOT NULL,
    Adres TEXT NOT NULL,
    Metraz NUMERIC(4) NOT NULL,
    ID_wlasciciela NUMERIC(5) NOT NULL,
    FOREIGN KEY (ID_wlasciciela) REFERENCES Mieszkaniec(ID)
);

-- Początkowe zależności funkcyjne (odczytane z modelu pojęciowego):
-- PESEL -> Imię, Nazwisko, Adres
-- Adres -> Metraż, PESEL_właściciela
-- PESEL_właściciela -> Imię_właściciela, Nazwisko_właściciela, Adres_właściciela

-- Zależności funkcyjne zastąpione równoważnymi:
-- PESEL -> Adres (zastąpiony przez ID_mieszkania)
-- Adres -> PESEL_właściciela (zastąpiony przez ID_właściciela)
-- PESEL_właściciela -> Adres_właściciela (analogicznie jak wyżej)
