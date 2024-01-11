# vim: ft=sls

{#-
    Removes the nftables package.
    Has a dependency on `nftables.config.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as nftables with context %}

include:
  - {{ sls_config_clean }}

nftables service overrides are removed:
  file.absent:
    - name: {{ salt["file.dirname"](nftables.lookup.service_override.format(service=nftables.lookup.service.name)) }}
    - require:
      - sls: {{ sls_config_clean }}

nftables is removed:
  pkg.removed:
    - name: {{ nftables.lookup.pkg.name }}
    - require:
      - nftables service overrides are removed

{%- if nftables.compat.disable_firewalld and "firewall-cmd" | which %}

Firewalld is enabled:
  service.running:
    - name: {{ nftables.lookup.firewalld.service }}
    - enable: true
    - require:
      - nftables is removed
{%- endif %}
