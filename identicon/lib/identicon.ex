defmodule Identicon do
  def main(input) do
    input |> hash_input |> pick_color |> build_grid |> filter_odd_squares |> build_pixel_map |> draw_image |> save_image(input)
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input) |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [red, green, blue | _tail]} = image) do
    %Identicon.Image{image | color: {red, green, blue}}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    ## Pipe passes return value before pipe as first arg in function after pipe
    grid = hex
    |> Enum.chunk_every(3)
    |> Enum.filter(fn x -> length(x) == 3 end)
    |> Enum.map(&mirror_row/1)
    |> List.flatten
    |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) when length(row) >= 3 do
    [first, second | _tail] = row

    ## ++ to append lists
    row ++ [second, first]
  end

  ## mirror_row def for any call where length(row) != 3
  def mirror_row(row) do
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    filtered_grid = Enum.filter(grid, fn ({val, _index}) -> rem(val, 2) == 0 end)

    %Identicon.Image{image | grid: filtered_grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map(grid, fn({_val, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250,250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  def save_image(image, fileName) do
    File.write("#{fileName}.png", image)
  end
end
