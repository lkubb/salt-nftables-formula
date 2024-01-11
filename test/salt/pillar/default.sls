# vim: ft=yaml
---
nftables:
  lookup:
    master: template-master
    # Just for testing purposes
    winner: lookup
    added_in_lookup: lookup_value
    pkg:
      name: nftables
    config: '/etc/nftables.conf'
    service:
      name: nftables
    config_d: /etc/nftables.d
    firewalld:
      service: firewalld
    nft_bin: /usr/sbin/nft
    service_override: /etc/systemd/system/{service}.service.d/salt.conf
    templates:
      mdns_allow: meta l4proto udp ip daddr 224.0.0.251 udp dport mdns accept
      mdns_allow_ip6: meta l4proto udp ip6 daddr ff02::fb udp dport mdns accept
      upnp_allow: meta l4proto udp ip daddr 239.255.255.250 udp dport 1900 accept
  compat:
    disable_firewalld: false
    flush: true
    reload_flush: true
  config:
    tables: {}
    vars: {}
  config_d:
    clean: true
    enable: true
    ignore:
      - osf
      - osf/pf.os

  tofs:
    # The files_switch key serves as a selector for alternative
    # directories under the formula files directory. See TOFS pattern
    # doc for more info.
    # Note: Any value not evaluated by `config.get` will be used literally.
    # This can be used to set custom paths, as many levels deep as required.
    files_switch:
      - any/path/can/be/used/here
      - id
      - roles
      - osfinger
      - os
      - os_family
    # All aspects of path/file resolution are customisable using the options below.
    # This is unnecessary in most cases; there are sensible defaults.
    # Default path: salt://< path_prefix >/< dirs.files >/< dirs.default >
    #         I.e.: salt://nftables/files/default
    # path_prefix: template_alt
    # dirs:
    #   files: files_alt
    #   default: default_alt
    # The entries under `source_files` are prepended to the default source files
    # given for the state
    # source_files:
    #   nftables-config-file-file-managed:
    #     - 'example_alt.tmpl'
    #     - 'example_alt.tmpl.jinja'

    # For testing purposes
    source_files:
      nftables-config-file-file-managed:
        - 'example.tmpl.jinja'

  # Just for testing purposes
  winner: pillar
  added_in_pillar: pillar_value
