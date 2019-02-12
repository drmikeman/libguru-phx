defmodule Libguru.Scheduler do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    process()

    schedule_work()
    {:noreply, state}
  end

  def process() do
    Libguru.FetchService.process()
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 8 * 60 * 60 * 1000)
  end
end