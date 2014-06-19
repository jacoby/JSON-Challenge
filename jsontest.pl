#!/home/jacoby/lang/bin/perl

use feature qw{ say state } ;
# use strict ;
# use warnings ;

use Carp ;
use Data::Dumper ;
use JSON ;

my $file = 'purduepm_json_challenge_1.json' ;

# Solution to part 1 of the challenge: read, parse,
# and display in object form the contents of the JSON

if ( open my $fh, '<', $file ) {
    say 'RAW' ;
    my $json = join q{} , <$fh> ;
    close $fh or croak "Could not close file: $_" ;
    say $json ;
    my $obj = from_json( $json ) ;
    say Dumper $obj ;
    }
say q{} ;

if ( open my $fh, '<', $file ) {
    say 'COOKED' ;
    my $json = join undef , <$fh> ;
    close $fh or croak "Could not close file: $_" ;
    my $obj = decode_json( $json ) ;

    # null_value should be a json NULL or None value, not a string.
    $obj->{ null_value } = JSON::null ;

    # boolean_true should be a json true value, not false
    $obj->{ boolean_true } = JSON::true ;

    # boolean_false should be a json false value, not true
    $obj->{ boolean_false } = JSON::false ;

    # integer_number should be the integer representation of its current value, not the floating point representation (ie 3)
    $obj->{ integer_number } = int $obj->{ integer_number } ;

    # number_examples -> "not a number" should not even be in the dictionary, lets remove it.
    delete $obj->{ number_examples }{ "not a number" } ;

    # in "array", the string "value5" should read "value4" to match "key4"
    $obj->{ array }[ -1 ]{ key4 } = 'value4' ;

    # my $json2 = encode_json( $obj ) ;
    my $json2 = to_json( $obj , { ascii => 1 , pretty => 1 } ) ;
    say Dumper $obj ;
    say $json ;
    say $json2 ;
    }
say q{} ;


__DATA__

While I sort things out with my system, if you have a bit of extra time, can you write a program that will do the following:

1) Read and Parse the JSON file.

Read the json file into memory and parse it into data structures that best fit the programming language you are using. There are 6 data types you need to worry about:

Primitive Types:
* null
* booleans
* strings
* numbers

Structured Types:
* arrays
* objects

More information about the json file format can be found here:
http://json.org/

The file represents a dictionary, or hash table, or associative array.

There is probably a library available in your programming language, you can use to quickly read and parse the file. The json.org website has a list of some libraries for popular programming languages.

After parsing the file into your language's data structures, you should print the values stored in the data structures to stdout or another file to make sure you are reading the data properly. don't just print the file after reading it.


2) Fix the JSON file and write it back to disk.

Here is where it gets tricky. Even though the json file was syntactically correct, I made some mistakes in the data that is stored in it. Here is a summary of what I wanted for each key in the dictionary :

* null_value should be a json NULL or None value, not a string.
* boolean_true should be a json true value, not false
* boolean_false should be a json false value, not true
* integer_number should be the integer representation of its current value, not the floating point representation (ie 3)
* number_examples -> "not a number" should not even be in the dictionary, lets remove it.
* in "array", the string "value5" should read "value4" to match "key4"

Can you write a program to make these specific changes? Don't forget to comment your code. If you find an interesting way of addressing elements inside of the structure, please highlight that in your code. For example, how would you find the value for "key4" in the file? If there were multiple dictionary keys named "key4" in the file, how could you make sure you were addressing the correct one?

The data in the outputted file should look something like like this:

{
    "null_value": null,
    "boolean_true": true,
    "boolean_false": false,
    "string": "this is my string.",
    "integer_number": 3,
    "number_examples": {
        "positive integer": 9,
        "negative integer": -1,
        "float": 2.3,
        "positive_exponent": 4.35e+58,
        "negative_exponent": 4.3508e-93
    },
    "array": [true,null,["value3"],{"key4":"value4"}]
}


Note that the order of the keys (null_value, boolean_true, boolean_false, ...) does not matter since the pairs of a json object are unordered.


We'll discuss how to perform these actions in the different programming languages people chose to use in the next meeting on May 20, 2014.
