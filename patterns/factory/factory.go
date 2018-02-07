// Factory Pattern
// A simple object is created by using a single method
// Give flexibility for creating objects
// objects are created all at once
// Most designs start with factory and evolve 
// to builder and/or abstract factory

package main

import(
	"fmt"
)

type Product interface {
	GetName() string
	GetColor() string
	GetState() string
	GetCity() string
}

type ConcreteProduct struct {
	Object Object
	Location Location
}

type Object struct {
	Name string
	Color string
}

type Location struct {
	City string
	State string
}

func Creator(name, color, city, state string) Product {
	return &ConcreteProduct{
		Object{
			Name: name,
			Color: color,
		},
		Location{
			City: city,
			State: state,
		},
	}
}

func ConcreteCreator(name, color, city, state string) ConcreteProduct {
	return ConcreteProduct{
		Object{
			Name: name,
			Color: color,
		},
		Location{
			City: city,
			State: state,
		},
	}
}

func (c *ConcreteProduct) GetName() string {
	return c.Object.Name
}

func (c *ConcreteProduct) GetColor() string {
	return c.Object.Color
}

func (c *ConcreteProduct) GetCity() string {
	return c.Location.City
}

func (c *ConcreteProduct) GetState() string {
	return c.Location.State
}

func main() {
	product1 := Creator(`ted`, `red`, `el paso`, `tx`)
	fmt.Println(product1.GetState())
}
