package main

import (
	"log"
	"net/http"
	"os"

	"github.com/gorilla/handlers"
)

func main() {
	if len(os.Args) == 1 {
		log.Fatal("Pass port as first argument and directory as second argument")
	}

	if len(os.Args) > 3 {
		log.Fatal("Too many arguments")
	}

	port := os.Args[1]
	path := os.Args[2]

	log.Printf("Starting FileServer on port: %s for path: %s\n", port, path)

	fileServerHandler := http.FileServer(http.Dir(path))
	loggingDecoratorHandler := handlers.LoggingHandler(os.Stdout, fileServerHandler)
	result := http.ListenAndServe(":"+port, loggingDecoratorHandler)

	log.Fatal(result)
}
