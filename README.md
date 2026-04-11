## 🎨 Art Gallery Management System (Oracle SQL)

### 🎓 University Project - Database Systems (SGBD)
**Developed by Mihai-Alexandru Andronescu**

---

## 🚀 Overview
This project focuses on the design and implementation of a relational database system tailored for an **Art Gallery**. It manages the complex relationships between artists, their artworks, international exhibitions, and sales transactions. The system is designed to provide both operational support for daily activities and analytical insights for management decisions.

## 📊 Database Architecture
The system is built on a normalized relational model consisting of **6 core tables** that handle:
* **Artists:** Portfolios, origins, and biographical data.
* **Artworks:** Technical details, creation years, and valuation.
* **Exhibitions:** Scheduling and location management across various galleries.
* **Sales:** Transactional history linking clients to specific purchases.
* **Clients:** Comprehensive contact management for art collectors.
* **Work-Exhibition Mapping:** A many-to-many junction table managing the placement of specific works in different exhibitions.

### 📐 Entity-Relationship Diagram (ERD)
*The repository includes a detailed schema visualizing the PK/FK relationships and data integrity constraints.*

## ✨ Technical Features & SQL Implementation
This project demonstrates advanced SQL proficiency through:
* **Data Definition (DDL):** Complex table structures with strict integrity constraints (`NOT NULL`, `PRIMARY KEY`, `FOREIGN KEY`).
* **Automation:** Implementation of **Sequences** (`SEQ_PRJ`) for automated ID generation.
* **Data Visualization:** Creation of **Views** (`VW_STATISTICI_ARTISTI`) for simplified reporting on artist performance and average prices.
* **Optimization:** Strategic use of **Indexes** to enhance query performance for client-transaction lookups.
* **Analytics:** Advanced queries utilizing:
    * **Joins:** Multi-table associations (up to 4 tables per join).
    * **Aggregations:** Grouping data by year, technique, or artist with `HAVING` filters.
    * **Subqueries:** Correlated and non-correlated subqueries for identifying top-tier sales and artists above-average performance.

## 🛠 Tech Stack
* **RDBMS:** Oracle SQL
* **Modeling:** Oracle SQL Developer Data Modeler
* **Language:** SQL / PL-SQL

## 📂 Repository Structure
* `Documentation/` - Full project report including ERD and requirements.
* `Scripts/` - Complete SQL scripts for schema creation and data population.
* `Queries/` - Collection of analytical SQL queries and reports.

---
*This project was developed at the Bucharest University of Economic Studies (ASE), Faculty of Economic Cybernetics, Statistics and Informatics.*
