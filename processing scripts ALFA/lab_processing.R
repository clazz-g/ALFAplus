if (!require("pacman")) install.packages("pacman")

pacman::p_load(tidyverse, VIM, ggpubr, ggeffects, car, sjPlot,caret, ggrain, emmeans, skimr, lavaan, patchwork, lme4, lmerTest, gtsummary, huxtable, readxl, broom.mixed, pwrss, mediation)

setwd("C:/Users/U253662/Documents/git/processing scripts/ALFAplus")
config <- config::get()
lab<-read_delim(paste0(config$alfa_dataset_raw, "A+ Long 2025 4Q_8_LAB_20251204105351.csv"), locale = locale(encoding = "UTF8"))%>%
  dplyr::select(IdParticipante, Collection_dt, Session, Visit, Sample_type, `1180_1`, `1183_1`, `1185_1`)%>%
  rename(subject = IdParticipante,
         cholesterol = `1180_1`,
         chol_LDL = `1183_1`,
         chol_HDL = `1185_1`,
         collection_dt_lab = Collection_dt)%>%
  filter(Sample_type == "Sangre",
         !if_all(c(cholesterol, chol_LDL, chol_HDL), is.na))%>%
  dplyr::select(-Session)%>%
  mutate(Visit= case_when(Visit == "V1" ~ 1,
                          Visit == "V2" ~ 2,
                          Visit == "V3" ~ 3,
                          .default = 2.5 ))

write.csv(lab, file = "G:/My Drive/Data/ALFA+/data_cleaned/ALFA_dataset_lab.csv", row.names = F)  
