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

remove_old_container:
  docker_image.absent:
    - names:
      - antivabo/build
    - force: True

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

prepare-app-container:
  file.recurse:
    - name: /host_build/run/
    - source: salt://res/run/
    - clean: True
    - makedirs: True

artifacts-ready:
  file.exists:
    - name: /host_build/artifacts
    - require:
      - run-build-container

create-app-container:
  docker_image.present:
    - name: antivabo/app
    - build: /host_build
    - dockerfile: run/Dockerfile
    - require:
      - artifacts-ready
      - prepare-app-container

push-image-antivabo-app:
  cmd.run:
    - name: docker push antivabo/app

