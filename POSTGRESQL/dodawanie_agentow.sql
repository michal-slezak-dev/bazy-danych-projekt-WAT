ALTER TABLE agent
ADD CONSTRAINT CKC_DATA_ZATRUDNIENIA CHECK (agent.data_zatrudnienia <= CURRENT_DATE )

-- następnie
INSERT INTO agent (id_osoby, PESEL, nr_dowodu_osobistego, imie, nazwisko, email, nr_tel, data_zatrudnienia, procent_prowizji)
VALUES
    (1, '75010123456', 'ABC111222', 'Paweł', 'Kowalczyk', 'pawel.kowalczyk@biuro.pl', '789123456', '2020-01-15', 3.5),
    (2, '80020234567', 'DEF333444', 'Anna', 'Malinowska', 'anna.malinowska@biuro.pl', '678234567', '2021-05-10', 2.5),
    (3, '83050345678', 'GHI555666', 'Marek', 'Domański', 'marek.domanski@biuro.pl', '567345678', '2019-09-20', 3.0),
    (4, '85060456789', 'JKL777888', 'Ewelina', 'Jabłońska', 'ewelina.jablonska@biuro.pl', '456456789', '2022-02-01', 3.0),
    (5, '86070567890', 'MNO999000', 'Tomasz', 'Górski', 'tomasz.gorski@biuro.pl', '345567890', '2020-07-30', 3.4),
    (6, '88080678901', 'PQR123987', 'Beata', 'Nowicka', 'beata.nowicka@biuro.pl', '234678901', '2023-01-05', 2.0),
    (7, '90090789012', 'STU654321', 'Adrian', 'Majewski', 'adrian.majewski@biuro.pl', '123789012', '2018-11-15', 3.7),
    (8, '91010890123', 'VWX987654', 'Klaudia', 'Olszewska', 'klaudia.olszewska@biuro.pl', '012890123', '2021-08-22', 2.1);
