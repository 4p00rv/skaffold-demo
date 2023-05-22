package main

import (
	"fmt"
	"net/http"
)

func hello(res http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(res, "hello\n")
}

func main() {
	port := ":8080"
	fmt.Printf("Listening on %s\n", port)
	http.HandleFunc("/hello", hello)
	http.ListenAndServe(port, nil)
}
