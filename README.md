# 🌍 World Life Expectancy Data Analysis

## 📌 Project Overview
This project analyzes **global life expectancy trends** using SQL-based **data cleaning and exploration**. It investigates how factors like **GDP, BMI, and adult mortality** influence longevity across different nations.

### 🔹 **Key Goals:**
✅ Clean and prepare data for accurate insights.  
✅ Analyze **life expectancy trends over time**.  
✅ Compare life expectancy against **GDP, BMI, and development status**.  
✅ Track **adult mortality trends** to assess healthcare effectiveness.  

---

## 📂 Project Structure

```
📁 WorldLifeExpectancy_Analysis
│── 📜 README.md                  # Project Documentation
│── 📜 data_exploration.sql        # SQL Queries for Data Analysis
│── 📜 data_cleaning.sql           # SQL Queries for Data Cleaning
```

---

## 🛠️ Data Cleaning Approach  

Before running the analysis, I cleaned the dataset to remove inconsistencies.

### 🚀 **Techniques Used:**
✔ **Handling Duplicates** – Removed redundant `Country-Year` records.  
✔ **Fixing Missing Status** – Updated empty `Developed/Developing` fields.  
✔ **Filling Missing Life Expectancy** – Used **interpolation** to estimate missing values.  

**🔧 Example Query - Fixing Missing Life Expectancy:**
```sql
UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2 ON t1.Country = t2.Country AND t1.Year = t2.Year - 1
JOIN worldlifeexpectancy t3 ON t1.Country = t3.Country AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;
```

---

## 🔍 Data Exploration & Key Insights

Once the data was cleaned, I used SQL to analyze **global health trends**. Below are the major insights:

### 📈 **1. Life Expectancy Trends Over Time**
- Analyzed the **change in life expectancy over 15 years**.
- Found **countries with the biggest improvements** and those lagging behind.

### 💰 **2. GDP vs. Life Expectancy**
- Wealthier nations **generally have higher life expectancy**.
- Some **low-GDP countries** performed better than expected due to **government health programs**.
- Some **high-GDP countries had lower life expectancy** due to **lifestyle diseases (obesity, stress, etc.)**.

**🔧 Example Query - Life Expectancy vs. GDP:**
```sql
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, 
ROUND(AVG(GDP),1) AS GDP
FROM worldlifeexpectancy
GROUP BY Country
HAVING Life_Exp > 0 AND GDP > 0
ORDER BY GDP DESC;
```

### 🌍 **3. Developed vs. Developing Countries**
- The gap between **developed and developing countries** is **narrowing**.
- Developing countries are making **significant improvements** due to **medical advancements**.

### 🍔 **4. BMI & Life Expectancy Correlation**
- High **BMI correlates with lower life expectancy** in some countries, highlighting **lifestyle-related risks**.
- Low-BMI nations **suffer from malnutrition and related health issues**.

### ⚰️ **5. Adult Mortality Trends**
- Used **window functions** to track cumulative **adult mortality rates**.
- **Declining mortality rates** indicate **improving healthcare systems**.
- **Persistently high mortality rates** in certain regions suggest **ongoing health crises**.

---

## 🔮 Future Enhancements  

💡 **Next Steps:**  
🔹 **Predictive Modeling** – Use **Python (scikit-learn)** to predict **future life expectancy trends**.  
🔹 **Visualization Dashboard** – Create **interactive dashboards in Tableau/Power BI**.  
🔹 **Geospatial Mapping** – Use **Python (Folium/GeoPandas)** for **regional analysis**.  

---

## 🏗️ How to Run This Project

### 📌 **Prerequisites**
- **SQL Database** (MySQL, PostgreSQL, or equivalent)
- (Optional) **Power BI/Tableau** for visualization

### 🚀 **Steps to Run**
1️⃣ **Import the dataset** into your SQL database.  
2️⃣ **Run `data_cleaning.sql`** to clean and prepare the data.  
3️⃣ **Execute `data_exploration.sql`** to generate insights.  
4️⃣ (Optional) **Use `visualization_dashboard.pbix`** to explore trends interactively.  


