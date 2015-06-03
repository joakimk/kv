defmodule KV.Registry do
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  # GenServer API

  def init(:ok) do
    {:ok, HashDict.new}
  end

  def handle_call({:lookup, name}, _from, buckets) do
    bucket = HashDict.fetch(buckets, name)
    {:reply, bucket, buckets}
  end

  def handle_cast({:create, name}, buckets) do
    if HashDict.has_key?(buckets, name) do
      {:noreply, buckets}
    else
      {:ok, bucket} = KV.Bucket.start_link
      buckets = HashDict.put(buckets, name, bucket)
      {:noreply, buckets}
    end
  end
end
