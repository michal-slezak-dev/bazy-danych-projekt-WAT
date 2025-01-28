/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     28.01.2025 15:38:52                          */
/*==============================================================*/

create sequence s_agent;

create sequence s_klient;

create sequence s_nieruchomosc;

create sequence s_oferta;

create sequence s_prowizja;

create sequence s_status_nieruchomosci;

create sequence s_status_oferty;

create sequence s_status_umowy;

create sequence s_transakcja;

create sequence s_typ_nieruchomosci;

create sequence s_typ_oferty;

create sequence s_udogodnienia;

create sequence s_umowa;

create sequence s_wizyta;

create sequence s_wlasciciel;

/*==============================================================*/
/* Table: agent                                                 */
/*==============================================================*/
create table agent (
   id_osoby             SERIAL not null,
   PESEL                VARCHAR(11)          not null unique,
   nr_dowodu_osobistego VARCHAR(9)           not null unique,
   data_zatrudnienia    DATE                 not null,
   procent_prowizji     DECIMAL(5,2)         not null
      constraint CKC_PROCENT_PROWIZJI_AGENT check (procent_prowizji >= 1),
   imie                 VARCHAR(16)          not null,
   nazwisko             VARCHAR(52)          not null,
   email                VARCHAR(255)         not null unique,
   nr_tel               VARCHAR(9)           not null unique,
   constraint PK_AGENT primary key (id_osoby)
);

comment on table agent is
'agent - osoba fizyczna, b�d�ca pracownikiem biura nieruchomo�ci, opiekuj�ca si� dan� ofert� i zajmuj�ca si� obs�ug� klient�w w procesie sprzeda�y/wynajmu nieruchomo�ci oraz prowadzenia wizyt w nich.';

/*==============================================================*/
/* Table: klient                                                */
/*==============================================================*/
create table klient (
   id_osoby             SERIAL not null,
   PESEL                VARCHAR(11)          not null unique,
   nr_dowodu_osobistego VARCHAR(9)           not null unique,
   imie                 VARCHAR(16)          not null,
   nazwisko             VARCHAR(52)          not null,
   email                VARCHAR(255)         null unique,
   nr_tel               VARCHAR(9)           not null unique,
   constraint PK_KLIENT primary key (id_osoby)
);

comment on table klient is
'klient - osoba fizyczna, korzystaj�ca z us�ug biura nieruchomo�ci w celu nabycia lub wynajmu nieruchomo�ci. ';

/*==============================================================*/
/* Table: nieruchomosc                                          */
/*==============================================================*/
create table nieruchomosc (
   id_nieruchomosci     SERIAL not null,
   id_typu_nieruchomosci INTEGER                 not null,
   id_statusu_nieruchomosci INTEGER                 not null,
   id_osoby             INTEGER                 not null,
   liczba_pokoi         INTEGER                 null
      constraint CKC_LICZBA_POKOI_NIERUCHO check (liczba_pokoi is null or (liczba_pokoi > 0)),
   powierzchnia         DECIMAL(11,2)        not null,
   miejscowosc          VARCHAR(65)          not null,
   ulica                VARCHAR(65)          not null,
   nr_ulicy             VARCHAR(6)           not null,
   nr_mieszkania        VARCHAR(6)           null,
   liczba_lazienek      INTEGER                 null
      constraint CKC_LICZBA_LAZIENEK_NIERUCHO check (liczba_lazienek is null or (liczba_lazienek > 0)),
   constraint PK_NIERUCHOMOSC primary key (id_nieruchomosci)
);

comment on table nieruchomosc is
'nieruchomsc - obiekt fizyczny w postaci budynku lub terenu o danym adresie i w�a�ciwo�ciach, takich jak: adres, powierzchnia, nazwa ulicy, numer ulicy, miejscowo��, dane w�a�ciciela itp.';

/*==============================================================*/
/* Index: wlasciciel_nieruchomosci_FK                           */
/*==============================================================*/
create  index wlasciciel_nieruchomosci_FK on nieruchomosc (
id_osoby
);

/*==============================================================*/
/* Table: nieruchomosc_udogodnienia                             */
/*==============================================================*/
create table nieruchomosc_udogodnienia (
   id_nieruchomosci     INTEGER                 not null,
   id_udogodnienia      INTEGER                 not null,
   constraint PK_NIERUCHOMOSC_UDOGODNIENIA primary key (id_nieruchomosci, id_udogodnienia)
);

comment on table nieruchomosc_udogodnienia is
'zwi�zek, de facto intersekcja mi�dzy nieruchomo�ci� a udogodnieniami

nieruchomo�� mo�e mie� wiele udogodnie� a udogodnienie mo�e dotyczy� wielu nieruchomo�ci';

/*==============================================================*/
/* Table: oferta                                                */
/*==============================================================*/
create table oferta (
   id_oferty            SERIAL not null,
   id_statusu_oferty    INTEGER                 not null,
   id_typu_oferty       INTEGER                 not null,
   id_nieruchomosci     INTEGER                 not null,
   id_osoby             INTEGER                 not null,
   cena                 INTEGER                 not null
      constraint CKC_CENA_OFERTA check (cena >= 0),
   opis_oferty          VARCHAR(65500)           not null,
   data_publikacji      DATE                 not null,
   data_zakonczenia     DATE                 null,
   constraint PK_OFERTA primary key (id_oferty)
);

comment on table oferta is
'oferta - reprezentuje ofert� sprzeda�y lub wynajmu nieruchomo�ci wraz z wszelkimi potrzebnymi informacjami o ofercie dla potencjalnego klienta, tj. jej statusie, typie, danymi w�a�ciciela nieruchomo�ci, agenta opiekuj�cego si� ofert� oraz samej nieruchomo�ci, np. jej cenie (cen� nieruchomo�ci zazwyczaj podaje si� jako liczb� ca�kowit�, tak te� przyj��em)

cena - cena nieruchomo�ci w przypadku oferty sprzeda�y oraz kwota miesi�cznego najmu w przypadku oferty wynajmu';

/*==============================================================*/
/* Index: nieruchomosc_oferta_FK                                */
/*==============================================================*/
create  index nieruchomosc_oferta_FK on oferta (
id_nieruchomosci
);

/*==============================================================*/
/* Index: agent_oferta_FK                                       */
/*==============================================================*/
create  index agent_oferta_FK on oferta (
id_osoby
);

/*==============================================================*/
/* Index: status_oferty_oferta_FK                               */
/*==============================================================*/
create  index status_oferty_oferta_FK on oferta (
id_statusu_oferty
);

/*==============================================================*/
/* Index: typ_oferty_oferta_FK                                  */
/*==============================================================*/
create  index typ_oferty_oferta_FK on oferta (
id_typu_oferty
);

/*==============================================================*/
/* Table: prowizja                                              */
/*==============================================================*/
create table prowizja (
   id_prowizji          SERIAL not null,
   id_transakcji        INTEGER                 not null,
   prowizja_agenta      DECIMAL(10,2)        not null
      constraint CKC_PROWIZJA_AGENTA_PROWIZJA check (prowizja_agenta >= 0),
   prowizja_biura       DECIMAL(10,2)        not null
      constraint CKC_PROWIZJA_BIURA_PROWIZJA check (prowizja_biura >= 0),
   constraint PK_PROWIZJA primary key (id_prowizji)
);

comment on table prowizja is
'prowizja - reprezentuje prowizje z podzia�em na prowizje agenta oraz biura na podstawie danej transakcji

prowizja_agenta - dla oferty sprzeda�y to b�dzie to r�wne procentowi agenta z tabeli agent a w przypadku oferty wynajmu to 45% miesi�cznego czynszu
prowizja_biura - 8% od ceny nieruchomo�ci - procent_agenta z tej kwoty w przypadku oferty sprzeda�y a w przypadku oferty wynajmu to 55% miesi�cznego czynszu';

/*==============================================================*/
/* Table: status_nieruchomosci                                  */
/*==============================================================*/
create table status_nieruchomosci (
   id_statusu_nieruchomosci SERIAL not null,
   status_nieruchomosci VARCHAR(21)          not null
      constraint CKC_STATUS_NIERUCHOMO_STATUS_N check (status_nieruchomosci in ('do remontu','do odświeżenia','stan deweloperski','stan surowy otwarty','stan surowy zamknięty','stan pod klucz','czysta','zarośnięta')),
   constraint PK_STATUS_NIERUCHOMOSCI primary key (id_statusu_nieruchomosci)
);

comment on table status_nieruchomosci is
'status_nieruchomosci � reprezentuje stan techniczny i wizualny nieruchomo�ci, np. do remontu/do od�wie�enia/stan deweloperski/stan surowy otwarty/zamkni�y/stan pod klucz/czysta/zaro�nieta, w zale�no�ci czy to dom, mieszkanie czy dzia�ka';

/*==============================================================*/
/* Table: status_oferty                                         */
/*==============================================================*/
create table status_oferty (
   id_statusu_oferty    SERIAL not null,
   status_oferty        VARCHAR(10)          not null
      constraint CKC_STATUS_OFERTY_STATUS_O check (status_oferty in ('aktywna','zakończona')),
   constraint PK_STATUS_OFERTY primary key (id_statusu_oferty)
);

comment on table status_oferty is
'status_oferty - okre�la bie��cy status oferty, np. aktywna/zako�czona';

/*==============================================================*/
/* Table: status_umowy                                          */
/*==============================================================*/
create table status_umowy (
   id_statusu_umowy     SERIAL not null,
   status_umowy         VARCHAR(12)          not null
      constraint CKC_STATUS_UMOWY_STATUS_U check (status_umowy in ('podpisana','zrealizowana')),
   constraint PK_STATUS_UMOWY primary key (id_statusu_umowy)
);

comment on table status_umowy is
'status_umowy - okre�la bie��cy status umowy, np. podpisana/zrealizowana

';

/*==============================================================*/
/* Table: transakcja                                            */
/*==============================================================*/
create table transakcja (
   id_transakcji        SERIAL not null,
   id_umowy             INTEGER                 not null,
   data_transakcji      DATE                 not null,
   kwota_prowizji       DECIMAL(10,2)        not null
      constraint CKC_KWOTA_PROWIZJI_TRANSAKC check (kwota_prowizji >= 0),
   constraint PK_TRANSAKCJA primary key (id_transakcji)
);

comment on table transakcja is
'transakcja - opisuje p�atno�ci zwi�zane z umowami wst�pnymi, na podstawie kt�rych klienci p�ac� sumaryczn� kwot� prowizji, kt�ra potem b�dzie podzielona mi�dzy biuro i danego klienta

kwota_prowizji --> 8% od ceny nieruchomo�ci w przypadku oferty sprzeda�y oraz jeden miesi�czny czynsz w przypadku oferty wynajmu nieruchomo�ci';

/*==============================================================*/
/* Index: umowa_transakcja2_FK                                  */
/*==============================================================*/
create  index umowa_transakcja2_FK on transakcja (
id_umowy
);

/*==============================================================*/
/* Table: typ_nieruchomosci                                     */
/*==============================================================*/
create table typ_nieruchomosci (
   id_typu_nieruchomosci SERIAL not null,
   typ_nieruchomosci    VARCHAR(20)          not null
      constraint CKC_TYP_NIERUCHOMOSCI_TYP_NIER check (typ_nieruchomosci in ('dom wolnostojący','bliźniak','szeregowiec','mieszkanie','działka budowlana','działka rolna','działka siedliskowa','działka rekreacyjna','działka leśna','działka inwestycyjna')),
   constraint PK_TYP_NIERUCHOMOSCI primary key (id_typu_nieruchomosci)
);

comment on table typ_nieruchomosci is
'typ_nieruchomosci � reprezentuje typ nieruchomo�ci, w celu ich klasyfikacji, np. dom wolnostoj�cy, bli�niak, szeregowiec, mieszkanie, dzia�ka budowlana, dzia�ka rolna, dzia�ka siedliskowa, dzia�ka rekreacyjna, dzia�ka le�na, dzia�ka inwestycyjna';

/*==============================================================*/
/* Table: typ_oferty                                            */
/*==============================================================*/
create table typ_oferty (
   id_typu_oferty       SERIAL not null,
   typ_oferty           VARCHAR(8)           not null
      constraint CKC_TYP_OFERTY_TYP_OFER check (typ_oferty in ('sprzedaż','wynajem')),
   constraint PK_TYP_OFERTY primary key (id_typu_oferty)
);

comment on table typ_oferty is
'typ_oferty - okre�la charakter oferty, np. sprzeda�, wynajem';

/*==============================================================*/
/* Table: udogodnienia                                          */
/*==============================================================*/
create table udogodnienia (
   id_udogodnienia      SERIAL not null,
   udogodnienie         VARCHAR(16)          not null
      constraint CKC_UDOGODNIENIE_UDOGODNI check (udogodnienie in ('garaż','kuchnia otwarta','pralka','zmywarka','winda','klimatyzacja','kanalizacja','szambo','wodociąg','gaz','prąd','kominek','spiżarnia','ogród','balkon')),
   constraint PK_UDOGODNIENIA primary key (id_udogodnienia)
);

comment on table udogodnienia is
'udogodnienia - reprezentuje udogodnienia, kt�re posiada dana nieruchomo��, np. gara�, kuchnia otwarta, pralka, zmywarka, winda, klimatyzacja, kanalizacja, wodoci�g, gaz, pr�d, kominek, spi�arnia, ogr�d, balkon itp.';

/*==============================================================*/
/* Table: umowa                                                 */
/*==============================================================*/
create table umowa (
   id_umowy             SERIAL not null,
   id_oferty            INTEGER                 not null unique,
   id_statusu_umowy     INTEGER                 not null,
   id_osoby             INTEGER                 not null,
   data_podpisania      DATE                 not null,
   kwota                INTEGER                 not null
      constraint CKC_KWOTA_UMOWA check (kwota >= 0),
   constraint PK_UMOWA primary key (id_umowy)
);

comment on table umowa is
'umowa - reprezentuje wst�pn� umow� prawn� (docelow� umow�, spe�niaj�c� wszelkie wymogi formalne zajmuje si� notariusz) zwie�czaj�c� sprzeda� lub wynajem danej nieruchomo�ci. Zawiera szczeg�y dotycz�ce w�a�ciciela, klienta, agenta oraz oferty, na podstawie kt�rej zosta�a sporz�dzona

kwota - ostateczna uzgodniona kwota kupna/wynajmu danej nieruchomo�ci';

/*==============================================================*/
/* Index: oferta_umowa2_FK                                      */
/*==============================================================*/
create  index oferta_umowa2_FK on umowa (
id_oferty
);

/*==============================================================*/
/* Index: status_umowy_umowa_FK                                 */
/*==============================================================*/
create  index status_umowy_umowa_FK on umowa (
id_statusu_umowy
);

/*==============================================================*/
/* Index: umowa_klient_FK                                       */
/*==============================================================*/
create  index umowa_klient_FK on umowa (
id_osoby
);

/*==============================================================*/
/* Table: wizyta                                                */
/*==============================================================*/
create table wizyta (
   id_wizyty            SERIAL not null,
   id_oferty            INTEGER                 not null,
   id_osoby             INTEGER                 not null,
   data_wizyty          DATE                 not null,
   godzina_wizyty       TIME                 not null
      constraint CKC_GODZINA_WIZYTY check (godzina_wizyty between '09:00:00' and '20:00:00'),
   constraint PK_WIZYTA primary key (id_wizyty)
);

comment on table wizyta is
'wizyta - reprezentuje wizyty w nieruchomo�ciach organizowane przez biuro nieruchomo�ci i prowadzone przez danego agenta opiekuj�cego si� dan� ofert�, posiada informacje o wizycie danego klienta na nieruchomo�ci, o tym kliencie i agencie, kt�ry si� dan� ofert� opiekuje';

/*==============================================================*/
/* Index: oferta_wizyta_FK                                      */
/*==============================================================*/
create  index oferta_wizyta_FK on wizyta (
id_oferty
);

/*==============================================================*/
/* Index: klient_wizyta_FK                                      */
/*==============================================================*/
create  index klient_wizyta_FK on wizyta (
id_osoby
);

/*==============================================================*/
/* Table: wlasciciel                                            */
/*==============================================================*/
create table wlasciciel (
   id_osoby             SERIAL not null,
   PESEL                VARCHAR(11)          not null unique,
   nr_dowodu_osobistego VARCHAR(9)           not null unique,
   imie                 VARCHAR(16)          not null,
   nazwisko             VARCHAR(52)          not null,
   email                VARCHAR(255)         null unique,
   nr_tel               VARCHAR(9)           not null unique,
   constraint PK_WLASCICIEL primary key (id_osoby)
);

comment on table wlasciciel is
'wlasciciel - osoba fizyczna b�d�ca w posiadaniu nieruchomo�ci. Na potrzeby projektu zak�adamy, �e w systemie biura jako w�a�ciciel danej nieruchomo�ci b�dzie wpisana jedna osoba.';

alter table nieruchomosc
   add constraint FK_NIERUCHO_STATUS_NI_STATUS_N foreign key (id_statusu_nieruchomosci)
      references status_nieruchomosci (id_statusu_nieruchomosci)
      on delete restrict on update restrict;

alter table nieruchomosc
   add constraint FK_NIERUCHO_TYP_NIERU_TYP_NIER foreign key (id_typu_nieruchomosci)
      references typ_nieruchomosci (id_typu_nieruchomosci)
      on delete restrict on update restrict;

alter table nieruchomosc
   add constraint FK_NIERUCHO_WLASCICIE_WLASCICI foreign key (id_osoby)
      references wlasciciel (id_osoby)
      on delete restrict on update restrict;

alter table nieruchomosc_udogodnienia
   add constraint FK_NIERUCHO_NIERUCHOM_NIERUCHO foreign key (id_nieruchomosci)
      references nieruchomosc (id_nieruchomosci)
      on delete restrict on update restrict;

alter table nieruchomosc_udogodnienia
   add constraint FK_NIERUCHO_NIERUCHOM_UDOGODNI foreign key (id_udogodnienia)
      references udogodnienia (id_udogodnienia)
      on delete restrict on update restrict;

alter table oferta
   add constraint FK_OFERTA_AGENT_OFE_AGENT foreign key (id_osoby)
      references agent (id_osoby)
      on delete restrict on update restrict;

alter table oferta
   add constraint FK_OFERTA_NIERUCHOM_NIERUCHO foreign key (id_nieruchomosci)
      references nieruchomosc (id_nieruchomosci)
      on delete restrict on update restrict;

alter table oferta
   add constraint FK_OFERTA_STATUS_OF_STATUS_O foreign key (id_statusu_oferty)
      references status_oferty (id_statusu_oferty)
      on delete restrict on update restrict;

alter table oferta
   add constraint FK_OFERTA_TYP_OFERT_TYP_OFER foreign key (id_typu_oferty)
      references typ_oferty (id_typu_oferty)
      on delete restrict on update restrict;

alter table prowizja
   add constraint FK_PROWIZJA_TRANSAKCJ_TRANSAKC foreign key (id_transakcji)
      references transakcja (id_transakcji)
      on delete restrict on update restrict;

alter table transakcja
   add constraint FK_TRANSAKC_UMOWA_TRA_UMOWA foreign key (id_umowy)
      references umowa (id_umowy)
      on delete restrict on update restrict;

alter table umowa
   add constraint FK_UMOWA_OFERTA_UM_OFERTA foreign key (id_oferty)
      references oferta (id_oferty)
      on delete restrict on update restrict;

alter table umowa
   add constraint FK_UMOWA_STATUS_UM_STATUS_U foreign key (id_statusu_umowy)
      references status_umowy (id_statusu_umowy)
      on delete restrict on update restrict;

alter table umowa
   add constraint FK_UMOWA_UMOWA_KLI_KLIENT foreign key (id_osoby)
      references klient (id_osoby)
      on delete restrict on update restrict;

alter table wizyta
   add constraint FK_WIZYTA_KLIENT_WI_KLIENT foreign key (id_osoby)
      references klient (id_osoby)
      on delete restrict on update restrict;

alter table wizyta
   add constraint FK_WIZYTA_OFERTA_WI_OFERTA foreign key (id_oferty)
      references oferta (id_oferty)
      on delete restrict on update restrict;

