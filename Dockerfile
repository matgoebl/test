FROM docker.io/python:3.9-bullseye
RUN apt-get update && apt-get upgrade
RUN apt install curl jq traceroute mtr nmap strace dnsutils openssl redir
COPY entry.sh /
CMD ["/entry.sh"]
