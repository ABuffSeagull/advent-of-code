defmodule MyFile do
  @enforce_keys [:name, :size]
  defstruct [:name, :size]
end

defmodule MyFolder do
  @behaviour Access

  @enforce_keys [:name]
  defstruct [:name, children: %{}]

  def fetch(%__MODULE__{} = folder, key), do: Access.fetch(folder.children, key)

  def get_and_update(%__MODULE__{} = folder, key, fun) do
    {value, children} = Access.get_and_update(folder.children, key, fun)
    {value, %{folder | children: children}}
  end

  def pop(%__MODULE__{} = folder, key), do: %{folder | children: Access.pop(folder.children, key)}
end

defmodule Day07 do
  def part1(filename) do
    filesystem = parse_filesystem(filename)

    count_dirs(filesystem)
  end

  def parse_filesystem(filename) do
    {filesystem, _} =
      File.stream!(filename)
      |> Stream.map(&String.trim/1)
      |> Enum.reduce({%MyFolder{name: "/"}, []}, &parse_line/2)

    filesystem
  end

  defp parse_line("$ cd /", {root, _}) do
    {root, []}
  end

  defp parse_line("$ cd ..", {root, [_ | path]}) do
    {root, path}
  end

  defp parse_line("$ cd " <> folder_name, {root, path}) do
    {root, [folder_name | path]}
  end

  defp parse_line("$ ls", {root, path}) do
    {root, path}
  end

  defp parse_line("dir " <> folder_name, {root, path}) do
    new_root = put_in(root, Enum.reverse([folder_name | path]), %MyFolder{name: folder_name})
    {new_root, path}
  end

  defp parse_line("", {root, path}), do: {root, path}

  defp parse_line(file_line, {root, path}) do
    {size, filename} = Integer.parse(file_line)

    filename = String.trim(filename)

    new_root = put_in(root, Enum.reverse([filename | path]), %MyFile{name: filename, size: size})

    {new_root, path}
  end

  defp count_dirs(%MyFolder{} = folder) do
    {total, current} =
      Enum.reduce(folder.children, {0, 0}, fn {_, entry}, {total, current} ->
        {child_total, child_current} = count_dirs(entry)
        {total + child_total, current + child_current}
      end)

    if current < 100_000 do
      {total + current, current}
    else
      {total, current}
    end
  end

  defp count_dirs(%MyFile{} = file) do
    {0, file.size}
  end

  def part2(filename) do
    filesystem = parse_filesystem(filename)

    sizes =
      filesystem
      |> get_directory_sizes()
      |> Enum.sort(:desc)

    unused_space = 30_000_000 - (70_000_000 - List.first(sizes))

    sizes
    # |> Enum.take_while(& &1 > unused_space)
    # |> List.last()
  end

  def get_directory_sizes(%MyFolder{} = folder) do
    {folders, files} =
      folder.children
      |> Stream.map(fn {_, entry} -> entry end)
      |> Enum.split_with(&is_struct(&1, MyFolder))

    files_size =
      files
      |> Stream.map(& &1.size)
      |> Enum.sum()

    folders_size =
      folders
      |> Enum.map(&get_directory_sizes/1)
      |> List.flatten()

    [files_size + Enum.sum(folders_size) | folders_size]
  end
end
