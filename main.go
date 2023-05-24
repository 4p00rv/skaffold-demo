package main

import (
	"fmt"
	"log"
	"net/http"
)

func hello(res http.ResponseWriter, req *http.Request) {
	log.Println("Handling /hello")
	fmt.Fprintf(res, "hello\n")
}

func main() {
	port := ":8080"
	fmt.Printf("Listening on %s\n", port)
	http.HandleFunc("/hello", hello)
	http.ListenAndServe(port, nil)
}
