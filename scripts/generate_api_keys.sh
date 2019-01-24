#!/bin/bash

# ---- API key pair (will create files apikey.pem and apikey_public.pem)
# ---- see doc on https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm
openssl genrsa -out ../certs/apikey.pem 2048
chmod 600 ./apikey.pem
openssl rsa -pubout -in ../certs/apikey.pem -out ../certs/apikey_public.pem
