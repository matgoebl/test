FROM docker.io/python:3.9-slim-bullseye
#FROM docker.io/python:3.9-bullseye
RUN apt-get update && apt-get -y upgrade
RUN apt install -y curl jq traceroute mtr nmap strace dnsutils openssl redir
COPY entry.sh /
CMD ["/entry.sh"]
