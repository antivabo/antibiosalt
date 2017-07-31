pull-image-antivabo-app:
  cmd.run:
    - name: docker pull antivabo/app

run-app-container:
  docker_container.running:
    - image: antivabo/app
    - port_bindings:
      - 8080:8080
