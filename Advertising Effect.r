rm(list=ls())
library(readxl)
library(Hmisc) 
#load data
multdata <- read_excel("HW2_MultimediaHW.xlsx")

# obtain summary stats for the data
summary(multdata)
colnames(multdata)

# Combining catalogs into a single column
multdata$Catalog <- multdata$Catalogs_ExistCust + multdata$Catalogs_NewCust + multdata$Catalogs_Winback

# Combining search and portal into a single variable
multdata$online_search <- multdata$Search + multdata$Portals

library(dplyr)
advertising <- multdata %>% select("Sales (units)","Catalog","Mailings","online_search","Newsletter","Retargeting",
                                   "Search", "Portals","ADV_Offline","Catalogs_ExistCust",
                                   "Catalogs_NewCust","Catalogs_Winback")

catalog <- advertising$Catalog
catalog_existing <- advertising$Catalogs_ExistCust
catalog_new <- advertising$Catalogs_NewCust
catalog_winback <- advertising$Catalogs_Winback
mailing <- advertising$Mailings
online <- advertising$online_search
newsletter <- advertising$Newsletter
retargeting <- advertising$Retargeting
search <- advertising$Search
portal <- advertising$Portals
tot_offline <- advertising$ADV_Offline
cust_new_exist <- advertising$Catalogs_NewCust + advertising$Catalogs_ExistCust

catalog_s <- sqrt(advertising$Catalog)
catalog_existing_s <- sqrt(advertising$Catalogs_ExistCust)
catalog_new_s <- sqrt(advertising$Catalogs_NewCust)
catalog_winback_s <- sqrt(advertising$Catalogs_Winback)
mailing_s <- sqrt(advertising$Mailings)
online_s <- sqrt(advertising$online_search)
newsletter_s <- sqrt(advertising$Newsletter)
retargeting_s <- sqrt(advertising$Retargeting)
search_s <- sqrt(advertising$Search)
portal_s <- sqrt(advertising$Portals)
tot_offline_s <- sqrt(advertising$ADV_Offline)
cust_new_exist_s <- sqrt(advertising$Catalogs_NewCust + advertising$Catalogs_ExistCust)

catalog_l <- log(1 + advertising$Catalog)
catalog_existing_l <- log(1 + advertising$Catalogs_ExistCust)
catalog_new_l <- log(1 + advertising$Catalogs_NewCust)
catalog_winback_l <- log(1 + advertising$Catalogs_Winback)
mailing_l <- log(1 + advertising$Mailings)
online_l <- log(1 + advertising$online_search)
newsletter_l <- log(1 + advertising$Newsletter)
retargeting_l <- log(1 + advertising$Retargeting)
search_l <- log(1 + advertising$Search)
portal_l <- log(1 + advertising$Portals)
tot_offline_l <- log(1 + advertising$ADV_Offline)
cust_new_exist_l <- log(1 + advertising$Catalogs_NewCust + advertising$Catalogs_ExistCust)

sales <- advertising$`Sales (units)`
lag_sales <- Lag(sales,shift=1)

# Focus Model
focal <- lm(sales ~ lag_sales + catalog_winback_s + portal_s + newsletter_s)
summary(focal)
AIC(focal)

# No Intercept
focal_no_intercept <- lm(sales ~ lag_sales + catalog_winback_s + portal_s + newsletter_s -1)
summary(focal_no_intercept)
AIC(focal_no_intercept)

# log instead of sqrt
focal_log <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l)
summary(focal_log)
AIC(focal_log)

#### Online Online synergy

## Newsletter-Search
news_search <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l + 
                      newsletter_l*search_l)
summary(news_search)
AIC(news_search)

## Search-Portal
search_portal <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l + 
                      search_l*portal_l)
summary(search_portal)
AIC(search_portal)

## Portal-Retargeting
portal_retargeting <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l + 
                      portal_l*retargeting_l)
summary(portal_retargeting)
AIC(portal_retargeting)

#### Offline Online synergy

# Offline - Newsletter
offline_newsletter <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l + 
                       newsletter_l*tot_offline_l)
summary(offline_newsletter)
AIC(offline_newsletter)


# Offline-Portal
offline_portal <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l + 
                           portal_l*tot_offline_l)
summary(offline_portal)
AIC(offline_portal)

# Mailing-Portal
mailing_portal <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l + 
                       portal_l*mailing_l)
summary(mailing_portal)
AIC(mailing_portal)

# Winback - Portal
winback_portal <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l + 
                       portal_l*catalog_winback_l)
summary(winback_portal)
AIC(winback_portal)

# New+Exist - Portal
newexist_portal <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l + 
                       portal_l*cust_new_exist_l)
summary(newexist_portal)
AIC(newexist_portal)

#### Offline Online synergy

# Portal-Retargeting + New+Exist-Portal
mixed_doubles <- lm(sales ~ lag_sales + catalog_winback_l + portal_l + newsletter_l + 
                        portal_l*cust_new_exist_l + portal_l*retargeting_l)
summary(mixed_doubles)
AIC(mixed_doubles)

#### Removal of Lag sales synergy

## Intercept
focal_no_intercept_nolag <- lm(sales ~ catalog_winback_s + portal_s + newsletter_s -1)
summary(focal_no_intercept_nolag)
AIC(focal_no_intercept_nolag)

## Log
focal_log_nolag <- lm(sales ~ catalog_winback_l + portal_l + newsletter_l)
summary(focal_log_nolag)
AIC(focal_log_nolag)

## online-online
portal_retargeting_nolag <- lm(sales ~ catalog_winback_l + portal_l + newsletter_l + 
                           portal_l*retargeting_l)
summary(portal_retargeting_nolag)
AIC(portal_retargeting_nolag)

## offline-online
newexist_portal_nolag <- lm(sales ~ catalog_winback_l + portal_l + newsletter_l + 
                        portal_l*cust_new_exist_l)
summary(newexist_portal_nolag)
AIC(newexist_portal_nolag)

## offline-online and online-online
mixed_doubles_nolag <- lm(sales ~ catalog_winback_l + portal_l + newsletter_l + 
                      portal_l*cust_new_exist_l + portal_l*retargeting_l)
summary(mixed_doubles_nolag)
AIC(mixed_doubles_nolag)
