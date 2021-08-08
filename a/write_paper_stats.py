# write_paper_stats.py.  Reads a paper statistics file generated by store_constant(), and
#                        creates a cleanly formatted web page with the stats
import os, sys
import pandas as pd
import warnings
import datetime
from pathlib import Path
import csv
from collections import Counter
import pandas as pd

## INCLUDE data validation tools
################################
# Write validation test values #
################################

# function to process y/n user input
def write_validation_value(validation_datafile, timestamp, test_type, validation_value, group="", sample_size=""):
    """
    adds a single test result to a validation datafile, in order to compile dataset validation results.
    Outputs an appended dataset after checking column agreement.
     test_type - name for a particular validation test, e.g. "mi_cons" for missing consumption values. matched to validation metadata table
     group - subgroup for disaggregation of test result, e.g. states or urban/rural
     value - test value, e.g. .03 (for 3%)
     sample_size - total sample tested for this validation test

    Environment:
     Standard py3 conda env is fine for this.

    Args:
     validation_datafile (str): filepath for saving/appending validation data. Must be .csv format.
     timestamp (date): timestamp for this suite of tests
     test_type (str): name of this validation test (must match to validation metadata table)
     group (str): subgroup for comparison
     validation_value (int): output value of this validation test
     sample_size (int): relevant sample size this validation test was conducted on
    """

    # assert that datafile is a .csv extension
    if not Path(validation_datafile).suffix == ".csv":
        raise TypeError("Validation output file must be in CSV format")

    # check the validation file - assert needed columns are there; if file doesn't exist, write headers
    check_validation_file(validation_datafile)

    # convert standard Stata "$S_DATE S$TIME" format to datetime
    timestamp = datetime.datetime.strptime(timestamp, '%d %b %Y %H:%M:%S')

    # open file and append line to CSV with ordered column entries
    with open(validation_datafile, 'a', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['test_type', 'group', 'value', 'sample_size']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames,  lineterminator='\n')
        writer.writerow({'test_type':test_type, 'group':group, 'value':validation_value, 'sample_size':sample_size})
    
# basic check of validation datafile
def check_validation_file(datafile):
    '''
    function to check whether a validation output file exists. if so, check columns; if not, write new file header and save
    '''
    
    # if file does exist, check column names
    if os.path.isfile(datafile):

        # get columns into a list
        header = next(csv.reader(open(datafile)))

        # compare lists, order independent
        if not Counter(header) == Counter(["timestamp", "test_type", "group", "value", "sample_size"]):
            raise OSError(f"Data file does not have the correct columns: [timestamp, test_type, group, value, sample_size]   {datafile}")

    # if file doesn't exists, initialize empty CSV with column headers
    if not os.path.isfile(datafile):
        with open(datafile, 'w') as csvfile:
            headers = ['test_type', 'group', 'value', 'sample_size']
            writer = csv.DictWriter(csvfile, delimiter=',', lineterminator='\n',fieldnames=headers)
            writer.writeheader()         


######################################
# Convert validation results to HTML #
######################################

def write_validation_html(title, htmlfilename, datafile, metadatafile, num_recent=5, groups=True, tests_outer=True):
    '''
    take validiation test results and combine with validation metadata settings to create HTML output

    Args:
     title(str): header title for HTML output
     htmlfilename(str): filename for saving the output HTML data. Must be a filename / path to be appended to ~/public_html.
     datafile (str): location of validation test output file (CSV)
     metadatafile (str): location of validation output metadata - test descriptions, thresholds, etc
     num_recent (int): count of most recent tests to include. default 5

    TO FIX: need to handle cases without groups correctly (table header construction, etc)
    '''

    ##############################################
    # Validation of input tables and output file #
    ##############################################

    # assert that the output datafile exists
    if not os.path.isfile(datafile):
        raise OSError("Validation data output file not found")

    # read in datafile and strip whitespace from colnames
    valdata = pd.read_csv(datafile)
    valdata = valdata.rename(columns=lambda x: x.strip())
    
    # assert datafile is in the right format - column check
    # TO FIX: add flexibility for non-grouped tests
    if not Counter(list(valdata.columns)) == Counter(["timestamp", "test_type", "group", "value", "sample_size"]):
        raise OSError(f"Validation output file does not have the correct columns: [timestamp, test_type, group, value, sample_size]   {datafile}")        
    
    # read in metadatafile
    mdata = pd.read_csv(metadatafile)
    mdata = mdata.rename(columns=lambda x: x.strip())
    
    # assert metadatafile is in the right format - column check
    if not Counter(list(mdata.columns)) == Counter(["test_type", "test_description", "warning_level", "error_level", "format"]):
        raise OSError(f"Metadata file does not have the correct columns: [test_type, test_description, warning_level, error_level, format]   {metadatafile}")        
    
    # assert that we have a metadata entry for every test type in the output data
    if not all(elem in list(mdata.test_type.values) for elem in list(valdata.test_type.unique())):
        raise AssertionError(f"Not all validation test types in validation output ({datafile}) are classified in the metadata ({metadatafile})")
    
    # construct htmlfile location py joining public_html folder with html filename
    htmlfilepath = Path(htmlfilename)
    if not htmlfilepath.suffix == ".html":
        raise TypeError("HTML output file have .html file extension")

    # open htmlfile for writing, with error handling
    try:
        with open(os.path.expanduser(htmlfilepath), 'w') as f:
            pass
    except IOError:
        print(f"could not write HTML output at {htmlfilepath}")

    # initialize the html file
    htmlout = open(os.path.expanduser(htmlfilepath),"w")

    #############################
    # Preamble for writing HTML #
    #############################
        
    # get all the groupings into a list
    groups = list(valdata.group.unique())

    # get all the tests into a list
    tests = list(valdata.test_type.unique())

    # get levelsof timestamps into a list
    timestamps = list(valdata.timestamp.unique())

    # check timestamp limits (default five). reduce list of timestamps to N most recent (default 5)
    timestamps.sort(reverse=True)
    if len(timestamps) > num_recent:
        timestamps = timestamps[0:num_recent]

    # define whether we need to group the table by just tests, or tests by groups
    # FIX THIS LATER
    if groups:
        num_groups = 2
    else:
        num_groups = 2

    # table width = timestamp columns plus group columns
    num_timestamps = len(timestamps)
    twidth = num_groups + num_timestamps

    ################################
    # Write body and table headers #
    ################################

    # write document header. NOTE! we host our stylesheets on the DDL
    # website; modify in
    # ~/ddl/ddl-web/main/static/main/assets/other/test_styles.css
    htmlout.write('''
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="https://shrug-assets-ddl.s3.amazonaws.com/static/main/assets/other/test_styles.css" />
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.js"></script>    
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/rowgroup/1.1.2/js/dataTables.rowGroup.min.js"></script>    
    <script>
    $(document).ready(function() {
    $('#valTable').DataTable();
    } );    
    </script>
    ''')
    
    # finish the head and start body and table header setup
    htmlout.write(f'''
    </head>
    <body>
    <h1>{title}</h1>
    <div id="output">
    <table id="valTable" class="row-border order-column">
    <thead>
    <tr>
    ''')

    # order matters
    if tests_outer:
        outertxt = 'Test Type'
        innertxt = 'Group'
        outers = tests
        inners = groups
    else:
        outertxt = 'Group'
        innertxt = 'Test Type'
        outers = groups
        inners = tests

    # write the table headers for the outer and inner cols and finish top header row
    htmlout.write(f'''
    <th rowspan="2" class="italic">{outertxt}</th>
    <th rowspan="2" class="italic">{innertxt}</th>
    <th class="italic" colspan="{num_timestamps}">Timestamp</th>
    </tr>
    <tr>
    ''')

    # write timestamps as table headers in a subrow
    for timestamp in timestamps:
        htmlout.write(f'''
        <th class="italic">{timestamp}</th>
        ''')

    # close the table headers and start the body
    htmlout.write(f'''
    </tr>
    </thead>
    <tbody>
    ''')

    #######################################
    # Write validation data to table body #
    #######################################
    
    # loop over first grouping (group or test) for writing validation
    # data rows. row data will be filtered and ordered using the
    # datatables jquery plugin
    for outer in outers:

        # loop over inners
        for inner in inners:
            
            # call function to write data row
            write_group_data(tests_outer=tests_outer, outer=outer, inner=inner, timestamps=timestamps, metadata=mdata, valdata=valdata, htmlfile=htmlout)
        
    # finish by closing off the table body and writing footer HTML
    htmlout.write('''
    </tbody>
    </table>
    </div>
    </body>
    </html>
    ''')
    
    # close html file
    htmlout.close()

    # pull username for printing public_html file location
    USER = os.environ.get('USER')
    
    # print clickable htmlfile rcweb link to screen
    print(f"HTML output is viewable at: {htmlfilename}")
    print(f"This might be findable at https://caligari.dartmouth.edu/~pnovosad/test/{os.path.basename(htmlfilename)}")
    

##################################
# Write a data table row to HTML #
##################################

# write a table row with data in it to the HTML output
def write_group_data(outer, inner, timestamps, htmlfile, metadata, valdata, tests_outer=True):
    
    # assert that there's only a single entry for this test type in
    # the metadata. this is put inside loop in case tests are the inner
    # grouping.
    if not len(metadata[metadata["test_type"] == outer]) == 1:
        raise ValueError(f"Metadata table has multiple entries for test_type = {outer} \nMETADATA: \n{metadata}")

    # initialize output HTML for this group
    group_html = ''
                
    # get string expressions for how to evaluate this test from the metadata
    warnx = metadata[metadata["test_type"] == outer].warning_level.values[0]
    errorx = metadata[metadata["test_type"] == outer].error_level.values[0]
                
    # pull the test expressions into an HTML tooltip
    tooltip = f'''<div class="tooltip">&#9432; <span class="tooltiptext">Warning: {warnx} \nError: {errorx}</span></div>'''

    # assign the tooltip to outer / inner location according to fun argument
    if tests_outer:
        outer_tooltip = tooltip
        inner_tooltip = ''
    else:
        inner_tooltip = tooltip
        outer_tooltip = ''
    
    # initalize the row HTML with the outer
    # group.we'll only write html if there is a flagged test. 
    group_html = f'''<tr><td>{outer}{outer_tooltip}</td>'''

    # check this test across all timestamps to see if there is any value above the warning threshold.
    flagged = check_warnings(valdata=valdata, mdata=metadata, timestamps=timestamps, group=inner, test_type=outer)
    
    # if so, write the data in the table row for this group-test
    if flagged:

        # now write the inner level table cell
        group_html = group_html + f'<td>{inner}{inner_tooltip}</td>'
        
        # now write all the data cells for all timestamps. loop over timestamps
        for timestamp in timestamps:

            # pull the row for this timestamp from the validation output dataset
            # TO FIX - INNER AND OUTER DYNAMICALLY - CHANGE COL NAMES IN DATAFRAME
            datarow = valdata[(valdata["group"] == inner) & (valdata["test_type"] == outer) & (valdata["timestamp"] == timestamp)]
            val = datarow.value.values[0]

            # check if this value crosses warning or error levels
            warn_result = True
            error_result = True

            # pull warning/error class into html snippet
            if warn_result and not error_result:
                cellclass = 'class="warning"'
            elif error_result:
                cellclass = 'class="error"'
            else:
                cellclass = ''

            # pull sample size out of the data row
            samplesize = ''
            if len(datarow.sample_size.values) > 0:
                samplesize = datarow.sample_size.values[0]

            # pull format from metadata table
            val_fmt = val

            # format the value string correctly
            # val_fmt = format_value(value=val, format=fmt)

            # check if we have a valid sample size for this test
            if samplesize != '' and not pd.isnull(samplesize):
                samplesize = round(str_to_numeric(samplesize), 0)
                sampletd = f'\n<i>N={samplesize}</i>'
            else:
                sampletd = ''

            # append the value (plus italicized sample size) to the row
            group_html = group_html + f'<td {cellclass}>{val_fmt}{sampletd}</td>'
    
        # write this row
        htmlfile.write(group_html)
        
        

##########################
# Small helper functions #
##########################
            
# check whether we hit any warning thresholds for this test/group across all timestamps
def check_warnings(valdata, mdata, timestamps, group, test_type):
    flag = False
    error_type = ''
    result = False
    for timestamp in timestamps:
        datarow = valdata[(valdata["group"] == group) & (valdata["test_type"] == test_type) & (valdata["timestamp"] == timestamp)]
#        print(f'test_type, group, timestamp: {test_type}, {group}, {timestamp}')
        if len(datarow.value) > 0:
            val = datarow.value.values[0]
            warnx = mdata[mdata["test_type"] == test_type].warning_level.values[0]
            errorx = mdata[mdata["test_type"] == test_type].error_level.values[0]
#            print(f"val, warn, error: {val}, {warnx}, {errorx}")
            result = True
        if result:
            flag = True
    return flag

# evaluate test expressions dynamically
def test_threshold(teststring, invalue):

    # replace input string, e.g. "x < .01", with the correct value
    expr = str(teststring).replace('x', str(invalue))
    
    # check the value against the threshold
    rval = eval(expr)

    # assert evaluated expression is either True or False
    if not type(rval) == bool:
        raise OSError(f"Test of {teststring} on value {invalue} does not yield True or False")

    # otherwise return True or False
    return rval

# basic numeric formatting function
def format_value(value, format):
        
    # format options as they stand are percentage, numeric, bool, and string.
    if format.lower() not in ['bool', 'boolean', '%', 'percent', 'percentage', 'number', 'numeric', 'string', 'count']:
        raise ValueError(f"'{format}' is an invalid test format type: must be percentage, numeric, bool, or string")

    # initialize return value
    val_clean = ''

    # check boolean first
    if format.lower() in ['bool', 'boolean']:
        if value.lower() in ['true', '1', 't', 'y']:
            val_clean = "True"
        elif value.lower() in ['false', '0', 'f', 'n']:
            val_clean = "False"
        return val_clean

    # percentage
    if any(x in format.lower() for x in ['%', 'percent', 'percentage']):

        # assert numeric
        value = str_to_numeric(value)
        
        # now format the percentage
        val_clean = f"{round(value * 100, 4)}%"
        return val_clean

    # counts
    if any(x in format.lower() for x in ['count', 'ct']):
    
        # assert numeric, round, and return
        value = round(str_to_numeric(value), 0)
        return value

    # leave string and numeric as-is (no error handling for now) and return
    return val_clean


# helper function for numericizing strings
def str_to_numeric(value):
    
        # assert numeric format
        try:
            return int(value)
        except ValueError:
            try:
                return float(value)
            except ValueError:
                raise ValueError(f'value ({value}) is not a string of a number')

###################
# MAIN            #
###################
            
# set the CSV input file
input_path = os.path.expanduser('~/iec/output/mort_new/mort_paper_stats.csv')
tmp_stat_path = os.path.expanduser('~/iec/output/pn/mort_stats.csv')
tmp_meta_path = os.path.expanduser('~/iec/output/pn/mort_metadata.csv')

# set the HTML output file
output_path = os.path.expanduser('~/public_html/test/mort_paper_stats.html')

# transform the CSV file into a format used by the data validation table
df = pd.read_csv(input_path, header=None)
df.columns = ['test_type', 'group', 'value']
df["timestamp"] = pd.Timestamp.now()
df["sample_size"] = None

# write the stats data to the temporary stats file
df.to_csv(tmp_stat_path, index=False)

################################
# CREATE A METADATA DATAFRAME

# create a new dataframe from the unique list of test types
mf = pd.DataFrame(df.test_type.unique())
mf.columns = ['test_type']

# specify some dummy data
mf['test_description'] = ''
mf['warning_level'] = 0
mf['error_level'] = 0
mf['format'] = 'number'

# write the metadata to a file
mf.to_csv(tmp_meta_path, index=False)

# produce the table
write_validation_html(title="Mortality Stats", htmlfilename=output_path, datafile=tmp_stat_path, metadatafile=tmp_meta_path)


# old paper stats table
# # read it into a dataset
# df = pd.read_csv(input_path, header=None)
# df.columns = ['desc', 'category', 'value']
# 
# # sort by category, retaining the index
# df.index.name = 'index'
# df = df.sort_values(['category', 'index'])
# 
# # get the list of categories
# categories = df['category'].unique()
# 
# # open the output file for writing
# with open(output_path, 'w') as f:
# 
#     # write a table header
#     f.write('<table padding=10>\n')
#         
#     # loop over the categories
#     for cat in categories:
# 
#         # write the category header
#         f.write(f'<tr><td colspan=2><h2>{cat}</h2></td></tr>\n')
# 
#         # get a dataframe with rows matching this category
#         df_cat = df[df.category == cat]
# 
#         # loop over rows in this dataframe
#         for index, row in df_cat.iterrows():
# 
#             # write a table row with this content
#             f.write(f'  <tr>\n    <td>{row.desc}</td>\n    <td>{round(row.value, 6)}</td>\n  </tr>\n')
# 
#         # write a blank row
#         f.write('<tr><td>&nbsp;</td></tr>\n')
# 
#     # close the table
#     f.write('</table>\n\n')
# 
# # print out a path to the file
# print(f'Created {output_path}.')


