defmodule KV.Bucket do
  def start_link do
    Agent.start_link(&HashDict.new/0)
  end

  def get(bucket, key) do
    Agent.get(bucket, &HashDict.get(&1, key))
  end

  def put(bucket, key, value) do
    Agent.update(bucket, &HashDict.put(&1, key, value))
  end
end
