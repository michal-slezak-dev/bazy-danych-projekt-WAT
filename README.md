# Projekt Bazy Danych dla Biura Nieruchomości

## Autor
Michał Ślęzak

## Prowadzący ćwiczenia laboratoryjne
Dr inż. Jarosław Koszela

## Prowadzący wykłady
Dr inż. Maciej Kiedrowicz
Mgr inż. Józef Woźniak

---

## Wprowadzenie
Celem projektu jest stworzenie relacyjnej bazy danych wspierającej procesy biznesowe biura nieruchomości. Baza obsługuje zarządzanie ofertami sprzedaży i wynajmu nieruchomości, umowami, transakcjami oraz agentami.

## Opis projektu
Projekt bazy danych dla biura nieruchomości ma na celu wspieranie procesów biznesowych biura, m.in. związanych z zarządzaniem ofertami sprzedaży i wynajmu nieruchomości, ich statusami, zarządzaniem umowami, oraz transakcjami finalizowanymi przez biuro. Baza danych została zaprojektowana w taki sposób, aby efektywnie obsługiwała takie funkcje jak: dodawanie, edytowanie ofert, zarządzanie umowami i transakcjami czy łatwiejszy dostęp do podglądu wyników działalności samego biura i jego agentów.

## Analiza wymagań
Właściciel może mieć wiele nieruchomości, ale nieruchomość ma jednego właściciela, aby ułatwić komunikację i zarządzanie nieruchomościami na poziomie biuro – właściciel. Dane właściciela, agenta i klienta takie jak ich PESEL, numer dowodu osobistego, email czy numer telefonu muszą być unikalne i muszą  być określone. Każda nieruchomość ma swój określony typ (rodzaj) i status (stan techniczny i wizualny). Nieruchomość może mieć udogodnienia. Agenci opiekują się danymi ofertami. Każda oferta ma swój typ (sprzedaż czy wynajem) oraz status (aktywna/zakończona). Agenci mogą prowadzić wizyty w nieruchomościach dla danych klientów. Jeśli klient jest zainteresowany i zdecydowany to sporządzana jest umowa wstępna z wszelkimi informacjami o kliencie, agencie jak i samej ofercie nieruchomości, służy do m.in. statystyki działalności biura, umowa wiążąca prawnie odnośnie sprzedaży/wynajmu nieruchomości jest sporządzana u notariusza a nie w biurze. Po podpisaniu umowy (opiewającą na ustaloną cenę nieruchomości lub czynszu miesięcznego wynajmu), przeprowadzana jest transakcja na kwotę 8% wartości ceny danej nieruchomości w ramach sprzedaży lub jednego całego miesięcznego czynszu w przypadku wynajmu, która to następnie będzie podzielona między biuro i agenta. Nieruchomość może mieć tylko jedną aktywną ofertę, ale wiele zakończonych. Jeśli dana nieruchomość została sprzedana lub wynajęta, wszystkie zaplanowane wizyty w przyszłości są usuwane z kalendarza wizyt. Agenci pracują (odbywają wizyty) między 9:00 a 20:00. Procent prowizji agenta wynosi co najmniej 1%. Gdy mamy do czynienia z działką to liczba pokoi i łazienek jest pusta, to samo tyczy się numeru mieszkania dla domu.

### Zakres funkcjonalności
- Zarządzanie nieruchomościami
- Obsługa klientów i wizyt
- Zarządzanie umowami i transakcjami
- Monitorowanie pracy agentów
- Automatyzacja i analiza działalności

## Wymagania Projektowe
- Minimum 10 tabel
- Minimum 3 widoki (1 funkcjonalny, 1 zmaterializowany)
- Minimum 3 triggery
- Minimum 3 procedury
- Minimum 3 funkcje
- Minimum 1 transakcja
- Minimum 1 funkcja kursora

Projekt wykonano w dwóch narzędziach:
- **Sybase SQL Anywhere** (zaawansowane narzędzie)
- **PostgreSQL** (open-source)

---

## Struktura Bazy Danych
### Kluczowe encje
- **osoba** – encja abstrakcyjna, po której dziedziczą wlasciciel, klient oraz agent
- **wlasciciel** – osoba fizyczna będąca w posiadaniu nieruchomości. Na potrzeby projektu zakładamy, że w systemie biura jako właściciel danej nieruchomości będzie wpisana jedna osoba
- **status_nieruchomosci** – reprezentuje stan techniczny i wizualny nieruchomości, np. do remontu/do odświeżenia/stan deweloperski/stan surowy otwarty/zamknięty/stan pod klucz/czysta/zarośnieta, w zależności czy to dom, mieszkanie czy działka
- **typ_nieruchomosci** – reprezentuje typ nieruchomości, w celu ich klasyfikacji, np. dom wolnostojacy/blizniak/szeregowiec/mieszkanie/działka
- **nieruchomość** – obiekt fizyczny w postaci budynku lub terenu o danym adresie i jego właściwościach
- **udogodnienia** - reprezentuje udogodnienia, które posiada dana nieruchomość, np. garaż, kuchnia otwarta, pralka, zmywarka, winda, klimatyzacja, kanalizacja, wodociąg, gaz, prąd, kominek, spiżarnia, ogród, balkon itp.
- **nieruchomosc_udogodnienia** – związek między encją nieruchomosc a udogodnienia, reprezentujący związek wiele do wielu. Posiada informacje o tym jakie udogodnienia ma dana nieruchomość
- **oferta** – reprezentuje ofertę sprzedaży lub wynajmu nieruchomości wraz z wszelkimi potrzebnymi informacjami o ofercie dla potencjalnego klienta, tj. id agenta opiekującego się ofertą oraz samej nieruchomości, np. jej cenie (cenę nieruchomości zazwyczaj podaje się jako liczbę całkowitą, tak też przyjąłem). Cena dla oferty sprzedaży to cena nieruchomości a w przypadku oferty wynajmu jest to kwota miesięcznego czynszu najmu
- **status_oferty** - określa bieżący status oferty, np. aktywna/zakończona
- **umowa** – reprezentuje wstępną umowę prawną (docelową umową, spełniającą wszelkie wymogi formalne zajmuje się notariusz) zwieńczającą sprzedaż lub wynajem danej nieruchomości. Zawiera szczegóły dotyczące właściciela, klienta, agenta oraz oferty, na podstawie której została sporządzona (kwota - ostateczna uzgodniona kwota kupna/wynajmu danej nieruchomości)
- **transakcja** – opisuje płatności związane z umowami wstępnymi, na podstawie których klienci płacą sumaryczną kwotę prowizji, która potem będzie podzielona między biuro i danego klienta (kwota_prowizji --> 8% od ceny nieruchomości w przypadku oferty sprzedaży oraz jeden miesięczny czynsz w przypadku oferty wynajmu nieruchomości)
- **agent** – osoba fizyczna, będąca pracownikiem biura nieruchomości, opiekująca się daną ofertą i zajmująca się obsługą klientów w procesie sprzedaży/wynajmu nieruchomości oraz prowadzenia wizyt w nich
- **klient** – osoba fizyczna, korzystająca z usług biura nieruchomości w celu nabycia lub wynajmu nieruchomości
- **wizyta** – reprezentuje wizyty w nieruchomościach organizowane przez biuro nieruchomości i prowadzone przez danego agenta opiekującego się daną ofertą, posiada informacje o wizycie danego klienta na nieruchomości, o tym kliencie i agencie, który się daną ofertą opiekuje
- **prowizja** - reprezentuje prowizje z podziałem na prowizje agenta oraz biura na podstawie danej transakcji (prowizja_agenta - dla oferty sprzedaży to będzie to równe procentowi agenta z tabeli agent a w przypadku oferty wynajmu to 45% miesięcznego czynszu, prowizja_biura - 8% od ceny nieruchomości - procent_agenta z tej kwoty w przypadku oferty sprzedaży a w przypadku oferty wynajmu to kwota_prowizji - 45% miesięcznego czynszu, czyli prowizja agenta)

### Dopuszczalne wartości
- **Status nieruchomości:** do remontu, do odświeżenia, stan deweloperski, stan surowy otwarty, stan surowy zamknięty, stan pod klucz, czysta, zarośnięta
- **Typ nieruchomości:** dom wolnostojący, bliźniak, szeregowiec, mieszkanie, działka budowlana, działka rolna, działka siedliskowa, działka rekreacyjna, działka leśna , działka inwestycyjna
- **Typ oferty:** sprzedaż, wynajem
- **Status oferty:** aktywna, zakończona
- **Status umowy:** podpisana, zrealizowana

---

## Widoki
- **v_nieskuteczne_wizyty** – nieruchomości z największą liczbą odbytych wizyt w poprzednim miesiącu a nadal są aktywne, posortowane malejąco.
- **mv_top_agenci_transakcje** – ranking agentów z największą liczbą transakcji
- **v_wizyty_na_dzien** – harmonogram wizyt na dany dzień

## Triggery
- **aktualizuj_status_oferty** – zmienia status oferty na „zakończona” po podpisaniu umowy
- **usun_wizyty_zakonczona_oferta** – usuwa przyszłe wizyty dla nieruchomości po zakończeniu oferty
- **sprawdz_prowizje** – uniemożliwia dodanie prowizji bez powiązanej transakcji

## Procedury
- **dodaj_wizyte** – planowanie wizyty dla aktywnej oferty
- **dodaj_umowe** – tworzenie umowy dla aktywnej oferty
- **dodaj_oferte** – dodawanie oferty dla nieruchomości lub aktualizacja istenijącej aktywnej oferty po podaniu parametru p_update
- **aktualizuj_wizyte** – aktualizacja terminu wizyty
- **finalizuj_transakcje** – rejestracja transakcji i obliczenie prowizji

## Funkcje
- **fn_przychody_z_transakcji** – oblicza całkowite przychody z transakcji za dany miesiąc bieżącego roku
- **fn_top_oferta_agenta** – zwraca aktywną ofertę agenta z największą liczbą wizyt
- **fn_oblicz_prowizje** – oblicza prowizję agenta i biura

---

## Modele bazy danych
- **Model konceptualny**
![image](https://github.com/user-attachments/assets/2451b6bd-1b6f-4311-87d1-337a94914e7f)

- **Model fizyczny**
![image](https://github.com/user-attachments/assets/1b6ab62a-9eba-4538-a058-519f751c2839)


## Podsumowanie
Projekt bazy danych dla biura nieruchomości dostarcza kompleksowe rozwiązanie do zarządzania nieruchomościami, ofertami, klientami i transakcjami. 

---

**Autor:** Michał Ślęzak  
**Rok:** 2024
