// Singleton Pattern
// Create only one instance of an object

package main

import(
	"fmt"
	"sync"
)

type singleton struct {
	Value int
}

var instance *singleton
var once sync.Once

func main() {
	t := Create(1)
	fmt.Println(t)
	t = Create(2)
	fmt.Println(t)
}

func Create(v int) *singleton {
	once.Do(func() {
		instance = &singleton{v}
	})
	return instance
}