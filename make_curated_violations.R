library(dplyr, warn.conflicts = FALSE)
library(readr)
library(codec)

d <-
  read_csv(fs::path("data-raw", "housing_violations.csv"),
         col_types = cols_only(
           `FULL ADDRESS` = col_character(),
           PARCEL = col_character(),
           V.I.D = col_character(),
           `VIOLATION TYPE` = col_character(),
           ISSUED = col_date(format = "%m/%d/%Y"))) |>
  rename(
    address = `FULL ADDRESS`,
    parcel_number = PARCEL,
    violation_id = V.I.D,
    violation_type = `VIOLATION TYPE`,
    date = ISSUED) |>
  distinct()

d$parcel_number <- gsub("[^[:alnum:]]", "", d$parcel_number)

d |>
  add_type_attrs() |>
  add_attrs(name = "curated_violations",
            title  = "Curated Housing and Health Code Violations shared from the City of Cincinnati Department of Buildings & Inspections",
            homepage = "https://github.com/geomarker-io/curated_violations",
            version = "0.1.2") |>
  write_tdr_csv()
  
