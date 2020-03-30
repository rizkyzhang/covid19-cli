#!/usr/bin/env bash 

VERSION="0.0.1"

BASE_API="https://corona.lmao.ninja/"
API_TOTAL_ENDPOINT="$BASE_API/all"

function get_data() {
  country=$1

  cases=$(curl -s $BASE_API/$country | jq ".cases")
  deaths=$(curl -s $BASE_API/$country | jq ".deaths")
  recovered=$(curl -s $BASE_API/$country | jq ".recovered")
}


