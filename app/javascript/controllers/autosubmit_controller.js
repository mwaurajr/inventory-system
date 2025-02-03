import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {
    this.debouncedSubmit = this.debounce(() => {
      this.element.requestSubmit();
    }, 500); // Adjust delay as needed
  }

  // Simple debounce implementation
  debounce(func, delay) {
    let timer;
    return function (...args) {
      clearTimeout(timer);
      timer = setTimeout(() => {
        func.apply(this, args);
      }, delay);
    };
  }

  submit() {
    this.debouncedSubmit();
  }
}

