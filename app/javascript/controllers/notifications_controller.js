import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  markAsRead(event) {
    event.preventDefault();

    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");
    fetch("/notifications/mark_as_read", {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken
      }
    }).then(response => {
      if (response.ok) {
        const badge = this.element.querySelector(".badge");
        if (badge) {
          badge.remove();
        }
      }
    });
  }
}
