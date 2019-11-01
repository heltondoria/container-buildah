FROM fedora:30
RUN echo "fastestmirror=true" >> /etc/dnf/dnf.conf
RUN echo -e "repo enable updates-testing\nupgrade\ninstall buildah podman\ntransaction run\n" > /tmp/transaction.txt
RUN dnf -y shell --setopt=install_weak_deps=False < /tmp/transaction.txt && \
  dnf install -y \
	buildah \
	podman \
	make && \
  dnf clean all
# Make buildah/podman happy with arbitrary UID/GID in OpenShift.
RUN chmod g=u /etc/passwd /etc/group
