import consumer from "./consumer"

  consumer.subscriptions.create("PresenceChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      if (Notification.permission === 'granted') {
        console.log("websocket notification")
        var title = `Push Notification for ${data.to_user}`
        var options = { body: data.msg }

        new Notification(title, options)
      }
      }
    });
