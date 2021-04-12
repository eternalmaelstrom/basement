#!/bin/bash -xe
SUBSCRIPTION_ID=$1
RESOURCE_GROUP_NAME=$2
STORAGE_ACCOUNT_NAME=$3

az group create  -l westus -n "${RESOURCE_GROUP_NAME}"
az storage account create -n "${STORAGE_ACCOUNT_NAME}" -g "${RESOURCE_GROUP_NAME}" -l westus --sku Standard_LRS
az storage container create -n tfstate --account-name "${STORAGE_ACCOUNT_NAME}"