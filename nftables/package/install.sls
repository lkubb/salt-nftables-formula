# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as nftables with context %}
{%- from tplroot ~ "/libtofsstack.jinja" import files_switch with context %}

nftables is installed:
  pkg.installed:
    - name: {{ nftables.lookup.pkg.name }}

nftables service overrides are installed:
  file.managed:
    - name: {{ nftables.lookup.service_override.format(service=nftables.lookup.service.name) }}
    - source: {{ files_switch(
                    ["nftables.service.override", "nftables.service.override.j2"],
                    config=nftables,
                    lookup="nftables service overrides are installed",
                 )
              }}
    - mode: '0644'
    - user: root
    - group: {{ nftables.lookup.rootgroup }}
    - makedirs: true
    - template: jinja
    - require:
      - nftables is installed
    - context:
        nftables: {{ nftables | json }}

{%- if nftables.compat.disable_firewalld and "firewall-cmd" | which %}

Firewalld is disabled:
  service.dead:
    - name: {{ nftables.lookup.firewalld.service }}
    - enable: false
{%- endif %}
