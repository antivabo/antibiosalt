erlang-repo:
  pkgrepo.managed:
    - name: deb https://packages.erlang-solutions.com/ubuntu {{ grains["oscodename"] }} contrib
    - humanname: {{ grains["oscodename"]|capitalize }} Erlang Package Repository
    - keyid: 434975BD900CCBE4F7EE1B1ED208507CA14F4FCA
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - file: /etc/apt/sources.list.d/erlang.list
    - refresh_db: True

erlang-install:
  pkg.latest:
    - name: erlang
    - cache_valid_time: 10080
    - require:
      - pkgrepo: erlang-repo

