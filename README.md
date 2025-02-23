# movie_mite

A Movie browsing application in Flutter.

* Bloc
* Clean Architecture
* Functional Programming

General Guiding Principles

* First make it work, then make it pretty
* Make swapping or adding APIs easy

## Roadmap

* Days 1-3: fiddled with architecture around the api
* Day 4: Implemented local storage of favorite movies
* Day 5: Implemented search movies and add & remove favorite movies

## Developer Notes

* Architecture for movie list
  * Initially, I planned to have the repository send a stream of movies.
    I only have to call a `get___Movies()` method once and then keep calling
    `getNextPage()` to get further results. These results are then saved to the
    cache.  This approach makes sure that what is in the data layer reflects 1:1
    the data in the presentation layer.
  * The idea didn't hold up too well when I started writing the implementation.
    First, I am getting twenty results at once, not one at a time--I will need
    a method to deal with that. Second, a class variable in a repository
    didn't sit well with me. I needed to keep track of `currentEndpoint` and
    `pageNumber` in memory.
  * I revised the idea so that the methods will have a page number parameter.
    `BrowseMoviesBloc` will keep track of the current endpoint and current page.
    `MoviesListBloc` will keep track of the list of movies. Although this removes
    the parity between data and presentation layers, I'm making the bloc to
    handle state and the repository handle retrieving data, as it should be.
  * I was still iffy about sending a "stream of a list of movies" so I asked
    Gemini about it and was left convinced: You're fetching new, independent
    chunks of data (pages) and appending them to the existing list. Each page
    is a distinct unit of data.
* Barrel Files. I just let the IDE handle importing, but I do see the advantage
  to lessen merge conflicts in larger teams. I'll get around to it at the end.
* Error handling. I use try/catch blocks on network or cache requests. Beyond
  data layer, I use `Either` from `fpdart`.
* Architecture for fetching data
  * Initially, I thought that making a bunch of methods for `get___Movies()` is
    better than making a monster function handling everything. Further reading
    about TheMovieDB api revealed that those endpoints are only for
    convenience. Those are actually forms of `/discover` endpoint.
  * Learning that, I decided to bunch them up in a `getMoviesByCollection()`
    method.  
  * Also, I'm going to try placing `favorites` in there too. I think it would be
    super easy to implement a simple favorites feature that way. I'll just take
    it out when it comes time to extend it.
* Choosing the local storage solution was more arduous than expected. As of
  Feb 2025:
  * Hive - Not maintained and documentation is down
  * Isar - Not maintained
  * Objectbox - Dependency issue with `objectbox_generator` not using null-safe
    dart
  * Drift - Seems promising so I decided to learn it
* Another issue encountered though is that I can't make tests for Drift. I'm
  having problems with the local installation of sqlite. Tried to do integration
  tests instead but no dice. Did it blind and it worked first try so that speaks
  for its reliability and user experience.

## Learnings

* Dart streams can only be listened to once. Make it a `broadcast()` to allow
  multiple listeners.
* Freezed package for `copyWith()` generation.
