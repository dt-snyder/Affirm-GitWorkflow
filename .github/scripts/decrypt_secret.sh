#!/bin/sh

# Decrypt the file
mkdir $HOME/secrets
gpg --version
# --batch to prevent interactive command
# --yes to assume "yes" for questions
gpg --quiet --batch --yes --decrypt --passphrase "$SFDX_JWT_PASS" \
--output $HOME/secrets/server.key server.key.gpg