# image de base (version stable)
FROM debian:stable
# mise a jour, installation de nginx & openssh
RUN apt-get update && apt-get install -y nginx openssh-server
# creer un utilisateur dans le groupe ssh
RUN useradd -ms /bin/bash -g ssh monuser
# changer mot de passe
RUN echo 'monuser:123456' | chpasswd
# Correction de la connexion SSH. Sinon, l'utilisateur est expulsé après la connexion
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
# Libérer de l'espace
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
# Exposer le port 22 et le port 80
EXPOSE 80 22
# commande a l'execution du container
CMD service ssh start && nginx -g 'daemon off;'