docker-deps:
  pkg.installed:
    - pkgs:
      - apt-transport-https 
      - ca-certificates
      - curl
      - software-properties-common

docker-repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ grains["oscodename"] }} stable
    - humanname: {{ grains["oscodename"]|capitalize }} Docker Package Repository
    - keyid: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - file: /etc/apt/sources.list.d/docker.list
    - refresh_db: True

docker-install:
  pkg.latest:
    - name: docker-ce
    - cache_valid_time: 10080
    - require:
      - pkg: docker-deps
      - pkgrepo: docker-repo

get-pip:
  file.managed:
    - name: /tmp/get-pip.py
    - source: https://bootstrap.pypa.io/get-pip.py
    - skip_verify: True

pip-install:
  cmd.run:
    - name: python /tmp/get-pip.py
    - require:
      - get-pip
    - cwd: /tmp

dockerpy:
  pip.installed:
    - name: docker-py >=1.4.0
    - require:
      - cmd: pip-install
    - reload_modules: True
