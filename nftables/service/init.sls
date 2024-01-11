# vim: ft=sls

{#-
    Starts the nftables service and enables it at boot time.
    Has a dependency on `nftables.config`_.
#}

include:
  - .running
