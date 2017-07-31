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
