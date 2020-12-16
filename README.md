# Replication READ-ME for mortality paper

These code and data files replicate the results in "Mortality Change
Among Less Educated Americans" by Paul Novosad, Charlie Rafkin, and
Sam Asher.  A working paper version of the manuscript can be found
[here](http://www.dartmouth.edu/~novosad/nra-mortality.pdf).

To regenerate the tables and figures from the paper, take the
following steps:

1. Download and unzip the replication data package from [this Google
   Drive
   folder](https://drive.google.com/drive/folders/1tKP0NXx4y1XkFhQFkzoXrkPhtGyvF0e8?usp=sharing) 
   * To get as many files as possible in .dta form, plus necessary
   CSVs, use [this
   link](https://drive.google.com/file/d/1tQ9ECy4ZPs-Npr--TEgk036emCaABibF/view?usp=sharing). 
   * To get all the files in CSV format, use [this
     link](https://drive.google.com/file/d/1XehK4BB-1aVzLKbjwughYAKibkuv2hPU/view?usp=sharing).
   * Regardless of your choice from the two above options, use [this
     link](https://drive.google.com/file/d/1SnMpRPzq4iEV9LdW8XG9iK8e_LaBnKrw/view?usp=sharing)
     to download the raw National Health Interview Survey data
     (1997-2017), which can be used to re-build the clean NHIS dataset.
     The clean all-years dataset is also included in the two files above.

2. Clone this repo and switch to the code folder.

3. Open the do file make_mortality_repl.do, and set the globals "out",
   "repdata", "tmp", and "mcode.  
   * "out" is the target folder for all outputs, such as tables
   and graphs. 
   * "tmp" is the folder for the data files and
   temporary data files that will be created during the rebuild.
   * "repdata" is the folder where you unzipped and saved the
     replication data package.
   * "mcode" is the code folder of the clone of the replication repo

4. Run the do file make_mortality_repl.do.  This will run through all the
   other do files to regenerate all of the results.
   
We have included all the required programs to generate the main
   results. However, some of the estimation output commands (like
   estout) may fail if certain Stata packages are missing. These can
   be replaced by the estimation output commands preferred by the
   user.
   
Please note we use globals for pathnames, which will cause errors if
   filepaths have spaces in them. Please store code and data in paths
   that can be access without spaces in filenames.
   
The current code does not generate mortality bounds and changes from
scratch, as these results took ~48 hours to generate with Matlab on a
server with max memory of 429 GB. 

This code was tested using Stata 15.0. Run time to generate all
results on our server was about __ minutes.


