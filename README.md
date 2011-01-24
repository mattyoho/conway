## Conway
A simple [Game of Life](http://en.wikipedia.org/wiki/Conway's_Game_of_Life)
implementation with a priority focus on object design.

It's probably a bit leaky of object references and hasn't had any go at
optimizing the efficiency of the algorithm.

Conway comes with a very simple ASCII visualizer. It can be invoked as
below, where the size argument determines the dimensions of the cell grid:

    conway --size 25 --cells="10,2 9,3 8,3 9,4 10,4" --stats
    conway -s 30 -c 2,3:3,3:3,2:2,2:3,4

When playing with the code itself, there's a sanity check Rake task:

    rake glider

Please feel free to send feedback via the
[GitHub project](https://github.com/mattyoho/conway) or via email at
mby _AT_ mattyoho _DOT_ com.
