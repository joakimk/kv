defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put bucket, "milk", 3
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "a key can be removed and the value returned", %{bucket: bucket} do
    KV.Bucket.put bucket, "milk", 3
    assert KV.Bucket.get(bucket, "milk") == 3

    value_of_deleted_key = KV.Bucket.delete(bucket, "milk")
    assert value_of_deleted_key == 3
    assert KV.Bucket.get(bucket, "milk") == nil
  end
end
