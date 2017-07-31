/host_build/run/:
  file.recurse:
    - source: salt://res/run/
    - clean: True
    - makedirs: True

binary-ready:
  file.exists:
    - name: /host_build/artifacts

create-app-container:
  docker_image.present:
    - name: antivabo/app
    - build: /host_build
    - dockerfile: run/Dockerfile
    - require:
      - binary-ready

run-app-container:
  docker_container.running:
    - image: antivabo/app
    - port_bindings:
      - 8080:8080

