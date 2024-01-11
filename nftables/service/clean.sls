# vim: ft=sls

{#-
    Stops the nftables service and disables it at boot time.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nftables with context %}

nftables is dead:
  service.dead:
    - name: {{ nftables.lookup.service.name }}
    - enable: false
