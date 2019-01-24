#!/bin/bash

# ---- SSH key pair (will create files sshkey and sshkey.pub)
rm -f ../certs/sshkey ../certs/sshkey.pub
ssh-keygen -t rsa -P "" -f ../certs/sshkey
