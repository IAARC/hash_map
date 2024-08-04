require_relative 'lib/hashmap'
require_relative 'lib/linkedlist'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

test.set('lion', 'milei')
test.set('hat', 'silver')
test.set('dog', 'golden')

test.set('moon', 'silver')

test.set('ice cream', 'brown')
test.set('apple', 'green')
test.set('jacket', 'red')

p test.entries
p test.length
p test.remove('lion')
p test.get('apple')
p test.has?('lion')
p test.has?('jacket')
p test.keys
p test.values
p test.clear
p test.entries
