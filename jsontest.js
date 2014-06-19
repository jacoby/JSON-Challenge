#!/usr/local/bin/node

fs = require( 'fs' ) ;

fs.readFile( 'purduepm_json_challenge_1.json' , 
    'utf8' , 
    function (err,data) {
        if ( err ) { return console.log(err) }
        console.log( "JSON as String" )
        console.log( data ) ;

        var json = JSON.parse( data ) ;
        console.log( "RAW" ) ;
        console.log( json ) ;

        console.log( "\nCOOKED" )

        // * null_value should be a json NULL or None value, not a string.
        json.null_value = null ;
        // * boolean_true should be a json true value, not false
        json.boolean_true = true ;
        // * boolean_false should be a json false value, not true
        json.boolean_false = false ;
        // * integer_number should be the integer representation of its current value, not the floating point representation (ie 3)
        json.integer_number = parseInt( json.integer_number ) ;
        // * number_examples -> "not a number" should not even be in the dictionary, lets remove it.
        delete json.number_examples['not a number'] ;

        // * in "array", the string "value5" should read "value4" to match "key4"
        json.array[3]["key4"] = "value4" ;
        console.log( json ) ;

        console.log( "\nStringified" ) ;
        console.log( JSON.stringify( json , null , "  " ) ) ;
    } ) ;

