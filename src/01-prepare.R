##
## Remove some subjects and items (deemed necessary by Tijn)
## Save dataframe without some columns
##

here::i_am("src/01-prepare.R")


library(dplyr)
library(readr)
library(here)

prepare_data <- function(data_in) {
  dataf <- read_delim(here(data_in), delim = " ") %>%
    mutate(
      item = as.numeric(item),
      subjectnr = as.numeric(subjectnr)
    )

  ## glimpse(dataf)
  ## all(sort(unique(dataf$item)) == seq(32))
  ## length(unique(dataf$subjectnr))

  out <- dataf %>%
    filter(
      !(item %in% c(14, 24)),
      subjectnr != 4,
      !(subjectnr == 40 & item == 19),
      !(subjectnr == 13 & item == 25),
      !(subjectnr == 43 & (item == 3 | item == 6 | item == 7)),
      !(subjectnr == 20 & item == 30)
    ) %>%
    group_by(cond) %>%
    mutate(
      quan = strsplit(cond[1], "_")[[1]][1],
      subj = strsplit(cond[1], "_")[[1]][2],
      obj = strsplit(cond[1], "_")[[1]][3]
    ) %>%
    ungroup()


  out %>%
    filter(subjectnr == 43, item %in% c(3, 6, 7, 14, 24))


  ## remove saccade time from fixation time
  ## (for rpdur, tgdur, gdur) and save it again as rpdur, tgdur, gdur

  out$rpdur <- out$rpdur - out$rpsacc
  out$tgdur <- out$tgdur - out$tgsacc
  out$gdur <- out$gdur - out$gsacc

  out <- out %>% select(-c("rpsacc", "tgsacc", "gsacc"))

  out %>%
    select(-cond, -expname) %>%
    rename(
      subj = subjectnr, subj_cond = subj, obj_cond = obj,
      quan_cond = quan, region = code
    ) %>%
    write_csv(here("results/allACTFiles_clean_sacccadtetime_removed.csv"))
}

main <- function(){
  prepare_data("data/allACTFiles_vp.csv")
}

if (sys.nframe() == 0) {
  main()
}
