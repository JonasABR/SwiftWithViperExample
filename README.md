This is an example of applying VIPER model in swift

### Article Searcher

This app is built upon nytimes api to search articles and see some usages of VIPER on swift 3.
I did not use viper struct model data and kept using api model because of the conformation to nscoding protocol , as i was using UserDefaults to store data.

## Third Party libs
I used cocoapods as dependency manager and the following libs
* Nuke - for downloading images,cache and usage on UIImageView
* Unbox - for json parsing and reflection

#Roadmap
* Change storage on UserDefaults to CoreData.
