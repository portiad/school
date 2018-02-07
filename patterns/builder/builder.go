// Builder Pattern
// Constructing a complex object step by step
// Used to build objects that require steps to 
// create them

package main

import(
	"fmt"
)

type Director struct {
	Builder Builder
}

func (d *Director) Construct() *Product {
	d.Builder.BuildPart()
	return d.Builder.GetPart()
}

type Builder interface {
	BuildPart()
	SetName()
	SetPrice()
	GetPart() *Product
}

type Product struct {
	Name string
	Price int
}

type ConcreteBuilder1 struct {
	Product Product
}

func (c *ConcreteBuilder1) BuildPart() {
	c.SetName()
	c.SetPrice()
}

func (c *ConcreteBuilder1) SetName() {
	c.Product.Name = `1`
}

func (c *ConcreteBuilder1) SetPrice() {
	c.Product.Price = 5
}

func (c *ConcreteBuilder1) GetPart() *Product {
	return &c.Product
}

type ConcreteBuilder2 struct {
	Product Product
}


func (c *ConcreteBuilder2) BuildPart() {
	c.SetName()
	c.SetPrice()
}

func (c *ConcreteBuilder2) SetName() {
	c.Product.Name = `2`
}

func (c *ConcreteBuilder2) SetPrice() {
	c.Product.Price = 10
}

func (c *ConcreteBuilder2) GetPart() *Product {
	return &c.Product
}

func main() {
	director1 := &Director{CreateBuild1()}
	product1 := director1.Construct()
	director2 := &Director{CreateBuild2()}
	product2 := director2.Construct()
	fmt.Println(product1)
	fmt.Println(product2)
}

func CreateBuild1() Builder {
	return &ConcreteBuilder1{}
}

func CreateBuild2() Builder {
	return &ConcreteBuilder2{}
}