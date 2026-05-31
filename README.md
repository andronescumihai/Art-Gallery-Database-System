<div align="center">

# 🎨 Art Gallery Management System

**Developed by Andronescu Mihai-Alexandru**

[![Oracle SQL](https://img.shields.io/badge/Oracle-SQL-F80000?style=for-the-badge&logo=oracle&logoColor=white)](https://www.oracle.com/database/)
[![PL/SQL](https://img.shields.io/badge/PL--SQL-DDL%2FDML-4479A1?style=for-the-badge)](https://docs.oracle.com/en/database/oracle/oracle-database/)
[![SQL Developer](https://img.shields.io/badge/Oracle%20SQL-Developer-F80000?style=for-the-badge&logo=oracle&logoColor=white)](https://www.oracle.com/database/sqldeveloper/)
[![Status](https://img.shields.io/badge/Status-Complete-success?style=for-the-badge)]()

*Relational database system for managing artists, artworks, exhibitions, clients, and sales — designed and implemented with Oracle SQL at Bucharest University of Economic Studies (ASE).*

[📐 Schema](#-database-schema) • [🗃️ DDL](#️-ddl--schema-creation) • [🔍 Analytics](#-analytical-queries) • [⚙️ Automation](#️-automation--views) • [📬 Contact](#-contact)

</div>

---

## 📌 Project Overview

This project implements a fully normalized relational database for an **Art Gallery**, covering the complete lifecycle of gallery operations: artist portfolio management, artwork cataloguing, exhibition scheduling, client relationship management, and sales transaction tracking.

Built with **Oracle SQL** and designed following the **3NF normalization standard**, the system supports both daily operational queries and management-level analytics such as artist revenue rankings, exhibition performance, and client purchase history.

> 🎓 Developed at **ASE București** — Facultatea de Cibernetică, Statistică și Informatică Economică, as part of the *Sisteme de Gestiune a Bazelor de Date (SGBD)* course.

---

## 📐 Database Schema

The system consists of **6 interrelated tables** with enforced referential integrity:

```
ARTISTI_PRJ ──────────────────────────────────┐
     │ PK: id_artist                           │
     │                                         │
     ▼ FK: id_artist                           │
LUCRARI_ARTA_PRJ ───────────────────────┐     │
     │ PK: id_lucrare                   │      │
     │ INDEX: id_artist                 │      │
     │                                  ▼      │
     ▼ FK: id_lucrare       LUCRARI_EXPOZITII_PRJ
VANZARI_PRJ                  PK: (id_lucrare, id_expozitie)
     │ PK: id_vanzare        INDEX: id_expozitie
     │ INDEX: id_client, id_lucrare              │
     │                                           ▼
     ▼ FK: id_client               EXPOZITII_PRJ
CLIENTI_PRJ                        PK: id_expozitie
     PK: id_client
```

### Tables at a Glance

| Table | Rows (seed data) | Key Columns | Role |
|:---|:---:|:---|:---|
| `ARTISTI_PRJ` | 10 | `id_artist`, `nume`, `tara_origine`, `biografie` | Artist portfolios & origins |
| `LUCRARI_ARTA_PRJ` | 24 | `id_lucrare`, `titlu`, `tehnica`, `pret_estimativ` | Artwork catalogue |
| `EXPOZITII_PRJ` | 6 | `id_expozitie`, `locatie`, `data_deschidere` | Exhibition scheduling |
| `CLIENTI_PRJ` | 20 | `id_client`, `nume`, `email`, `telefon` | Collector CRM |
| `VANZARI_PRJ` | 30 | `id_vanzare`, `pret_final`, `data_vanzare` | Sales transactions |
| `LUCRARI_EXPOZITII_PRJ` | 30+ | `id_lucrare`, `id_expozitie`, `loc_in_expozitie` | Artwork ↔ Exhibition mapping |

---

## 🗃️ DDL — Schema Creation

### Core Tables

```sql
CREATE TABLE ARTISTI_PRJ (
    id_artist    NUMBER(6)      NOT NULL,
    nume         VARCHAR2(60)   NOT NULL,
    tara_origine VARCHAR2(40),
    data_nasterii DATE,
    biografie    VARCHAR2(4000),
    CONSTRAINT ARTISTI_PRJ_PK PRIMARY KEY (id_artist)
);

CREATE TABLE LUCRARI_ARTA_PRJ (
    id_lucrare      NUMBER(6)    NOT NULL,
    titlu           VARCHAR2(100) NOT NULL,
    an_realizare    NUMBER(4),
    tehnica         VARCHAR2(60)  NOT NULL,
    pret_estimativ  NUMBER(10,2),
    id_artist       NUMBER(6)    NOT NULL,
    CONSTRAINT LUCRARI_ARTA_PRJ_PK      PRIMARY KEY (id_lucrare),
    CONSTRAINT LUCRARI_ARTA_PRJ_ARTIST_FK FOREIGN KEY (id_artist)
        REFERENCES ARTISTI_PRJ (id_artist)
);

CREATE TABLE VANZARI_PRJ (
    id_vanzare   NUMBER(8)    NOT NULL,
    data_vanzare DATE         NOT NULL,
    pret_final   NUMBER(10,2) NOT NULL,
    id_client    NUMBER(6)    NOT NULL,
    id_lucrare   NUMBER(6)    NOT NULL,
    CONSTRAINT VANZARI_PRJ_PK         PRIMARY KEY (id_vanzare),
    CONSTRAINT VANZARI_PRJ_CLIENT_FK  FOREIGN KEY (id_client)
        REFERENCES CLIENTI_PRJ (id_client),
    CONSTRAINT VANZARI_PRJ_LUCRARE_FK FOREIGN KEY (id_lucrare)
        REFERENCES LUCRARI_ARTA_PRJ (id_lucrare)
);
```

### Junction Table — Many-to-Many (Artwork ↔ Exhibition)

```sql
CREATE TABLE LUCRARI_EXPOZITII_PRJ (
    id_lucrare       NUMBER(6)    NOT NULL,
    id_expozitie     NUMBER(6)    NOT NULL,
    data_expusa      DATE,
    loc_in_expozitie VARCHAR2(100),
    CONSTRAINT LUCRARI_EXPOZITII_PRJ_PK PRIMARY KEY (id_lucrare, id_expozitie),
    CONSTRAINT LE_PRJ_LUCRARE_FK   FOREIGN KEY (id_lucrare)
        REFERENCES LUCRARI_ARTA_PRJ (id_lucrare),
    CONSTRAINT LE_PRJ_EXPOZITIE_FK FOREIGN KEY (id_expozitie)
        REFERENCES EXPOZITII_PRJ (id_expozitie)
);
```

---

## ⚙️ Automation & Views

### Sequences — Auto-ID Generation

Five dedicated sequences ensure conflict-free primary key generation across all entities:

```sql
CREATE SEQUENCE SEQ_ARTISTI_PRJ   START WITH 100 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_CLIENTI_PRJ   START WITH 100 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_EXPOZITII_PRJ START WITH 100 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_LUCRARI_PRJ   START WITH 100 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_VANZARI_PRJ   START WITH 100 INCREMENT BY 1 NOCACHE;
```

### Views — Simplified Reporting

```sql
-- Simplified artist roster (operational view)
CREATE VIEW VW_ARTISTI_SIMPLU AS
SELECT id_artist, nume, tara_origine, data_nasterii
FROM ARTISTI_PRJ;

-- Management analytics: artwork count & average price per artist
CREATE VIEW VW_STATISTICI_ARTISTI AS
SELECT
    a.id_artist,
    a.nume,
    COUNT(l.id_lucrare)             AS nr_lucrari,
    ROUND(AVG(l.pret_estimativ), 2) AS pret_mediu
FROM ARTISTI_PRJ a
LEFT JOIN LUCRARI_ARTA_PRJ l ON a.id_artist = l.id_artist
GROUP BY a.id_artist, a.nume;
```

### Indexes — Query Optimization

```sql
-- Speeds up artwork lookups by artist
CREATE INDEX LUCRARI_ARTA_PRJ_ARTIST_IX ON LUCRARI_ARTA_PRJ (id_artist);

-- Accelerates client transaction history queries
CREATE INDEX VANZARI_PRJ_CLIENT_IX  ON VANZARI_PRJ (id_client);
CREATE INDEX VANZARI_PRJ_LUCRARE_IX ON VANZARI_PRJ (id_lucrare);
CREATE INDEX LE_PRJ_EXPOZITIE_IX    ON LUCRARI_EXPOZITII_PRJ (id_expozitie);

-- Virtual index for composite client + date lookups (NOSEGMENT)
CREATE INDEX VIRT_VANZARI_CLIENT_DATA
    ON VANZARI_PRJ (id_client, data_vanzare) NOSEGMENT;
```

---

## 🔍 Analytical Queries

The project includes **8 analytical queries** covering DML updates, multi-table JOINs, aggregations, and correlated subqueries.

### Query 1 — Price Adjustment (DML)
Apply a 10% price increase to all artworks created after 2020:
```sql
UPDATE LUCRARI_ARTA_PRJ
SET    pret_estimativ = pret_estimativ * 1.10
WHERE  an_realizare > 2020;
```

### Query 2 — Bulk Email Domain Migration (DML)
Migrate all client emails from `example.com` to the gallery's own domain:
```sql
UPDATE CLIENTI_PRJ
SET    email = REPLACE(email, 'example.com', 'galerie.ro')
WHERE  email LIKE '%example.com';
```

### Query 3 — Artist Revenue Ranking (3-table JOIN)
```sql
SELECT a.nume, a.tara_origine,
       COUNT(v.id_vanzare) AS nr_vanzari,
       SUM(v.pret_final)   AS total_incasari
FROM   ARTISTI_PRJ a
JOIN   LUCRARI_ARTA_PRJ l ON a.id_artist  = l.id_artist
JOIN   VANZARI_PRJ v      ON l.id_lucrare = v.id_lucrare
GROUP BY a.nume, a.tara_origine
ORDER BY total_incasari DESC;
```

### Query 4 — Top Clients by Spend in 2022
```sql
SELECT c.nume AS nume_client,
       COUNT(v.id_vanzare) AS nr_tranzactii,
       SUM(v.pret_final)   AS total_2022
FROM   CLIENTI_PRJ c
JOIN   VANZARI_PRJ v ON c.id_client = v.id_client
WHERE  EXTRACT(YEAR FROM v.data_vanzare) = 2022
GROUP BY c.nume
ORDER BY total_2022 DESC;
```

### Query 5 — Exhibition Diversity (Distinct Artists per Show, 4-table JOIN)
```sql
SELECT e.nume AS nume_expozitie, e.locatie,
       COUNT(DISTINCT l.id_artist) AS nr_artisti_distincti
FROM   EXPOZITII_PRJ e
JOIN   LUCRARI_EXPOZITII_PRJ le ON e.id_expozitie = le.id_expozitie
JOIN   LUCRARI_ARTA_PRJ l       ON le.id_lucrare   = l.id_lucrare
GROUP BY e.nume, e.locatie
ORDER BY nr_artisti_distincti DESC;
```

### Query 6 — Above-Average Revenue Artists (Correlated Subquery)
Identifies artists whose total sales exceed the fleet average — using a nested subquery:
```sql
SELECT a.id_artist, a.nume
FROM   ARTISTI_PRJ a
WHERE (SELECT SUM(v.pret_final)
       FROM   LUCRARI_ARTA_PRJ l
       JOIN   VANZARI_PRJ v ON l.id_lucrare = v.id_lucrare
       WHERE  l.id_artist = a.id_artist)
    >
      (SELECT AVG(t.total_artist)
       FROM  (SELECT l2.id_artist, SUM(v2.pret_final) AS total_artist
              FROM   LUCRARI_ARTA_PRJ l2
              JOIN   VANZARI_PRJ v2 ON l2.id_lucrare = v2.id_lucrare
              GROUP BY l2.id_artist) t);
```

### Query 7 — Revenue per Exhibition
```sql
SELECT e.id_expozitie, e.nume,
       SUM(v.pret_final) AS total_expozitie
FROM   EXPOZITII_PRJ e
JOIN   LUCRARI_EXPOZITII_PRJ le ON e.id_expozitie = le.id_expozitie
JOIN   LUCRARI_ARTA_PRJ l       ON le.id_lucrare   = l.id_lucrare
JOIN   VANZARI_PRJ v            ON l.id_lucrare    = v.id_lucrare
GROUP BY e.id_expozitie, e.nume
ORDER BY total_expozitie DESC;
```

### Query 8 — Most Active Artists (HAVING filter)
Artists with works in at least 2 different exhibitions:
```sql
SELECT a.id_artist, a.nume,
       COUNT(DISTINCT le.id_expozitie) AS nr_expozitii
FROM   ARTISTI_PRJ a
JOIN   LUCRARI_ARTA_PRJ l       ON a.id_artist   = l.id_artist
JOIN   LUCRARI_EXPOZITII_PRJ le ON l.id_lucrare  = le.id_lucrare
GROUP BY a.id_artist, a.nume
HAVING COUNT(DISTINCT le.id_expozitie) >= 2
ORDER BY nr_expozitii DESC;
```

---

## 📊 Seed Data Summary

| Entity | Count | Examples |
|:---|:---:|:---|
| Artists | 10 | Andrei Popescu (RO), Luca Bianchi (IT), Sophie Dubois (FR), Kenji Tanaka (JP) |
| Artworks | 24 | Oil, Acrylic, Watercolour, Mixed Media, Digital Print, Installation |
| Exhibitions | 6 | Culori Urbane (București), Abstract și Forme (Cluj), Portrete Contemporane (Iași)... |
| Clients | 20 | Collectors across 20 Romanian cities |
| Sales | 30 | Date range: March 2022 – October 2022, values 1,850–5,100 RON |
| Exhibition placements | 30+ | Specific sala + perete assignments per artwork |

---

## 📂 Repository Structure

```
art-gallery-db/
│
├── 📄 README.md
│
├── 🗃️ Scripts/
│   └── Setup_Database.sql          # Full DDL: tables, sequences, views, indexes, seed data
│
├── 🔍 Queries/
│   └── Analytical_Queries.sql      # 8 analytical queries (DML, JOINs, subqueries)
│
└── 📁 Documentation/
    ├── Project_Report.docx          # Full project report with requirements & design decisions
    └── Schema_DB.png                # ERD — PK/FK relationships visualized
```

---

## 🛠️ Technical Stack

| Layer | Tool |
|:---|:---|
| **RDBMS** | Oracle Database |
| **Language** | SQL / PL-SQL |
| **Modeling** | Oracle SQL Developer Data Modeler |
| **IDE** | Oracle SQL Developer |
| **Normalization** | 3NF — no transitive dependencies |

---

## 📬 Contact

<div align="center">

**Andronescu Mihai-Alexandru**  
*ASE București — Cibernetică, Statistică și Informatică Economică*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mihai-alexandru-andronescu-58792b33b/)
[![Email](https://img.shields.io/badge/Email-Contact-EA4335?style=for-the-badge&logo=gmail&logoColor=white)](mailto:andronescumihai.alex13@gmail.com)

</div>

---

<div align="center">
<sub>Designed for precision. Built for scale. Queried for insight.</sub>
</div>
