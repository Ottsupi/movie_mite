# movie_mite

A Movie browsing application in Flutter.

* Bloc
* Clean Architecture

## How to run

1. Clone the repository
2. `flutter run`

The packages using code generation are `json_serializable` and `drift`.
All generated code are tracked by git. To generate,
`dart run build_runner build`

## Progress

* Days 1-3: fiddled with architecture around the api
* Day 4: Implemented local storage of favorite movies
* Day 5: Implemented search movies and removal of favorite movies
* Day 6: Implemented injecting favorite movies to network results.
  Presentation layer improvements

## Limitations

* Movie Details are not queried. Only the information from the api's movie
  list is used.
* Adding or removing favorites does not update the button
* Favorite movies list, refreshing is needed to get the updated list when
  removing favorites

## Developer Notes

* Architecture for movie list
  * Call `get___Movies()` then keep calling `getNextPage()` thereafter.
    Results and status are sent through a stream.
  * The gist is to expose enough information about the data layer so that
    the presentation layer can react to most events.
* Error handling. I use try/catch blocks on network or cache requests. Beyond
  data layer, I use `Either` from `fpdart`.
* Testing. I write tests for the data and domail layer as I implement it to
  monitor the data flow.
* Commits. All commits I make are self-contained and I do it often to make a
  "save point" of the last working version. Breaking changes are addressed in
  the next immediate commits.
* Choosing the local storage solution. As of Feb 2025:
  * Hive - Not maintained and documentation is down
  * Isar - Not maintained
  * Objectbox - Dependency issue with `objectbox_generator` not using null-safe
    dart
  * Drift - Seems promising so I decided to learn it

## Learnings

* Dart streams can only be listened to once. Make it a `broadcast()` to allow
  multiple listeners.
* Drift database
* Bloc `transform` for debouncing.

## Personal thoughts

* Unfortunately, I was not able to spend as much time on this as I hoped.
* Definitely spent too much time planning the data layer architecture, only
  to not use half of it.
* I wanted to do more things so I think I'll continue this project but with books.
