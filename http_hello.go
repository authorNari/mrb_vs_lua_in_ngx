package main

import (
    "io"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    io.WriteString(w, "Hello world!")
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":12340", nil)
}