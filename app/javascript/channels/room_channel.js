import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const room_element = document.getElementById('room-id');
  const room_id = room_element.getAttribute('data-room-id');

if (room_id) {
  consumer.subscriptions.create({channel: "RoomChannel", room_id: room_id}, {
    
    connected() {
      console.log("connected to room....");
      this.perform("appear");
    // Called when the subscription is ready for use on the server
    },

    disconnected() {
      console.log("disconnected");
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      const userMsgElements = document.querySelectorAll(`.user-status-${data.user_id}`);
        userMsgElements.forEach(function(element) {
          if (data.status === 'online') {
          element.classList.add(data.status);
          } else {
            element.classList.remove(data.status);
          }
        });

      const form = document.getElementById('input-field');
      var messageHolder = $('#message_holder');

      // Append a new <p> tag
      function appendNewPTag(content, username) {
        var newPTag = $('<p><span class ="small-margin">'+ username + '</span><strong>'+ content + '</strong></p>');

        // Append the new <p> tag
        messageHolder.append(newPTag);
        messageHolder.scrollTop(messageHolder[0].scrollHeight);

      }
      // Example usage
      if (data.content) {
        appendNewPTag(data.content, data.username);
      }

      if (data.clearForm) {
        form.value = '';
      }
    }
  });

  // const leaveRoomButton = document.getElementById('leave-room-button');

  // if (leaveRoomButton) {
  //   leaveRoomButton.addEventListener('click', () => {
  //     // Unsubscribe or disconnect from the RoomChannel when leaving the room
  //     roomChannel.unsubscribe(); // or roomChannel.disconnected();
  //     console.log("Left the room");
  //   });
  // }
}
});
