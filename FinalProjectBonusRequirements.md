# Final Project Ideas

## Easy

* UI for setting custom rulesets - user configurable live / stay neighbor count
* support .rle patterns, commonly found in many life pattern repositories

## Medium

* Support Generations - a family of life-like rules where dead cells remain on the board for multiple generations
* Support general binary rules - where not just the neighbor count matters, but the relative position of each neighbor. (eg: a rule where a cell dies if it is surounded by two live cells directly to the left and right of itself)
* Support other, less life-like, 2d cellular automata, like Langdons Ant and WireWorld
* Advanced grid editing - box / lasso select, clipboard support, custom brushes for "painting" cell patterns


## Hard

* Implement HashLife. Instead of a size limited bounded 2d array, represent the board as an quadtree, expandable as needed. Using a quadtree, future generations of the grid can be precomputed and hashed, enabling extremely rapid simulation speeds. Using HashLife, large complex projects like the Meta Cell (a giant 10k x 10k pattern that simulates a game of life cell within game of life), turing machines, and universal constructors can be simulated easily.  
* use opengl / metal to construct a 3d view for the life grid

