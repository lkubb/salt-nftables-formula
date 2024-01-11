# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_file = tplroot ~ ".config.file" %}
{%- from tplroot ~ "/map.jinja" import mapdata as nftables with context %}

include:
  - {{ sls_config_file }}

nftables is running:
  service.running:
    - name: {{ nftables.lookup.service.name }}
    - enable: true
    - reload: true
    - watch:
      - sls: {{ sls_config_file }}
