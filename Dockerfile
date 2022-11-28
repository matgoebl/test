FROM docker.io/python:3.9-bullseye
COPY entry.sh /
CMD ["/entry.sh"]
