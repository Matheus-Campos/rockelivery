defmodule Rockelivery.Orders.ReportRunner do
  use GenServer

  require Logger

  alias Rockelivery.Orders.Report

  # Client

  def start_link(_initial_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    Logger.info("Report runner started")
    schedule_report_generation()
    {:ok, state}
  end

  @impl true
  def handle_info(_message, state) do
    Logger.info("Generating report...")

    Report.create()
    schedule_report_generation()

    {:noreply, state}
  end

  def schedule_report_generation do
    Process.send_after(self(), :generate, 1000 * 60 * 60 * 4)
  end
end
