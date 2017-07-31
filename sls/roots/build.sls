/host_build/build:
  file.recurse:
    - source: salt://res/build/
    - clean: True
    - makedirs: True

/host_build/artifacts:
  file.recurse:
    - source: salt://res/artifacts/
    - clean: True
    - makedirs: True

/host_build/build/erlang_build.sh:
  file.managed:
    - source: salt://res/build/erlang_build.sh
    - mode: 755 

create-build-container:
  docker_image.present:
    - name: antivabo/build
    - build: /host_build/build/
    - watch:
      - file: /host_build/build
      - file: /host_build/build/erlang_build.sh

run-build-container:
  docker_container.running:
    - image: antivabo/build
    - auto_remove: True
    - interactive: True 
    - binds: /host_build/artifacts:/artifacts
