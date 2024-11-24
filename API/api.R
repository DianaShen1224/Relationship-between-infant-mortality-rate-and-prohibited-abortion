id <- do_provision(example = FALSE)

install_r_package(
  droplet = id,
  c(
    "plumber",
    "remotes",
    "here"
  )
)

debian_apt_get_install(
  id,
  "libssl-dev",
  "libsodium-dev",
  "libcurl4-openssl-dev"
)

debian_apt_get_install(
  id,
  "libxml2-dev"
)

install_r_package(
  id,
  c(
    "config",
    "httr",
    "urltools",
    "plumber"
  )
)

install_r_package(id, c("xml2"))
install_r_package(id, c("tidyverse"))
install_r_package(id, c("tidymodels"))

do_deploy_api(
  droplet = id,
  path = "example",
  localPath = getwd(),
  
  
  port = 8000,
  docs = TRUE,
  overwrite = TRUE
)


do_deploy_api(id, "infant-death", "~/Relationship between infant mortality rate and prohibited abortion", 8000,docs = TRUE,overwrite = TRUE)
