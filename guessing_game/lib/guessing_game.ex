defmodule GuessingGame do
 def main do
   correct = 333

   guess = IO.gets("Guess a number: ") |> String.trim()

    IO.puts("You guessed #{guess} and the correct answer was #{correct}")

    if String.to_integer(guess) == correct do
      IO.puts("Wow, you got it right...")
    end
 end

 def test do
   nums = [1,2,3,4,5]
   sum_and_avg(nums)
 end

 def sum_and_avg(numbers) do
  sum = sum_list(numbers)

  avg = sum / length(numbers)

  {sum, avg}
 end

 # Enum.sum from scratch
 def sum_list([]) do
  0
 end

 def sum_list([head | tail]) do
   head + sum_list(tail)
 end
end
