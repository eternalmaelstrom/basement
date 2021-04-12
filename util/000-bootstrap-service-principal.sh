#!/bin/bash -xe
SUBSCRIPTION_ID=$1

az ad sp create-for-rbac --name "http://eternalmaelstrom-github-sp" --role Contributor --scopes "/subscriptions/${SUBSCRIPTION_ID}" --sdk-auth