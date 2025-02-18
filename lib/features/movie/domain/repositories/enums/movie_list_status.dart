/// The current status of the movie list stream.
///
/// * [initial] on startup or when the movie list is cleared
/// * [loading] a network request is ongoing or retrieving from cache
/// * [networkLoaded] data loaded from network
/// * [cacheLoaded] data loaded from cache
/// * [error] a problem occured
enum MovieListStatus { initial, loading, networkLoaded, cacheLoaded, error }
