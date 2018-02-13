defmodule Open do
  def open_html(html) do
    path = Path.join(System.tmp_dir!(), "open_#{NaiveDateTime.utc_now()}.html")
    File.write!(path, html)
    open_file(path)
  end

  def open_file(path) do
    browser_open(path)
  end

  # Copied from Hex lib/mix/tasks/hex.docs.ex
  defp browser_open(path) do
    start_command = start_command()

    if System.find_executable(start_command) do
      System.cmd(start_command, [path])
      :ok
    else
      Mix.raise("Command not found: #{start_command}")
    end
  end

  defp start_command() do
    case :os.type() do
      {:win32, _} -> "start"
      {:unix, :darwin} -> "open"
      {:unix, _} -> "xdg-open"
    end
  end
end
