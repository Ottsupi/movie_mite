# movie_mite

A Movie browsing application in Flutter.

* Bloc
* Clean Architecture

General Guiding Principles

* First make it work, then make it pretty
* Make swapping or adding APIs easy

## Roadmap

* [x] Display list of movies

* [ ] Retrieve the list of movies from a `MovieListRepository` as a stream.
      Because it's cool. Also this will presumably make it easier to store in
      a cache.
* [ ] Display movie details and store favorite movies locally.
* [ ] Cache browsed movie lists
* [ ] Improve UI
* [ ] Add favorites tagging feature (plan to watch, liked, disliked, etc)

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
