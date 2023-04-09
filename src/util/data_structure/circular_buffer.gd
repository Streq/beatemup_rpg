class_name CircularBuffer

var buffer : Array= []
var SIZE := 2

var front_index := 0
var end_index := 0

var size = 0

func _init(size: int):
	SIZE  = size
	initialize()

func _offset(index, value):
	return (index + (value%SIZE) + SIZE)%SIZE

func _offset_forward(index, positive_value):
	return (index + positive_value)%SIZE

func _decrement(index):
	return (index-1+SIZE)%SIZE 
func _increment(index):
	return (index+1)%SIZE 

func push_back(val):
	end_index = _increment(end_index)
	var deleted = null
	size += 1
	if end_index == front_index and size > 1:
		size = SIZE
		front_index = _increment(front_index)
		deleted = buffer[end_index]
	buffer[end_index] = val
	return deleted

func push_front(val):
	front_index = _decrement(front_index)
	var deleted = null
	size += 1
	if end_index == front_index and size > 1:
		size = SIZE
		end_index = _decrement(end_index)
		deleted = buffer[front_index]
	buffer[front_index] = val
	return deleted

func to_array() -> Array:
	var ret = []
	for i in size:
		ret.append(at(i))
	return ret

func pop_back():
	if size==0:
		printerr("tried to pop on empty circularbuffer")
		return
	size -= 1
	var deleted = buffer[end_index]
	buffer[end_index] = null
	end_index = _decrement(end_index)
	return deleted

func pop_front():
	if size==0:
		printerr("tried to pop on empty circularbuffer")
		return
	size -= 1
	var deleted = buffer[front_index]
	buffer[front_index] = null
	front_index = _increment(front_index)
	return deleted

const NOT_FOUND = -1

func at(index):
	var p_index = _logical_to_physical(index)
	return buffer[p_index] if p_index != NOT_FOUND else null

func set_at(index, value):
	var p_index = _logical_to_physical(index)
	if p_index != NOT_FOUND:
		buffer[p_index] = value
	
func _logical_to_physical(index):
	if index >= 0 and size > index:
		return (front_index + index)%SIZE
	elif index < 0 and size >= -index:
		return (end_index + index+1 + SIZE)%SIZE
	else:
		return -1
	

func clear():
	buffer.clear()
	initialize()

func resize(new_size: int):
	if front_index<=end_index:
		var offset = min(size,new_size)-1
		buffer = buffer.slice(front_index, front_index+offset)
	else:
#		012345
#		  e s
#		si llamo con resize a 3
		var offset1 = min(SIZE - front_index, new_size)-1
#		min(6-4, 3)-1 = 1
		var first_half = buffer.slice(front_index, front_index + offset1)
#		45
		var offset2 = min(end_index, new_size - offset1 - 2)
#		min(2,3-1) = 0
		var last_half = buffer.slice(0, offset2)
		buffer = first_half
		buffer.append_array(last_half)
	SIZE = new_size
	buffer.resize(SIZE)
	size = min(size, SIZE)
	front_index = 0
	end_index = size-1


func initialize():
	size = 0
	front_index = SIZE/2
	end_index = SIZE/2-1
	buffer.resize(SIZE)
