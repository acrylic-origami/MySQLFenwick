# MySQLFenwick

## What

Trying desperately to get `O(lg^2 n)` cumulative sum search out of MySQL by shoving the entire binary search and Fenwick cumulative sum operation into a single query. 

## How

MySQL has a particular disdain for looping procedures, whose performance suffers dramatically with the overhead from separated `SELECT` statements, so trying to condense it into a single query is a natural path to attempt instead.

`conditional_advance` and `fenwick_one_query` both act on a table `` `entries` `` constructed as:

	CREATE TABLE entries (
	    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	    weight DECIMAL(9, 3),
	    fenwick DECIMAL(9, 3)
	) ENGINE=MEMORY;
	
with the `MEMORY` engine providing O(1) search time. `weight` is added as a convenience for the initial construction; in practice `fenwick` alone would store all of the data in the table. `build_fenwick` is provided to build the Fenwick tree from values stored in weight. Rows of `id` _must_ be consecutive and increasing.

Unfortunately, MySQL's hatred towards efficient procedures is matched only by its disregard for side-effect accumulator predictability. Theoretically, `conditional_advance` shouldn't be necessary as its own function, as all it does is fetches the `fenwick` value of the requested row, provided that the row index is not 0. However, after dozens of test queries, no way was found to integrate it into the original operation other than to place it in a separate function.

While still ~40% faster than using the equivalent procudure, this queries lags _far_ behind linear search, which executes in ~10% the time in the regime of 10^4 entries.