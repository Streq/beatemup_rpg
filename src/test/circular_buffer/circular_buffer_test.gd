extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	test_push_front()
	test_push_back()


func test_push_front():
	print("test_push_front")
	var buffer = CircularBuffer.new(10)
	buffer.push_front(1)
	buffer.push_front(2)
	buffer.push_front(3)
	buffer.push_front(4)
	buffer.push_front(5)
	buffer.push_front(6)
	buffer.push_front(7)
	
	check([7,6,5,4,3,2,1], buffer.to_array())
	
	print("removing 3 elements from the front")
	buffer.pop_front()
	buffer.pop_front()
	buffer.pop_front()
	
	check([4,3,2,1], buffer.to_array())
	
	print("removing 2 elements from the back")
	buffer.pop_back()
	buffer.pop_back()
	
	check([4,3], buffer.to_array())

func check(expected, actual):
	print(actual)
	assert(actual == expected, str(actual) + " isn't expected value " + str(expected))
	


func test_push_back():
	print("test_push_back")
	var buffer = CircularBuffer.new(10)
	buffer.push_back(1)
	buffer.push_back(2)
	buffer.push_back(3)
	buffer.push_back(4)
	buffer.push_back(5)
	buffer.push_back(6)
	buffer.push_back(7)
	
	check([1,2,3,4,5,6,7], buffer.to_array())

	
	print("removing 3 elements from the front")
	buffer.pop_front()
	buffer.pop_front()
	buffer.pop_front()
	
	
	check([4,5,6,7], buffer.to_array())
	
	
	print("removing 2 elements from the back")
	buffer.pop_back()
	buffer.pop_back()
	
	check([4,5], buffer.to_array())

	print("emptying the thing")
	buffer.pop_back()
	buffer.pop_back()
	
	
	check([], buffer.to_array())
	
	print("filling the thing from the back")
	buffer.push_back(1)
	buffer.push_back(2)
	buffer.push_back(3)
	buffer.push_back(4)
	buffer.push_back(5)
	buffer.push_back(6)
	buffer.push_back(7)
	buffer.push_back(8)
	buffer.push_back(9)
	buffer.push_back(10)
	buffer.push_back(11)
	buffer.push_back(12)
	buffer.push_back(13)
	buffer.push_back(14)
	buffer.push_back(15)
	buffer.push_back(16)
	buffer.push_back(17)
	
	
	check([8,9,10,11,12,13,14,15,16,17], buffer.to_array())
	
	print("filling the thing from the front")
	buffer.push_front(1)
	buffer.push_front(2)
	buffer.push_front(3)
	buffer.push_front(4)
	buffer.push_front(5)
	buffer.push_front(6)
	buffer.push_front(7)
	buffer.push_front(8)
	buffer.push_front(9)
	buffer.push_front(10)
	buffer.push_front(11)
	buffer.push_front(12)
	buffer.push_front(13)
	buffer.push_front(14)
	buffer.push_front(15)
	buffer.push_front(16)
	buffer.push_front(17)
	

	check([17,16,15,14,13,12,11,10,9,8], buffer.to_array())
