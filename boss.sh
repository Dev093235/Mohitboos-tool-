#!/data/data/com.termux/files/usr/bin/bash

red='\033[1;31m'; green='\033[1;32m'; blue='\033[1;34m'; cyan='\033[1;36m'; yellow='\033[1;33m'; reset='\033[0m'

clear
echo -e "${red} ██████╗  ██████╗ ███████╗███████╗███████╗"
echo -e "${red} ██╔══██╗██╔═══██╗██╔════╝██╔════╝██╔════╝"
echo -e "${cyan} ██████╔╝██║   ██║███████╗█████╗  █████╗"
echo -e "${green} ██╔═══╝ ██║   ██║╚════██║██╔══╝  ██╔══╝"
echo -e "${yellow} ██║     ╚██████╔╝███████║███████╗███████╗"
echo -e "${yellow} ╚═╝      ╚═════╝ ╚══════╝╚══════╝╚══════╝"
echo -e "${cyan}     🔥 Mohit Boss Tool v3 Pro Max 🔥"
echo -e "${reset}     [⚡ 15-in-1 Hacker Toolkit ⚡]"
echo

echo -e "${blue}1.${reset} Website Audit (Speed + SEO + Headers)"
echo -e "${blue}2.${reset} Subdomain Scan (Amass)"
echo -e "${blue}3.${reset} Email Scraper"
echo -e "${blue}4.${reset} Phone Number Scraper"
echo -e "${blue}5.${reset} Link Extractor"
echo -e "${blue}6.${reset} Technology Detector (WhatWeb)"
echo -e "${blue}7.${reset} Port Scanner (Nmap)"
echo -e "${blue}8.${reset} Admin Panel Finder"
echo -e "${blue}9.${reset} Directory Bruteforcer"
echo -e "${blue}10.${reset} CMS Detector"
echo -e "${blue}11.${reset} Git Exposure Checker"
echo -e "${blue}12.${reset} Brute Force Login (Hydra)"
echo -e "${blue}13.${reset} Social Media Finder"
echo -e "${blue}14.${reset} robots.txt Viewer"
echo -e "${blue}15.${reset} Auto Report ZIP"
echo

read -p "🚀 Enter your choice (1-15): " choice
mkdir -p result

case $choice in

1)
  read -p "🔗 Enter website URL: " url
  curl -s -o /dev/null -w "DNS: %{time_namelookup}\nConnect: %{time_connect}\nTTFB: %{time_starttransfer}\nTotal: %{time_total}\n" -I "$url" > result/audit.txt
  curl -s -I "$url" | grep -i "content-security-policy" >> result/audit.txt
  echo "✅ Saved in result/audit.txt"
  ;;

2)
  read -p "🔗 Enter domain: " domain
  amass enum -d "$domain" > result/subdomains.txt
  echo "✅ Saved in result/subdomains.txt"
  ;;

3)
  read -p "🔗 Enter URL: " url
  curl -s "$url" | grep -Eo "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" > result/emails.txt
  echo "✅ Saved in result/emails.txt"
  ;;

4)
  read -p "🔗 Enter URL: " url
  curl -s "$url" | grep -Eo "[0-9]{10}" > result/phones.txt
  echo "✅ Saved in result/phones.txt"
  ;;

5)
  read -p "🔗 Enter URL: " url
  curl -s "$url" | grep -Eo '<a [^>]+>' | grep -Eo 'href="[^"]+"' | cut -d'"' -f2 > result/links.txt
  echo "✅ Saved in result/links.txt"
  ;;

6)
  read -p "🔗 Enter URL: " url
  whatweb "$url" > result/tech.txt
  echo "✅ Saved in result/tech.txt"
  ;;

7)
  read -p "🔎 Enter IP or domain: " target
  nmap "$target" -oN result/ports.txt
  echo "✅ Saved in result/ports.txt"
  ;;

8)
  read -p "🔗 Enter website URL: " url
  for path in admin login wp-admin wp-login.php adminpanel; do
    full="$url/$path"
    code=$(curl -s -o /dev/null -w "%{http_code}" "$full")
    echo "$full => $code" >> result/admin.txt
  done
  echo "✅ Saved in result/admin.txt"
  ;;

9)
  read -p "🔗 Enter website URL: " url
  for d in uploads assets config js css images backup old test; do
    full="$url/$d"
    code=$(curl -s -o /dev/null -w "%{http_code}" "$full")
    echo "$full => $code" >> result/dirs.txt
  done
  echo "✅ Saved in result/dirs.txt"
  ;;

10)
  read -p "🔗 Enter website URL: " url
  whatweb "$url" | grep -i cms > result/cms.txt
  echo "✅ Saved in result/cms.txt"
  ;;

11)
  read -p "🔗 Enter URL: " url
  curl -s -o /dev/null -w "%{http_code}" "$url/.git/config" > result/git.txt
  echo "✅ Saved in result/git.txt"
  ;;

12)
  echo "🔐 Brute Force (Hydra)"
  read -p "Target IP: " ip
  read -p "Service (eg. ssh, ftp): " srv
  read -p "Username: " user
  read -p "Wordlist path: " word
  hydra -l "$user" -P "$word" "$ip" "$srv" -o result/brute.txt
  echo "✅ Saved in result/brute.txt"
  ;;

13)
  read -p "👤 Enter username: " name
  echo "https://facebook.com/$name" > result/social.txt
  echo "https://instagram.com/$name" >> result/social.txt
  echo "https://twitter.com/$name" >> result/social.txt
  echo "https://linkedin.com/in/$name" >> result/social.txt
  echo "✅ Saved in result/social.txt"
  ;;

14)
  read -p "🔗 Enter URL: " url
  curl -s "$url/robots.txt" > result/robots.txt
  echo "✅ Saved in result/robots.txt"
  ;;

15)
  zip -r /sdcard/mohitboss_report.zip result
  echo "✅ Final ZIP saved in /sdcard/mohitboss_report.zip"
  ;;

*)
  echo "❌ Invalid choice."
  ;;
esac
