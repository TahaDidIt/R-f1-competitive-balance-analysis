# F1 competitive balance analysis in R
This is a for-refernce backup of code I wrote in R, to quantify and visualise points-dominance and constructors standings variation in Formula 1.

The R scripts query and manipulate datasets to calculate points scored at races, perform some statistics, and generate visualisations of this which can be found in the 'output' folder. It accounts for sprint races and the old points system too.

### Data
I got my data from the fantastic [Ergast API](https://ergast.com/mrd/) (now deprecated and moving to [Jolpica-f1](https://github.com/jolpica/jolpica-f1)). Only the datasets relevant to the analysis are included, and can be found in the 'data used' folder along with some custom queried/modified ("MOD") datasets.

I've also included an unused dataset about average position change during the race. Although not relevant, this is data that I custom scraped from [Motorsport Total](https://www.motorsport-total.com), another fantastic site with an eye-watering variety of interesting data and statistics. I've included this because the dataset could be the focus of an interesting project another day; but the site is in German, doesn't seem to have a way to directly download data, and this was so long ago that I've likely forgotten how to work the scraper (I used BardeenAI). Therefore I've included it here out of fear of not having the mental sanity to reproduce it later.
