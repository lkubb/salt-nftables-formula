# vim: ft=sls

{#-
    *Meta-state*.

    This installs the nftables package,
    manages the nftables configuration file
    and then starts the associated nftables service.
#}

include:
  - .package
  - .config
  - .service
