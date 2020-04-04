#!/usr/bin/env bash 

VERSION="0.1.0"

API="https://corona-stats.online"

function get_stats() {
  if [ "$1" == "world" ]; then
    stats=($(curl -s "${API}?format=json" | jq -r ".worldStats | .cases,.todayCases,.deaths,.todayDeaths,.recovered | @sh")) 
    return $stats
  fi
  
  if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ]; then
    country="$1%20$2%20$3"
  elif [ -n "$1" ] && [ -n "$2" ]; then
    country="$1%20$2"
  else
    country="$1"
  fi

  stats=($(curl -s "${API}/${country}?format=json" | jq -r ".data[] | .cases,.todayCases,.deaths,.todayDeaths,.recovered | @sh"))

  return $stats
}

function print_stats() {
  get_stats $@

  RED=$(tput setaf 1)
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)

  cases=${stats[0]}
  today_cases=${stats[1]}
  deaths=${stats[2]}
  today_deaths=${stats[3]}
  recovered=${stats[4]}

  echo "${YELLOW}Cases     = ${cases} +${today_cases}"
  echo "${RED}Deaths    = ${deaths} +${today_deaths}"
  echo "${GREEN}Recovered = ${recovered}"
}

print_stats $@

