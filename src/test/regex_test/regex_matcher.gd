extends Reference
class_name RegexMatcher

var include_regexs : PoolStringArray
var exclude_regexs : PoolStringArray

var regex = RegEx.new()


func _init(include_regexs:PoolStringArray, exclude_regexs:PoolStringArray) -> void:
	self.include_regexs = include_regexs
	self.exclude_regexs = exclude_regexs

func check(string_to_check:String) -> bool:
	for regex_str in exclude_regexs:
		if _check_regex(regex_str, string_to_check):
			return false

	for regex_str in include_regexs:
		if _check_regex(regex_str, string_to_check):
			return true

	return false

func _check_regex(regex_str:String,string:String)->bool:
	regex.compile(regex_str)
	var search = regex.search(string)
	if !search:
		return false
	var matches = search.strings
	return matches.has(string)
	
