// Prototype Pattern
// Used when cost of creation is large
// Copy an existing objects data with a minor change

package main

import(
	"fmt"
)

type Protoype interface {
	Clone(string) Protoype
}

type ConcretePrototype struct {
	Type string
}

func (c ConcretePrototype) Clone(t string) Protoype {
	c.Type = t
	return &c
}

func main() {
	client := Create()
	client2 := client.Clone(`hi`)
	fmt.Println(client)
	fmt.Println(client2)
}

func Create() Protoype {
	return &ConcretePrototype{}
}