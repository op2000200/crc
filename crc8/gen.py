import random

def generate_128bit_numbers(num_numbers):
  """Generates num_numbers 128-bit binary numbers as strings."""
  numbers = []
  for _ in range(num_numbers):
    number = ''.join(random.choice(['0', '1']) for _ in range(32))
    numbers.append(f"32'b{number}")
  return numbers

# Generate 99 numbers
numbers = generate_128bit_numbers(10)

# Print the numbers (You'll likely want to write these to a file for your Verilog code)
for i, number in enumerate(numbers):
  print(f"input_data[{i}] = {number};")

