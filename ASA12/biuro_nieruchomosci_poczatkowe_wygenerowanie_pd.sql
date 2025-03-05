/*==============================================================*/
/* DBMS name:      Sybase SQL Anywhere 12                       */
/* Created on:     26.01.2025 12:45:51                          */
/*==============================================================*/


if exists(select 1 from sys.sysforeignkey where role='FK_NIERUCHO_STATUS_NI_STATUS_N') then
    alter table nieruchomosc
       delete foreign key FK_NIERUCHO_STATUS_NI_STATUS_N
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NIERUCHO_TYP_NIERU_TYP_NIER') then
    alter table nieruchomosc
       delete foreign key FK_NIERUCHO_TYP_NIERU_TYP_NIER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NIERUCHO_WLASCICIE_WLASCICI') then
    alter table nieruchomosc
       delete foreign key FK_NIERUCHO_WLASCICIE_WLASCICI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NIERUCHO_NIERUCHOM_NIERUCHO') then
    alter table nieruchomosc_udogodnienia
       delete foreign key FK_NIERUCHO_NIERUCHOM_NIERUCHO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_NIERUCHO_NIERUCHOM_UDOGODNI') then
    alter table nieruchomosc_udogodnienia
       delete foreign key FK_NIERUCHO_NIERUCHOM_UDOGODNI
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_OFERTA_AGENT_OFE_AGENT') then
    alter table oferta
       delete foreign key FK_OFERTA_AGENT_OFE_AGENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_OFERTA_NIERUCHOM_NIERUCHO') then
    alter table oferta
       delete foreign key FK_OFERTA_NIERUCHOM_NIERUCHO
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_OFERTA_STATUS_OF_STATUS_O') then
    alter table oferta
       delete foreign key FK_OFERTA_STATUS_OF_STATUS_O
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_OFERTA_TYP_OFERT_TYP_OFER') then
    alter table oferta
       delete foreign key FK_OFERTA_TYP_OFERT_TYP_OFER
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_PROWIZJA_TRANSAKCJ_TRANSAKC') then
    alter table prowizja
       delete foreign key FK_PROWIZJA_TRANSAKCJ_TRANSAKC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TRANSAKC_TRANSAKCJ_PROWIZJA') then
    alter table transakcja
       delete foreign key FK_TRANSAKC_TRANSAKCJ_PROWIZJA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_TRANSAKC_UMOWA_TRA_UMOWA') then
    alter table transakcja
       delete foreign key FK_TRANSAKC_UMOWA_TRA_UMOWA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_UMOWA_OFERTA_UM_OFERTA') then
    alter table umowa
       delete foreign key FK_UMOWA_OFERTA_UM_OFERTA
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_UMOWA_STATUS_UM_STATUS_U') then
    alter table umowa
       delete foreign key FK_UMOWA_STATUS_UM_STATUS_U
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_UMOWA_UMOWA_KLI_KLIENT') then
    alter table umowa
       delete foreign key FK_UMOWA_UMOWA_KLI_KLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_UMOWA_UMOWA_TRA_TRANSAKC') then
    alter table umowa
       delete foreign key FK_UMOWA_UMOWA_TRA_TRANSAKC
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_WIZYTA_KLIENT_WI_KLIENT') then
    alter table wizyta
       delete foreign key FK_WIZYTA_KLIENT_WI_KLIENT
end if;

if exists(select 1 from sys.sysforeignkey where role='FK_WIZYTA_OFERTA_WI_OFERTA') then
    alter table wizyta
       delete foreign key FK_WIZYTA_OFERTA_WI_OFERTA
end if;

drop index if exists agent.agent_PK;

drop table if exists agent;

drop index if exists klient.klient_PK;

drop table if exists klient;

drop index if exists nieruchomosc.typ_nieruchomosci_nieruchomosc_FK;

drop index if exists nieruchomosc.status_nieruchomosci_nieruchomosc_FK;

drop index if exists nieruchomosc.wlasciciel_nieruchomosci_FK;

drop index if exists nieruchomosc.nieruchomosc_PK;

drop table if exists nieruchomosc;

drop index if exists nieruchomosc_udogodnienia.nieruchomosc_udogodnienia_PK;

drop table if exists nieruchomosc_udogodnienia;

drop index if exists oferta.typ_oferty_oferta_FK;

drop index if exists oferta.status_oferty_oferta_FK;

drop index if exists oferta.agent_oferta_FK;

drop index if exists oferta.nieruchomosc_oferta_FK;

drop index if exists oferta.oferta_PK;

drop table if exists oferta;

drop index if exists prowizja.transakcja_prowizja_FK;

drop index if exists prowizja.prowizja_PK;

drop table if exists prowizja;

drop index if exists status_nieruchomosci.status_nieruchomosci_PK;

drop table if exists status_nieruchomosci;

drop index if exists status_oferty.status_oferty_PK;

drop table if exists status_oferty;

drop index if exists status_umowy.status_umowy_PK;

drop table if exists status_umowy;

drop index if exists transakcja.transakcja_prowizja2_FK;

drop index if exists transakcja.umowa_transakcja2_FK;

drop index if exists transakcja.transakcja_PK;

drop table if exists transakcja;

drop index if exists typ_nieruchomosci.typ_nieruchomosci_PK;

drop table if exists typ_nieruchomosci;

drop index if exists typ_oferty.typ_oferty_PK;

drop table if exists typ_oferty;

drop index if exists udogodnienia.udogodnienia_PK;

drop table if exists udogodnienia;

drop index if exists umowa.umowa_klient_FK;

drop index if exists umowa.status_umowy_umowa_FK;

drop index if exists umowa.oferta_umowa2_FK;

drop index if exists umowa.umowa_PK;

drop table if exists umowa;

drop index if exists wizyta.klient_wizyta_FK;

drop index if exists wizyta.oferta_wizyta_FK;

drop index if exists wizyta.wizyta_PK;

drop table if exists wizyta;

drop index if exists wlasciciel.wlasciciel_PK;

drop table if exists wlasciciel;

/*==============================================================*/
/* Table: agent                                                 */
/*==============================================================*/
create table agent 
(
   id_osoby             integer                        not null default autoincrement,
   PESEL                varchar(11)                    not null unique,
   nr_dowodu_osobistego varchar(9)                     not null unique,
   data_zatrudnienia    date                           not null,
   procent_prowizji     decimal(5,2)                   not null
   	constraint CKC_PROCENT_PROWIZJI_AGENT check (procent_prowizji >= 1.00),
   imie                 varchar(16)                    not null,
   nazwisko             varchar(52)                    not null,
   email                varchar(255)                   not null unique,
   nr_tel               varchar(9)                     not null unique,
   constraint PK_AGENT primary key clustered (id_osoby)
);

comment on table agent is 
'agent - osoba fizyczna, b�d�ca pracownikiem biura nieruchomo�ci, opiekuj�ca si� dan� ofert� i zajmuj�ca si� obs�ug� klient�w w procesie sprzeda�y/wynajmu nieruchomo�ci oraz prowadzenia wizyt w nich.';

/*==============================================================*/
/* Index: agent_PK                                              */
/*==============================================================*/
create unique index agent_PK on agent (
id_osoby ASC
);

/*==============================================================*/
/* Table: klient                                                */
/*==============================================================*/
create table klient 
(
   id_osoby             integer                        not null default autoincrement,
   PESEL                varchar(11)                    not null unique,
   nr_dowodu_osobistego varchar(9)                     not null unique,
   imie                 varchar(16)                    not null,
   nazwisko             varchar(52)                    not null,
   email                varchar(255)                   null unique,
   nr_tel               varchar(9)                     not null unique,
   constraint PK_KLIENT primary key clustered (id_osoby)
);

comment on table klient is 
'klient - osoba fizyczna, korzystaj�ca z us�ug biura nieruchomo�ci w celu nabycia lub wynajmu nieruchomo�ci. ';

/*==============================================================*/
/* Index: klient_PK                                             */
/*==============================================================*/
create unique index klient_PK on klient (
id_osoby ASC
);

/*==============================================================*/
/* Table: nieruchomosc                                          */
/*==============================================================*/
create table nieruchomosc 
(
   id_nieruchomosci     integer                        not null default autoincrement,
   id_typu_nieruchomosci integer                        not null,
   id_statusu_nieruchomosci integer                        not null,
   id_osoby             integer                        not null,
   liczba_pokoi         integer                        null
   	constraint CKC_LICZBA_POKOI_NIERUCHO check (liczba_pokoi is null or (liczba_pokoi > 0)),
   powierzchnia         decimal(11,2)                  not null
      constraint CKC_POWIERZCHNIA check (powierzchnia > 0),
   miejscowosc          varchar(65)                    not null,
   ulica                varchar(65)                    not null,
   nr_ulicy             varchar(6)                     not null,
   nr_mieszkania        varchar(6)                     null,
   liczba_lazienek      integer                        null
   	constraint CKC_LICZBA_LAZIENEK_NIERUCHO check (liczba_lazienek is null or (liczba_lazienek > 0)),
   constraint PK_NIERUCHOMOSC primary key (id_nieruchomosci)
);

comment on table nieruchomosc is 
'nieruchomsc - obiekt fizyczny w postaci budynku lub terenu o danym adresie i w�a�ciwo�ciach, takich jak: adres, powierzchnia, nazwa ulicy, numer ulicy, miejscowo��, dane w�a�ciciela itp.';

/*==============================================================*/
/* Index: nieruchomosc_PK                                       */
/*==============================================================*/
create unique index nieruchomosc_PK on nieruchomosc (
id_nieruchomosci ASC
);

/*==============================================================*/
/* Index: wlasciciel_nieruchomosci_FK                           */
/*==============================================================*/
create index wlasciciel_nieruchomosci_FK on nieruchomosc (
id_osoby ASC
);

/*==============================================================*/
/* Index: status_nieruchomosci_nieruchomosc_FK                  */
/*==============================================================*/
create index status_nieruchomosci_nieruchomosc_FK on nieruchomosc (
id_statusu_nieruchomosci ASC
);

/*==============================================================*/
/* Index: typ_nieruchomosci_nieruchomosc_FK                     */
/*==============================================================*/
create index typ_nieruchomosci_nieruchomosc_FK on nieruchomosc (
id_typu_nieruchomosci ASC
);

/*==============================================================*/
/* Table: nieruchomosc_udogodnienia                             */
/*==============================================================*/
create table nieruchomosc_udogodnienia 
(
   id_nieruchomosci     integer                        not null,
   id_udogodnienia      integer                        not null,
   constraint PK_NIERUCHOMOSC_UDOGODNIENIA primary key (id_nieruchomosci, id_udogodnienia)
);

comment on table nieruchomosc_udogodnienia is 
'zwi�zek, de facto intersekcja mi�dzy nieruchomo�ci� a udogodnieniami

nieruchomo�� mo�e mie� wiele udogodnie� a udogodnienie mo�e dotyczy� wielu nieruchomo�ci';

/*==============================================================*/
/* Index: nieruchomosc_udogodnienia_PK                          */
/*==============================================================*/
create unique index nieruchomosc_udogodnienia_PK on nieruchomosc_udogodnienia (
id_nieruchomosci ASC,
id_udogodnienia ASC
);

/*==============================================================*/
/* Table: oferta                                                */
/*==============================================================*/
create table oferta 
(
   id_oferty            integer                        not null default autoincrement,
   id_statusu_oferty    integer                        not null,
   id_typu_oferty       integer                        not null,
   id_nieruchomosci     integer                        not null,
   id_osoby             integer                        not null,
   cena                 integer                        not null
   	constraint CKC_CENA_OFERTA check (cena >= 0),
   opis_oferty          long varchar                   not null,
   data_publikacji      date                           not null,
   data_zakonczenia     date                           null,
   constraint PK_OFERTA primary key (id_oferty)
);

comment on table oferta is 
'oferta - reprezentuje ofert� sprzeda�y lub wynajmu nieruchomo�ci wraz z wszelkimi potrzebnymi informacjami o ofercie dla potencjalnego klienta, tj. jej statusie, typie, danymi w�a�ciciela nieruchomo�ci, agenta opiekuj�cego si� ofert� oraz samej nieruchomo�ci, np. jej cenie (cen� nieruchomo�ci zazwyczaj podaje si� jako liczb� ca�kowit�, tak te� przyj��em)

cena - cena nieruchomo�ci w przypadku oferty sprzeda�y oraz kwota miesi�cznego najmu w przypadku oferty wynajmu';

/*==============================================================*/
/* Index: oferta_PK                                             */
/*==============================================================*/
create unique index oferta_PK on oferta (
id_oferty ASC
);

/*==============================================================*/
/* Index: nieruchomosc_oferta_FK                                */
/*==============================================================*/
create index nieruchomosc_oferta_FK on oferta (
id_nieruchomosci ASC
);

/*==============================================================*/
/* Index: agent_oferta_FK                                       */
/*==============================================================*/
create index agent_oferta_FK on oferta (
id_osoby ASC
);

/*==============================================================*/
/* Index: status_oferty_oferta_FK                               */
/*==============================================================*/
create index status_oferty_oferta_FK on oferta (
id_statusu_oferty ASC
);

/*==============================================================*/
/* Index: typ_oferty_oferta_FK                                  */
/*==============================================================*/
create index typ_oferty_oferta_FK on oferta (
id_typu_oferty ASC
);

/*==============================================================*/
/* Table: prowizja                                              */
/*==============================================================*/
create table prowizja 
(
   id_prowizji          integer                        not null default autoincrement,
   id_transakcji        integer                        not null unique,
   prowizja_agenta      decimal(10,2)                  not null
   	constraint CKC_PROWIZJA_AGENTA_PROWIZJA check (prowizja_agenta >= 0),
   prowizja_biura       decimal(10,2)                  not null
   	constraint CKC_PROWIZJA_BIURA_PROWIZJA check (prowizja_biura >= 0),
   constraint PK_PROWIZJA primary key (id_prowizji)
);

comment on table prowizja is 
'prowizja - reprezentuje prowizje z podzia�em na prowizje agenta oraz biura na podstawie danej transakcji

prowizja_agenta - dla oferty sprzeda�y to b�dzie to r�wne procentowi agenta z tabeli agent a w przypadku oferty wynajmu to 45% miesi�cznego czynszu
prowizja_biura - 8% od ceny nieruchomo�ci - procent_agenta z tej kwoty w przypadku oferty sprzeda�y a w przypadku oferty wynajmu to 55% miesi�cznego czynszu';

/*==============================================================*/
/* Index: prowizja_PK                                           */
/*==============================================================*/
create unique index prowizja_PK on prowizja (
id_prowizji ASC
);

/*==============================================================*/
/* Index: transakcja_prowizja_FK                                */
/*==============================================================*/
create index transakcja_prowizja_FK on prowizja (
id_transakcji ASC
);

/*==============================================================*/
/* Table: status_nieruchomosci                                  */
/*==============================================================*/
create table status_nieruchomosci 
(
   id_statusu_nieruchomosci integer                        not null default autoincrement,
   status_nieruchomosci varchar(21)                    not null unique
   	constraint CKC_STATUS_NIERUCHOMO_STATUS_N check (status_nieruchomosci in ('do remontu','do odświeżenia','stan deweloperski','stan surowy otwarty','stan surowy zamknięty','stan pod klucz','czysta','zarośnięta', '')),
   constraint PK_STATUS_NIERUCHOMOSCI primary key (id_statusu_nieruchomosci)
);

comment on table status_nieruchomosci is 
'status_nieruchomosci � reprezentuje stan techniczny i wizualny nieruchomo�ci, np. do remontu/do od�wie�enia/stan deweloperski/stan surowy otwarty/zamkni�y/stan pod klucz/czysta/zaro�nieta, w zale�no�ci czy to dom, mieszkanie czy dzia�ka';

/*==============================================================*/
/* Index: status_nieruchomosci_PK                               */
/*==============================================================*/
create unique index status_nieruchomosci_PK on status_nieruchomosci (
id_statusu_nieruchomosci ASC
);

/*==============================================================*/
/* Table: status_oferty                                         */
/*==============================================================*/
create table status_oferty 
(
   id_statusu_oferty    integer                        not null default autoincrement,
   status_oferty        varchar(10)                    not null unique
   	constraint CKC_STATUS_OFERTY_STATUS_O check (status_oferty in ('aktywna','zakończona')),
   constraint PK_STATUS_OFERTY primary key (id_statusu_oferty)
);

comment on table status_oferty is 
'status_oferty - okre�la bie��cy status oferty, np. aktywna/zako�czona';

/*==============================================================*/
/* Index: status_oferty_PK                                      */
/*==============================================================*/
create unique index status_oferty_PK on status_oferty (
id_statusu_oferty ASC
);

/*==============================================================*/
/* Table: status_umowy                                          */
/*==============================================================*/
create table status_umowy 
(
   id_statusu_umowy     integer                        not null default autoincrement,
   status_umowy         varchar(12)                    not null unique
   	constraint CKC_STATUS_UMOWY_STATUS_U check (status_umowy in ('podpisana','zrealizowana')),
   constraint PK_STATUS_UMOWY primary key (id_statusu_umowy)
);

comment on table status_umowy is 
'status_umowy - okre�la bie��cy status umowy, np. podpisana/zrealizowana

';

/*==============================================================*/
/* Index: status_umowy_PK                                       */
/*==============================================================*/
create unique index status_umowy_PK on status_umowy (
id_statusu_umowy ASC
);

/*==============================================================*/
/* Table: transakcja                                            */
/*==============================================================*/
create table transakcja 
(
   id_transakcji        integer                        not null default autoincrement,
   id_prowizji          integer                        null unique,
   id_umowy             integer                        not null unique,
   data_transakcji      date                           not null,
   kwota_prowizji       decimal(10,2)                  not null
   	constraint CKC_KWOTA_PROWIZJI_TRANSAKC check (kwota_prowizji >= 0),
   constraint PK_TRANSAKCJA primary key (id_transakcji)
);

comment on table transakcja is 
'transakcja - opisuje p�atno�ci zwi�zane z umowami wst�pnymi, na podstawie kt�rych klienci p�ac� sumaryczn� kwot� prowizji, kt�ra potem b�dzie podzielona mi�dzy biuro i danego klienta

kwota_prowizji --> 8% od ceny nieruchomo�ci w przypadku oferty sprzeda�y oraz jeden miesi�czny czynsz w przypadku oferty wynajmu nieruchomo�ci';

/*==============================================================*/
/* Index: transakcja_PK                                         */
/*==============================================================*/
create unique index transakcja_PK on transakcja (
id_transakcji ASC
);

/*==============================================================*/
/* Index: umowa_transakcja2_FK                                  */
/*==============================================================*/
create index umowa_transakcja2_FK on transakcja (
id_umowy ASC
);

/*==============================================================*/
/* Index: transakcja_prowizja2_FK                               */
/*==============================================================*/
create index transakcja_prowizja2_FK on transakcja (
id_prowizji ASC
);

/*==============================================================*/
/* Table: typ_nieruchomosci                                     */
/*==============================================================*/
create table typ_nieruchomosci 
(
   id_typu_nieruchomosci integer                        not null default autoincrement,
   typ_nieruchomosci    varchar(20)                    not null unique
   	constraint CKC_TYP_NIERUCHOMOSCI_TYP_NIER check (typ_nieruchomosci in ('dom wolnostojacy','bliźniak','szeregowiec','mieszkanie','działka budowlana','działka rolna','działka siedliskowa','działka rekreacyjna','działka leśna','działka inwestycyjna')),
   constraint PK_TYP_NIERUCHOMOSCI primary key (id_typu_nieruchomosci)
);

comment on table typ_nieruchomosci is 
'typ_nieruchomosci � reprezentuje typ nieruchomo�ci, w celu ich klasyfikacji, np. dom wolnostoj�cy, bli�niak, szeregowiec, mieszkanie, dzia�ka budowlana, dzia�ka rolna, dzia�ka siedliskowa, dzia�ka rekreacyjna, dzia�ka le�na, dzia�ka inwestycyjna';

/*==============================================================*/
/* Index: typ_nieruchomosci_PK                                  */
/*==============================================================*/
create unique index typ_nieruchomosci_PK on typ_nieruchomosci (
id_typu_nieruchomosci ASC
);

/*==============================================================*/
/* Table: typ_oferty                                            */
/*==============================================================*/
create table typ_oferty 
(
   id_typu_oferty       integer                        not null default autoincrement,
   typ_oferty           varchar(8)                     not null unique
   	constraint CKC_TYP_OFERTY_TYP_OFER check (typ_oferty in ('sprzedaż','wynajem')),
   constraint PK_TYP_OFERTY primary key (id_typu_oferty)
);

comment on table typ_oferty is 
'typ_oferty - okre�la charakter oferty, np. sprzeda�, wynajem';

/*==============================================================*/
/* Index: typ_oferty_PK                                         */
/*==============================================================*/
create unique index typ_oferty_PK on typ_oferty (
id_typu_oferty ASC
);

/*==============================================================*/
/* Table: udogodnienia                                          */
/*==============================================================*/
create table udogodnienia 
(
   id_udogodnienia      integer                        not null default autoincrement,
   udogodnienie         varchar(16)                    not null unique
   	constraint CKC_UDOGODNIENIE_UDOGODNI check (udogodnienie in ('garaż','kuchnia otwarta','pralka','zmywarka','winda','klimatyzacja','kanalizacja','szambo','wodociąg','gaz','prąd','kominek','spiżarnia','ogród','balkon')),
   constraint PK_UDOGODNIENIA primary key (id_udogodnienia)
);

comment on table udogodnienia is 
'udogodnienia - reprezentuje udogodnienia, kt�re posiada dana nieruchomo��, np. gara�, kuchnia otwarta, pralka, zmywarka, winda, klimatyzacja, kanalizacja, wodoci�g, gaz, pr�d, kominek, spi�arnia, ogr�d, balkon itp.';

/*==============================================================*/
/* Index: udogodnienia_PK                                       */
/*==============================================================*/
create unique index udogodnienia_PK on udogodnienia (
id_udogodnienia ASC
);

/*==============================================================*/
/* Table: umowa                                                 */
/*==============================================================*/
create table umowa 
(
   id_umowy             integer                        not null default autoincrement,
   id_oferty            integer                        not null unique,
   id_statusu_umowy     integer                        not null,
   id_osoby             integer                        not null,
   data_podpisania      date                           not null,
   kwota                integer                        not null
   	constraint CKC_KWOTA_UMOWA check (kwota >= 0),
   constraint PK_UMOWA primary key (id_umowy)
);

comment on table umowa is 
'umowa - reprezentuje wst�pn� umow� prawn� (docelow� umow�, spe�niaj�c� wszelkie wymogi formalne zajmuje si� notariusz) zwie�czaj�c� sprzeda� lub wynajem danej nieruchomo�ci. Zawiera szczeg�y dotycz�ce w�a�ciciela, klienta, agenta oraz oferty, na podstawie kt�rej zosta�a sporz�dzona

kwota - ostateczna uzgodniona kwota kupna/wynajmu danej nieruchomo�ci';

/*==============================================================*/
/* Index: umowa_PK                                              */
/*==============================================================*/
create unique index umowa_PK on umowa (
id_umowy ASC
);

/*==============================================================*/
/* Index: oferta_umowa2_FK                                      */
/*==============================================================*/
create index oferta_umowa2_FK on umowa (
id_oferty ASC
);

/*==============================================================*/
/* Index: status_umowy_umowa_FK                                 */
/*==============================================================*/
create index status_umowy_umowa_FK on umowa (
id_statusu_umowy ASC
);

/*==============================================================*/
/* Index: umowa_klient_FK                                       */
/*==============================================================*/
create index umowa_klient_FK on umowa (
id_osoby ASC
);

/*==============================================================*/
/* Table: wizyta                                                */
/*==============================================================*/
create table wizyta 
(
   id_wizyty            integer                        not null default autoincrement,
   id_oferty            integer                        not null,
   id_osoby             integer                        not null,
   data_wizyty          date                           not null,
   godzina_wizyty       time                           not null
      constraint CKC_GODZINA_WIZYTY check (godzina_wizyty between '09:00:00' and '20:00:00'),
   constraint PK_WIZYTA primary key (id_wizyty)
);

comment on table wizyta is 
'wizyta - reprezentuje wizyty w nieruchomo�ciach organizowane przez biuro nieruchomo�ci i prowadzone przez danego agenta opiekuj�cego si� dan� ofert�, posiada informacje o wizycie danego klienta na nieruchomo�ci, o tym kliencie i agencie, kt�ry si� dan� ofert� opiekuje';

/*==============================================================*/
/* Index: wizyta_PK                                             */
/*==============================================================*/
create unique index wizyta_PK on wizyta (
id_wizyty ASC
);

/*==============================================================*/
/* Index: oferta_wizyta_FK                                      */
/*==============================================================*/
create index oferta_wizyta_FK on wizyta (
id_oferty ASC
);

/*==============================================================*/
/* Index: klient_wizyta_FK                                      */
/*==============================================================*/
create index klient_wizyta_FK on wizyta (
id_osoby ASC
);

/*==============================================================*/
/* Table: wlasciciel                                            */
/*==============================================================*/
create table wlasciciel 
(
   id_osoby             integer                        not null default autoincrement,
   PESEL                varchar(11)                    not null unique,
   nr_dowodu_osobistego varchar(9)                     not null unique,
   imie                 varchar(16)                    not null,
   nazwisko             varchar(52)                    not null,
   email                varchar(255)                   null unique,
   nr_tel               varchar(9)                     not null unique,
   constraint PK_WLASCICIEL primary key clustered (id_osoby)
);

comment on table wlasciciel is 
'wlasciciel - osoba fizyczna b�d�ca w posiadaniu nieruchomo�ci. Na potrzeby projektu zak�adamy, �e w systemie biura jako w�a�ciciel danej nieruchomo�ci b�dzie wpisana jedna osoba.';

/*==============================================================*/
/* Index: wlasciciel_PK                                         */
/*==============================================================*/
create unique index wlasciciel_PK on wlasciciel (
id_osoby ASC
);

alter table nieruchomosc
   add constraint FK_NIERUCHO_STATUS_NI_STATUS_N foreign key (id_statusu_nieruchomosci)
      references status_nieruchomosci (id_statusu_nieruchomosci)
      on update restrict
      on delete restrict;

comment on foreign key nieruchomosc.FK_NIERUCHO_STATUS_NI_STATUS_N is 
'status_nieruchomosci_nieruchomosc - zwi�zek mi�dzy statusem nieruchomo�ci a dan� nieruchomo�ci�

status_nieruchomo�ci mo�e dotyczy� wielu nieruchomo�ci, ale dana nieruchomo�� ma tylko jeden status';

alter table nieruchomosc
   add constraint FK_NIERUCHO_TYP_NIERU_TYP_NIER foreign key (id_typu_nieruchomosci)
      references typ_nieruchomosci (id_typu_nieruchomosci)
      on update restrict
      on delete restrict;

comment on foreign key nieruchomosc.FK_NIERUCHO_TYP_NIERU_TYP_NIER is 
'typ_nieruchomosci_nieruchomosc - zwi�zek mi�dzy typem nieruchomo�ci a dan� nieruchomo�ci�


typ_nieruchomo�ci mo�e dotyczy� wielu nieruchomo�ci, ale dana nieruchomo�� jest tylko jednego typu';

alter table nieruchomosc
   add constraint FK_NIERUCHO_WLASCICIE_WLASCICI foreign key (id_osoby)
      references wlasciciel (id_osoby)
      on update restrict
      on delete restrict;

comment on foreign key nieruchomosc.FK_NIERUCHO_WLASCICIE_WLASCICI is 
'zwi�zek ��cz�cy osob� b�d�c� w�a�cicielem nieruchomo�ci z jej nieruchomo�ciami

w�a�ciciel mo�e mie� wiele nieruchomo�ci (osoba mo�e by� w�a�cicielem wielu nieruchomo�ci), ale nieruchomo�� w naszej bazie ma tylko jednego w�a�ciciela)';

alter table nieruchomosc_udogodnienia
   add constraint FK_NIERUCHO_NIERUCHOM_NIERUCHO foreign key (id_nieruchomosci)
      references nieruchomosc (id_nieruchomosci)
      on update restrict
      on delete restrict;

comment on foreign key nieruchomosc_udogodnienia.FK_NIERUCHO_NIERUCHOM_NIERUCHO is 
'zwi�zek, de facto intersekcja mi�dzy nieruchomo�ci� a udogodnieniami

nieruchomo�� mo�e mie� wiele udogodnie� a udogodnienie mo�e dotyczy� wielu nieruchomo�ci';

alter table nieruchomosc_udogodnienia
   add constraint FK_NIERUCHO_NIERUCHOM_UDOGODNI foreign key (id_udogodnienia)
      references udogodnienia (id_udogodnienia)
      on update restrict
      on delete restrict;

comment on foreign key nieruchomosc_udogodnienia.FK_NIERUCHO_NIERUCHOM_UDOGODNI is 
'zwi�zek, de facto intersekcja mi�dzy nieruchomo�ci� a udogodnieniami

nieruchomo�� mo�e mie� wiele udogodnie� a udogodnienie mo�e dotyczy� wielu nieruchomo�ci';

alter table oferta
   add constraint FK_OFERTA_AGENT_OFE_AGENT foreign key (id_osoby)
      references agent (id_osoby)
      on update restrict
      on delete restrict;

comment on foreign key oferta.FK_OFERTA_AGENT_OFE_AGENT is 
'agent_oferta - zwi�zek pomi�dzy dan� ofert� a opiekuj�cym si� nim agentem

agent mo�e by� opiekunem wielu ofert, ale oferta ma tylko jednego agenta, kt�ry jest jej opiekunem';

alter table oferta
   add constraint FK_OFERTA_NIERUCHOM_NIERUCHO foreign key (id_nieruchomosci)
      references nieruchomosc (id_nieruchomosci)
      on update restrict
      on delete restrict;

comment on foreign key oferta.FK_OFERTA_NIERUCHOM_NIERUCHO is 
'nieruchomosc_oferta - zwi�zek ��cz�cy dan� nieruchomo�� i powi�zan� z ni� ofert� kupna/sprzeda�y

nieruchomo�� jest przedmiotem jednej oferty a oferta dotyczy tylko jednej nieruchomo�ci';

alter table oferta
   add constraint FK_OFERTA_STATUS_OF_STATUS_O foreign key (id_statusu_oferty)
      references status_oferty (id_statusu_oferty)
      on update restrict
      on delete restrict;

comment on foreign key oferta.FK_OFERTA_STATUS_OF_STATUS_O is 
'status_oferty_oferta - zwi�zek mi�dzy aktualnym statusem oferty a dan� ofert�

status_oferty mo�e dotyczy� wielu ofert, ale dana oferta ma tylko jeden status';

alter table oferta
   add constraint FK_OFERTA_TYP_OFERT_TYP_OFER foreign key (id_typu_oferty)
      references typ_oferty (id_typu_oferty)
      on update restrict
      on delete restrict;

comment on foreign key oferta.FK_OFERTA_TYP_OFERT_TYP_OFER is 
'typ_oferty_oferta - zwi�zek mi�dzy typem oferty a dan� ofert�

typ_oferty mo�e dotyczy� wielu ofert, ale dana oferta jest tylko jednego typu';

alter table prowizja
   add constraint FK_PROWIZJA_TRANSAKCJ_TRANSAKC foreign key (id_transakcji)
      references transakcja (id_transakcji)
      on update restrict
      on delete restrict;

comment on foreign key prowizja.FK_PROWIZJA_TRANSAKCJ_TRANSAKC is 
'transakcja_prowizja - zwi�zek mi�dzy dan� transakcj� a prowizj�

Jedna transakcja dotyczy jednej prowizji i prowizja jednej danej transakcji';

alter table transakcja
   add constraint FK_TRANSAKC_TRANSAKCJ_PROWIZJA foreign key (id_prowizji)
      references prowizja (id_prowizji)
      on update restrict
      on delete restrict;

comment on foreign key transakcja.FK_TRANSAKC_TRANSAKCJ_PROWIZJA is 
'transakcja_prowizja - zwi�zek mi�dzy dan� transakcj� a prowizj�

Jedna transakcja dotyczy jednej prowizji i prowizja jednej danej transakcji';

alter table transakcja
   add constraint FK_TRANSAKC_UMOWA_TRA_UMOWA foreign key (id_umowy)
      references umowa (id_umowy)
      on update restrict
      on delete restrict;

comment on foreign key transakcja.FK_TRANSAKC_UMOWA_TRA_UMOWA is 
'umowa_transakcja - zwi�zek pomi�dzy dan� umow� a transakcj� z ni� zwi�zan�

W ramach umowy przeprowadzana jest jedna transakcja, ale transakcja dotyczy danej, konkretnej jednej umowy';

alter table umowa
   add constraint FK_UMOWA_OFERTA_UM_OFERTA foreign key (id_oferty)
      references oferta (id_oferty)
      on update restrict
      on delete restrict;

comment on foreign key umowa.FK_UMOWA_OFERTA_UM_OFERTA is 
'oferta_umowa - zwi�zek mi�dzy dan� ofert� a umow� z ni� zwi�zan�

oferta dotyczy jednej umowy a umowa jest sporz�dzana w ramach jednej oferty';

alter table umowa
   add constraint FK_UMOWA_STATUS_UM_STATUS_U foreign key (id_statusu_umowy)
      references status_umowy (id_statusu_umowy)
      on update restrict
      on delete restrict;

comment on foreign key umowa.FK_UMOWA_STATUS_UM_STATUS_U is 
'status_umowy_umowa - okre�la bie��cy stan umowy, np. podpisana/zrealizowana

status_umowy mo�e dotyczy� wielu um�w, ale umowa ma tylko jeden status_umowy';

alter table umowa
   add constraint FK_UMOWA_UMOWA_KLI_KLIENT foreign key (id_osoby)
      references klient (id_osoby)
      on update restrict
      on delete restrict;

comment on foreign key umowa.FK_UMOWA_UMOWA_KLI_KLIENT is 
'umowa_klient - zwi�zek pomi�dzy umow� a danym klientem

umowa musi dotyczy� tylko jednego klienta a klient mo�e by� przedmiotem wielu um�w';

alter table umowa
   add constraint FK_UMOWA_UMOWA_TRA_TRANSAKC foreign key (id_transakcji)
      references transakcja (id_transakcji)
      on update restrict
      on delete restrict;

comment on foreign key umowa.FK_UMOWA_UMOWA_TRA_TRANSAKC is 
'umowa_transakcja - zwi�zek pomi�dzy dan� umow� a transakcj� z ni� zwi�zan�

W ramach umowy przeprowadzana jest jedna transakcja, ale transakcja dotyczy danej, konkretnej jednej umowy';

alter table wizyta
   add constraint FK_WIZYTA_KLIENT_WI_KLIENT foreign key (id_osoby)
      references klient (id_osoby)
      on update restrict
      on delete restrict;

comment on foreign key wizyta.FK_WIZYTA_KLIENT_WI_KLIENT is 
'klient_wizyta - zwi�zek pomi�dzy klientem a wizyt�, kt�rej by�/jest/b�dzie uczestnikiem

wizyta dotyczy jednego klienta z bazy, ale klient mo�e by� uczestnikiem wielu wizyt';

alter table wizyta
   add constraint FK_WIZYTA_OFERTA_WI_OFERTA foreign key (id_oferty)
      references oferta (id_oferty)
      on update restrict
      on delete restrict;

comment on foreign key wizyta.FK_WIZYTA_OFERTA_WI_OFERTA is 
'oferta_wizyta - zwi�zek pomi�dzy dan� ofert� a wizyt� dotycz�c� jej

oferta mo�e dotyczy� wielu wizyt, ale dana wizyta dotyczy tylko jednej konkretnej oferty';

