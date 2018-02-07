// Abstract Factory Pattern
// Creating Object by using multiple factory method
// Creates operations for related objects 
// Each set objects orginate from a common base

package main

import(
	"fmt"
)

type Factory int

const (
  A Factory = iota
  B
)

type AbstractFactory interface {
	CreateProductA() AbstractProduct
	CreateProductB() AbstractProduct
}

type ConcreteProductA struct {
	Brand string
}
type ConcreteProductB struct {
	Brand string
}

type AbstractProduct interface {
	GetBrand() string
}

type ConcreteFactory1 struct {}

func (c *ConcreteFactory1) CreateProductA() AbstractProduct {
	return &ConcreteProductA{`1a`}
}

func (c *ConcreteFactory1) CreateProductB() AbstractProduct {
	return &ConcreteProductB{`1b`}
}

type ConcreteFactory2 struct {}

func (c *ConcreteFactory2) CreateProductA() AbstractProduct {
	return &ConcreteProductA{`2a`}
}

func (c *ConcreteFactory2) CreateProductB() AbstractProduct {
	return &ConcreteProductB{`2b`}
}

func (c *ConcreteProductA) GetBrand() string {
	return c.Brand
}

func (c *ConcreteProductB) GetBrand() string {
	return c.Brand
}

func main() {
	factories := []Factory{A, B}

	for _, v := range factories {
		factory1 := CreateFactory(v)
		product := factory1.CreateProductA()
		fmt.Println(product)
		product = factory1.CreateProductB()
		fmt.Println(product)
	}
}


func CreateFactory(f Factory) AbstractFactory {
	switch f {
	case A:
		return &ConcreteFactory1{}
	case B:
		return &ConcreteFactory2{}
	default:
		return nil
	}
}