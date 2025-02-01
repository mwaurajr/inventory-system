import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Automatically remove the notification element after 30 seconds
    this.startTimer();
  }

  startTimer() {
    setTimeout(() => {
      this.element.remove();
    }, 30000);
  }
}

