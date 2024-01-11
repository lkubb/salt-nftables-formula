# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_package_install = tplroot ~ ".package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as nftables with context %}
{%- from tplroot ~ "/libtofsstack.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

{%- if nftables.config_d.enable %}

nftables confdir is managed:
  file.recurse:
    - name: {{ nftables.lookup.config_d }}
    - source: {{ files_switch(
                    ["nftables.d"],
                    config=nftables,
                    lookup="nftables confdir is managed",
                 )
              }}
    - file_mode: '0600'
    - dir_mode: '0700'
    - user: root
    - group: {{ nftables.lookup.rootgroup }}
    - makedirs: true
    - template: jinja
    - clean: {{ nftables.config_d.clean }}
    - exclude_pat:
      - '.gitkeep'
{%-   for ignore in nftables.config_d.ignore %}
      - {{ ignore | json }}
{%-   endfor %}
    - include_empty: true
    - require:
      - sls: {{ sls_package_install }}
    - context:
        nftables: {{ nftables | json }}
    - require_in:
      - file: {{ nftables.lookup.config }}
{%- endif %}

nftables configuration is managed:
  file.managed:
    - name: {{ nftables.lookup.config }}
    - source: {{ files_switch(
                    ["nftables.conf", "nftables.conf.j2"],
                    config=nftables,
                    lookup="nftables configuration is managed",
                 )
              }}
    - mode: '0600'
    - user: root
    - group: {{ nftables.lookup.rootgroup }}
    - makedirs: true
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        nftables: {{ nftables | json }}
