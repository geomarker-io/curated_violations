# curated_violations

The goal of this repository is to curate data regularly shared from the City of Cincinnati Department of Buildings & Inspections.

## reading data

Read from the latest version available in the repository here on GitHub with:

```{r}
codec::read_tdr_csv("https://raw.githubusercontent.com/geomarker-io/curated_violations/main/curated_violations/tabular-data-resource.yaml")
```

Read from a specific [release](https://github.com/geomarker-io/curated_violations/releases); e.g., for [version 0.1.1](https://github.com/geomarker-io/curated_violations/releases/tag/0.1.1):

```{r}
codec::read_tdr_csv("https://github.com/geomarker-io/curated_violations/releases/download/0.1.1/tabular-data-resource.yaml")
```

## creating data

As of now, this process entails an email and the depositing of data onto the RISEUP sharepoint site. "Violations related to health mold or lead in the last five years" are subset by the city and come in two files Microsoft Excel files, one for health code violations and one for housing violations.  Each dataset is under a subfolder that denotes the date and source of the original excel files on the [RISEUP](https://cchmc.sharepoint.com/:f:/r/sites/RISEUP/Shared%20Documents/Data/violations_related_to_health_mold_lead?csf=1&web=1&e=JzLPKw) sharepoint.

These were *manually* saved within `data-raw/` as `health_violations.csv` and `housing_violations.csv` using Excel after difficulties with {readxl}. Note that the housing excel file is spread across two sheets and must be manually combined into one csv file. When copying, beware the random row at the bottom called "Grand Totals:"  (`¯\_(ツ)_/¯`).

After more data exploration, all but 11 of ~ 18k `health` records were duplicates already contained in `housing` records; so only `housing` records are now considered and there no longer a `violation_city_category`. Dashes were removed from the parcel identifiers so they are consistent with parcel identifer representation in CAGIS.

`make_curated_violations.R` reads this csv file from `data-raw/`, applies some cleaning, and saves the data as a [tabular-data-resource](https://geomarker.io/codec/articles/reading-writing-tdr.html) (i.e., a folder with a data CSV file and a metadata YAML file) called `curated_violations`.

