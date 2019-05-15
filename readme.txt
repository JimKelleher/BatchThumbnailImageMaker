
re: the artists.json input files located in this app:

There are 2 aspects to these files: 1) their content (ie, what artists, images, etc) and
2) their format (JSON format, arrays, etc)

Since the actual data is pasted in at run time, these files are only located here to give
some historical context and guidance for future runs.  The JSON DB databae will be its
eventual home.

artists.json
------------

Takes its content from the react.js artist entry app which is where the most recent changes
were maintained.

It takes its format from the JSON DB artist database because that is where it will eventually
live and that is the format (standard) used by all JSON databases.

-------------------------------------------------------------------------------------------------

During my testing I learned that the process of saving resized images on the GoDaddy server
would terminate part way through.  I imagine that that is a space usage violation.  My solution
was to divide the file into 2 halves:

artistsA.json (obsoleted/deleted)
--------------

beginning through the letter M

artistsB.json (obsoleted/deleted)
--------------

the letter M (continued) through the end

Thus, 2 very long running batch sessions were needed to complete the process.

artist_fixes.json
------------------

Manually looked-up replacements to bad images.





