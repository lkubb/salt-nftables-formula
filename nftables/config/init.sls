# vim: ft=sls

{#-
    Manages the nftables service configuration.
    Has a dependency on `nftables.package`_.
#}

include:
  - .file
