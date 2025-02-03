
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    this.debouncedSubmit = this.debounce(() => {
      this.element.requestSubmit();
    }, 500);
  }

  // A generic debounce implementation
  debounce(func, delay) {
    let timer;
    return function (...args) {
      clearTimeout(timer);
      timer = setTimeout(() => {
        func.apply(this, args);
      }, delay);
    };
  }

  // This method is called on each input event (attached via data-action)
  submit() {
    this.debouncedSubmit();
  }
}

