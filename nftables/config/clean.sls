# vim: ft=sls

{#-
    Removes the configuration of the nftables service and has a
    dependency on `nftables.service.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_service_clean = tplroot ~ ".service.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as nftables with context %}

include:
  - {{ sls_service_clean }}

nftables configuration is absent:
  file.absent:
    - name: {{ nftables.lookup.config }}
    - require:
      - sls: {{ sls_service_clean }}
