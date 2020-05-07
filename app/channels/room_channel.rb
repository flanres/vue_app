class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # Vue.jsから受け取ったdataをチャンネルに流す
    ActionCable.server.broadcast "message_channel", name: data["task"], req: data["req"], index: data["index"], is_done: data["is_done"]
  end

  def create_speak(data)
    # サーバ側でブロードキャストデータを作成する
    push_data = {}
    push_data.store("id", data["created_task"]["id"])
    push_data.store("name", data["created_task"]["name"])
    push_data.store("is_done", data["created_task"]["is_done"])
    # Vue.jsから受け取ったdataをチャンネルに流す
    ActionCable.server.broadcast "message_channel", name: push_data, req: 'create'
  end
end
