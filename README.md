# SQLDataWarehouseProject

Welcome to the **SQL Data Warehouse Project**, a modern and scalable data warehousing solution designed to handle large volumes of data, transform it into actionable insights, and enable analytics and machine learning. This project leverages the **Extract, Transform, and Store (ETS)** processes, robust data modeling, and advanced analytics capabilities.

---

## Key Components

### **Sources**
- Data ingestion from **CRM** and **ERP** systems.
- **File types:** CSV files.
- **Interface:** Files in folders.

---

## **Bronze Layer**
### **Purpose**
- Store raw data as-is.

### **Object Type**
- Tables.

### **Load Mechanism**
- Batch processing.
- Full load, truncate & insert.

### **Transformations**
- None.

### **Data Model**
- None.

---

## **Silver Layer**
### **Purpose**
- Clean and standardize data.

### **Object Type**
- Tables.

### **Load Mechanism**
- Batch processing.
- Full load, truncate & insert.

### **Transformations**
- Data cleansing.
- Standardization.
- Normalization.
- Derived columns.
- Enrichment.

### **Data Model**
- None.

---

## **Gold Layer**
### **Purpose**
- Provide business-ready data.

### **Object Type**
- Views.

### **Load Mechanism**
- None (data is queried directly).

### **Transformations**
- Data integrations.
- Aggregations.
- Business logic.

### **Data Model**
- Star schema.
- Flat tables.
- Aggregated tables.

---

## **Consume**

### **Tools for analytics and reporting**
- **Business Intelligence tools** (e.g., Power BI, Tableau).
- **Ad-hoc SQL queries.**

This structured approach ensures scalability, data integrity, and optimized analytics, enabling organizations to derive meaningful insights efficiently.

