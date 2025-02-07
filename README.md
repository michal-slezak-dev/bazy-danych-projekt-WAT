##Projekt Bazy Danych dla biura nieruchomości##

Jest to projekt bazy danych wraz z implementacją w Sybase oraz PostgreSQL. Zostało to wykonane w ramach projektu zaliczeniowego z przedmiotu Bazy Danych na 3. semestrze studiów
na kierunku informatyka WCY WAT.

Projekt oczywiście nie jest idealny, nie uwzględnia wszystkich edge case'ów, są rzeczy, które mogłyby zostać dodane i/lub zrobione lepiej. 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 
Projekt bazy danych dla biura nieruchomości

Wprowadzenie
Treść zadania
Stworzyć projekt nietrywialnej, relacyjnej bazy danych, która ma mieć:
•	Minimum 10 tabel
•	Minimum 3 widoki, z czego:
o	Minimum 1 funkcjonalny
o	Minimum 1 zmaterializowany
•	Minimum 3 triggery
•	Minimum 3 procedury
•	Minimum 3 funkcje
•	Minimum 1 transakcja
•	Minimum 1 funkcja kursora

Projekt ma być wykonany w 2 narzędziach:
•	1 ma być z grupy zaawansowanych (np. Oracle, Sybase itp.)
•	2 ma być z grupy narzędzi open source (np. PostgreSQL itp.)

Opis projektu
Projekt bazy danych dla biura nieruchomości ma na celu wspieranie procesów biznesowych biura, m.in. związanych z zarządzaniem ofertami sprzedaży i wynajmu nieruchomości, ich statusami, zarządzaniem umowami, oraz transakcjami finalizowanymi przez biuro. Baza danych została zaprojektowana w taki sposób, aby efektywnie obsługiwała takie funkcje jak: dodawanie, edytowanie ofert, zarządzanie umowami i transakcjami czy łatwiejszy dostęp do podglądu wyników działalności samego biura i jego agentów.

Zakres funkcjonalności bazy danych obejmuje m.in.:
•	Zarządzanie nieruchomościami (przechowywanie informacji o nich)
•	Zarządzanie ofertami
•	Obsługę klientów (wizytacje nieruchomości, podpisywanie umów)
•	Transakcje związane z zarządzanymi nieruchomościami
•	Pracę agentów
•	Statusy i typy umów, ofert oraz typy nieruchomości
•	Automatyzacja i analiza wyników działalności biura i agentów
Analiza wymagań
Właściciel może mieć wiele nieruchomości, ale nieruchomość ma jednego właściciela, aby ułatwić komunikację i zarządzanie nieruchomościami na poziomie biuro – właściciel. Dane właściciela, agenta i klienta takie jak ich PESEL, numer dowodu osobistego, email czy numer telefonu muszą być unikalne i muszą  być określone. Każda nieruchomość ma swój określony typ (rodzaj) i status (stan techniczny i wizualny). Nieruchomość może mieć udogodnienia. Agenci opiekują się danymi ofertami. Każda oferta ma swój typ (sprzedaż czy wynajem) oraz status (aktywna/zakończona). Agenci mogą prowadzić wizyty w nieruchomościach dla danych klientów. Jeśli klient jest zainteresowany i zdecydowany to sporządzana jest umowa wstępna z wszelkimi informacjami o kliencie, agencie jak i samej ofercie nieruchomości, służy do m.in. statystyki działalności biura, umowa wiążąca prawnie odnośnie sprzedaży/wynajmu nieruchomości jest sporządzana u notariusza a nie w biurze. Po podpisaniu umowy (opiewającą na ustaloną cenę nieruchomości lub czynszu miesięcznego wynajmu), przeprowadzana jest transakcja na kwotę 8% wartości ceny danej nieruchomości w ramach sprzedaży lub jednego całego miesięcznego czynszu w przypadku wynajmu, która to następnie będzie podzielona między biuro i agenta. Nieruchomość może mieć tylko jedną aktywną ofertę, ale wiele zakończonych. Jeśli dana nieruchomość została sprzedana lub wynajęta, wszystkie zaplanowane wizyty w przyszłości są usuwane z kalendarza wizyt. Agenci pracują (odbywają wizyty) między 9:00 a 20:00. Procent prowizji agenta wynosi co najmniej 1%. Gdy mamy do czynienia z działką to liczba pokoi i łazienek jest pusta, to samo tyczy się numeru mieszkania dla domu.
Wyróżnione pozycje na diagramie konceptualnym:
osoba – encja abstrakcyjna, po której dziedziczą wlasciciel, klient oraz agent.
wlasciciel – osoba fizyczna będąca w posiadaniu nieruchomości. Na potrzeby projektu zakładamy, że w systemie biura jako właściciel danej nieruchomości będzie wpisana jedna osoba.
status_nieruchomosci – reprezentuje stan techniczny i wizualny nieruchomości, np. do remontu/do odświeżenia/stan deweloperski/stan surowy otwarty/zamknięty/stan pod klucz/czysta/zarośnieta, w zależności czy to dom, mieszkanie czy działka
typ_nieruchomosci – reprezentuje typ nieruchomości, w celu ich klasyfikacji, np. dom wolnostojacy/blizniak/szeregowiec/mieszkanie/działka.
nieruchomosc - obiekt fizyczny w postaci budynku lub terenu o danym adresie i jego właściwościach
udogodnienia - reprezentuje udogodnienia, które posiada dana nieruchomość, np. garaż, kuchnia otwarta, pralka, zmywarka, winda, klimatyzacja, kanalizacja, wodociąg, gaz, prąd, kominek, spiżarnia, ogród, balkon itp.
nieruchomosc_udogodnienia – związek między encją nieruchomosc a udogodnienia, reprezentujący związek wiele do wielu. Posiada informacje o tym jakie udogodnienia ma dana nieruchomość.
oferta - reprezentuje ofertę sprzedaży lub wynajmu nieruchomości wraz z wszelkimi potrzebnymi informacjami o ofercie dla potencjalnego klienta, tj. id agenta opiekującego się ofertą oraz samej nieruchomości, np. jej cenie (cenę nieruchomości zazwyczaj podaje się jako liczbę całkowitą, tak też przyjąłem). Cena dla oferty sprzedaży to cena nieruchomości a w przypadku oferty wynajmu jest to kwota miesięcznego czynszu najmu.
status_oferty - określa bieżący status oferty, np. aktywna/zakończona
typ_oferty - określa charakter oferty, np. sprzedaż, wynajem
umowa - reprezentuje wstępną umowę prawną (docelową umową, spełniającą wszelkie wymogi formalne zajmuje się notariusz) zwieńczającą sprzedaż lub wynajem danej nieruchomości. Zawiera szczegóły dotyczące właściciela, klienta, agenta oraz oferty, na podstawie której została sporządzona (kwota - ostateczna uzgodniona kwota kupna/wynajmu danej nieruchomości)
status_umowy - określa bieżący status umowy, np. podpisana/zrealizowana
transakcja - opisuje płatności związane z umowami wstępnymi, na podstawie których klienci płacą sumaryczną kwotę prowizji, która potem będzie podzielona między biuro i danego klienta (kwota_prowizji --> 8% od ceny nieruchomości w przypadku oferty sprzedaży oraz jeden miesięczny czynsz w przypadku oferty wynajmu nieruchomości)
agent - osoba fizyczna, będąca pracownikiem biura nieruchomości, opiekująca się daną ofertą i zajmująca się obsługą klientów w procesie sprzedaży/wynajmu nieruchomości oraz prowadzenia wizyt w nich.
klient - osoba fizyczna, korzystająca z usług biura nieruchomości w celu nabycia lub wynajmu nieruchomości.
wizyta - reprezentuje wizyty w nieruchomościach organizowane przez biuro nieruchomości i prowadzone przez danego agenta opiekującego się daną ofertą, posiada informacje o wizycie danego klienta na nieruchomości, o tym kliencie i agencie, który się daną ofertą opiekuje
prowizja - reprezentuje prowizje z podziałem na prowizje agenta oraz biura na podstawie danej transakcji (prowizja_agenta - dla oferty sprzedaży to będzie to równe procentowi agenta z tabeli agent a w przypadku oferty wynajmu to 45% miesięcznego czynszu, prowizja_biura - 8% od ceny nieruchomości - procent_agenta z tej kwoty w przypadku oferty sprzedaży a w przypadku oferty wynajmu to kwota_prowizji - 45% miesięcznego czynszu, czyli prowizja agenta)
Dopuszczalne wartości
Kwoty prowizji, transakcji, kolumny, które są wartościami liczbowymi muszą być >= 0, z wyjątkiem liczby pokoi i łazienek, które jeśli nie są NULL to musza być > 0.
Status nieruchomości: do remontu, do odświeżenia, stan deweloperski, stan surowy otwarty, stan surowy zamknięty, stan pod klucz, czysta, zarośnięta
Typ nieruchomości: dom wolnostojący, bliźniak, szeregowiec, mieszkanie, działka budowlana, działka rolna, działka siedliskowa, działka rekreacyjna, działka leśna , działka inwestycyjna
Typ oferty: sprzedaż, wynajem
Status oferty: aktywna, zakończona
Status umowy: podpisana, zrealizowana
Modele bazy danych
Model konceptualny
 
Model fizyczny
 
Widoki
Widok v_nieskuteczne_wizyty wyświetlający nieruchomości z największą liczbą odbytych wizyt w poprzednim miesiącu a nadal są aktywne, posortowane malejąco. Pomaga w analizie, które nieruchomości są najbardziej interesujące dla klientów, dzięki czemu będzie wiadomo, które nieruchomości lepiej wypromować.

Widok zmaterializowany mv_top_agenci_transakcje zawierający dane o agentach z największą liczbą zakończonych transakcji posortowany malejąco, który pozwoli na szybką analizę skuteczności poszczególnych agentów (status umowy to zrealizowana).

Widok v_wizyty_na_dzien wyświetlający harmonogram wizyt w danym dniu, w tym dane o kliencie, agencie i nieruchomości z oferty, której ta wizyta dotyczy. Ułatwi to organizację harmonogramu wizyt dla kadry zarządzającej biura.
Triggery
Trigger aktualizuj_status_oferty, który po podpisaniu umowy (gdy status umowy to podpisana) zmienia status oferty na ‘zakończona’.

Trigger usun_wizyty_zakonczona_oferta, który usuwa wszystkie przyszłe powiązane, zaplanowane wizyty dla nieruchomości z danej oferty, gdy status oferty zmieni się na ‘zakończona’.

Trigger sprawdz_prowizje, który działa na tabeli prowizja i jeśli próbujemy dodać prowizję, ale nie ma powiązanej z nią transakcji to wyrzuca błąd i nie pozwala dodać tej prowizji.

Procedury
Procedura dodaj_wizyte, która umożliwia zaplanowanie wizyty w związku z ofertą, która jest aktywna.

Procedura dodaj_umowe, która dodaje umowę wraz z jednym ze statusów (podpisana), sprawdzając czy oferta, której dotyczy umowa jest aktywna.

Procedura dodaj_oferte, która dodaje ofertę dla danej nieruchomości, ale tylko wtedy gdy nie ma innej aktywnej oferty dla tej nieruchomości, jeśli jest to wywala błąd, bo nie może być dwóch aktywnych ofert dla tej samej nieruchomości. Chyba że w wywołaniu procedury podany zostanie parametr p_update od update, co zaktualizuje po prostu aktywną ofertę, jeśli istnieje.

Procedura aktualizuj_wizyte, która aktualizuje termin wizyty na danej nieruchomości.

Procedura z transakcją finalizuj_transakcje, która dodaje transakcje dla danej umowy(pod warunkiem, że status umowy to ‘podpisana’), zmienia status umowy na ‘zrealizowana’ i dodaje prowizje agenta i biura do tabeli prowizja.

Funkcje
Funkcja z kursorem fn_przychody_z_transakcji, która oblicza całkowite przychody z transakcji z danego miesiąca bieżącego roku.

Funkcja z kursorem fn_top_oferta_agenta, która zwraca id aktywnej oferty danego agenta, która miała najwięcej wizyt w ciągu miesiąca.

Funkcja fn_oblicz_prowizje, która zwraca obliczoną prowizję agenta oraz biura (przydatna w transakcji finalizuj_transakcje)


