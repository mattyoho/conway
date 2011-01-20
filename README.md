## Conway
A simple Game of Life implementation with foremost focus on object design.

It's currently very much leaky of object references and has no mind for
efficiency.

Conway comes with a very simple ASCII visualizer. It can be invoked as
below, where the size argument determines the dimensions of the cell grid:

    conway --size 25 --cells="10,2 9,3 8,3 9,4 10,4"
    conway -s 30 -c 2,3:3,3:3,2:2,2:3,4

Please feel free to send feedback via the
[GitHub project](https://github.com/mattyoho/conway) or via email at
mby _AT_ mattyoho _DOT_ com.


