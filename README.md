Customer Churn Analysis - Telecom Industry

Tools: Python | MySQL | pandas | matplotlib | seaborn | scikit-learn | Python | QL (SQLite) | pandas | scikit-learn

Business Problem
A telecom company wants to reduce customer churn. This project identifies the key drivers of churn and builds a predictive model to flag at-risk customers before they leave.

Dataset
• Source: IBM Telco Customer Churn (Kaggle)
• 7,043 customers | 50 features | Target: Churn Label (Yes/No) | Includes Churn Reason, CLTV, Satisfaction Score

Key Findings
1. Contract type is the strongest predictor of churn. Month-to-month customers churn at [X]%, compared to [X]% for two-year contract customers.
2. New customers are the highest risk group. Customers with tenure under 12 months have a [X]% churn rate - more than double the overall average.
3. Fiber optic internet users churn more than DSL users, suggesting a pricing or service quality issue in that segment.

Model Performance
• Algorithm: Logistic Regression
• Accuracy: [X]%
• ROC-AUC: [X]
• Most predictive features: contract type, tenure, monthly charges

Business Recommendations
• Offer month-to-month customers a discount to switch to annual contracts during months 1-12
• Create an early retention program for new customers with fiber optic internet
• Review pricing for customers paying above $70/month on month-to-month plans

Project Structure
data/ - Raw dataset
sql/ - Schema creation and 10 exploration queries
notebooks/ - EDA (8 analyses) and prediction (logistic regression)
visuals/ - All charts as PNG files
