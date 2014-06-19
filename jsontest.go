package main

import (
  // "fmt"
  // "reflect"
  "os"
  "bufio"
  "log"
  "encoding/json"
  "io/ioutil"
  // "strings"
  // "io"
)

// ======================================================================
// readLines reads a whole file into memory
// and returns a slice of its lines.
func readLines(path string) ([]string, error) {
    file, err := os.Open(path)
    if err != nil {
        return nil, err
        }
    defer file.Close()
    var lines []string
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        lines = append(lines, scanner.Text())
        }
    return lines, scanner.Err()
    }

// ======================================================================
// pulled reading from file into a function
func getJSON( filename string )( source string ){
    lines, err := readLines(filename)
    if err != nil {
        log.Fatalf("readLines: %s", err)
        }
    for _, line := range lines {
        source += line 
        source += "\n"
        }
    return source
    }

// ======================================================================
// writing JSON to file
func putJSON( object interface{}, filename string ) {
    // fmt.Println( filename )
    b, err := json.Marshal( object )
    if err != nil {
        log.Fatalf("Marshal: %s", err)
        }
    // os.Stdout.Write( b )
    ioutil.WriteFile( filename , b , 0644 )
    }

// ======================================================================
func main() {
    // read from file 
    filename := "purduepm_json_challenge_1.json"
    source := getJSON( filename )

    var f interface{}
    err := json.Unmarshal( []byte( source ) , &f ) 
    if err != nil {
        log.Fatalf("Unmarshal: %s", err)
        }
    m := f.(map[string]interface{})

    // fmt.Println( "===================================" )
    // fmt.Println( reflect.TypeOf( f ) ) ;
    // fmt.Println( "===================================" )
    // fmt.Println( "Reading In File" )
    // fmt.Println( source )
    // fmt.Println( "" )
    // fmt.Println( "In Go object form" )
    // fmt.Println( m ) 
    // fmt.Println( "" )
    // fmt.Println( "===================================" )

    m[ "null_value" ] = nil
    m[ "boolean_true" ] = true
    m[ "boolean_false" ] = false
    m[ "integer_number" ] = 3
    delete(m["number_examples"].(map[string]interface{}), "not a number")
    m_array := m["array"].([]interface{})
    m_array[3].(map[string]interface{})["key4"] = "value4"

    // THIS is where I failed to reach into number_examples 
    // to remove "not a number"

    // THIS is where I failed to reach into array to get to
    // key4 and change value5 to value4

    // write to file
    putJSON( m , "go_output.json" )
    }
