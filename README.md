# Headline Analysis Project
---
######The purpose of this project is to employ a sentiment analysis engine in order to explore the sentiment rankings across different news headlines.
- For instance, is the sentiment ranking of news site A more positive than news site B over a certain time period?
- If you believe a news site has a certain bias, is that reflected in their sentiment rating?

---
### Gems
- [Wayback](https://github.com/XOlator/wayback_gem)
- [Alchemy](https://github.com/technekes/alchemy-api-rb)

###APIs
- [Alchemy](http://www.alchemyapi.com/)

---
###Wayback Scraper Script
- This is the script to search through the given URL to scrape headlines
- This script can be found in App/wayback_scrapper
- script_v1.rb drives the code for the script
- This script writes its results to a CSV file
- CSVs can be found in the /cnn_headlines & /fox_headlines directories


###Rake file
- Run scrape file to populate database from CSV
- Rake file also runs the article title through the Alchemy API to update the `sentiment_score` field 

---
####Database snapshots can be found in `db/dumps/*`
