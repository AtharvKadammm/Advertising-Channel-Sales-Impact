# 📊 Sales Impact of Advertising Channels

This project investigates how various advertising strategies — including spending on TV, Radio, Social Media, and use of different influencer types (Mega, Macro, Micro, Nano) — influence product sales. It uses applied statistical techniques to guide smarter marketing decisions.

---

## 📘 Project Overview

- Dataset: 4,572 real observations across 5 variables  
- Source: [Kaggle - Dummy Advertising and Sales Data](https://www.kaggle.com/datasets/harrimansaragih/dummy-advertising-and-sales-data)  
- Key Variables: Ad spend on TV, Radio, Social Media + Influencer Type + Product Sales

---

## 📊 Techniques Applied

- 📎 **T-Test** – Comparing mean sales between Mega and Micro influencers  
- 📚 **One-Way ANOVA** – Testing mean sales differences across all influencer types  
- 📈 **Bootstrapping** – Estimating 95% CI for mean sales  
- 🧮 **Regression Modeling** – Built 4 linear models, compared using AIC, BIC, MSPE, Adjusted R²  
- 🧪 **F-Test** – Nested model comparison  
- 🔐 **GLM (Logistic Regression)** – Predicting high/low sales outcome

---

## 🔍 Key Insights

- 📺 **TV ads** were the only significant predictor of higher sales  
- 👥 Influencer type showed **no statistically significant effect** on sales  
- 📉 Social Media impact was minimal; Radio had some predictive power  
- 📊 Model 4 (Full model) had the best fit; Model 2 (TV + Radio) had best MSPE  
- 🔄 Bootstrapped sales mean is stable (CI: 189.8–195.3)

---

## 🧰 Tools Used

- R  
- ggplot2, tidyverse, corrplot, boot, MASS  
- LaTeX (reporting)

---

## 📁 Files Included

- `Sales Impact of Advertising Channels.ipynb` – R-to-Python-converted analysis (optional)
- `vertopal.com_Sales Impact of Advertising Channels.pdf` – Final report
- `README.md`

---

## 👩‍💻 Team

- Atharv Kadam  
- Atharva Patil  
- Om Kokate

> MS Data Science — University of Colorado Boulder

---

## 📬 Connect

📫 [LinkedIn – Atharv Kadam](https://www.linkedin.com/in/atharv-kadam)  
🔗 [GitHub – AtharvKadammm](https://github.com/AtharvKadammm)
