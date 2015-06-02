defmodule ElixirAnalysis do
  @moduledoc """
  Module is used for housing the functions for testing and analysing code
  """
  
  # Defining costants for testing
  @key "+"
  def add, do: @key
  @key "-"
  def sub, do: @key
  @key "*"
  def mul, do: @key
  @key "/"
  def div, do: @key
  @key ","
  def com, do: @key
  @key "("
  def left_normal, do: @key
  @key "{"
  def left_currly, do: @key
  @key "["
  def left_square, do: @key
  @key ")"
  def right_normal, do: @key
  @key "}"
  def right_currly, do: @key
  @key "]"
  def right_square, do: @key

  @doc """
  Function looks for operators which do not have spaces around them
  """
  def check_operators(resource, n, key) do
    map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 0, :file => "file", :line => 0}
	  String.split(resource, "\n")
	  # Testing the file for operators
	  valid = String.split(resource, " " <> key <> " ")
	  invalid = String.split(resource, key)
	    if (length(invalid) > 1) do 
		  if (length(valid) > 1 and length(valid) == length(invalid)) do 
		    map = %{} 
		  else
			map = %{map | :name => "Spaces aroud operators",
						  :problem => "You must put spaces around operators, that is a good practice for code readability.",
						  :solution => "Add spaces before and after the operator +, -, *, / or comma and semicolon.",
						  :priority => 2,
						  :file => "File.name()",
						  :line => n}
		  end
		end
	%{}
  end

  # Looping the function for testing all the lines
  def loop_operators(resource, n, key) when n <= 1 do
	check_operators(resource, n, key)
  end

  def loop_operators(resource, n, key) do
	check_operators(resource, n, key)
	loop_operators(resource, n-1, key)
  end

  @doc """
  Function checks for spaces arount left parenthesis, and warns the user to remove them. 
  Cases when user shoud put spaces on the left side of the parenthesis is after if and case loops
  """
  def check_parenthesis_left(resource, n, key) do
    map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 2, :file => "file", :line => 0}
	String.split(resource, "\n")
	# Testing the file for operators
	valid = String.split(resource, key)
	valid_if = String.split(resource, "if " <> key)
	invalid_if = String.split(resource, "if " <> key <> " ")
	invalid_left = String.split(resource, " " <> key)
	invalid_right = String.split(resource, key <> " ")
	if (length(invalid_if) > 1) do
	  map = %{map | :name => "Spaces aroud parenhesis",
					:problem => "You should not put spaces around parenhesis, that is a good practice for code readability.",
					:solution => "Remove spaces before and after the parenhesis.",
					:priority => 2,
					:file => "File.name()",
					:line => n}
	else
	  if (length(valid_if) > 1) do
		map = %{}
	  else
		if (length(valid) > 1) do
		  if (length(invalid_left) > 1 or length(invalid_right) > 1) do
			map = %{map | :name => "Spaces aroud parenhesis",
						  :problem => "You should not put spaces around parenhesis, that is a good practice for code readability.",
						  :solution => "Remove spaces before and after the parenhesis.",
						  :priority => 2,
						  :file => "File.name()",
						  :line => n}
		  else
			map = %{}
			end
		  end
		end
	  end
	  %{}	
  end

  # Looping the function for testing all the lines
  def loop_parenthesis_left(resource, n, key) when n <= 1 do
    check_parenthesis_left(resource, n, key)
  end

  def loop_parenthesis_left(resource, n, key) do
    check_parenthesis_left(resource, n, key)
    loop_parenthesis_left(resource, n-1, key)
  end

  @doc """
  Function checks for spaces arount right parenthesis, and warns the user to remove them. 
  """
  def check_parenthesis_right(resource, n, key) do
    map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 2, :file => "file", :line => 0}
	String.split(resource, "\n")
	# Testing the file for operators
	valid = String.split(resource, key)
	invalid = String.split(resource, " " <> key)
	  if (length(valid) > 1) do
		if (length(invalid) > 1) do
		  map = %{}
		else
		  map = %{map | :name => "Spaces aroud parenhesis",
						:problem => "You should not put spaces around parenhesis, that is a good practice for code readability.",
						:solution => "Remove spaces before and after the parenhesis.",
						:priority => 2,
						:file => "File.name()",
						:line => n}
		end
	  end
	  %{}
  end

  # Looping the function for testing all the lines
  def loop_parenthesis_right(resource, n, key) when n <= 1 do
    check_parenthesis_right(resource, n, key)
  end

  def loop_parenthesis_right(resource, n, key) do
    check_parenthesis_right(resource, n, key)
    loop_parenthesis_right(resource, n-1, key)
  end

  @doc """
  Function is looking for improper use of do end block in if loops.
  It tells user to use do ... end instead of do:
  """
  def check_if_loop(resource, n) do
    map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 2, :file => "file", :line => 0}
	String.split(resource, "\n")
	# Testing the file for operators
	valid = String.split(resource, "do")
	invalid = String.split(resource, "do:")
	  if (length(valid) > 1) do
		if (length(invalid) > 1) do
		  map = %{map | :name => "Do block in if loop",
			            :problem => "You should always use do ... end block of code instead of do: .",
						:solution => "Replace your do: code with do, remove the colon, and add end below your block.",
						:priority => 2,
						:file => "File.name()",
						:line => n}	
		else
		  map = %{}
		end
	  end
  end

  # Looping the function for testing all the lines
  def loop_if(resource, n) when n <= 1 do
    check_if_loop(resource, n)
  end

  def loop_if(resource, n) do
    check_if_loop(resource, n)
    loop_if(resource, n-1)
  end

  @doc """
  Function looks for bad habits in naming boolean functions.
  User is encouraged to use question mark instead of is_ in their names.
  """
  def check_boolean_naming(resource, n) do
    map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 2, :file => "file", :line => 0}
	String.split(resource, "\n")
	# Testing the file for operators
	invalid = String.split(resource, "is_")
	  if (length(invalid) > 1) do
		map = %{map | :name => "Improper naming for boolean function",
			          :problem => "Using is_ in your boolean function names is not recommended. Use ? behind your name.",
					  :solution => "Remove is_ from your function's name and add question mark behind it.",
					  :priority => 2,
					  :file => "File.name()",
					  :line => n}
	  else
		map = %{}
	  end
  end

  # Looping the function for testing all the lines
  def loop_boolean_naming(resource, n) when n <= 1 do
    check_boolean_naming(resource, n)
  end

  def loop_boolean_naming(resource, n) do
    check_boolean_naming(resource, n)
    loop_boolean_naming(resource, n-1)
  end

  @doc """
  Function is checking if there are more then one modules per one file.
  """
  def check_modules(resource, n) do
    map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 2, :file => "file", :line => 0}
	String.split(resource, "\n")
	# Testing the file for operators
	value = String.split(resource, "module")
	  if (length(value) > 2) do
		map = %{map | :name => "More then one module per one file",
			          :problem => "It is highly discouraged to have more then one module per one file. Code readability and maintenance is not as good.",
					  :solution => "Create new file and place one module to that file.",
					  :priority => 2,
					  :file => "File.name()",
					  :line => n}
	  else
		map = %{}
	  end
  end

  # Looping the function for testing all the lines
  def loop_modules(resource, n) when n <= 1 do
    check_modules(resource, n)
  end

  def loop_modules(resource, n) do
    check_modules(resource, n)
    loop_modules(resource, n-1)
  end

  @doc """
  Function checks if the code is too long for one file
  """
  def check_project_length(resource, n) do
    map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 2, :file => "file", :line => 0}
	String.split(resource, "\n")
	# Testing the file for operators
	lines = String.split(resource, "\n")
	  if (length(lines) > 500) do
		map = %{map | :name => "File is too long",
			          :problem => "Your file has too many lines of code. For better readability make more files and place some code to other files.",
					  :solution => "Create new files and place some amount of your code to those files.",
					  :priority => 1,
					  :file => "File.name()",
					  :line => n}
	  else
		map = %{}
	  end
  end

  # Looping the function for testing all the lines
  def loop_project_length(resource, n) when n <= 1 do
    check_project_length(resource, n)
  end

  def loop_project_length(resource, n) do
    check_project_length(resource, n)
    loop_project_length(resource, n-1)
  end

  @doc """
  Function looks for bad formated tabs in string
  """
  def check_tabs(resource, n) do
    map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 2, :file => "file", :line => 0}
	  String.split(resource, "\n")
	  # Testing the file for tabs
	  	String.split(resource, "\n")
		search = String.split(resource, "    ")
		if (length(search) > 1) do
		    map = %{} 
		  else
			map = %{map | :name => "Bad formated tabs",
						  :problem => "You must put two spaces for tabs, that is a good practice for code readability.",
						  :solution => "Add two spaces for tabs insted of four spaces",
						  :priority => 1,
						  :file => "File.name()",
						  :line => n}
		end

  end

  # Looping the function for testing all the lines
  def loop_tabs(resource, n) when n <= 1 do
	check_tabs(resource, n)
  end

  def loop_tabs(resource, n) do
	check_tabs(resource, n)
	loop_tabs(resource, n-1)
  end

  @doc """
  Function looks for bad formated comments
  """
  def check_comments(resource, n) do
	map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 2, :file => "file", :line => 0}
	# Testing the file for comments
	valid = String.split(resource, "# ")
	invalid = String.split(resource, "#")
	if (length(invalid) > 1) do
	  if (length(valid) > 1 and length(valid) == length(invalid)) do
	    map = %{}
	  else
	    map = %{map | :name => "Bad formated comments",
					  :problem => "You must put one space after hash, that is a good practice for code readability.",
					  :solution => "Add one space after hash",
					  :priority => 1,
					  :file => "File.name()",
					  :line => n}
	  end
	end
	%{}
  end

  # Looping the function for testing all the lines
  def loop_comments(resource, n) when n <= 1 do
	check_comments(resource, n)
  end

  def loop_comments(resource, n) do
	check_comments(resource, n)
	loop_comments(resource, n-1)
  end

  @doc """
  Function looks for doc if there isn't one than it tells to user to add them
  """
  def check_for_documentation(resource, n) do
  	map = %{:name => "ok", :problem => "problem", :solution => "solution", :priority => 2, :file => "file", :line => 0}
	# Testing the file for comments
	key_module = String.split(resource, "@moduledoc")
	key_doc = String.split(resource, "@doc")
	if (length(key_module) > 1) do
	  map = %{}
	else
	  map = %{map | :name => "No doc and moduledoc comments",
				  :problem => "Your code don't have any doc and moduledoc comments",
				  :solution => "Add doc and module doc comments in your code for making it more readable",
				  :priority => 1,
				  :file => "File.name()",
				  :line => n}
	end
	if (length(key_doc) > 1) do
	  map = %{}
	else
	  map = %{map | :name => "No doc and moduledoc comments",
				  :problem => "Your code don't have any doc and moduledoc comments",
				  :solution => "Add doc and module doc comments in your code for making it more readable",
				  :priority => 1,
				  :file => "File.name()",
				  :line => n}
	end
  end

  # Looping the function for testing all the lines
  def loop_for_documentation(resource, n) when n <= 1 do
	check_for_documentation(resource, n)
  end

  def loop_for_documentation(resource, n) do
	check_for_documentation(resource, n)
	loop_for_documentation(resource, n-1)
  end

  def call_all_functions(resource) do
  	lines = String.split(resource, "\n")
  	size = length(lines)

  	# Calling all the functions
  	[loop_operators(resource, size, add),
  	loop_operators(resource, size, sub),
  	loop_operators(resource, size, mul),
  	loop_operators(resource, size, div),
  	loop_operators(resource, size, com),
  	loop_parenthesis_left(resource, size, left_normal),
  	loop_parenthesis_left(resource, size, left_currly),
  	loop_parenthesis_left(resource, size, left_square),
  	loop_parenthesis_right(resource, size, right_normal),
  	loop_parenthesis_right(resource, size, right_currly),
  	loop_parenthesis_right(resource, size, right_square),
  	loop_if(resource, size),
  	loop_boolean_naming(resource, size),
  	loop_modules(resource, size),
  	loop_project_length(resource, size),
  	loop_tabs(resource, size),
  	loop_comments(resource, size),
  	loop_for_documentation(resource, size)]
  end	

end 