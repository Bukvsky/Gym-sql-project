DROP TABLE Wyposazenie_Silownia;
DROP TABLE Klubowicz_Silownia;
DROP TABLE Pracownik_nizszego_szczebla;
DROP TABLE Silownia;
DROP TABLE Spolka_Franczyzowa;
DROP TABLE Wyposazenie;
DROP TABLE Klubowicz;
DROP TABLE Rodzaj_subskrypcji;
DROP TABLE Stanowisko;
DROP TABLE Manager_klubu;
DROP TABLE Miasto_silowni;
DROP TABLE Franczyzobiorca;

ALTER TABLE Klubowicz DROP CONSTRAINT Klubowicz_Rodzaj_subskrypcji;
ALTER TABLE Klubowicz_Silownia DROP CONSTRAINT Klubowicz_Silownia_Klubowicz;
ALTER TABLE Klubowicz_Silownia DROP CONSTRAINT Klubowicz_Silownia_Silownia;
ALTER TABLE Pracownik_nizszego_szczebla DROP CONSTRAINT Pracownik_nizszego_szczebla_Spolka_Franczyzowa;
ALTER TABLE Pracownik_nizszego_szczebla DROP CONSTRAINT Pracownik_nizszego_szczebla_Stanowisko;
ALTER TABLE Silownia DROP CONSTRAINT Silownia_Manager_klubu;
ALTER TABLE Silownia DROP CONSTRAINT Silownia_Miasto;
ALTER TABLE Silownia DROP CONSTRAINT Silownia_Spolka_Franczyzowa;
ALTER TABLE Spolka_Franczyzowa DROP CONSTRAINT Spolka_Franczyzowa_Franczyzobiorca;
ALTER TABLE Wyposazenie_Silownia DROP CONSTRAINT Wyposazenie_Silownia_Silownia;
ALTER TABLE Wyposazenie_Silownia DROP CONSTRAINT Wyposazenie_Silownia_Wyposazenie;


CREATE TABLE Franczyzobiorca (
    ID_Franczyzobiorcy integer  NOT NULL,
    Imię varchar2(40)  NOT NULL,
    Nazwisko varchar2(40)  NOT NULL,
    CONSTRAINT Franczyzobiorca_pk PRIMARY KEY (ID_Franczyzobiorcy)
) ;

-- Table: Klubowicz
CREATE TABLE Klubowicz (
    ID_Klubowicza integer  NOT NULL,
    Imię varchar2(40)  NOT NULL,
    Nazwisko varchar2(40)  NOT NULL,
    Data_dolaczenia date  NOT NULL,
    Rodzaj_subskrypcji integer  NOT NULL,
    CONSTRAINT Klubowicz_pk PRIMARY KEY (ID_Klubowicza)
) ;

-- Table: Klubowicz_Siłownia
CREATE TABLE Klubowicz_Silownia (
    Silownia_ID_silowni integer  NOT NULL,
    Klubowicz_ID_Klubowicza integer  NOT NULL,
    Data date  NOT NULL,
    CONSTRAINT Klubowicz_Silownia_pk PRIMARY KEY (Silownia_ID_silowni,Klubowicz_ID_Klubowicza,Data)
) ;

-- Table: Manager klubu
CREATE TABLE Manager_klubu (
    ID_Managera integer  NOT NULL,
    Imię varchar2(40)  NOT NULL,
    Nazwisko varchar2(40)  NOT NULL,
    CONSTRAINT Manager_klubu_pk PRIMARY KEY (ID_Managera)
) ;

-- Table: Miasto
CREATE TABLE Miasto_silowni (
    ID_Miasta integer  NOT NULL,
    Nazwa_Miasta varchar2(50)  NOT NULL,
    Liczba_ludności integer  NOT NULL,
    CONSTRAINT Miasto_pk PRIMARY KEY (ID_Miasta)
) ;

-- Table: Pracownik_niższego_szczebla
CREATE TABLE Pracownik_nizszego_szczebla (
    ID_Pracownika integer  NOT NULL,
    Imię varchar2(40)  NOT NULL,
    Nazwisko varchar2(40)  NOT NULL,
    Stanowisko_ID_Stanowiska integer  NOT NULL,
    Spolka_Franczyzowa_ID_spolki integer  NOT NULL,
    CONSTRAINT Pracownik_nizszego_szczebla_pk PRIMARY KEY (ID_Pracownika)
) ;

-- Table: Rodzaj subskrypcji
CREATE TABLE Rodzaj_subskrypcji (
    ID_Subskrypcji integer  NOT NULL,
    Nazwa varchar2(20)  NOT NULL,
    Cena integer  NOT NULL,
    CONSTRAINT Rodzaj_subskrypcji_pk PRIMARY KEY (ID_Subskrypcji)
) ;

-- Table: Siłownia
CREATE TABLE Silownia (
    ID_silowni integer  NOT NULL,
    Powierzchnia_klubu integer  NOT NULL,
    Spolka_Franczyzowa_ID_spolki integer  NOT NULL,
    Miasto_ID_Miasta integer  NOT NULL,
    Manager_klubu_ID_Managera integer  NOT NULL,
    CONSTRAINT Silownia_pk PRIMARY KEY (ID_silowni)
) ;

-- Table: Spółka Franczyzowa
CREATE TABLE Spolka_Franczyzowa (
    ID_spolki integer  NOT NULL,
    Franczyzobiorca_ID_Franczyzobiorcy integer  NOT NULL,
    CONSTRAINT Spolka_Franczyzowa_pk PRIMARY KEY (ID_spolki)
) ;

-- Table: Stanowisko
CREATE TABLE Stanowisko (
    ID_Stanowiska integer  NOT NULL,
    Nazwa varchar2(20)  NOT NULL,
    CONSTRAINT Stanowisko_pk PRIMARY KEY (ID_Stanowiska)
) ;

-- Table: Wyposażenie
CREATE TABLE Wyposazenie (
    ID_wyposazenia integer  NOT NULL,
    Nazwa varchar2(50)  NOT NULL,
    Cena_Katalogowa integer  NOT NULL,
    Opis varchar2(255)  NOT NULL,
    CONSTRAINT Wyposazenie_pk PRIMARY KEY (ID_wyposazenia)
) ;

-- Table: Wyposażenie_Siłownia
CREATE TABLE Wyposazenie_Silownia (
    Wyposazenie_ID_wyposazenia integer  NOT NULL,
    Silownia_ID_silowni integer  NOT NULL,
    CONSTRAINT Wyposazenie_Silownia_pk PRIMARY KEY (Wyposazenie_ID_wyposazenia,Silownia_ID_silowni)
) ;

-- foreign keys
-- Reference: Klubowicz_Rodzaj subskrypcji (table: Klubowicz)
ALTER TABLE Klubowicz ADD CONSTRAINT Klubowicz_Rodzaj_subskrypcji
    FOREIGN KEY (Rodzaj_subskrypcji)
    REFERENCES Rodzaj_subskrypcji(ID_Subskrypcji);

-- Reference: Klubowicz_Siłownia_Klubowicz (table: Klubowicz_Siłownia)
ALTER TABLE Klubowicz_Silownia ADD CONSTRAINT Klubowicz_Silownia_Klubowicz
    FOREIGN KEY (Klubowicz_ID_Klubowicza)
    REFERENCES Klubowicz (ID_Klubowicza);

-- Reference: Klubowicz_Siłownia_Siłownia (table: Klubowicz_Siłownia)
ALTER TABLE Klubowicz_Silownia ADD CONSTRAINT Klubowicz_Silownia_Silownia
    FOREIGN KEY (Silownia_ID_silowni)
    REFERENCES Silownia (ID_silowni);

-- Reference: Pracownik_niższego_szczebla_Spółka Franczyzowa (table: Pracownik_niższego_szczebla)
ALTER TABLE Pracownik_nizszego_szczebla ADD CONSTRAINT Pracownik_nizszego_szczebla_Spolka_Franczyzowa
    FOREIGN KEY (Spolka_Franczyzowa_ID_spolki)
    REFERENCES Spolka_Franczyzowa (ID_spolki);

-- Reference: Pracownik_niższego_szczebla_Stanowisko (table: Pracownik_niższego_szczebla)
ALTER TABLE Pracownik_nizszego_szczebla ADD CONSTRAINT Pracownik_nizszego_szczebla_Stanowisko
    FOREIGN KEY (Stanowisko_ID_Stanowiska)
    REFERENCES Stanowisko (ID_Stanowiska);

-- Reference: Siłownia_Manager klubu (table: Siłownia)
ALTER TABLE Silownia ADD CONSTRAINT Silownia_Manager_klubu
    FOREIGN KEY (Manager_klubu_ID_Managera)
    REFERENCES Manager_klubu (ID_Managera);

-- Reference: Siłownia_Miasto (table: Siłownia)
ALTER TABLE Silownia ADD CONSTRAINT Silownia_Miasto
    FOREIGN KEY (Miasto_ID_Miasta)
    REFERENCES Miasto_silowni (ID_Miasta);

-- Reference: Siłownia_Spółka Franczyzowa (table: Siłownia)
ALTER TABLE Silownia ADD CONSTRAINT Silownia_Spolka_Franczyzowa
    FOREIGN KEY (Spolka_Franczyzowa_ID_spolki)
    REFERENCES Spolka_Franczyzowa (ID_spolki);

-- Reference: Spółka Franczyzowa_Franczyzobiorca (table: Spółka Franczyzowa)
ALTER TABLE Spolka_Franczyzowa ADD CONSTRAINT Spolka_Franczyzowa_Franczyzobiorca
    FOREIGN KEY (Franczyzobiorca_ID_Franczyzobiorcy)
    REFERENCES Franczyzobiorca (ID_Franczyzobiorcy);

-- Reference: Wyposażenie_Siłownia_Siłownia (table: Wyposażenie_Siłownia)
ALTER TABLE Wyposazenie_Silownia ADD CONSTRAINT Wyposazenie_Silownia_Silownia
    FOREIGN KEY (Silownia_ID_silowni)
    REFERENCES Silownia (ID_silowni);

-- Reference: Wyposażenie_Siłownia_Wyposażenie (table: Wyposażenie_Siłownia)
ALTER TABLE Wyposazenie_Silownia ADD CONSTRAINT Wyposazenie_Silownia_Wyposazenie
    FOREIGN KEY (Wyposazenie_ID_wyposazenia)
    REFERENCES Wyposazenie (ID_wyposazenia);

-- End of file.
--Insert into franczyzobiorca
INSERT INTO FRANCZYZOBIORCA (ID_Franczyzobiorcy, Imię, Nazwisko) values (1,'Lukasz','Dojka');
INSERT INTO FRANCZYZOBIORCA (ID_Franczyzobiorcy, Imię, Nazwisko) values (2,'Sebastian','Musial');
INSERT INTO FRANCZYZOBIORCA (ID_Franczyzobiorcy, Imię, Nazwisko) values (3,'Jan','Bednarek');
INSERT INTO FRANCZYZOBIORCA (ID_Franczyzobiorcy, Imię, Nazwisko) values (4,'Kamila','Wrzesien');
INSERT INTO FRANCZYZOBIORCA (ID_Franczyzobiorcy, Imię, Nazwisko) values (5,'Krzysztof','Macko');

--Insert into rodzaj subskrypcji
INSERT INTO Rodzaj_subskrypcji (ID_Subskrypcji, Nazwa, Cena)
VALUES (1, 'Standard', 50);
INSERT INTO Rodzaj_subskrypcji (ID_Subskrypcji, Nazwa, Cena)
VALUES (2, 'Premium', 100);
INSERT INTO Rodzaj_subskrypcji (ID_Subskrypcji, Nazwa, Cena)
VALUES (3, 'VIP', 200);


--Insert into Klubowicz
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (1, 'Adam', 'Nowak', TO_DATE('2023-01-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (2, 'Anna', 'Kowalska', TO_DATE('2023-02-20', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (3, 'Michał', 'Wiśniewski', TO_DATE('2023-03-10', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (4, 'Katarzyna', 'Wójcik', TO_DATE('2023-04-05', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (5, 'Adam', 'Kowalski', TO_DATE('2024-01-30', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (6, 'Ewa', 'Kowalska', TO_DATE('2024-02-05', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (7, 'Piotr', 'Wiśniewski', TO_DATE('2024-02-20', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (8, 'Maria', 'Lis', TO_DATE('2024-03-10', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (9, 'Andrzej', 'Zieliński', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 2);

INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (10, 'Monika', 'Kowalczyk', TO_DATE('2024-04-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (11, 'Tomasz', 'Wójcik', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (12, 'Anna', 'Nowakowska', TO_DATE('2024-05-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (13, 'Marek', 'Krawczyk', TO_DATE('2024-06-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (14, 'Joanna', 'Woźniak', TO_DATE('2024-06-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (15, 'Marcin', 'Dąbrowski', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (16, 'Katarzyna', 'Piotrowska', TO_DATE('2024-07-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (17, 'Jan', 'Grabowski', TO_DATE('2024-08-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (18, 'Alicja', 'Jankowska', TO_DATE('2024-08-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (19, 'Łukasz', 'Michalski', TO_DATE('2024-09-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (20, 'Aleksandra', 'Wojciechowska', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (21, 'Grzegorz', 'Kamiński', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (22, 'Ewa', 'Adamczyk', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (23, 'Piotr', 'Lewandowski', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (24, 'Karolina', 'Zielińska', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (25, 'Michał', 'Szymański', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (26, 'Magdalena', 'Pawlak', TO_DATE('2024-12-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (27, 'Kamil', 'Walczak', TO_DATE('2024-01-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (28, 'Natalia', 'Baran', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (29, 'Rafał', 'Górecki', TO_DATE('2024-02-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (30, 'Dominika', 'Kucharska', TO_DATE('2024-02-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (31, 'Adrian', 'Mazur', TO_DATE('2024-03-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (32, 'Katarzyna', 'Nowak', TO_DATE('2024-03-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (33, 'Łukasz', 'Wójcik', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (34, 'Anna', 'Lis', TO_DATE('2024-04-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (35, 'Tomasz', 'Kowalczyk', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (36, 'Monika', 'Witkowska', TO_DATE('2024-05-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (37, 'Marcin', 'Duda', TO_DATE('2024-06-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (38, 'Weronika', 'Krawczyk', TO_DATE('2024-06-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (39, 'Grzegorz', 'Zając', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (40, 'Julia', 'Król', TO_DATE('2024-07-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (41, 'Kamil', 'Wieczorek', TO_DATE('2024-08-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (42, 'Karol', 'Kaczmarek', TO_DATE('2024-08-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (43, 'Zofia', 'Mazurek', TO_DATE('2024-09-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (44, 'Mateusz', 'Czarnecki', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (45, 'Paulina', 'Wesołowska', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (46, 'Radosław', 'Szczepański', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (47, 'Barbara', 'Sadowska', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (48, 'Jacek', 'Chmielewski', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (49, 'Elżbieta', 'Kubiak', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (50, 'Wojciech', 'Sobczak', TO_DATE('2024-12-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (51, 'Adam', 'Nowicki', TO_DATE('2024-01-05', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (52, 'Ewa', 'Wojciechowska', TO_DATE('2024-01-20', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (53, 'Piotr', 'Zieliński', TO_DATE('2024-02-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (54, 'Anna', 'Lewandowska', TO_DATE('2024-02-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (55, 'Michał', 'Jankowski', TO_DATE('2024-03-05', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (56, 'Katarzyna', 'Szymańska', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (57, 'Tomasz', 'Kamiński', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (58, 'Joanna', 'Baranowska', TO_DATE('2024-04-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (59, 'Marcin', 'Pawlak', TO_DATE('2024-05-05', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (60, 'Karolina', 'Wiśniewska', TO_DATE('2024-05-20', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (61, 'Paweł', 'Wróblewski', TO_DATE('2024-06-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (62, 'Monika', 'Kaczmarek', TO_DATE('2024-06-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (63, 'Grzegorz', 'Sadowski', TO_DATE('2024-07-05', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (64, 'Aleksandra', 'Zawadzka', TO_DATE('2024-07-20', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (65, 'Rafał', 'Mazurek', TO_DATE('2024-08-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (66, 'Natalia', 'Sikorska', TO_DATE('2024-08-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (67, 'Andrzej', 'Kozłowski', TO_DATE('2024-09-05', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (68, 'Julia', 'Kowal', TO_DATE('2024-09-20', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (69, 'Maciej', 'Kalinowski', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (70, 'Zofia', 'Wysocka', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (71, 'Łukasz', 'Czajkowski', TO_DATE('2024-11-05', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (72, 'Joanna', 'Pietrzak', TO_DATE('2024-11-20', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (73, 'Tomasz', 'Borkowski', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (74, 'Ewa', 'Majewska', TO_DATE('2024-12-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (75, 'Michał', 'Ostrowski', TO_DATE('2023-01-05', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (76, 'Paulina', 'Tomaszewska', TO_DATE('2023-01-20', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (77, 'Radosław', 'Dobrowolski', TO_DATE('2023-02-05', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (78, 'Agnieszka', 'Ratajczak', TO_DATE('2023-02-20', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (79, 'Grzegorz', 'Szulc', TO_DATE('2023-03-05', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (80, 'Maria', 'Mikołajczyk', TO_DATE('2023-03-20', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (81, 'Jakub', 'Pakulski', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (82, 'Kamila', 'Jabłońska', TO_DATE('2024-04-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (83, 'Piotr', 'Krawiec', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (84, 'Alicja', 'Sobolewska', TO_DATE('2024-05-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (85, 'Łukasz', 'Witkowski', TO_DATE('2024-06-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (86, 'Anna', 'Jasińska', TO_DATE('2024-06-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (87, 'Krzysztof', 'Zając', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (88, 'Dominika', 'Walczak', TO_DATE('2024-07-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (89, 'Bartosz', 'Mazurek', TO_DATE('2024-08-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (90, 'Marcelina', 'Dąbrowska', TO_DATE('2024-08-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (91, 'Sebastian', 'Wesołowski', TO_DATE('2024-09-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (92, 'Gabriela', 'Król', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (93, 'Damian', 'Wieczorek', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (94, 'Agata', 'Kaczmarek', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (95, 'Robert', 'Mazurek', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (96, 'Martyna', 'Sikora', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (97, 'Artur', 'Kozłowski', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (98, 'Patrycja', 'Zawadzka', TO_DATE('2024-12-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (99, 'Dawid', 'Wójcik', TO_DATE('2023-01-05', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (100, 'Kinga', 'Witkowska', TO_DATE('2023-01-20', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (101, 'Mateusz', 'Kowal', TO_DATE('2023-02-05', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (102, 'Karolina', 'Majewska', TO_DATE('2023-02-20', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (103, 'Kamil', 'Ostrowski', TO_DATE('2023-03-05', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (104, 'Oliwia', 'Tomaszewska', TO_DATE('2023-03-20', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (105, 'Krzysztof', 'Dobrowolski', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (106, 'Natalia', 'Ratajczak', TO_DATE('2023-04-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (107, 'Szymon', 'Szulc', TO_DATE('2023-05-05', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (108, 'Maja', 'Mikołajczyk', TO_DATE('2023-05-20', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (109, 'Kacper', 'Kowalski', TO_DATE('2023-06-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (110, 'Zofia', 'Lewandowska', TO_DATE('2024-06-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (111, 'Maciej', 'Duda', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (112, 'Nadia', 'Sikorska', TO_DATE('2024-07-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (113, 'Paweł', 'Wójcik', TO_DATE('2024-08-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (114, 'Maja', 'Kaczor', TO_DATE('2024-08-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (115, 'Jan', 'Grabowski', TO_DATE('2024-09-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (116, 'Aleksandra', 'Pawlak', TO_DATE('2024-09-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (117, 'Kacper', 'Michalak', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (118, 'Oliwia', 'Zając', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (119, 'Bartosz', 'Woźniak', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (120, 'Filip', 'Krawczyk', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (121, 'Julia', 'Baran', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (122, 'Szymon', 'Piotrowski', TO_DATE('2024-12-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (123, 'Natalia', 'Zalewska', TO_DATE('2023-01-05', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (124, 'Michał', 'Mazurek', TO_DATE('2023-01-20', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (125, 'Zuzanna', 'Walczak', TO_DATE('2023-02-05', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (126, 'Kamil', 'Dąbrowski', TO_DATE('2023-02-20', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (127, 'Wiktoria', 'Wesołowska', TO_DATE('2023-03-05', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (128, 'Krzysztof', 'Jabłoński', TO_DATE('2023-03-20', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (129, 'Maria', 'Nowak', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (130, 'Mikołaj', 'Kowalczyk', TO_DATE('2023-04-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (131, 'Julia', 'Lis', TO_DATE('2023-05-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (132, 'Piotr', 'Witkowski', TO_DATE('2023-05-15', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (133, 'Zofia', 'Sobczak', TO_DATE('2023-06-01', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (134, 'Filip', 'Jasiński', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (135, 'Anna', 'Zawadzka', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (136, 'Bartłomiej', 'Kwiatkowski', TO_DATE('2023-07-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (137, 'Natalia', 'Michalska', TO_DATE('2023-08-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (138, 'Damian', 'Nowak', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (139, 'Hanna', 'Wojciechowska', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (140, 'Kacper', 'Lewicki', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (141, 'Maja', 'Kubiak', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (142, 'Tomasz', 'Piotrowski', TO_DATE('2024-01-05', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (143, 'Weronika', 'Grabowska', TO_DATE('2024-01-20', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (144, 'Oskar', 'Lisowski', TO_DATE('2024-02-05', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (145, 'Anna', 'Jaworska', TO_DATE('2024-02-20', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (146, 'Patryk', 'Łukasik', TO_DATE('2024-03-05', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (147, 'Karolina', 'Sikora', TO_DATE('2024-03-20', 'YYYY-MM-DD'), 3);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (148, 'Bartosz', 'Olejnik', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 1);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (149, 'Katarzyna', 'Tomczak', TO_DATE('2024-04-15', 'YYYY-MM-DD'), 2);
INSERT INTO Klubowicz (ID_Klubowicza, Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES (150, 'Filip', 'Kaczmarek', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 3);


--Wyposazenia
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (1, 'Bieżnia elektryczna', 3500, 'Profesjonalna bieżnia do ćwiczeń w domu i na siłowni');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (2, 'Rower stacjonarny', 1200, 'Rower do ćwiczeń cardio z regulacją oporu');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (3, 'Orbitrek', 2200, 'Elektryczny orbitrek z programami treningowymi');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (4, 'Ławka do ćwiczeń', 800, 'Regulowana ławka do ćwiczeń siłowych');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (5, 'Hantle', 500, 'Zestaw hantli o różnych wagach');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (6, 'Sztanga', 700, 'Sztanga olimpijska z zestawem obciążeń');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (7, 'Mata do jogi', 100, 'Antypoślizgowa mata do jogi i ćwiczeń');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (8, 'Piłka gimnastyczna', 60, 'Piłka do ćwiczeń rehabilitacyjnych i fitness');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (9, 'Drążek do podciągania', 150, 'Drążek montowany do ściany do podciągania');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (10, 'Stepper', 300, 'Stepper do ćwiczeń cardio z regulacją oporu');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (11, 'Skakanka', 30, 'Profesjonalna skakanka do ćwiczeń fitness');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (12, 'Ergometr wioślarski', 2500, 'Symulator wiosłowania do ćwiczeń cardio');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (13, 'Roller do masażu', 80, 'Wałek do masażu mięśni i rozluźniania powięzi');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (14, 'Trampolina fitness', 400, 'Mała trampolina do ćwiczeń w domu');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (15, 'Bosu', 350, 'Platforma do ćwiczeń równowagi i stabilizacji');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (16, 'Piłka lekarska', 90, 'Piłka do ćwiczeń siłowych i koordynacyjnych');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (17, 'Rower spinningowy', 1800, 'Profesjonalny rower do spinningu');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (18, 'Kettlebell', 300, 'Zestaw kettlebelli o różnych wagach');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (19, 'Multistacja', 5000, 'Wielofunkcyjne urządzenie do ćwiczeń siłowych');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (20, 'Ławeczka do brzuszków', 200, 'Ławeczka do ćwiczeń mięśni brzucha');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (21, 'Guma do ćwiczeń', 50, 'Zestaw gum oporowych do ćwiczeń');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (22, 'Power tower', 1000, 'Wieża do ćwiczeń z własną masą ciała');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (23, 'Smith machine', 4000, 'Maszyna Smitha do ćwiczeń siłowych');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (24, 'Skrzynia plyometryczna', 600, 'Skrzynia do ćwiczeń plyometrycznych');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (25, 'Drabinka gimnastyczna', 250, 'Drewniana drabinka do ćwiczeń rozciągających');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (26, 'Torba bułgarska', 450, 'Torba treningowa do ćwiczeń siłowych i wytrzymałościowych');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (27, 'Suwnica na nogi', 3500, 'Suwnica do ćwiczeń mięśni nóg');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (28, 'Zestaw ciężarków', 600, 'Kompletny zestaw ciężarków do ćwiczeń w domu');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (29, 'Box jump', 500, 'Pudełko do skoków w górę');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (30, 'Lina do ćwiczeń', 200, 'Gruba lina do treningu wytrzymałościowego');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (31, 'Maty do ćwiczeń', 300, 'Zestaw mat do ćwiczeń fitness i pilates');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (32, 'Suspension trainer', 700, 'System do ćwiczeń z własną masą ciała zawieszany na drzwiach');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (33, 'Pas wibracyjny', 150, 'Pas wibracyjny do masażu i wzmacniania mięśni brzucha');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (34, 'Płyty balansowe', 200, 'Zestaw płyt do ćwiczeń równowagi');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (35, 'Poręcze do dipów', 800, 'Stojące poręcze do ćwiczeń mięśni ramion i klatki piersiowej');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (36, 'Kółko do ćwiczeń brzucha', 60, 'Kółko do ćwiczeń mięśni brzucha i pleców');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (37, 'Trenażer równowagi', 180, 'Urządzenie do ćwiczeń równowagi i koordynacji');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (38, 'Stojak na ciężary', 500, 'Stojak do przechowywania ciężarów i obciążeń');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (39, 'Wałek do masażu mięśni', 90, 'Wałek do masażu i rozluźniania mięśni');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (40, 'Płetwy treningowe', 120, 'Płetwy do ćwiczeń pływackich wzmacniających nogi');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (41, 'Sandały do biegania', 350, 'Sandały minimalistyczne do biegania');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (42, 'Skrzynia wielofunkcyjna', 400, 'Skrzynia do przechowywania sprzętu sportowego');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (43, 'Piłki obciążeniowe', 250, 'Zestaw piłek obciążeniowych do ćwiczeń siłowych');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (44, 'Ergometr narciarski', 3000, 'Symulator jazdy na nartach do ćwiczeń cardio');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (45, 'Stojak na rowery', 150, 'Stojak do przechowywania rowerów w domu');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (46, 'Maska treningowa', 180, 'Maska do ćwiczeń z ograniczonym dostępem powietrza');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (47, 'Pas kulturystyczny', 100, 'Pas wspomagający przy ćwiczeniach siłowych');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (48, 'Skakanka z obciążeniem', 80, 'Skakanka z dodatkowym obciążeniem');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (49, 'Rękawice bokserskie', 200, 'Rękawice do ćwiczeń bokserskich i na worku');
INSERT INTO Wyposazenie (ID_wyposazenia, Nazwa, Cena_Katalogowa, Opis)
VALUES (50, 'Gumy do treningu oporowego', 300, 'Zestaw gum oporowych do ćwiczeń fitness i rehabilitacji');

Commit;

select *
FROM MIASTO_SILOWNI;

INSERT INTO Miasto_silowni (ID_Miasta, Nazwa_Miasta, Liczba_ludności)
VALUES (1, 'Warszawa', 1790658);
INSERT INTO Miasto_silowni (ID_Miasta, Nazwa_Miasta, Liczba_ludności)
VALUES (2, 'Kraków', 780981);
INSERT INTO Miasto_silowni (ID_Miasta, Nazwa_Miasta, Liczba_ludności)
VALUES (3, 'Łódź', 670642);
INSERT INTO Miasto_silowni (ID_Miasta, Nazwa_Miasta, Liczba_ludności)
VALUES (4, 'Wrocław', 641607);
INSERT INTO Miasto_silowni (ID_Miasta, Nazwa_Miasta, Liczba_ludności)
VALUES (5, 'Poznań', 532048);

INSERT INTO Stanowisko (ID_Stanowiska, Nazwa)
VALUES (1, 'Trener Personalny');
INSERT INTO Stanowisko (ID_Stanowiska, Nazwa)
VALUES (2, 'Recepcjonista');
INSERT INTO Stanowisko (ID_Stanowiska, Nazwa)
VALUES (3, 'Instruktor Fitness');
INSERT INTO Stanowisko (ID_Stanowiska, Nazwa)
VALUES (4, 'Sprzątacz');
INSERT INTO Stanowisko (ID_Stanowiska, Nazwa)
VALUES (5, 'Dietetyk');
INSERT INTO Stanowisko(ID_Stanowiska, Nazwa)
VALUES (6, 'Konserwator maszyn');


SELECT *
FROM Stanowisko;

INSERT INTO Manager_klubu (ID_Managera, Imię, Nazwisko)
VALUES (1, 'Marek', 'Kowalski');
INSERT INTO Manager_klubu (ID_Managera, Imię, Nazwisko)
VALUES (2, 'Anna', 'Nowak');
INSERT INTO Manager_klubu (ID_Managera, Imię, Nazwisko)
VALUES (3, 'Piotr', 'Wiśniewski');
INSERT INTO Manager_klubu (ID_Managera, Imię, Nazwisko)
VALUES (4, 'Katarzyna', 'Wójcik');
INSERT INTO Manager_klubu (ID_Managera, Imię, Nazwisko)
VALUES (5, 'Tomasz', 'Zieliński');
INSERT INTO Manager_klubu (ID_Managera, Imię, Nazwisko)
VALUES (6, 'Weronika', 'Kowalczyk');
INSERT INTO Manager_klubu (ID_Managera, Imię, Nazwisko)
VALUES (7, 'Jan', 'Dąbrowski');
INSERT INTO Manager_klubu (ID_Managera, Imię, Nazwisko)
VALUES (8, 'Karolina', 'Lis');

INSERT INTO Spolka_Franczyzowa (ID_spolki, Franczyzobiorca_ID_Franczyzobiorcy)
VALUES (1, 1);
INSERT INTO Spolka_Franczyzowa (ID_spolki, Franczyzobiorca_ID_Franczyzobiorcy)
VALUES (2, 2);
INSERT INTO Spolka_Franczyzowa (ID_spolki, Franczyzobiorca_ID_Franczyzobiorcy)
VALUES (3, 3);
INSERT INTO Spolka_Franczyzowa (ID_spolki, Franczyzobiorca_ID_Franczyzobiorcy)
VALUES (4, 3);
INSERT INTO Spolka_Franczyzowa (ID_spolki, Franczyzobiorca_ID_Franczyzobiorcy)
VALUES (5, 4);
INSERT INTO Spolka_Franczyzowa (ID_spolki, Franczyzobiorca_ID_Franczyzobiorcy)
VALUES (6, 5);
INSERT INTO Spolka_Franczyzowa (ID_spolki, Franczyzobiorca_ID_Franczyzobiorcy)
VALUES (7, 5);
INSERT INTO Spolka_Franczyzowa (ID_spolki, Franczyzobiorca_ID_Franczyzobiorcy)
VALUES (8, 1);

INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (1, 'Jan', 'Kowalski', 1, 1); -- Trener Personalny, Klub 1
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (2, 'Anna', 'Nowak', 2, 1); -- Recepcjonistka, Klub 1
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (3, 'Karolina', 'Wójcik', 2, 1); -- Recepcjonistka, Klub 1
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (4, 'Mateusz', 'Lewandowski', 3, 1); -- Instruktor Fitness, Klub 1
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (5, 'Ewa', 'Dąbrowska', 4, 1); -- Sprzątacz, Klub 1
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (6, 'Piotr', 'Woźniak', 4, 1); -- Sprzątacz, Klub 1
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (7, 'Alicja', 'Kowalczyk', 5, 1); -- Dietetyk, Klub 1
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (8, 'Damian', 'Zając', 6, 1);

INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (9, 'Aleksandra', 'Mazur', 1, 2); -- Trener Personalny
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (10, 'Mikołaj', 'Adamczyk', 2, 2); -- Recepcjonista
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (11, 'Julia', 'Zając', 2, 2); -- Recepcjonistka
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (12, 'Wojciech', 'Kwiatkowski', 3, 2); -- Instruktor Fitness
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (13, 'Martyna', 'Wojciechowska', 4, 2); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (14, 'Dominik', 'Szymański', 4, 2); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (15, 'Natalia', 'Duda', 5, 2); -- Dietetyk
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (16, 'Marek', 'Witkowski', 6, 2); -- Konserwator maszyn

INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (17, 'Katarzyna', 'Nowak', 1, 3); -- Trener Personalny
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (18, 'Jan', 'Kowalski', 2, 3); -- Recepcjonista
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (19, 'Karolina', 'Wiśniewska', 2, 3); -- Recepcjonistka
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (20, 'Paweł', 'Lewandowski', 3, 3); -- Instruktor Fitness
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (21, 'Aleksandra', 'Dąbrowska', 4, 3); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (22, 'Maciej', 'Wójcik', 4, 3); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (23, 'Alicja', 'Kowalczyk', 5, 3); -- Dietetyk
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (24, 'Damian', 'Lis', 6, 3); -- Konserwator maszyn

INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (25, 'Anna', 'Nowak', 1, 4); -- Trener Personalny
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (26, 'Piotr', 'Kowalczyk', 2, 4); -- Recepcjonista
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (27, 'Monika', 'Lewandowska', 2, 4); -- Recepcjonistka
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (28, 'Tomasz', 'Dąbrowski', 3, 4); -- Instruktor Fitness
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (29, 'Magdalena', 'Nowak', 4, 4); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (30, 'Kamil', 'Krawczyk', 4, 4); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (31, 'Dominika', 'Woźniak', 5, 4); -- Dietetyk
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (32, 'Jakub', 'Jabłoński', 6, 4); -- Konserwator maszyn

INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (33, 'Alicja', 'Kowalska', 1, 5); -- Trener Personalny
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (34, 'Krzysztof', 'Zieliński', 2, 5); -- Recepcjonista
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (35, 'Magdalena', 'Wójcik', 2, 5); -- Recepcjonistka
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (36, 'Marcin', 'Lis', 3, 5); -- Instruktor Fitness
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (37, 'Anna', 'Kaczmarek', 4, 5); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (38, 'Jan', 'Piotrowski', 4, 5); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (39, 'Natalia', 'Zawadzka', 5, 5); -- Dietetyk
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (40, 'Artur', 'Włodarczyk', 6, 5); -- Konserwator maszyn

INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (41, 'Aleksandra', 'Nowak', 1, 6); -- Trener Personalny
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (42, 'Tomasz', 'Kwiatkowski', 2, 6); -- Recepcjonista
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (43, 'Monika', 'Pawlak', 2, 6); -- Recepcjonistka
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (44, 'Paweł', 'Kaczor', 3, 6); -- Instruktor Fitness
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (45, 'Katarzyna', 'Grabowska', 4, 6); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (46, 'Rafał', 'Michalski', 4, 6); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (47, 'Magdalena', 'Zielińska', 5, 6); -- Dietetyk
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (48, 'Michał', 'Lewandowski', 6, 6); -- Konserwator maszyn

INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (49, 'Julia', 'Woźniak', 1, 7); -- Trener Personalny
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (50, 'Marek', 'Wójcik', 2, 7); -- Recepcjonista
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (51, 'Agnieszka', 'Kowalczyk', 2, 7); -- Recepcjonistka
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (52, 'Piotr', 'Lis', 3, 7); -- Instruktor Fitness
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (53, 'Ewa', 'Zawadzka', 4, 7); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (54, 'Jan', 'Duda', 4, 7); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (55, 'Martyna', 'Piotrowska', 5, 7); -- Dietetyk
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (56, 'Damian', 'Walczak', 6, 7); -- Konserwator maszyn


INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (57, 'Katarzyna', 'Kowal', 1, 8); -- Trener Personalny
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (58, 'Łukasz', 'Zieliński', 2, 8); -- Recepcjonista
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (59, 'Anna', 'Dąbrowska', 2, 8); -- Recepcjonistka
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (60, 'Maciej', 'Witkowski', 3, 8); -- Instruktor Fitness
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (61, 'Monika', 'Krawczyk', 4, 8); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (62, 'Tomasz', 'Lewandowski', 4, 8); -- Sprzątacz
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (63, 'Karolina', 'Piotrowska', 5, 8); -- Dietetyk
INSERT INTO Pracownik_nizszego_szczebla (ID_Pracownika, Imię, Nazwisko, Stanowisko_ID_Stanowiska, Spolka_Franczyzowa_ID_spolki)
VALUES (64, 'Piotr', 'Kwiatkowski', 6, 8); -- Konserwator maszyn

Commit;
SELECT *
FROM Spolka_Franczyzowa;

INSERT INTO Silownia (ID_silowni, Powierzchnia_klubu, Spolka_Franczyzowa_ID_spolki, Miasto_ID_Miasta, Manager_klubu_ID_Managera)
VALUES (1, 1000, 1, 1, 1);
INSERT INTO Silownia (ID_silowni, Powierzchnia_klubu, Spolka_Franczyzowa_ID_spolki, Miasto_ID_Miasta, Manager_klubu_ID_Managera)
VALUES (2, 1200, 2, 2, 2);
INSERT INTO Silownia (ID_silowni, Powierzchnia_klubu, Spolka_Franczyzowa_ID_spolki, Miasto_ID_Miasta, Manager_klubu_ID_Managera)
VALUES (3, 900, 3, 3, 3);
INSERT INTO Silownia (ID_silowni, Powierzchnia_klubu, Spolka_Franczyzowa_ID_spolki, Miasto_ID_Miasta, Manager_klubu_ID_Managera)
VALUES (4, 800, 4, 4, 4);
INSERT INTO Silownia (ID_silowni, Powierzchnia_klubu, Spolka_Franczyzowa_ID_spolki, Miasto_ID_Miasta, Manager_klubu_ID_Managera)
VALUES (5, 1100, 5, 5, 5);
INSERT INTO Silownia (ID_silowni, Powierzchnia_klubu, Spolka_Franczyzowa_ID_spolki, Miasto_ID_Miasta, Manager_klubu_ID_Managera)
VALUES (6, 950, 6, 1, 6);
INSERT INTO Silownia (ID_silowni, Powierzchnia_klubu, Spolka_Franczyzowa_ID_spolki, Miasto_ID_Miasta, Manager_klubu_ID_Managera)
VALUES (7, 1050, 7, 2, 7);
INSERT INTO Silownia (ID_silowni, Powierzchnia_klubu, Spolka_Franczyzowa_ID_spolki, Miasto_ID_Miasta, Manager_klubu_ID_Managera)
VALUES (8, 1150, 8, 3, 8);

select *
FROM Silownia;


select *
FROM Wyposazenie_Silownia;

INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (1, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (2, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (3, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (4, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (5, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (6, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (7, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (8, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (9, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (10, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (11, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (12, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (13, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (14, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (15, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (16, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (17, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (18, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (19, 1);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (20, 1);

-- Siłownia 2
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (21, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (22, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (23, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (24, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (25, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (26, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (27, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (28, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (29, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (30, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (31, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (32, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (33, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (34, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (35, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (36, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (37, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (38, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (39, 2);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (40, 2);

-- Siłownia 3
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (41, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (42, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (43, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (44, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (45, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (46, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (47, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (48, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (49, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (50, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (1, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (2, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (3, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (4, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (5, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (6, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (7, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (8, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (9, 3);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (10, 3);

-- Siłownia 4
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (11, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (12, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (13, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (14, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (15, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (16, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (17, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (18, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (19, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (20, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (21, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (22, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (23, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (24, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (25, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (26, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (27, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (28, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (29, 4);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (30, 4);

-- Siłownia 5
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (31, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (32, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (33, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (34, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (35, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (36, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (37, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (38, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (39, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (40, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (41, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (42, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (43, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (44, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (45, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (46, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (47, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (48, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (49, 5);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (50, 5);

-- Siłownia 6
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (1, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (2, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (3, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (4, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (5, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (6, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (7, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (8, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (9, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (10, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (11, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (12, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (13, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (14, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (15, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (16, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (17, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (18, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (19, 6);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (20, 6);

-- Siłownia 7
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (21, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (22, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (23, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (24, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (25, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (26, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (27, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (28, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (29, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (30, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (31, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (32, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (33, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (34, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (35, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (36, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (37, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (38, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (39, 7);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (40, 7);

-- Siłownia 8
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (41, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (42, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (43, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (44, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (45, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (46, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (47, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (48, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (49, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (50, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (1, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (2, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (3, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (4, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (5, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (6, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (7, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (8, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (9, 8);
INSERT INTO Wyposazenie_Silownia (Wyposazenie_ID_wyposazenia, Silownia_ID_silowni) VALUES (10, 8);


--Wizyta klubowiczów w klubach


INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 1, TO_DATE('2024-06-25', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 2, TO_DATE('2024-06-26', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 3, TO_DATE('2024-06-27', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 4, TO_DATE('2024-06-28', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 5, TO_DATE('2024-06-29', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 6, TO_DATE('2024-06-30', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 7, TO_DATE('2024-07-01', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 8, TO_DATE('2024-07-02', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 9, TO_DATE('2024-07-03', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 11, TO_DATE('2024-07-05', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 12, TO_DATE('2024-07-06', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 13, TO_DATE('2024-07-07', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 14, TO_DATE('2024-07-08', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 15, TO_DATE('2024-07-09', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 16, TO_DATE('2024-07-10', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 17, TO_DATE('2024-07-11', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 18, TO_DATE('2024-07-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 19, TO_DATE('2024-07-13', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 20, TO_DATE('2024-07-14', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 21, TO_DATE('2024-07-15', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 22, TO_DATE('2024-07-16', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 23, TO_DATE('2024-07-17', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 24, TO_DATE('2024-07-18', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 25, TO_DATE('2024-07-19', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 26, TO_DATE('2024-07-20', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 27, TO_DATE('2024-07-21', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 28, TO_DATE('2024-07-22', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 29, TO_DATE('2024-07-23', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 30, TO_DATE('2024-07-24', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 31, TO_DATE('2024-07-25', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 32, TO_DATE('2024-07-26', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 33, TO_DATE('2024-07-27', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 34, TO_DATE('2024-07-28', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 35, TO_DATE('2024-07-29', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 36, TO_DATE('2024-07-30', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 37, TO_DATE('2024-07-31', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 38, TO_DATE('2024-08-01', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 39, TO_DATE('2024-08-02', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 40, TO_DATE('2024-08-03', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 41, TO_DATE('2024-08-04', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 42, TO_DATE('2024-08-05', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 43, TO_DATE('2024-08-06', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 44, TO_DATE('2024-08-07', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 45, TO_DATE('2024-08-08', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 46, TO_DATE('2024-08-09', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 47, TO_DATE('2024-08-10', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 48, TO_DATE('2024-08-11', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 49, TO_DATE('2024-08-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 50, TO_DATE('2024-08-13', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 51, TO_DATE('2024-08-14', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 52, TO_DATE('2024-08-15', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 53, TO_DATE('2024-08-16', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 54, TO_DATE('2024-08-17', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 55, TO_DATE('2024-08-18', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 56, TO_DATE('2024-08-19', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 57, TO_DATE('2024-08-20', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 58, TO_DATE('2024-08-21', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 59, TO_DATE('2024-08-22', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 60, TO_DATE('2024-08-23', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 61, TO_DATE('2024-08-24', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 62, TO_DATE('2024-08-25', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 63, TO_DATE('2024-08-26', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 64, TO_DATE('2024-08-27', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 65, TO_DATE('2024-08-28', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 66, TO_DATE('2024-08-29', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 67, TO_DATE('2024-08-30', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 68, TO_DATE('2024-08-31', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 69, TO_DATE('2024-09-01', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 70, TO_DATE('2024-09-02', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 71, TO_DATE('2024-09-03', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 72, TO_DATE('2024-09-04', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 73, TO_DATE('2024-09-05', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 74, TO_DATE('2024-09-06', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 75, TO_DATE('2024-09-07', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 76, TO_DATE('2024-09-08', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 77, TO_DATE('2024-09-09', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 78, TO_DATE('2024-09-10', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 79, TO_DATE('2024-09-11', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 80, TO_DATE('2024-09-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 81, TO_DATE('2024-09-13', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 82, TO_DATE('2024-09-14', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 83, TO_DATE('2024-09-15', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 84, TO_DATE('2024-09-16', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 85, TO_DATE('2024-09-17', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 86, TO_DATE('2024-09-18', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 87, TO_DATE('2024-09-19', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 88, TO_DATE('2024-09-20', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 89, TO_DATE('2024-09-21', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 90, TO_DATE('2024-09-22', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 91, TO_DATE('2024-09-23', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 92, TO_DATE('2024-09-24', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 93, TO_DATE('2024-09-25', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 94, TO_DATE('2024-09-26', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 95, TO_DATE('2024-09-27', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 96, TO_DATE('2024-09-28', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 97, TO_DATE('2024-09-29', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 98, TO_DATE('2024-09-30', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 99, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 100, TO_DATE('2024-10-02', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 101, TO_DATE('2024-10-03', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 102, TO_DATE('2024-10-04', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 103, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 104, TO_DATE('2024-10-06', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 105, TO_DATE('2024-10-07', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 106, TO_DATE('2024-10-08', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 107, TO_DATE('2024-10-09', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 108, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 109, TO_DATE('2024-10-11', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 110, TO_DATE('2024-10-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 111, TO_DATE('2024-10-13', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 112, TO_DATE('2024-10-14', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 113, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 114, TO_DATE('2024-10-16', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 115, TO_DATE('2024-10-17', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 116, TO_DATE('2024-10-18', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 117, TO_DATE('2024-10-19', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 118, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 119, TO_DATE('2024-10-21', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 120, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 121, TO_DATE('2024-10-23', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 122, TO_DATE('2024-10-24', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 123, TO_DATE('2024-10-25', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 124, TO_DATE('2024-10-26', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 125, TO_DATE('2024-10-27', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 126, TO_DATE('2024-10-28', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 127, TO_DATE('2024-10-29', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 128, TO_DATE('2024-10-30', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 129, TO_DATE('2024-10-31', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 130, TO_DATE('2024-11-01', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 131, TO_DATE('2024-11-02', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 132, TO_DATE('2024-11-03', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 133, TO_DATE('2024-11-04', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 134, TO_DATE('2024-11-05', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 135, TO_DATE('2024-11-06', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 136, TO_DATE('2024-11-07', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 137, TO_DATE('2024-11-08', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 138, TO_DATE('2024-11-09', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 139, TO_DATE('2024-11-10', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 140, TO_DATE('2024-11-11', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 141, TO_DATE('2024-11-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 142, TO_DATE('2024-11-13', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 143, TO_DATE('2024-11-14', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 144, TO_DATE('2024-11-15', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 145, TO_DATE('2024-11-16', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 146, TO_DATE('2024-11-17', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 147, TO_DATE('2024-11-18', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 148, TO_DATE('2024-11-19', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 149, TO_DATE('2024-11-20', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 150, TO_DATE('2024-11-21', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 148, TO_DATE('2024-11-19', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 67, TO_DATE('2024-06-30', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 70, TO_DATE('2024-03-02', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 75, TO_DATE('2024-05-07', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 56, TO_DATE('2024-06-15', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 29, TO_DATE('2024-04-23', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 29, TO_DATE('2024-06-03', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (4, 8, TO_DATE('2024-06-02', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 47, TO_DATE('2024-03-20', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 59, TO_DATE('2024-05-28', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 92, TO_DATE('2024-07-11', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 100, TO_DATE('2024-11-05', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 118, TO_DATE('2024-09-20', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (7, 141, TO_DATE('2024-08-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (1, 141, TO_DATE('2024-08-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (2, 141, TO_DATE('2024-08-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (3, 141, TO_DATE('2024-08-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (5, 141, TO_DATE('2024-08-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (6, 141, TO_DATE('2024-08-12', 'YYYY-MM-DD'));
INSERT INTO Klubowicz_Silownia (Silownia_ID_silowni, Klubowicz_ID_Klubowicza, Data) VALUES (8, 141, TO_DATE('2024-08-12', 'YYYY-MM-DD'));

--1.Znajdź wszystkich klubowiczów, którzy dołączyli do siłowni w 2024 roku:
SELECT *
FROM Klubowicz
WHERE EXTRACT(YEAR FROM Data_dolaczenia) = 2024;
--2. Znajdź liczbę klubowiczów, którzy dołączyli do siłowni w każdym miesiącu 2024 roku:

SELECT TO_CHAR(Data_dolaczenia, 'MM') AS Miesiąc, COUNT(*) AS Liczba_klubowiczów
FROM Klubowicz
WHERE EXTRACT(YEAR FROM Data_dolaczenia) = 2024
GROUP BY TO_CHAR(Data_dolaczenia, 'MM')
ORDER BY Miesiąc;

--3. Znajdź imiona i nazwiska wszystkich franczyzobiorców:
SELECT Imię, Nazwisko
FROM Franczyzobiorca;

--4. Znajdź nazwy i ceny wszystkich rodzajów wyposażenia, które znajdują się w siłowni o identyfikatorze (ID) 1:
SELECT W.Nazwa, W.Cena_Katalogowa
FROM Wyposazenie W
JOIN Wyposazenie_Silownia WS ON W.ID_wyposazenia = WS.Wyposazenie_ID_wyposazenia
WHERE WS.Silownia_ID_silowni = 1
ORDER BY W.Cena_Katalogowa;

--5. Znajdź wszystkich klubowiczów, którzy dołączyli do siłowni w 2024 roku i nigdy nie wykupili karnetu:
SELECT K.Imię, K.Nazwisko
FROM Klubowicz K
WHERE EXTRACT(YEAR FROM K.Data_dolaczenia) = 2024
AND NOT EXISTS (
    SELECT *
    FROM Klubowicz_Silownia K2
    WHERE K2.Klubowicz_ID_Klubowicza = K.ID_Klubowicza
);
--6. Znajdź nazwy miast, w których liczba siłowni jest większa niż średnia liczba siłowni na jedno miasto:
SELECT M.Nazwa_Miasta
FROM Miasto_silowni M
JOIN Silownia S ON M.ID_Miasta = S.Miasto_ID_Miasta
GROUP BY M.Nazwa_Miasta
HAVING COUNT(*) > (
    SELECT AVG(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM Miasto_silowni M2
        JOIN Silownia S2 ON M2.ID_Miasta = S2.Miasto_ID_Miasta
        GROUP BY M2.Nazwa_Miasta
    )
);
--7. Znajdź wszystkie rodzaje wyposażenia, które znajdują się w co najmniej trzech siłowni:
SELECT W.Nazwa
FROM Wyposazenie W
JOIN Wyposazenie_Silownia WS ON W.ID_wyposazenia = WS.Wyposazenie_ID_wyposazenia
GROUP BY W.Nazwa
HAVING COUNT(DISTINCT WS.Silownia_ID_silowni) > 3;

--8. Znajdź identyfikatory (ID), imiona i nazwiska oraz nazwy stanowisk wszystkich pracowników niższego szczebla i kierowników:
SELECT P.ID_Pracownika, P.Imię, P.Nazwisko, S.Nazwa
FROM Pracownik_nizszego_szczebla P
JOIN Stanowisko S ON P.Stanowisko_ID_Stanowiska = S.ID_Stanowiska
WHERE S.Nazwa IN ('Pracownik niższego szczebla', 'Trener Personalny');

--9. Znajdź nazwy miast, w których znajdują się siłownie, a także liczbę siłowni w każdym mieście:
SELECT M.Nazwa_Miasta, COUNT(*) AS Liczba_silowni
FROM Miasto_silowni M
JOIN Silownia S ON M.ID_Miasta = S.Miasto_ID_Miasta
GROUP BY M.Nazwa_Miasta
ORDER BY Liczba_silowni DESC;

--10. Znajdź łączną liczbę karnetów wykupionych przez wszystkich klubowiczów w 2024 roku:
SELECT Rodzaj_subskrypcji, SUM(Rodzaj_subskrypcji)
FROM Klubowicz
WHERE EXTRACT(YEAR FROM Data_dolaczenia) = 2024
GROUP BY Rodzaj_subskrypcji;

--11. Znajdź średnią cenę miesięczną karnetów:
SELECT AVG(RS.Cena) AS Srednia_cena_miesieczna
FROM Rodzaj_subskrypcji RS
JOIN Klubowicz_Silownia KS ON RS.ID_Subskrypcji = KS.Klubowicz_ID_Klubowicza
JOIN Klubowicz K ON KS.Klubowicz_ID_Klubowicza = K.ID_Klubowicza;

--12. Znajdź liczbę klubowiczów, którzy dołączyli do siłowni w każdym kwartale 2024 roku:
SELECT
    CASE
        WHEN EXTRACT(MONTH FROM Data_dolaczenia) IN (1, 2, 3) THEN 'Q1'
        WHEN EXTRACT(MONTH FROM Data_dolaczenia) IN (4, 5, 6) THEN 'Q2'
        WHEN EXTRACT(MONTH FROM Data_dolaczenia) IN (7, 8, 9) THEN 'Q3'
        ELSE 'Q4'
    END AS Kwartał,
    COUNT(*) AS Liczba_klubowiczów
FROM Klubowicz
WHERE EXTRACT(YEAR FROM Data_dolaczenia) = 2024
GROUP BY
    CASE
        WHEN EXTRACT(MONTH FROM Data_dolaczenia) IN (1, 2, 3) THEN 'Q1'
        WHEN EXTRACT(MONTH FROM Data_dolaczenia) IN (4, 5, 6) THEN 'Q2'
        WHEN EXTRACT(MONTH FROM Data_dolaczenia) IN (7, 8, 9) THEN 'Q3'
        ELSE 'Q4'
    END
ORDER BY Kwartał;

--13.Znajdź wszystkie miasta, w których znajdują się siłownie, które mają powierzchnię klubu powyżej 1000 m².
SELECT MS.Nazwa_Miasta, S.ID_silowni
FROM Miasto_silowni MS
JOIN Silownia S ON MS.ID_Miasta = S.Miasto_ID_Miasta
WHERE S.Powierzchnia_klubu > 1000;

--14.Znajdź wszystkie siłownie zarządzane przez managerów o imieniu 'Anna'.
SELECT S.ID_silowni, S.Powierzchnia_klubu, M.Imię, M.Nazwisko
FROM Silownia S
JOIN Manager_klubu M ON S.Manager_klubu_ID_Managera = M.ID_Managera
WHERE M.Imię = 'Anna';

--15.Znajdź średnią liczbę ludności miasta, w którym znajduje się każda siłownia.
SELECT MS.Nazwa_Miasta, AVG(MS.Liczba_ludności) AS Średnia_ludność
FROM Miasto_silowni MS
JOIN Silownia S ON MS.ID_Miasta = S.Miasto_ID_Miasta
GROUP BY MS.Nazwa_Miasta;

--16.Policz liczbę pracowników niższego szczebla dla każdej spółki franczyzowej.
SELECT SF.ID_spolki, COUNT(*) AS Liczba_pracowników
FROM Spolka_Franczyzowa SF
JOIN Pracownik_nizszego_szczebla PNS ON SF.ID_spolki = PNS.Spolka_Franczyzowa_ID_spolki
GROUP BY SF.ID_spolki;

SELECT * from Silownia;
--17.Znajdź wszystkie siłownie, które mają wyposażenie kosztujące więcej niż 1000 PLN.
SELECT S.ID_silowni, S.Powierzchnia_klubu,M.Nazwa_Miasta, SUM(W.Cena_Katalogowa)
FROM Silownia S
INNER JOIN Wyposazenie_Silownia WS ON S.ID_silowni = WS.Silownia_ID_silowni
INNER JOIN Wyposazenie W ON WS.Wyposazenie_ID_wyposazenia = W.ID_wyposazenia
INNER JOIN Miasto_silowni M ON M.ID_Miasta = S.Miasto_ID_Miasta
GROUP BY S.ID_silowni, S.Powierzchnia_klubu, M.Nazwa_Miasta;

--18.Znajdź wszystkich klubowiczów, którzy są zapisani do więcej niż jednej siłowni:
SELECT k.ID_Klubowicza, k.Imię, k.Nazwisko, COUNT(ks.Silownia_ID_silowni) AS Liczba_Siłowni
FROM Klubowicz k
JOIN Klubowicz_Silownia ks ON k.ID_Klubowicza = ks.Klubowicz_ID_Klubowicza
GROUP BY k.ID_Klubowicza, k.Imię, k.Nazwisko
HAVING COUNT(ks.Silownia_ID_silowni) > 1;

--19.Znajdź klubowiczów, którzy dołączyli po 1 stycznia 2023 roku i mają subskrypcję typu 'Premium':
SELECT k.ID_Klubowicza, k.Imię, k.Nazwisko, k.Data_dolaczenia
FROM Klubowicz k
JOIN Rodzaj_subskrypcji rs ON k.Rodzaj_subskrypcji = rs.ID_Subskrypcji
WHERE k.Data_dolaczenia > TO_DATE('2023-01-01', 'YYYY-MM-DD') AND rs.Nazwa = 'Premium';

--20.Znajdź najdroższe wyposażenie w każdej siłowni:
SELECT s.ID_silowni, s.Powierzchnia_klubu, w.ID_wyposazenia, w.Nazwa, w.Cena_Katalogowa
FROM Silownia s
JOIN Wyposazenie_Silownia ws ON s.ID_silowni = ws.Silownia_ID_silowni
JOIN Wyposazenie w ON ws.Wyposazenie_ID_wyposazenia = w.ID_wyposazenia
WHERE w.Cena_Katalogowa = (
    SELECT MAX(w2.Cena_Katalogowa)
    FROM Wyposazenie_Silownia ws2
    JOIN Wyposazenie w2 ON ws2.Wyposazenie_ID_wyposazenia = w2.ID_wyposazenia
    WHERE ws2.Silownia_ID_silowni = s.ID_silowni
);
--21.Znajdź wszystkich klubowiczów, którzy odwiedzili każdą siłownię w systemie:
SELECT k.ID_Klubowicza, k.Imię, k.Nazwisko
FROM Klubowicz k
WHERE NOT EXISTS (
    SELECT s.ID_silowni
    FROM Silownia s
    WHERE NOT EXISTS (
        SELECT ks.Silownia_ID_silowni
        FROM Klubowicz_Silownia ks
        WHERE ks.Silownia_ID_silowni = s.ID_silowni
        AND ks.Klubowicz_ID_Klubowicza = k.ID_Klubowicza
    )
);

--22.Znajdź wszystkie siłownie, które mają powierzchnię klubu większą niż średnia powierzchnia klubów:
SELECT s.ID_silowni, s.Powierzchnia_klubu
FROM Silownia s
WHERE s.Powierzchnia_klubu > (
    SELECT AVG(s2.Powierzchnia_klubu)
    FROM Silownia s2
);
--23.Znajdź najmniej popularny rodzaj subskrypcji (tzn. ten, który ma najmniej klubowiczów):
SELECT rs.ID_Subskrypcji, rs.Nazwa, COUNT(k.Rodzaj_subskrypcji) AS Liczba_Klubowiczow
FROM Rodzaj_subskrypcji rs
LEFT JOIN Klubowicz k ON rs.ID_Subskrypcji = k.Rodzaj_subskrypcji
GROUP BY rs.ID_Subskrypcji, rs.Nazwa
ORDER BY Liczba_Klubowiczow
FETCH FIRST 1 ROWS ONLY;-- only 1 record

--24.Znajdź wszystkie miasta, w których znajdują się siłownie zarządzane przez więcej niż jednego menedżera klubu:
SELECT ms.ID_Miasta, ms.Nazwa_Miasta, COUNT(DISTINCT s.Manager_klubu_ID_Managera) AS Liczba_Menedżerów
FROM Miasto_silowni ms
JOIN Silownia s ON ms.ID_Miasta = s.Miasto_ID_Miasta
GROUP BY ms.ID_Miasta, ms.Nazwa_Miasta
HAVING COUNT(DISTINCT s.Manager_klubu_ID_Managera) > 1;

--25.Znajdź wszystkie miasta, w których średnia liczba ludności wynosi więcej niż 700000, oraz wyświetl liczbę siłowni w każdym z tych miast:
SELECT ms.ID_Miasta, ms.Nazwa_Miasta, AVG(ms.Liczba_ludności) AS Średnia_Ludność, COUNT(s.ID_silowni) AS Liczba_Siłowni
FROM Miasto_silowni ms
JOIN Silownia s ON ms.ID_Miasta = s.Miasto_ID_Miasta
GROUP BY ms.ID_Miasta, ms.Nazwa_Miasta
HAVING AVG(ms.Liczba_ludności) > 700000;


--26. Znajdź imiona i nazwiska klubowiczów oraz pracowników niższego szczebla w jednym zestawieniu
SELECT Imię, Nazwisko, 'Klubowicz' AS Typ
FROM Klubowicz
UNION
SELECT Imię, Nazwisko, 'Pracownik niższego szczebla' AS Typ
FROM Pracownik_nizszego_szczebla;
--27. Usuń wszystkie siłownie, które mają powierzchnię klubu mniejszą niż 500 m²
DELETE FROM Silownia
WHERE Powierzchnia_klubu < 500;

--28
INSERT INTO Klubowicz (Imię, Nazwisko, Data_dolaczenia, Rodzaj_subskrypcji)
VALUES ('Jan', 'Kowalski', '2024-06-26', 151);

--29. Znajdź wszystkie siłownie, które mają powierzchnię klubu większą niż jakakolwiek siłownia w mieście o nazwie 'Warszawa'
SELECT S.ID_silowni, S.Powierzchnia_klubu
FROM Silownia S
WHERE S.Powierzchnia_klubu > ANY (
    SELECT S2.Powierzchnia_klubu
    FROM Silownia S2
    JOIN Miasto_silowni M ON S2.Miasto_ID_Miasta = M.ID_Miasta
    WHERE M.Nazwa_Miasta = 'Warszawa'
);
-- 30.Znajdź wszystkie siłownie, które mają powierzchnię klubu większą niż wszystkie siłownie w mieście o nazwie 'Kraków'
SELECT S.ID_silowni, S.Powierzchnia_klubu
FROM Silownia S
WHERE S.Powierzchnia_klubu > ALL (
    SELECT S2.Powierzchnia_klubu
    FROM Silownia S2
    JOIN Miasto_silowni M ON S2.Miasto_ID_Miasta = M.ID_Miasta
    WHERE M.Nazwa_Miasta = 'Kraków'
);