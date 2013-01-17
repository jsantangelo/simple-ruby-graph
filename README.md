simple-ruby-graph
=================

simple-ruby-graph is a (hopefully) simple implementation of the [graph](http://en.wikipedia.org/wiki/Graph_(mathematics)). It has support for edge weight, and bi-direction.

Additionally, simple-ruby-graph provides a callback registrar. The graph will automatically
register all vertices/nodes and edges with the callback registrar (if defined), and each
vertex/node/edge will be called back on each passing of one time unit (or `tick`).

This registrar was created originally for the purpose simulation, where in the graph would
simulate some real-world construct, and the callback registrar would simulate the passing of
time.

How To Use
----------

To exercise (and demonstrate) all of the features simple-ruby-graph has, simply type:

	./Test.rb

from the main source directory. Alternatively, you can specify `ruby` as the executor:

	ruby Test.rb

