# Headline Analysis Project
------
## Description

#### The purpose of this project is to employ a sentiment analysis engine in order to explore the sentiment rankings across various headlines from multiple news sources.
<br>
For instance, is the sentiment ranking of news site A more positive than news site B over a certain time period?

If you believe a news site has a certain bias, is that reflected in their sentiment rating?
<br>
## Gems used in this application:

#### [Alchemy API](https://github.com/technekes/alchemy-api-rb)
#### [Wayback Machine](https://github.com/XOlator/wayback_gem)
#### [D3](https://github.com/emilford/d3js-rails)
#### [Nokogiri](https://github.com/sparklemotion/nokogiri)

------

## API's used in this application:

#### [Alchemy API](http://www.alchemyapi.com/)
#### The Alchemy API allows for 1000 calls a day. If you are working on a non-commericial project, contact them via email and you may be given a larger daily amount.

------

## Getting Started:

Clone the repository

Run `bundle install` if you do not have any of the gems used in this project.

Set up your database by using the `rake db:create`, and `rake db:migrate` commands

Visit the [Alchemy API](http://www.alchemyapi.com/) website and request an API key.

###Wayback Scraper Script

This script searches through the given URL to scrape headlines
The script can be found in lib/wayback_scrapper
script_v7.rb drives the code for the script
The scraped headlines will be written to a local CSV file
CSVs can be found in the lib directory headlines directories

###Rake file

Run the scrape file to populate the database from the CSV
The rake file also runs the article title through the Alchemy API to update the `sentiment_score` field in the database
