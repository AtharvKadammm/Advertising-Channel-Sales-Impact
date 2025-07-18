
# 📦 Load required libraries
library(tidyverse)
library(corrplot)
library(boot)
library(MASS)
library(ggplot2)

# 📥 Load the dataset
df <- read.csv("Dummy Data HSS.csv")

# 🧹 Handle missing values
df$TV[is.na(df$TV)] <- median(df$TV, na.rm = TRUE)
df$Radio[is.na(df$Radio)] <- median(df$Radio, na.rm = TRUE)
df$Social.Media[is.na(df$Social.Media)] <- median(df$Social.Media, na.rm = TRUE)
df$Sales[is.na(df$Sales)] <- median(df$Sales, na.rm = TRUE)

# Convert Influencer column to lowercase and factor
df$Influencer <- tolower(df$Influencer)
df$Influencer <- as.factor(df$Influencer)

# 1️⃣ T-Test: Mega vs Micro Influencers
df_filtered <- df %>% filter(Influencer %in% c("mega", "micro"))
mega_sales <- df_filtered %>% filter(Influencer == "mega") %>% pull(Sales)
micro_sales <- df_filtered %>% filter(Influencer == "micro") %>% pull(Sales)
t_test_result <- t.test(mega_sales, micro_sales)
print(t_test_result)

# 2️⃣ One-Way ANOVA
anova_result <- aov(Sales ~ Influencer, data = df)
summary(anova_result)
tukey_result <- TukeyHSD(anova_result)
print(tukey_result)

# 3️⃣ Bootstrapping Confidence Interval
boot_mean <- function(data, indices) { return(mean(data[indices])) }
set.seed(100)
boot_sales <- boot(data = df$Sales, statistic = boot_mean, R = 1000)
boot_ci <- boot.ci(boot_sales, type = "perc")
print(boot_ci)

# 4️⃣ Regression Models (Model Selection)
set.seed(100)
n <- nrow(df)
train_indices <- sample(seq_len(n), size = 0.8 * n)
train <- df[train_indices, ]
test <- df[-train_indices, ]
model1 <- lm(Sales ~ TV, data = train)
model2 <- lm(Sales ~ TV + Radio, data = train)
model3 <- lm(Sales ~ TV + Radio + Social.Media, data = train)
model4 <- lm(Sales ~ TV + Radio + Social.Media + Influencer, data = train)
test$Influencer <- factor(test$Influencer, levels = levels(train$Influencer))
pred1 <- predict(model1, newdata = test)
pred2 <- predict(model2, newdata = test)
pred3 <- predict(model3, newdata = test)
pred4 <- predict(model4, newdata = test)
mspe1 <- mean((test$Sales - pred1)^2)
mspe2 <- mean((test$Sales - pred2)^2)
mspe3 <- mean((test$Sales - pred3)^2)
mspe4 <- mean((test$Sales - pred4)^2)
model_comp <- data.frame(
  Model = c("TV", "TV + Radio", "TV + Radio + Social.Media", "Full Model"),
  AIC = c(AIC(model1), AIC(model2), AIC(model3), AIC(model4)),
  BIC = c(BIC(model1), BIC(model2), BIC(model3), BIC(model4)),
  Adj_R2 = c(summary(model1)$adj.r.squared, summary(model2)$adj.r.squared,
             summary(model3)$adj.r.squared, summary(model4)$adj.r.squared),
  MSPE = c(mspe1, mspe2, mspe3, mspe4)
)
print(model_comp)

# 5️⃣ F-Test
f_test_result <- anova(model2, model4)
print(f_test_result)

# 6️⃣ GLM Logistic Regression
threshold <- median(df$Sales)
df$High_Sales <- ifelse(df$Sales > threshold, 1, 0)
glm_model <- glm(High_Sales ~ TV + Radio + Social.Media + Influencer,
                 family = binomial(link = "logit"), data = df)
summary(glm_model)
