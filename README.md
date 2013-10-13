# Headline Analysis Project
------
Project Page:<br>
http://headlines-and-data.herokuapp.com/

#####sen·ti·ment (noun)
1. A view of or attitude toward a situation or event; an opinion. A general feeling or opinion.
2. A feeling or emotion.

In this context sentiment was used to gauge how postive vs negative a headline was.

## Summary

#####This was a [Devbootcamp Chicago](http://www.devbootcamp.com) final team project. Our goal for the 8 day project was to attempt to analyze the sentiment of different news agencies' headlines over the course of time.

Interesting questions we were hoping to answer include:

* Are there any general sentimental trends for a news source's headlines over time?
* Is there any correlation between time of the year and sentiment?
* Is there any correlation between the current political environment and different news source's headline sentiments?
* Can we viusually detect the positive/negative current events over time?

Results:

Besides the un-surprising result that all news trends negative no scientific conclusions can be made from this first iteration of the project.

Reasons include:

* Despite collecting a ton of headlines there is still not sufficient data yet. (Wayback machine data collection really picks up only about mid 2011)
* No true statistical analysis was completed. (we only had 8 days, weren't data scientists, and chose interactivty over further analysis)
* Only one sentiment engine was used. Even with sufficient data more than one scoring engine would be needed to back any type of implications.


##How it works

#####The quick and dirty of how this worked:

1. Target a specific news site on the wayback machine.
2. Open up frontpage of news site and save up to 20 headlines for that day.
3. Repeat for every day available going back in time up to 5ish years. (about 20-30 thousand headlines per news site)
4. Feed each headline through AlchemyApi's sentiment analysis engine and save respective score. (score ranged from -1 (negative) to 1 (positive) ) 
5. Save headline, date, score, and respective news source to our database.
6. Plot data using D3.

You can find a slightly more detailed explanation [here](https://speakerdeck.com/luizneves77/sentimental-headlines)

## Stack:

* HTML/CSS
* RoR, Postgres/MemCache
* Javascript/Jquery

## Key tools:

* [Alchemy API](http://www.alchemyapi.com/) was cool enough to provide us with an API key worth 30,000 requests a day. Their engine and robust API allowed us to score each headline very quickly.
* [Wayback Machine](http://archive.org/web/) was our source of the actual news pages going back time.
* [Wayback Gem](https://github.com/XOlator/wayback_gem) turned out to be incredibly useful/important for our project. It allowed for a very easy collection of all the different urls needed for scraping. 
* [Nokogiri](https://github.com/sparklemotion/nokogiri) is a well known scraping gem that made grabbing what we needed from each page relatively simple.
* [D3](https://github.com/emilford/d3js-rails) is an impressive plotting tool that was a challenge to learn but is the backbone to our visualizations.

## Future Iterations

* The script is not bad for how simple/short it is but could be refined to collect better/more headlines
* More than one sentinment engine score would be cool/interesting
* Include a counter to track keywords within headlines. (This might be difficult but would be a very powerful analysis tool)
* More unique/interesting D3 visualizations.

Feel free to fork away!

------

##The Team:

#####[Luiz](https://github.com/Luiz-N)- Vision, script and visualizations
#####[Corey s](https://github.com/Cspeisman)- Script and visualizations
#####[Kelmer](https://github.com/kelmerp)- Database seeding, migrating and optimization (memcahce)
#####[Corey W](https://github.com/corywest)- Database seeding and front-end framework.

------
## Getting Started:

Clone the repository

Run `bundle install` if you do not have any of the gems used in this project.

Set up your database by using the `rake db:create`, and `rake db:migrate` commands

Visit the [Alchemy API](http://www.alchemyapi.com/) website and request an API key.

###Wayback Scraper Script

This script searches through the given URL to scrape headlines.
The script can be found in lib/wayback_scrapper.
script_v1.rb drives the code for the script.
The scraped headlines will be written to a local CSV file. (Be sure to create a folder for the source first)
CSVs can be found in the lib directory headlines directories

###Seed file

Run the seed file to populate the database from the CSV
Th file also runs the article title through the Alchemy API to update the `sentiment_score` field in the database
