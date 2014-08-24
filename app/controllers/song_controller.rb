class SongController < WebsocketRails::BaseController
  
  attr_accessor :message_counter

  def initialize_session
    puts "Session Initialized\n"
    @message_counter = 0
  end
  
  def client_connected
    # do something when a client connects
    puts "execuitng?"
  end
  
  def new_message
    #puts "Message from UID: #{client_id}\n"
    #@message_counter += 1
    #puts @message_counter
    puts message[:text]
    broadcast_message :new_message, message
    #puts :new_message
  end
  
  def new_user
    puts "storing user in data store\n"
    data_store[:user] = message
    broadcast_user_list
  end
  
  def change_username
    data_store[:user] = message
    broadcast_user_list
  end
  
  def delete_user
    data_store.remove_client
    broadcast_message :new_message, {user_name: 'System', msg_body: "Client #{client_id} disconnected"}
    broadcast_user_list
  end
  
  def broadcast_user_list
    users = data_store.each_user
    puts "broadcasting user list: #{users}\n"
    broadcast_message :user_list, users
  end

end