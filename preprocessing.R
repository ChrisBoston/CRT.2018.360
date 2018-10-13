# set the working directory
setwd("C:/Users/Chris/OneDrive/MPH/HST 953/updated dataset")

# load the libraries
library("data.table")

# read the clinical dataset
dataset_trend_cancer_clinical = as.matrix(fread(file=paste0(getwd(),"/dataset_trend_cancer_clinical.txt"),header=FALSE,sep="|",check.names=FALSE,stringsAsFactors=FALSE))

colnames(dataset_trend_cancer_clinical) = c("SUBJECT_ID","HADM_ID","ICUSTAY_ID","AGE_ADMISSION","GENDER","RACE","MARITAL_STATUS","ELIXHAUSER_VANWALRAVEN","ELIXHAUSER_SID29","ELIXHAUSER_SID30","VASOPRESSORS_DURATION_MINUTES","VENTILATION_DURATION_MINUTES","OASIS_SCORE", "APSIII_SCORE","ICU_TYPE","RRT","DNR_ADMISSION","DNR_ANY","CMO_ADMISSION","CMO_ANY","SOFA_SCORE","SAPS_SCORE","MORTALITY_ICU","MORTALITY_TIME","LOS_ICU","LOS_HOSPITAL","SOLID_TUMOR","METASTATIC_CANCER","LYMPHOMA","ORALMAL","GIMAL", "RESPMAL","CONNMAL", "GUMAL", "OTHERMAL", "TRUELYMPHOMA", "OTHERHEMMAL","LEUKEMIA", "METS", "TUMOR")

# replace missing values with NAs
dataset_trend_cancer_clinical[which(dataset_trend_cancer_clinical=="NA",arr.ind=TRUE)] = NA

# consider only the patients over 18 years old
dataset_trend_cancer_clinical = dataset_trend_cancer_clinical[which(as.numeric(dataset_trend_cancer_clinical[,"AGE_ADMISSION"])>18),]

# set to 91.61 the age over 90 (see MIMIC policies)
dataset_trend_cancer_clinical[which(as.numeric(dataset_trend_cancer_clinical[,"AGE_ADMISSION"])>90),"AGE_ADMISSION"] = 91.61

# write the datasets fo files
write.table(dataset_trend_cancer_clinical,file=paste0(getwd(),"/dataset_trend_cancer_clinical_processed.txt"),quote=FALSE,sep="\t",row.names=FALSE,col.names=TRUE)
