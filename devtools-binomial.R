# =====================================================
# Devtools workflow
# library(devtools)
# =====================================================

# assuming your working directory is the dir of your package:
devtools::document()          # generate documentation
devtools::check_man()         # check documentation
devtools::test()              # run tests
devtools::build_vignettes()   # build vignettes
devtools::build()             # build bundle
devtools::install(build_vignettes = TRUE)  # install package
