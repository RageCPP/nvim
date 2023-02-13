# Multithreaded Programming

## Two Reasons

- if you have a computational problem and you manage to separate it into small pieces that can be run in parallel independently from each other, you can expect a huge performance boost when running it on multiple processor units.
- you can modularize computations along orthogonal axes. For example, you can do long computations in a thread instead of blocking the UI thread, so the user interface remains responsive while a long computation occurs in the background.

## Three Problem 
### Tearing
two kinds of tearing: `torn read` and `torn write`
### Deadlocks
### False-Sharing


## Thread 
C++ threading library defined in `<thread>`.`std::thread` is a `variadic template`

