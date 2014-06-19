#!/usr/bin/Rscript
suppressPackageStartupMessages( require( "rjson"   , quietly=TRUE ) )

# READ JSON FROM FILE, TURN INTO OBJECT
print( "============================================================" )
print( "Read" )
json_obj <- fromJSON( file = 'purduepm_json_challenge_1.json', unexpected.escape = "escape" )
print( json_obj ) 

#MODIFY 
print( "============================================================" )
print( "Modify" )
json_obj$null_value <- NULL
json_obj$boolean_true <- TRUE
json_obj$boolean_false <- FALSE
json_obj$integer_number <- as.integer( json_obj$integer_number )
json_obj$number_examples$`not a number` <- NULL

for ( i in 1:4 ) {
    if ( "list" == typeof( json_obj$array[[i]] ) ) {
        for ( name in names( json_obj$array[[i]] ) ) {
            json_obj$array[[i]][[name]] = "value4"
            } 
        }
    } 
print( json_obj )

# CONVERT OBJECT TO JSON, WRITE TO FILE
print( "============================================================" )
print( "Write To File" )
json_str <- toJSON( json_obj ) 
print( json_str )
write( json_str , file="bar.json", append=FALSE )
